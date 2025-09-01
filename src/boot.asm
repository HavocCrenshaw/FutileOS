org 0x7C00
bits 16

main:
    hlt ; Nothing to be done

.halt:
    jmp .halt ; Catch the processor if it tries to run away

times 510 - ($ - $$) db 0
dw 0xAA55
