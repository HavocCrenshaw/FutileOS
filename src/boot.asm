ORG 0x7C00
BITS 16

main:
    CALL clear
    MOV SI, _hello
    CALL print
    CALL loadsectors

clear:
    ; Set video mode to guarantee behavior
    MOV AH, 00h              ; Set video mode
    MOV AL, 02h              ; 80x25 text resolution, 16 colors
    INT 10h                  ; Video interrupt
    
    ; Reset our cursor position
    MOV AH, 02h              ; Set cursor position
    MOV DH, 0                ; Row 0
    MOV DL, 0                ; Column 0
    INT 10h                  ; Video interrupt

    RET

print:
    MOV AH, 0x0E             ; Teletype output
    LODSB                    ; Load character from SI into AL and increment
    TEST AL, AL              ; Check if character is null
    JZ print_return
    INT 10h                  ; Video interrupt
    JMP print                ; Loop

print_return:
    RET

loadsectors:
    XOR AX, AX               ; Clear DS
    MOV DS, AX
    CLD

    MOV AH, 02h              ; Read sectors from drive
    MOV AL, 1                ; We want to read this many sectors
    MOV CH, 0                ; Cylinder 0
    MOV CL, 2                ; Sector 2
    MOV DH, 0                ; Head 0
    MOV DL, 0
    MOV ES, AX               ; Clear ES
    MOV BX, 0x7E00           ; Set data at next sector
    INT 13h                  ; Read/write drive interrupt
    JMP 0x0000:0x7E00        ; Jump to the next sector, we're done.

_hello: DB "Loading FutileOS...", 0

TIMES 510 - ($ - $$) DB 0
DW 0xAA55
