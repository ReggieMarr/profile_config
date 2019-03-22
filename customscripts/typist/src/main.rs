/*
    This cli app will be used to search for a pattern in 
    a file and print relevant info.
*/

#[macro_use]
extern crate structopt;

use std::path::PathBuf;
use structopt::StructOpt;

use std::fs::*;
use std::io::BufReader;
/*
    Derive is used as a precompile command to let the compiler know
    that the following lines will use structopts functionality.
*/

#[derive(StructOpt)]
struct Cli {
    /// The pattern to look for.
    pattern: String,
    /// The path for the file to read.
    // Note that the following preprocessor command is required to 
    // implement string parsing
    #[structopt(parse(from_os_str))]
    path: std::path::PathBuf
}

fn main() {
    // Note that we should only use the from_args method inside main
    let args = Cli::from_args();
    let filename = File::open(&args.path).expect("Could not read file");
    let content = std::fs::read_to_string(&args.path).expect("Could not read file");
    //This could be used to only open a part of the file at a time (default is 8kb)
    //but BufReader does not give its return value the line argument
    //let content = BufReader::new(filename);
    
    for line in content.lines() {
        if line.contains(&args.pattern) {
            println!("{}", line);
        }
    }   
}