ORG 0x7E00
BITS 16

main:
    CALL init
    MOV SI, _command
    CALL print

    ; Safety rails while there's no loop
    CLI
    HLT
    JMP main

print:
    MOV AH, 0x0E             ; Teletype output
    LODSB                    ; Load character from SI into AL and increment
    TEST AL, AL              ; Check if character is null
    JZ print_return
    INT 10h                  ; Video interrupt
    JMP print                ; Loop

print_return:
    RET

init:
    ; Prepare our screen for usage
    CALL clear
    RET

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

; Reads the current input from the keyboard, and saves printing characters, tabs, spaces, and newlines into the heap. It also handles other characters, such as
; the arrow keys and handles them accordingly.
readinput:

_command: DB "(> ", 0

TIMES 512 - ($ - $$) DB 0
