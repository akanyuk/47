	device zxspectrum128
	page 0
	org #6000

	ld sp, $-2

	xor a : out (#fe), a

	ld a, #13 : ld bc, #7ffd : out (c), a 
	ld hl, #c000
	ld de, #4000
	ld bc, #1b00
	ldir

	ei

loop	
	ld a, #10 : ld bc, #7ffd : out (c), a 
	ld b, 13
1	push bc
	call fast.DisplayFrame
	call fast.NextFrame
	halt
	halt
	halt
	halt
	pop bc
	djnz 1b

	ld a, #11 : ld bc, #7ffd : out (c), a 	
	ld b, 3
1	push bc
	call fast.DisplayFrame
	call fast.NextFrame
	halt
	halt
	halt
	halt
	pop bc
	djnz 1b

	jr loop

DATA	module fast
	include "player.asm"
	endmodule

	page 3
	org #c000
	incbin "first.scr"

	savesna "fast.sna", #6000
