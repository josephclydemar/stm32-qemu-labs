MEMORY
{
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 512K
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 96K
}

ENTRY(reset_handler)

SECTIONS
{
  .text : ALIGN(4)
  {
    *(.vector_table)
    *(.text)
    KEEP(*(.vector_table))
  } >FLASH

  .data :
  {
    *(.data)
  } >SRAM
}
