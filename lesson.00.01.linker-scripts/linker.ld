SECTIONS
{
  .text :
  {
    *(.text .data)
  }
  .rodata :
  {
    *(.rodata)
  }
  /*.data :
  {
    EXCLUDE_FILE(build/bar.o) *(.data)
  }*/
}
