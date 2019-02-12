# scripts
Mostly OSCP/OSCE related scripts

## append_bytes_to_file.py

This script adds the chosen number of bytes to the end of a file:

```shell
$ ls -h -s putty.exe
760K putty.exe
$ ./append_bytes_to_file.py putty.exe 4096
$ ls -h -s putty.exe
764K putty.exe
```

## urlencode.py

This script URL encodes (or optionally decodes) a string fed to it:

```shell
$ ./urlencode.py 'This is a test, so you can see "how it works!"'
This%20is%20a%20test%2C%20so%20you%20can%20see%20%22how%20it%20works%21%22
```

Use `-d` to decode:

```shell
$ ./urlencode.py -d 'This%20is%20a%20test%2C%20so%20you%20can%20see%20%22how%20it%20works%21%22'
This is a test, so you can see "how it works!"
```

## x64dbg.ps1

This script will automate installing x64dbg along with Python 2.7, x64dbgpy, mona and xAnalyzer plugins.
