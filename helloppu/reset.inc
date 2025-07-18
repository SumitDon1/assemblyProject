;; Macro to initialize the NES by disabling rendering and clearing RAM values

.macro INIT_NES
    sei                 ; Disable all IRQ interrupts
    cld                 ; Clear the decimal mode (unsupported by the NES)
    ldx #$FF
    txs                 ; Initialize the stack pointer at $01FF
    inx                 ; Increment X, causing a roll-off from $FF to $00
    stx PPU_CTRL           ; disable NMI
    stx PPU_MASK           ; disable rendering
    stx $4010              ; disable DMC IRQs

    lda #$40
    sta $4017           ; disable APU frame IRQ

;; we have to wait for 2 b blank for this 
Wait1stVBlank:
    bit PPU_STATUS      ;Perform a bitwise check with PPU_STATUS
    bpl Wait1stVBlank   ;Loop until bit-7 (sign bit) is 1 (inside VBlank)

    txa                 ; A = 0

ClearRAM:   
    sta $0000,x         ; Zero RAM addresses from $0000 to $00FF
    sta $0100,x         ; Zero RAM addresses from $0100 to $01FF
    sta $0200,x         ; Zero RAM addresses from $0200 to $02FF
    sta $0300,x         ; Zero RAM addresses from $0300 to $03FF
    sta $0400,x         ; Zero RAM addresses from $0400 to $04FF
    sta $0500,x         ; Zero RAM addresses from $0500 to $05FF
    sta $0600,x         ; Zero RAM addresses from $0600 to $06FF
    sta $0700,x         ; Zero RAM addresses from $0700 to $07FF
    inx                 ; X++
    bne ClearRAM        ; Loops until X reaches 0 again (after roll-off)

Wait2ndVBlank:
    bit PPU_STATUS      ;Perform a bitwise check with PPU_STATUS
    bpl Wait2ndVBlank   ;Loop until bit-7 (sign bit) is 1 (inside VBlank)

.endmacro