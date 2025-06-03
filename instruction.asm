; addressing mode
;;;IMMEDIATE MODE
LDA #80                 ; load A register with literal decimal 80

;;;AbSOLUTE (zero page mode) 
LDA $80                 ; loads A register with the value inside memory address $80

;;;ABSOLUTE (zero page indexed)
STA $80,X               ; store the value of A into memory address {$80 + X}

; Page zero are the memory address bw $00 and $FF
