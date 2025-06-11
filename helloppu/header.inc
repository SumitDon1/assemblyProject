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
