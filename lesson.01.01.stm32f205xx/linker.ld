MEMORY
{
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1M
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}

ENTRY(reset_handler)

SECTIONS
{
  .isr_vector :
  {
    KEEP(*(.isr_vector))
  } > FLASH
  .text :
  {
    *(.text)
  } > FLASH

  .data :
  {
    *(.data)
  } > SRAM
}
