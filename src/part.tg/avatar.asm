	call RND8
	ld l, a 
	and 3 : ld h, a

	ld de, #5061
	ld bc, AVATAR_MASK
	ld ix, AVATAR_MASK2
	ld a, 16
1	push af
	ld a, (bc) : and (hl) : or (ix + 0) : ld (de), a
	inc hl
	inc bc
	inc de
	inc ix
	ld a, (bc) : and (hl) : or (ix + 0) : ld (de), a
	inc hl
	inc bc
	inc ix
	dec de
	call common.DownDE
	pop af
	dec a : jr nz, 1b

	; colorize
1	call RND8
	call RND8
	and 3 : add 3
.lastAvaColor	cp 0 : jr z, 1b
	ld (.lastAvaColor + 1), a

	; ld (#5a21), a
	; ld (#5a22), a
	ld (#5a41), a
	ld (#5a42), a
	ld (#5a61), a
	ld (#5a62), a
	ld (#5a81), a
	ld (#5a82), a

	ret

AVATAR_MASK	db %00000111, %11100000
	db %00011111, %11111000
	db %00111111, %11111100
	db %01111111, %11111110
	db %01111111, %11111110
	db %11111111, %11111111	
	db %11111111, %11111111	
	db %11111111, %11111111	
	db %11111111, %11111111	
	db %11111111, %11111111	
	db %11111111, %11111111	
	db %01111111, %11111110
	db %01111111, %11111110
	db %00111111, %11111100
	db %00011111, %11111000
	db %00000111, %11100000

AVATAR_MASK2	db %00000111, %11100000
	db %00011000, %00011000
	db %00100000, %00000100
	db %01000000, %00000010
	db %01000000, %00000010
	db %10000000, %00000001	
	db %10000000, %00000001	
	db %10000000, %00000001	
	db %10000000, %00000001	
	db %10000000, %00000001	
	db %10000000, %00000001	
	db %01000000, %00000010
	db %01000000, %00000010
	db %00100000, %00000100
	db %00011000, %00011000
	db %00000111, %11100000
