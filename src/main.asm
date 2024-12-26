	device zxspectrum128

	; Parts addresses
	define A_PART_ANIMA1 #7000

	; Parts pages
	define P_PART_ANIMA1 1

	; Counters
	define C_PART_ANIMA1 200

	org #6000
page0s	
	module common
	include "src/common/common.asm"	
	endmodule
	
	di : ld sp, page0s
	xor a : out (#fe), a 

	call common.ClearScreen

	ld a,#be, i,a, hl,interr, (#beff),hl : im 2 : ei

1	ld de, C_PART_ANIMA1
	ld hl, (INTS_COUNTER) : sbc hl, de : jr c, 1b

	; part.anima1: depack and start
	ld a, P_PART_ANIMA1 : call common.SetPage
	ld hl, PART_ANIMA1_PACKED
	ld de, A_PART_ANIMA1
	call common.Depack
	call A_PART_ANIMA1

	jr $

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy
	ifdef _DEBUG_BORDER : ld a, #01 : out (#fe), a : endif ; debug

	; ints counter
INTS_COUNTER	equ $+1
	ld hl, #0000 : inc hl : ld ($-3), hl

	ifdef _DEBUG_BORDER : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

page0e	display /d, '[page 0] free: ', #ffff - $, ' (', $, ')'	

	define _page1 : page 1 : org #c000
page1s	
PART_ANIMA1_PACKED incbin "build/part.anima1.bin.zx0"
page1e	display /d, '[page 1] free: ', 65536 - $, ' (', $, ')'

	include "src/builder.asm"
