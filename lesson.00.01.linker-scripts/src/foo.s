%define SYS_WRITE 1

%define STDOUT 1
%define STDERR 2

%macro write 3
  mov rax, SYS_WRITE
  mov rdi, %1
  lea rsi, %2
  mov rdx, %3
  syscall
%endmacro

section .data
str1: db "Hello, from Foo!!\n"
str1_len equ $ - str1

section .text
global _foo_func
_foo_func:
  write STDOUT, [str1], str1_len
  
