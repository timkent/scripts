#!/usr/bin/env python3

# DEPS: $ sudo apt-get install python3-pefile

import argparse
import pefile

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('file', help='the file to list PE sections')
    args = parser.parse_args()

    pe = pefile.PE(args.file)
    for section in pe.sections:
        print(section)
        print()

if __name__ == '__main__':
    main()
