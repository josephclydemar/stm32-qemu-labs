typedef unsigned long uint32_t;

#define FLASH_BASE   0x08000000
#define SRAM_BASE    0x20000000
#define PERIPH_BASE  0x40000000

#define SRAM_SIZE    96 * 1024
#define SRAM_END     (SRAM_BASE + SRAM_SIZE)

#define RCC_BASE     (PERIPH_BASE + 0x23800)
#define RCC_APB1ENR  ((uint32_t*)(RCC_BASE + 0x30))

#define GPIOA_BASE   (PERIPH_BASE + 0x20000)
#define GPIOA_MODER  ((uint32_t*)(GPIOA_BASE + 0x00))
#define GPIOA_ODR    ((uint32_t*)(GPIOA_BASE + 0x14))

int reset_handler(void);
void delay(uint32_t count);

uint32_t *vector_table[] __attribute__((section(".isr_vector"))) = {
  (uint32_t *)SRAM_END,
  (uint32_t *)reset_handler
};

int reset_handler(void)
{
  *RCC_APB1ENR = 0x1;
  *GPIOA_MODER |= 0x400;

  while(1) {
    *GPIOA_ODR = 0x20;
    delay(200000);
    *GPIOA_ODR = 0x0;
    delay(200000);
  }
  return 0;
}

void delay(uint32_t count)
{
  while(count--);
}
