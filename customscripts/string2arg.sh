#! /bin/bash

string2arg() {
    inStr=$1;
    export arg_filename=$(cut -d":" -f1 <<< $1);
    export arg_linenum=$(cut -d":" -f2 <<< $1);
    echo $arg_filename;
    tail $arg_filename --lines=+$arg_linenum;
}
