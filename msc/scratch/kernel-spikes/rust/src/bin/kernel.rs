//! A small CLI over the kernel.
//!
//!   kernel show LOGFILE [--at N]    fold LOGFILE (or its first N records), print state and frontier
//!   kernel example [--write FILE]   run the spec's worked example stage by stage (and write its log)

use std::process::ExitCode;

use kernel::{codec, example, render::render_state, Log};

fn usage() -> ExitCode {
    eprintln!("usage: kernel show LOGFILE [--at N]\n       kernel example [--write FILE]");
    ExitCode::from(2)
}

fn main() -> ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    match args.first().map(String::as_str) {
        Some("show") => {
            let Some(path) = args.get(1) else { return usage() };
            let text = match std::fs::read_to_string(path) {
                Ok(t) => t,
                Err(e) => {
                    eprintln!("{path}: {e}");
                    return ExitCode::FAILURE;
                }
            };
            let records = match codec::decode_log(&text) {
                Ok(r) => r,
                Err(e) => {
                    eprintln!("{path}: {e}");
                    return ExitCode::FAILURE;
                }
            };
            let log = Log::from_records(records);
            let state = match args.iter().position(|a| a == "--at") {
                Some(i) => match args.get(i + 1).and_then(|n| n.parse().ok()) {
                    Some(n) => log.state_at(n),
                    None => return usage(),
                },
                None => log.state().clone(),
            };
            print!("{}", render_state(&state));
            ExitCode::SUCCESS
        }
        Some("example") => {
            let mut log = Log::new();
            for stage in example::stages() {
                for r in stage.records {
                    log.append(r);
                }
                println!("== {} ==", stage.name);
                print!("{}", render_state(log.state()));
                println!();
            }
            if let Some(i) = args.iter().position(|a| a == "--write") {
                let Some(path) = args.get(i + 1) else { return usage() };
                if let Err(e) = std::fs::write(path, codec::encode_log(log.records())) {
                    eprintln!("{path}: {e}");
                    return ExitCode::FAILURE;
                }
                println!("wrote {} record(s) to {path}", log.len());
            }
            ExitCode::SUCCESS
        }
        _ => usage(),
    }
}
