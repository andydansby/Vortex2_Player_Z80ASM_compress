;Test codes (commented)
;Entry and other points
;START initialize playing of module at MDLADDR
;START+3 initialization with module address in HL
;START+5 play one quark
;START+8 mute
;START+10 setup and status flags
;START+11 current position value (byte) (optional)

;START
;	LD HL,MDLADDR	;START
;	JR INIT			;START+3
;	JP PLAY			;START+5
;	JR MUTE			;START+8
;SETUP	DB 0 		;START+10
;CurPos	DB 0 		;START+11
	SECTION MAIN
	ORG 0x8000


lockandload:	
    LD A,2	
    LD (START+10),A
	
	call UNCOMP_SONG
	
	ld hl, BUFFER_UNCOMP
	;ld hl, song1
	
    CALL START+3	
    EI

_LP:
	HALT
	
	CALL START+5	
	XOR A	;test keyboard	
	IN A,($FE)	
	CPL	
	AND 15	
	JR Z, _LP
	
	JP START+8	
ret
	
; ZX0 Parameters:
; HL: source address (compressed data)
; DE: destination address (decompressing)
UNCOMP_SONG:
	ld hl, song1
	;call EXT_WORD
	ld de, BUFFER_UNCOMP
	call dzx0_standard
	RET

SECTION PTZX_Player
ORG 0xC000

	include "Z_PTZX.asm"
BUFFER_UNCOMP:
	defs $2000	;defs $1522
; Space for the largest pt3 file

	
; *** Song ***
song1:
    binary "songs\TrafOfD.zx0"

