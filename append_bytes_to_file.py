#!/usr/bin/env python3

import argparse

def main():

    parser = argparse.ArgumentParser()

    parser.add_argument('file', help='the file to modify')
    parser.add_argument('size', help='size (in bytes) to append', type=int)

    args = parser.parse_args()

    with open(args.file, 'ab') as dest:
        dest.write(b'\x00' * args.size)

if __name__ == '__main__':
    main()
