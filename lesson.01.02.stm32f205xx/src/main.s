.syntax unified
.cpu cortex-m3
.thumb

.section .text
.global main
.type main, %function
main:
instruction_width:
  adds.n r0, r1
  adds.w r1, #0xb2
embedded_shift_operations:
  ldr r0, =0x8000da5e
  mov r1, #0x2d
  ldr r2, =0xfabf5dac
  ldr r3, =0xfdda7f48
  subs r1, #0x4a        /* used to set NF in xPSR */
  adds r2, r3           /* used to set CF in xPSR */

  mov r4, r0, asr #0x4
  mov r5, r0, lsr #0x4
  mov r6, r0, lsl #0x4
  mov r7, r0, ror #0x4

  mov r8, r0, rrx
  mov r1, #0x2d
  adds r1, #0x1a        /* used to clear CF in xPSR */
  mov r9, r0, rrx
memory_access_instructions: /* CHAPTER 3.4 */
  ldr r0, =0x20000000
  ldr r1, =0x20000020
  ldr r2, =0x20000060

  ldr r3, =0xad0c
  ldr r4, =0xabadbb0d
  ldr r5, =0xface
  ldr r6, =0xdec0

  /* Store (write to memory) */
  str r3, [r0]
  str r4, [r0, #0x20]
  str r5, [r2, #-0x20]
  str r6, [r1, r3]
  str r7, [r0, #0x40]!
  str r8, [r0], #-0x20
  str r9, [r0, r3, lsl #0x2]
  
  adr r0, bitwise_logical_operations
  mov pc, r0

  mov r0, 0
  mov r1, 0
  mov r2, 0
  mov r3, 0
  mov r4, 0

  /* Load: 1 reg/word (read from memory) */
  /* immediate offset */
  ldr r0, =0x20000020
  mov r1, 0
  mov r2, 0
  mov r3, 0
  ldr r1, [r0]
  ldr r2, [r0, #0x20]
  ldr r3, [r0, #-0x20]
  ldr r4, [r0, r3]
  ldr r5, [r0, r3, lsl #0x2]
  /* ldr pc, [r0, #0x20] */ /* (bit0 is 0 which causes a fault at runtime) */
  
  /* pre-indexed offset */
  ldr r0, =0x20000020
  mov r1, 0
  mov r2, 0
  mov r3, 0
  ldr r1, [r0]!
  ldr r2, [r0, #0x20]!
  ldr r3, [r0, #-0x20]!

  /* post-indexed offset */
  ldr r0, =0x20000020
  mov r1, 0
  mov r2, 0
  mov r3, 0
  ldr r2, [r0], #0x20
  ldr r3, [r0], #-0x20


  /* Load: 2 reg/word */
  ldr r0, =0x20000020
  mov r1, 0
  mov r2, 0
  mov r3, 0
  mov r4, 0
  mov r5, 0
  mov r6, 0
  ldrd r1, r2, [r0]
  ldrd r3, r4, [r0, #0x20]
  ldrd r5, r6, [r0, #-0x20]
  /* ldrd r0, r1, embedded_shift_operations (ERROR: src/main.s:84: Error: offset not a multiple of 4) */
load_store_multiple:
  ldr r0, =0x2000b000

  mov r1, 0
  mov r2, 0
  mov r3, 0
  mov r4, 0
  /* ldmib r0, {r1, r2, r3, r4} */
  ldmia r0, {r1, r2, r3, r4}
  ldmia r0!, {r1, r2, r3, r4}
  /* ldmdb r0, {r1, r2, r3, r4} */
  /* ldmda r0, {r1, r2, r3, r4} */

  ldr r1, =0xad0c
  ldr r2, =0xabadbb0d
  ldr r3, =0xface
  ldr r4, =0xdec0
  /* stmib r0, {r1, r2, r3, r4} */
  /* stmia r0, {r1, r2, r3, r4} */
  stmdb r0, {r1, r2, r3, r4}
  stmdb r0!, {r1, r2, r3, r4}
  /* stmda r0, {r1, r2, r3, r4} */
stack_operations:
  push {r1, r2, r3}
  pop {r4, r5, r6}
load_store_exclusive:
  mov r3, #0x5
again_load_store_exclusive:
  ldr r0, =0x2000b000
  ldr r1, =0xabadbb0d
  str r1, [r0]
  mov r1, 0
incr_ex:
  ldrex r1, [r0]
  add r1, #0x1

check_eq3:
  cmp r3, #0x3
  beq clear_ex

  strex r2, r1, [r0]
  cmp r2, #0x0
  bne incr_ex

  subs r3, #0x1
  cmp r3, #0x0
  bne again_load_store_exclusive
  b data_processing_instructions
clear_ex:
  clrex
  sub r3, #0x1
  b check_eq3

data_processing_instructions: /* CHAPTER 3.5 */
  /* Addition */
  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  add r2, r1
  add r2, r0, #0x23             /* r2 = r0 + #imm12 (immediate value) */
  add r2, r0, r1                /* r2 = r0 + r1 */
  add r2, r0, r1, lsl #0x2      /* r2 = r0 + (r1 << 2) */

  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  adc r2, r1
  adc r2, r0, #0x23             /* r2 = r0 + #imm12 + CF (immediate value) */
  adc r2, r0, r1                /* r2 = r0 + r1 + CF */
  adc r2, r0, r1, lsl #0x2      /* r2 = r0 + r1 + CF */

  /* Subtraction */
  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  sub r2, r1
  sub r2, r0, #0x23             /* r2 = r0 - #imm12 (immediate value) */
  sub r2, r0, r1                /* r2 = r0 - r1 */
  sub r2, r0, r1, lsl #0x2      /* r2 = r0 - (r1 << 2) */

  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  sbc r2, r1
  sbc r2, r0, #0x23             /* r2 = r0 - #imm12 - (1 - CF) (immediate value) */
  sbc r2, r0, r1                /* r2 = r0 - r1 - (1 - CF) */
  sbc r2, r0, r1, lsl #0x2      /* r2 = r0 - (r1 << 2) - (1 - CF) */

  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  rsb r2, r1
  rsb r2, r0, #0x23             /* r2 = #imm12 - r0 (immediate value) */
  rsb r2, r0, r1                /* r2 = r1 - r0 */
  rsb r2, r0, r1, lsl #0x2      /* r2 = r1 - r0 */

bitwise_logical_operations:
  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  and r2, r1
  and r2, r0, #0x23             /* */
  and r2, r0, r1                /* */
  and r2, r0, r1, lsl #0x10     /* */
  and r2, r0, r1, lsr #0x10     /* */
  and r2, r0, r1, asr #0x10     /* */
  and r2, r0, r1, ror #0x10     /* */
  and r2, r0, r1, rrx           /* */

  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  orr r2, r1
  orr r2, r0, #0x23             /* */
  orr r2, r0, r1                /* */
  orr r2, r0, r1, lsl #0x10     /* */
  orr r2, r0, r1, lsr #0x10     /* */
  orr r2, r0, r1, asr #0x10     /* */
  orr r2, r0, r1, ror #0x10     /* */
  orr r2, r0, r1, rrx           /* */

  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  eor r2, r1
  eor r2, r0, #0x23             /* */
  eor r2, r0, r1                /* */
  eor r2, r0, r1, lsl #0x10     /* */
  eor r2, r0, r1, lsr #0x10     /* */
  eor r2, r0, r1, asr #0x10     /* */
  eor r2, r0, r1, ror #0x10     /* */
  eor r2, r0, r1, rrx           /* */

  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  bic r2, r1
  bic r2, r0, #0x23             /* */
  bic r2, r0, r1                /* */
  bic r2, r0, r1, lsl #0x10     /* */
  bic r2, r0, r1, lsr #0x10     /* */
  bic r2, r0, r1, asr #0x10     /* */
  bic r2, r0, r1, ror #0x10     /* */
  bic r2, r0, r1, rrx           /* */

  mov r0, #0x40b5
  mov r1, #0x2d1a
  mov r2, #0x51e0
  orn r2, r1
  orn r2, r0, #0x23             /* */
  orn r2, r0, r1                /* */
  orn r2, r0, r1, lsl #0x10     /* */
  orn r2, r0, r1, lsr #0x10     /* */
  orn r2, r0, r1, asr #0x10     /* */
  orn r2, r0, r1, ror #0x10     /* */
  orn r2, r0, r1, rrx           /* */

bitwise_shift_operations:
  asr r2, r0, #0x10
  asr r2, r0, r1

  lsl r2, r0, #0x10
  lsl r2, r0, r1

  lsr r2, r0, #0x10
  lsr r2, r0, r1

  ror r2, r0, #0x10
  ror r2, r0, r1

  rrx r2, r0

count_leading_zeroes_operation:
  mov r1, #0x2d1a
  mov r2, #0x51e0
  clz r2, r1

comparison_operation:
  mov r1, #0x2d1a
  mov r2, #0x51e0

  /* similar to `subs` */
  cmp r2, #0x5d
  cmp r1, r2
  cmp r1, r2, lsr #0x4
  cmp r1, r2, lsl #0x4
  cmp r1, r2, ror #0x8
  
  /* similar to `adds` */
  cmn r2, #0x5d
  cmn r1, r2
  cmn r1, r2, lsr #0x4
  cmn r1, r2, ror #0x8

l2:
  add r0, #0x4
  b l2

.size main, . - main

