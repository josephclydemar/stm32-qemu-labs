.syntax unified
.cpu cortex-m3
.thumb

.equ FLASH_BASE,   0x08000000
.equ SRAM_BASE,    0x20000000
.equ SRAM_SIZE,    (128 * 1024)
.equ SRAM_END,     (SRAM_BASE + SRAM_SIZE)


.section .isr_vector, "a", %progbits
.align 2
.global vector_table
.type vector_table, %object
vector_table:
  .word SRAM_END
  .word reset_handler
  .word 0
  .word 0
.size vector_table, . - vector_table


.section .text, "ax", %progbits
.align 2
.extern main

.global reset_handler
.type reset_handler, %function
reset_handler:
  ldr r0, =0x155ab00b
  ldr r1, =0xd020fee7
  push {r0, r1}

  b main
.size reset_handler, . - reset_handler

