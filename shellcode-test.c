// compile with gcc -m32 -o shellcode-test shellcode-test.c
const char __attribute__ ((section (".text#"))) main[] = "\xCC";
