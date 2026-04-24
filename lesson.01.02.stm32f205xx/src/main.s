.syntax unified
.cpu cortex-m3
.thumb

.section .text
.global main
.type main, %function
main:
  mov r0, #0xda5e
l2:
  add r0, #0x4
  b l2

.size main, . - main
