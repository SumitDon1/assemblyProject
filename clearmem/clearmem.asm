
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; iNES header contains a total of 16 bytes with the flags at $7FF0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "HEADER"
;; basically we are setting the 16kb of ram available in PRGROM
.byte $4E,$45,$53,$1A			; 4 bytes with the characters 'N''E''S''\n'
.byte $02				        ; how many 16KIB of ram we have (we have 2 ie 32 kb)
.byte $01				        ; how many 8KB of CHR-ROM we'll use(8 KIB)
.byte %00000000			    	; horz mirroring,no battery,mapper 0
.byte %00000000			    	; mapper 0, playchoice,NES 2.0
.byte $00				        ; no PRG-RAM
.byte $00 			        	; NTSC tv form
.byte $00 			        	; NO PRG-RAM
.byte $00,$00,$00,$00,$00		; unused padding to complete 16 bytes of header

;; PRG-ROM code located at $8000

.segment "CODE"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reset handler (called when the NES resets/powers-on)   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Reset:      
    sei                 ; Disable all IRQ interrupts
    cld                 ; Clear the decimal mode (unsupported by the NES)
    ldx #$FF
    txs                 ; Initialize the stack pointer at $01FF

    inx                 ; Increment X, causing a roll-off from $FF to $00

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

LoopForever:
    jmp LoopForever     ; Forces an infinite loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NMI:
    rti                         ; return from interrupt

IRQ:
    rti                         ; return from interrupt



.segment "VECTORS"
.word NMI                       ; address which is 2 bytes of NMI handler
.word Reset                     ; address which is 2 bytes of reset handler
.word IRQ                       ; address which is 2 bytes of IRQ handler
; address of the NMI handler
; address of the RESET handler
; address of the IRQ handler

