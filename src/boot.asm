ORG 0x7C00
BITS 16

main:
    MOV SI, hello
    MOV AH, 0x0E ; Teletype output, moving the cursor one to the right after printing a character.
    MOV BH, 0x0 ; Page 0

print:
    LODSB
    CMP AL, 0 ; Make sure we're done
    JZ halt ; If zero, go and halt
    INT 0x10 ; Video interrupt
    JMP print

halt:
    HLT;
    JMP halt ; Catch the processor if it tries to run away

hello: DB "Hello, World!", 0x0A, 0x0D, 0

TIMES 510 - ($ - $$) DB 0
DW 0xAA55
