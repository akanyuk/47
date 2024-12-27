	device zxspectrum128

	; define DEBUG 1

	org #6000
	module common
	include "src/common/common.asm"	
	endmodule

start	ei : ld sp, start

	ld a, 1 : out (#fe), a 
	ld a, %01000010 : call common.SetScreenAttr

	call PART_START
	
	di : halt

PART_START	include "part.cnt8x8.asm"
		
	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
