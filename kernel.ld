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
    PROVIDE(kernelTextStart = .);
    EXCLUDE_FILE(build/src/user/*)
    *(.text .text.*)
    . = ALIGN(0x1000);
    PROVIDE(kernelTextEnd = .);
  }

  .rodata : {
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/user/*)
    *(.srodata .srodata.*) /* do not need to distinguish this from .rodata */
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/user/*)
    *(.rodata .rodata.*)
  }

  .data : {
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/user/*)
    *(.sdata .sdata.*) /* do not need to distinguish this from .data */
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/user/*)
    *(.data .data.*)
  }

  .bss : {
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/user/*)
    *(.sbss .sbss.*) /* do not need to distinguish this from .bss */
    . = ALIGN(16);
    EXCLUDE_FILE(build/src/user/*)
    *(.bss .bss.*)
  }

  .eh_frame : {
    EXCLUDE_FILE(build/src/user/*)
    *(.eh_frame .eh_frame.*)
  }

  .user : {
    . = ALIGN(0x1000);
    PROVIDE(userTextStart = .);
    *(.text .text.*)
    . = ALIGN(0x1000);
    PROVIDE(userDataStart = .);
    *(.srodata .srodata.*)
    *(.rodata .rodata.*)
    *(.sdata .sdata.*)
    *(.data .data.*)
    *(.sbss .sbss.*)
    *(.bss .bss.*)
    *(.eh_frame .eh_frame.*)
    . = ALIGN(0x1000);
    PROVIDE(userDataEnd = .);
  }

  PROVIDE(end = .);
}