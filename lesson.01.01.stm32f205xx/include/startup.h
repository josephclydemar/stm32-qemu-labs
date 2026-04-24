#ifndef STARTUP_H_
#define STARTUP_H_

#include "common.h"

#define FLASH_BASE   0x08000000
#define SRAM_BASE    0x20000000
// #define PERIPH_BASE  0x40000000

#define SRAM_SIZE    (128 * 1024)
#define SRAM_END     (SRAM_BASE + SRAM_SIZE)

void reset_handler(void);

uint32_t *vector_table[] __attribute__((section(".isr_vector"))) = {
  (uint32_t *)SRAM_END,
  (uint32_t *)reset_handler,
};

#endif // STARTUP_H_

