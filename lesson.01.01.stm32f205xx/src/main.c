#include "common.h"

void delay(uint32_t count)
{
  while(count--);
}

int main(void)
{
  uint32_t my_num1 = 5;
  uint32_t *my_num1_ptr = &my_num1;
  while (1) {
    if (my_num1 > 6500) {
      my_num1 = 0;
    }
    if (my_num1 == 0x1d) {
      my_num1_ptr = 0x0;
    }
    if (my_num1 % 0x29 == 0) {
      *my_num1_ptr -= 2;
      __asm volatile (
        "ldr r0, =0xd020fee7\n"
        "ldr r1, =0x05fa0004\n"
        "str r1, [r0]\n"
      );
    }

    my_num1 += 4;
    delay(40000);
  }
}
