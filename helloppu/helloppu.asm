.include "consts.inc"
.include "header.inc"
.include "reset.inc"
;; PRG-ROM code located at $8000

.segment "CODE"

.proc LoadPalette
    ldy #0
LoopPalette:
    ;; TODO
    lda PaletteData,y               ; lookup byte in ROM
    sta PPU_DATA                    ; set value to send to PPU_DATA
    iny                             ; y++
    cpy #32                         ;is y equL 32
    bne LoopPalette                 ;not yet we should keep look
    rts
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reset handler (called when the NES resets/powers-on)   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; check reset.inc
Reset:      
    INIT_NES

Main:
    ; setting the main backgnd color to $2A(lime green)
    ; see image 25-06-04 185833
    bit PPU_STATUS
    ldx #$3F                       ; 
    stx PPU_ADDR                   ; Set hi-byte of PPU_ADDR to $3F
    ldx #$00                       ; 
    stx PPU_ADDR                   ; set lo-byte of PPU_ADDR to $00

    jsr LoadPalette                 ; jump to subroutine LoadPalette

    ; lda #$2A                       ; 
    ; sta PPU_DATA                   ; send $2A lime green code to PPU_ADDR
    lda #%00011110                 ; 
    sta PPU_MASK                   ; set PPU_MASK bits to show background


LoopForever:
    jmp LoopForever             ; Forces an infinite loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NMI:
    rti                         ; return from interrupt

IRQ:
    rti                         ; return from interrupt

PaletteData:
.byte $0F,$2A,$0C,$3A,$0F,$2A,$0C,$3A,$0F,$2A,$0C,$3A,$0F,$2A,$0C,$3A ; backgnd
.byte $0F,$10,$00,$26,$0F,$10,$00,$26,$0F,$10,$00,26,$0F,$10,$00,$26  ; sprites

.segment "VECTORS"
.word NMI                       ; address which is 2 bytes of NMI handler
.word Reset                     ; address which is 2 bytes of reset handler
.word IRQ                       ; address which is 2 bytes of IRQ handler
; address of the NMI handler
; address of the RESET handler
; address of the IRQ handler

