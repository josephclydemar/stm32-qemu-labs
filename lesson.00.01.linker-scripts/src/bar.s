section .data
myint3: dd 73, 67
str3: db "Hello from BAr!!\n"

section .text
_bar_func:
  mov rbx, 0x4e792f
  and rbx, rcx

section .rodata
_haha:
  mov dword [myint3], 0xe2
