	device zxspectrum128

	; define DEBUG 1

	org #6000
start
	module common
	include "src/common/common.asm"	
	endmodule

	ei : ld sp, start

	ld a, 0 : out (#fe), a 

	call PART_START
	
	di : halt

PART_START	
	module tg
	include "part.tg.asm"
	endmodule
				
	display /d, 'Part length: ', $ - PART_START
	display 'Part ended at: ', $

	; build
	if (_ERRORS == 0 && _WARNINGS == 0)
	  savesna SNA_FILENAME, start	  ; SNA_FILENAME defined in Makefile
	  savebin BIN_FILENAME, PART_START, $-PART_START  ; BIN_FILENAME defined in Makefile
	endif
