//! Serialization of the log: one record per line, whitespace-separated tokens,
//! each string token percent-encoded so it never contains whitespace or `%`
//! unescaped. Hand-rolled (no serde) so the crate keeps zero dependencies.
//!
//! ```text
//! cs <segment> <author> <n> { <id> <version> <claimed> <m> { <target> <needed> <seen> }*m }*n
//! act <actor> <criterion> check <rung>|affirm <n> { <id> <version> }*n <m> { <id> }*m
//! ```
//! Lines that are empty or start with `#` are ignored on decode.

use std::collections::{BTreeMap, BTreeSet};

use crate::model::*;

fn enc(s: &str) -> String {
    let mut o = String::new();
    if s.is_empty() {
        return "%".to_string(); // a lone % is the empty string
    }
    for b in s.bytes() {
        if b.is_ascii_graphic() && b != b'%' {
            o.push(b as char);
        } else {
            o.push_str(&format!("%{b:02X}"));
        }
    }
    o
}

fn dec(s: &str) -> Result<String, String> {
    if s == "%" {
        return Ok(String::new());
    }
    let b = s.as_bytes();
    let mut out = Vec::with_capacity(b.len());
    let mut i = 0;
    while i < b.len() {
        if b[i] == b'%' {
            let h = s.get(i + 1..i + 3).ok_or_else(|| format!("bad escape in {s:?}"))?;
            out.push(u8::from_str_radix(h, 16).map_err(|_| format!("bad escape in {s:?}"))?);
            i += 3;
        } else {
            out.push(b[i]);
            i += 1;
        }
    }
    String::from_utf8(out).map_err(|_| format!("not utf-8: {s:?}"))
}

pub fn encode_record(r: &Record) -> String {
    let mut t: Vec<String> = Vec::new();
    match r {
        Record::Changeset(cs) => {
            t.push("cs".into());
            t.push(enc(&cs.segment.0));
            t.push(enc(&cs.author));
            t.push(cs.veritoids.len().to_string());
            for (id, w) in &cs.veritoids {
                t.push(enc(&id.0));
                t.push(w.version.0.to_string());
                t.push(w.claimed.name().into());
                t.push(w.references.len().to_string());
                for (tg, rf) in &w.references {
                    t.push(enc(&tg.0));
                    t.push(rf.needed.name().into());
                    t.push(rf.seen.0.to_string());
                }
            }
        }
        Record::Act(a) => {
            t.push("act".into());
            t.push(enc(&a.actor));
            t.push(enc(&a.criterion));
            match a.kind {
                ActKind::Check { rung } => {
                    t.push("check".into());
                    t.push(rung.name().into());
                }
                ActKind::Affirmation => t.push("affirm".into()),
            }
            t.push(a.reads.len().to_string());
            for (id, v) in &a.reads {
                t.push(enc(&id.0));
                t.push(v.0.to_string());
            }
            t.push(a.concerns.len().to_string());
            for id in &a.concerns {
                t.push(enc(&id.0));
            }
        }
    }
    t.join(" ")
}

pub fn encode_log(records: &[Record]) -> String {
    let mut s = String::new();
    for r in records {
        s.push_str(&encode_record(r));
        s.push('\n');
    }
    s
}

struct Toks<'a> {
    it: std::str::SplitWhitespace<'a>,
}

impl<'a> Toks<'a> {
    fn next(&mut self, what: &str) -> Result<&'a str, String> {
        self.it.next().ok_or_else(|| format!("expected {what}, found end of line"))
    }
    fn string(&mut self, what: &str) -> Result<String, String> {
        dec(self.next(what)?)
    }
    fn count(&mut self, what: &str) -> Result<usize, String> {
        let s = self.next(what)?;
        s.parse().map_err(|_| format!("expected count for {what}, found {s:?}"))
    }
    fn version(&mut self) -> Result<Version, String> {
        let s = self.next("version")?;
        s.parse().map(Version).map_err(|_| format!("expected version, found {s:?}"))
    }
    fn rung(&mut self) -> Result<Rung, String> {
        let s = self.next("rung")?;
        Rung::parse(s).ok_or_else(|| format!("expected rung, found {s:?}"))
    }
}

pub fn decode_record(line: &str) -> Result<Record, String> {
    let mut t = Toks { it: line.split_whitespace() };
    let rec = match t.next("record tag")? {
        "cs" => {
            let segment = SegmentId(t.string("segment")?);
            let author = t.string("author")?;
            let n = t.count("veritoids")?;
            let mut veritoids = BTreeMap::new();
            for _ in 0..n {
                let id = VeritoidId(t.string("veritoid id")?);
                let version = t.version()?;
                let claimed = t.rung()?;
                let m = t.count("references")?;
                let mut references = BTreeMap::new();
                for _ in 0..m {
                    let tg = VeritoidId(t.string("reference target")?);
                    let needed = t.rung()?;
                    let seen = t.version()?;
                    if references.insert(tg.clone(), Reference { needed, seen }).is_some() {
                        return Err(format!("duplicate reference to {tg}"));
                    }
                }
                if veritoids.insert(id.clone(), Written { version, claimed, references }).is_some() {
                    return Err(format!("duplicate veritoid {id} in changeset"));
                }
            }
            Record::Changeset(SegmentChangeset { segment, author, veritoids })
        }
        "act" => {
            let actor = t.string("actor")?;
            let criterion = t.string("criterion")?;
            let kind = match t.next("act kind")? {
                "check" => ActKind::Check { rung: t.rung()? },
                "affirm" => ActKind::Affirmation,
                k => return Err(format!("unknown act kind {k:?}")),
            };
            let n = t.count("reads")?;
            let mut reads = BTreeMap::new();
            for _ in 0..n {
                let id = VeritoidId(t.string("read id")?);
                let v = t.version()?;
                if reads.insert(id.clone(), v).is_some() {
                    return Err(format!("duplicate read of {id}"));
                }
            }
            let m = t.count("concerns")?;
            let mut concerns = BTreeSet::new();
            for _ in 0..m {
                let id = VeritoidId(t.string("concern id")?);
                if !concerns.insert(id.clone()) {
                    return Err(format!("duplicate concern {id}"));
                }
            }
            Record::Act(Act { actor, criterion, kind, reads, concerns })
        }
        tag => return Err(format!("unknown record tag {tag:?}")),
    };
    if let Some(extra) = t.it.next() {
        return Err(format!("trailing token {extra:?}"));
    }
    Ok(rec)
}

pub fn decode_log(text: &str) -> Result<Vec<Record>, String> {
    let mut out = Vec::new();
    for (n, line) in text.lines().enumerate() {
        let l = line.trim();
        if l.is_empty() || l.starts_with('#') {
            continue;
        }
        out.push(decode_record(l).map_err(|e| format!("line {}: {e}", n + 1))?);
    }
    Ok(out)
}
