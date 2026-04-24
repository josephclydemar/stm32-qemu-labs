#include "startup.h"

int main(void);

void reset_handler(void)
{
  /* just determining the order of pushes to stack */
  __asm volatile (
    "ldr r0, =0x155ab00b\n"
    "ldr r1, =0xd020fee7\n"
    "push {r0, r1}\n"
  );

  main();
}

