	define _MUSIC_ 1
	define P_TRACK 6 ; трек и плеер лежат здесь

	device zxspectrum128
	page 0
	org #6000
page0s	
	module common
	include "src/common/common.asm"	
	endmodule
	
	di : ld sp, page0s
	xor a : out (#fe), a 

	call common.ClearScreen

	ifdef _MUSIC_
	ld a, P_TRACK : call common.SetPage
	call PT3PLAY
	ld a, #01 : ld (MUSIC_STATE), a
	endif

	ld a,#5c : ld i,a : ld hl,interr : ld (#5cff),hl : im 2 : ei

	call PART_ANIMA1
	jr $

interr	di
	push af,bc,de,hl,ix,iy
	exx : ex af, af'
	push af,bc,de,hl,ix,iy
	ifdef _DEBUG_BORDER : ld a, #01 : out (#fe), a : endif ; debug

	ifdef _MUSIC_
MUSIC_STATE	equ $+1	
	ld a, #00 : or a : jr z, 1f
	ld a, (common.CUR_SCREEN) : ld b, a
	ld a, P_TRACK : or b : or %00010000
	ld bc, #7ffd : out (c), a
	call PT3PLAY + 5	
	// Restore page
	ld a, (common.CUR_SCREEN) : ld b, a 
	ld a, (common.CUR_PAGE) : or b : or %00010000
	ld bc, #7ffd : out (c), a
1	
	endif

	; ints counter
INTS_COUNTER	equ $+1
	ld hl, #0000 : inc hl : ld ($-3), hl

	ifdef _DEBUG_BORDER : xor a : out (#fe), a : endif ; debug
	pop iy,ix,hl,de,bc,af
	exx : ex af, af'
	pop iy,ix,hl,de,bc,af
	ei
	ret

PART_ANIMA1	include "src/part.anima1/part.anima1.asm"

page0e	display /d, '[page 0] free: ', #ffff - $, ' (', $, ')'	

	define _page1 : page 1 : org #c000
page1s	
FRAME_0000	include "res/anima1/0000.asm"
FRAME_0001	include "res/anima1/0001.asm"
FRAME_0002	include "res/anima1/0002.asm"
FRAME_0003	include "res/anima1/0003.asm"
FRAME_0004	include "res/anima1/0004.asm"
page1e	display /d, '[page 1] free: ', 65536 - $, ' (', $, ')'

	define _page3 : page 3 : org #c000
page3s	
FRAME_0005	include "res/anima1/0005.asm"
FRAME_0006	include "res/anima1/0006.asm"
FRAME_0007	include "res/anima1/0007.asm"
FRAME_0008	include "res/anima1/0008.asm"
FRAME_0009	include "res/anima1/0009.asm"
FRAME_000a	include "res/anima1/000a.asm"
page3e	display /d, '[page 3] free: ', 65536 - $, ' (', $, ')'

	define _page4 : page 4 : org #c000
page4s	
FRAME_000b	include "res/anima1/000b.asm"
FRAME_000c	include "res/anima1/000c.asm"
FRAME_000d	include "res/anima1/000d.asm"
FRAME_000e	include "res/anima1/000e.asm"
FRAME_000f	include "res/anima1/000f.asm"
page4e	display /d, '[page 4] free: ', 65536 - $, ' (', $, ')'

	define _page6 : page 6 : org #c000
page6s	
PT3PLAY	include "src/PTxPlay.asm"
	incbin "res/vetattk.pt3"
page6e	display /d, '[page 6] free: ', 65536 - $, ' (', $, ')'

	include "src/builder.asm"
