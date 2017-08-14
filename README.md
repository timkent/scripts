# scripts
Mostly OSCP related scripts

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
