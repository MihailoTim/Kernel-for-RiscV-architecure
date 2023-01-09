OUTPUT_ARCH( "riscv" )
ENTRY( _entry )

SECTIONS
{
  /*
   * ensure that entry.S / _entry is at 0x80000000,
   * where qemu's -kernel jumps.
   */
  . = 0x80000000;

  .text : {
    *(.entry_os) . = ALIGN(0x1000);
    PROVIDE(userTextStart = .);
    EXCLUDE_FILE(build/src/kernel/*)
    *(.text .text.*)
    . = ALIGN(0x1000);
    PROVIDE(etext = .);
  }

  .rodata : {
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/kernel/*)
    *(.srodata .srodata.*) /* do not need to distinguish this from .rodata */
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/kernel/*)
    *(.rodata .rodata.*)
  }

  .data : {
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/kernel/*)
    *(.sdata .sdata.*) /* do not need to distinguish this from .data */
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/kernel/*)
    *(.data .data.*)
  }

  .bss : {
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/kernel/*)
    *(.sbss .sbss.*) /* do not need to distinguish this from .bss */
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/kernel/*)
    *(.bss .bss.*)
  }

  .eh_frame : {
    EXCLUDE_FILE(build/src/kernel/*)
    *(.eh_frame .eh_frame.*)
  }

  .kernel : {
    . = ALIGN(0x1000);
    PROVIDE(kernelTextStart = .);
    *(.text .text.*)
    PROVIDE(kernelDataStart = .);
    *(.srodata .srodata.*)
    *(.rodata .rodata.*)
    *(.sdata .sdata.*)
    *(.data .data.*)
    *(.sbss .sbss.*)
    *(.bss .bss.*)
    *(.eh_frame .eh_frame.*)
  }

  PROVIDE(end = .);
}