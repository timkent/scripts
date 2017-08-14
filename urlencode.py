#!/usr/bin/env python3

# urlencode.py
# https://github.com/timkent/scripts

import argparse
from urllib.parse import quote, unquote

def main():

    parser = argparse.ArgumentParser()
    
    parser.add_argument("-d", "--decode", help="decode instead of the default of encode", action="store_true")
    parser.add_argument("string", type=str, help="the string to decode or encode")
    
    args = parser.parse_args()
    
    if not args.decode:
        print(quote(args.string))
    else:
        print(unquote(args.string))

if __name__ == "__main__":
    main()
