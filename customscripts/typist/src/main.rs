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


extern crate failure;
use failure::ResultExt;

extern crate exitfailure;
use exitfailure::ExitFailure;

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

#[derive(Debug)]
struct CustomError(String);


/// main takes only cli arguments and returns only error type
//fn main()-> Result<(), Box<dyn std::error::Error>> {
// This is a more direct way to return errors
//fn main() -> Result<(), CustomError> {
//this allows us to create logged errors
fn main() -> Result<(), ExitFailure> {
    // Note that we should only use the from_args method inside main
    let args = Cli::from_args();
    //let filename = File::open(&args.path).expect("Could not read file");
    //let content = std::fs::read_to_string(&args.path).expect("Could not read file");
    //This could be used to only open a part of the file at a time (default is 8kb)
    //but BufReader does not give its return value the line argument
    //let content = BufReader::new(filename);
    
    // let content = match result {
    //     Ok(content) => { content },
    //     //Returns type result 
    //     Err(error) => {return Err(error.into());}
    //     //Example of a panic error
    //     //Err(error) => { panic!("Can't deal with {}, just exit here", error); }
    // };
    //The above can be replaced by the below as the ? operator expands to code that converts error types.
    // This results in an alright error code but does not provide much context
    // (E.g. a file not found would error would return the following)
    // Error: Os { code: 2, kind: NotFound, message: “No such file or directory” }
    // let content = std::fs::read_to_string(&args.path)?;
    //This is good but does not store the error
    //let content = std::fs::read_to_string(path)
    //    .map_err(|err| CustomError(format!("Error reading `{}`: {}", path, err)))?;
    let path = "test.txt";
    let content = std::fs::read_to_string(path)
        .with_context(|_| format!("could not read file `{}`", path))?;
    println!("file content: {}", content);


    // This is the default result value which indicates the program executed successfully
    Ok(())   
}