	device zxspectrum128

	; define DEBUG 1

	org #6000
	module common
	include "src/common/common.asm"	
	endmodule

start	ei : ld sp, start

	ld a, 0 : out (#fe), a 

1	ld bc, #3437
	call cnt8x8.Initial

	ld b, 50 : halt : djnz $-1

	ld a, 3
	call cnt8x8.Do

	ld a, 7 : out (#fe), a 
	halt
	call common.ClearScreen
	halt
	ld a, 0 : out (#fe), a 
	ld b, 10 : halt : djnz $-1

	jr 1b
	di : halt

PART_START	
	module cnt8x8
	include "part.cnt8x8.asm"
	endmodule
				
	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
