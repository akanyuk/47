	call scrollAvaC

	ld b, 8
.sloop	push bc

	ld hl, #4261
	ld de, #4061
	ld b, 18*8
1	push bc
	push hl
	push de
	ld bc, 12 : ldir
	pop de : call common.DownDE
	pop hl : call common.DownHL
	pop bc : djnz 1b

	pop bc : djnz .sloop

	jp fourEmptyL

ScrollFast2x	call scrollAvaC

	ld b, 4
.sfloop	push bc

	ld hl, #4461
	ld de, #4061
	ld b, 18*8 - 4
1	push bc
	push hl
	push de
	ld bc, 12 : ldir
	pop de : call common.DownDE
	pop hl : call common.DownHL
	pop bc : djnz 1b

	pop bc : djnz .sfloop

	; call fourEmptyL
	; ret

fourEmptyL	; adding 4 empty lines
	ld hl, #4461
	ld de, #4061
	ld b, 17*8 - 4
1	push bc
	push hl
	push de
	ld bc, 12 : ldir
	pop de : call common.DownDE
	pop hl : call common.DownHL
	pop bc : djnz 1b
	ret
	
	; scrolling avatar colors
scrollAvaC	ld hl, #58c1
	ld de, #5861
	ld a, 15
1	ldi : ldi
	ld bc, #001e
	add hl, bc
	ex de, hl
	add hl, bc
	ex de, hl
	dec a : jr nz, 1b

	ret