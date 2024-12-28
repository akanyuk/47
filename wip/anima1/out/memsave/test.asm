
	device zxspectrum128

	org #5d00
	ld sp, $-2

	xor a : out (#fe), a

	ld a, #13 : ld bc, #7ffd : out (c), a 
	ld hl, #c000
	ld de, #4000
	ld bc, #1b00
	ldir
	
	ld a, #10 : ld bc, #7ffd : out (c), a 
	ei 
	
1   	halt
	halt
    	ld de, #4000
	call	player
	jp	1b

player	module memsave
	include "player.asm"
	endmodule
	display /d, "Animation size: ", $-player
	savebin "memsave.bin", player, $-player

	page 3
	org #c000
	incbin "../fast/first.scr"

	savesna "memsave.sna", #5d00
