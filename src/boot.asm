ORG 0x7C00
BITS 16

clear:
    MOV AH, 0x05 ; Select page
    MOV AL, 0x1 ; Page 1
    INT 0x10

main:
    MOV SI, command
    MOV AH, 0x0E ; Teletype output, moving the cursor one to the right after printing a character.
    MOV BH, 0x1 ; Page 0

print:
    LODSB
    TEST AL, AL ; Make sure we're done
    JZ input ; If zero, go and halt
    INT 0x10 ; Video interrupt
    JMP print

input:
    MOV AH, 0x0 ; Read key press
    INT 0x16 ; Keyboard interrupt
    CMP AL, 0x0D ; Check if it's a carriage return
    JE newline
    MOV AH, 0x0E
    INT 0x10
    JMP input ; Keep it looping

newline:
    MOV AH, 0x0E
    MOV AL, 0x0D ; Return
    INT 0x10
    MOV AL, 0x0A ; Newline
    INT 0x10
    JMP input ; Keep it loopin

halt:
    CLI ; Disable hardware interrupts
    HLT
    JMP halt ; Catch the processor if it tries to run away

command: DB "(> ", 0

TIMES 510 - ($ - $$) DB 0
DW 0xAA55
