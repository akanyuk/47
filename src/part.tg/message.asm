	call RND8
	and 3 ; message lines count
	push af

	ld de, #5063
	call dispLine

	pop af : dec a : ret z
	push af

	ld de, #5463
	call dispLine

	pop af : dec a : ret z
	push af

	ld de, #5083
	call dispLine

	pop af : dec a : ret z

	ld de, #5483
	call dispLine

	ret

	; de - screen addr
dispLine	call fillLineBuf
	call dispLineBuf
	call dispLineBuf
	; call dispLineBuf
	; ret
dispLineBuf	push de
	call RND8
	ld l, a 
	and 3 : ld h, a
	ld bc, LINE_BUFF
	dup 9
	ld a, (bc) : and (hl) : ld (de), a
	inc hl
	inc de
	inc bc
	edup
	ld a, (bc) : and (hl) : ld (de), a
	pop de
	inc d
	ret

fillLineBuf	ld hl, LINE_BUFF
1	ld (hl), 0
	inc hl 
	ld a, l : cp 10 : jr nz, 1b

	call RND8
	and 3 : inc a

	ld hl, LINE_BUFF
	ld (hl), %00000111 ; first letter always with space before
1	inc hl 
	ld (hl), %01110111
	dec a : jr nz, 1b

	; second word

	push hl
	call RND8
	pop hl
	and 3 : inc a

	add l : cp 10 : ret nc
	sub l

	ld (hl), %00000111 ; first letter always with space before
1	inc hl 
	ld (hl), %01110111
	dec a : jr nz, 1b

	; third word
	
	push hl
	call RND8
	pop hl
	and 3 : inc a

	add l : cp 10 : ret nc
	sub l

	ld (hl), %00000111 ; first letter always with space before
1	inc hl 
	ld (hl), %01110111
	dec a : jr nz, 1b

	ret

	align #100
LINE_BUFF	block 10
