section .data
str2: db "Quo!!\n"

section .text
_quo_func:
  mov rdx, 0x7d40
  add rbx, 0x3a
  
