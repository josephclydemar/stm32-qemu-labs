; syscall numbers
%define SYS_EXIT  60

; syscall %macros
%macro exit 1
  mov rax, SYS_EXIT
  mov rdi, %1
  syscall
%endmacro

section .text
global _start
extern _foo_func
_start:
  mov rax, 0xf7
  call _foo_func
  exit 0

