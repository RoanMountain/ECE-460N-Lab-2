            .ORIG X3000
            LEA R0, B
            LDW R0, R0, #0 ; Get X3100 in R0
            LDB R2, R0, #1 ; Get val in x3101
            LDB R1, R0, #0 ; get val in x3100
            AND R3, R3, #0 ; clear R3 for multiplication
            AND R4, R4, #0

LOOP        ADD R2, R2, #0
            BRz DONE
            ADD R3, R3, R1 ;Add R1 to R3 R2 times
            ADD R2, R2, #-1
            BRnzp LOOP

DONE        LEA R5, MASK
            LDW R5, R5, #0 ; Get our bitmask
            AND R5, R5, R3 ; Check if byte addition overflowed into bit 9+
            BRz NOVERFLOW
            ADD R4, R4, #1

NOVERFLOW   STB R3, R0, #2 ; Store our final values
            STB R4, R0, #3
            HALT

MASK        .FILL XFF00
B           .FILL X3100
