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

## pefile_sections.py

Displays PE sections for the chosen file:

```shell
$ ./pefile_sections.py putty.exe | head -n 13
[IMAGE_SECTION_HEADER]
0x138      0x0   Name:                          .00cfg
0x140      0x8   Misc:                          0x4       
0x140      0x8   Misc_PhysicalAddress:          0x4       
0x140      0x8   Misc_VirtualSize:              0x4       
0x144      0xC   VirtualAddress:                0x1000    
0x148      0x10  SizeOfRawData:                 0x200     
0x14C      0x14  PointerToRawData:              0x400     
0x150      0x18  PointerToRelocations:          0x0       
0x154      0x1C  PointerToLinenumbers:          0x0       
0x158      0x20  NumberOfRelocations:           0x0       
0x15A      0x22  NumberOfLinenumbers:           0x0       
0x15C      0x24  Characteristics:               0x40000040
```

## shellcode-test.c

Source file to easily add shellcode to for testing/debugging.

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

## webshell.py

This is a python3 based web shell based on gist here: https://gist.github.com/phoemur/461c97aa5af5c785062b7b4db8ca79cd

I have made the following changes:
* Make output a bit nicer and safer
* Work regardless of scheme
* Append a GUID to the end of the path to provide security through obscurity :)

## x64dbg.ps1

This script will automate installing x64dbg along with Python 2.7, x64dbgpy, mona and xAnalyzer plugins.
