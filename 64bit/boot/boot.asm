[org 0x7c00]

KERNEL_ADDRESS equ 0x100000

cli

ldgt [gdt_descriptor]

;Zmiana na tryb chroniony - Protected Mode - PM
mov eax, cr0
or eax, 0x1
mov cr0, eax

jmp 0x8:init_pm

[bits 32]

init_pm:
  mov ax, 0x10
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  
call build_page_tables

;Wlacz PAE
mov eax, cr4
or eax, 1 << 5
mov cr4, eax

;Opcjonalnie


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[bits 16]
times 510 -($-$$) db 0
dw 0xaa55

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
