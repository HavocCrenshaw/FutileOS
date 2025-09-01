org 0x7C00
bits 16

main:
    mov ah, 0x0A ; Write character
    mov al, 0x48 ; Letter h
    mov bh, 0x0 ; Page zero
    mov cx, 0x4 ; Print 4 times

    int 0x10 ; video interrupt

    hlt ; Nothing left to be done

.halt:
    jmp .halt ; Catch the processor if it tries to run away

times 510 - ($ - $$) db 0
dw 0xAA55
