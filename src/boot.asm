org 0x7C00
bits 16

main:
    ; Brute forcing Hello World because I can't do assembly, lol
    mov ah, 0x0A ; Write character
    mov al, 0x48 ; Letter 'H'
    mov bh, 0x0 ; Page zero
    mov cx, 0x1 ; Print once

    int 0x10 ; Video interrupt

    mov ah, 0x03 ; Get cursor position
    int 0x10
    inc dl ; Move the cursor over one
    mov ah, 0x02 ; Set cursor position
    int 0x10

    mov ah, 0x0A
    mov al, 0x65 ; Letter 'e'
    mov cx, 0x1
    int 0x10

    mov ah, 0x02
    inc dl
    int 0x10

    mov ah, 0x0A
    mov al, 0x6C ; Letter `l`
    int 0x10

    mov ah, 0x02
    inc dl
    int 0x10

    mov ah, 0x0A
    mov al, 0x6C ; Letter `l`
    int 0x10

    mov ah, 0x02
    inc dl
    int 0x10

    mov ah, 0x0A
    mov al, 0x6F ; Letter `o`
    int 0x10

    hlt ; Nothing left to be done

.halt:
    jmp .halt ; Catch the processor if it tries to run away

times 510 - ($ - $$) db 0
dw 0xAA55
