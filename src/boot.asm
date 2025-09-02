ORG 0x7C00
BITS 16

main:
    MOV SI, hello
    MOV AH, 0x0E ; Teletype output, moving the cursor one to the right after printing a character.
    MOV BH, 0x0 ; Page 0

print:
    LODSB
    TEST AL, AL ; Make sure we're done
    JZ input ; If zero, go and halt
    INT 0x10 ; Video interrupt
    JMP print

input:
    MOV AH, 0x0 ; Read key press
    INT 0x16 ; Keyboard interrupt
    CMP AL, 0x0D ; See if the key pressed is return
    JE halt ; If so, let's get out

    MOV AH, 0x0E
    INT 0x10
    JMP input ; Keep it looping

halt:
    CLI ; Disable hardware interrupts
    HLT
    JMP halt ; Catch the processor if it tries to run away

hello: DB "Type something, why don'tcha?", 0x0D, 0x0A, 0

TIMES 510 - ($ - $$) DB 0
DW 0xAA55
