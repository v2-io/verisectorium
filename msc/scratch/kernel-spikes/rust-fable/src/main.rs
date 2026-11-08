//! A small CLI over the kernel.
//!
//!   kernel example [OUT.jsonl]   run the §6 worked example, print each
//!                                checkpoint's frontier, write the log
//!   kernel show LOG.jsonl [N]    load a log, print the state (as of record N,
//!                                default all) and its frontier

use std::fs::File;
use std::io::{BufReader, BufWriter};
use std::process::ExitCode;

use kernel::{Log, State, example};

fn main() -> ExitCode {
    let args: Vec<String> = std::env::args().skip(1).collect();
    match args.first().map(String::as_str) {
        Some("example") => run_example(args.get(1).map(String::as_str)),
        Some("show") if args.len() >= 2 => show(&args[1], args.get(2).map(String::as_str)),
        _ => {
            eprintln!("usage: kernel example [OUT.jsonl] | kernel show LOG.jsonl [N]");
            ExitCode::from(2)
        }
    }
}

fn print_state(s: &State) {
    print!("{}", s.render());
    let f = s.frontier();
    if f.is_empty() {
        println!("frontier: empty (steady)");
    } else {
        println!("frontier ({} owed):", f.len());
        for o in &f {
            println!("    {o}");
        }
    }
}

fn run_example(out: Option<&str>) -> ExitCode {
    let (log, steps) = example::build();
    for step in &steps {
        println!("== {} (after {} records) ==", step.name, step.index);
        print_state(&log.state_at(step.index));
        println!();
    }
    if let Some(path) = out {
        match File::create(path).and_then(|f| log.write_to(BufWriter::new(f))) {
            Ok(()) => println!("wrote {} records to {path}", log.len()),
            Err(e) => {
                eprintln!("could not write {path}: {e}");
                return ExitCode::FAILURE;
            }
        }
    }
    ExitCode::SUCCESS
}

fn show(path: &str, n: Option<&str>) -> ExitCode {
    let log = match File::open(path).map_err(Into::into).and_then(|f| Log::read_from(BufReader::new(f))) {
        Ok(log) => log,
        Err(e) => {
            eprintln!("could not load {path}: {e}");
            return ExitCode::FAILURE;
        }
    };
    let n = match n.map(str::parse::<usize>) {
        None => log.len(),
        Some(Ok(n)) => n,
        Some(Err(e)) => {
            eprintln!("bad record index: {e}");
            return ExitCode::from(2);
        }
    };
    println!("{} records; state as of {}", log.len(), n.min(log.len()));
    print_state(&log.state_at(n));
    ExitCode::SUCCESS
}
