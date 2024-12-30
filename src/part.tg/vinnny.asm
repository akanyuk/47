	ld a, 11
1	push af
	call vinnnyStage
	pop af
	dec a : cp #ff : jr nz, 1b
	ret

VinnnyHide	xor a
1	push af
	ld (.vhMod + 1), a
	call vinnnyStage
	ld hl, #4034	
.vhMod	ld a, 0
	add l : ld l, a
	ld b, 176
2	ld (hl), 0
	call common.DownHL
	djnz 2b

	pop af
	inc a : cp 12 : jr nz, 1b
	ret

vinnnyStage	ld (.vs2 + 1), a
	
	ld e, a
	ld hl, .vs1 + 1
	cpl : add (hl) : inc a : ld (hl), a
	ld a, e

	ld hl, VINNNY
	ld de, #4034
	add e : ld e, a
	ld b, 176
.vsLoop	push bc
	push de
.vs1	ld bc, 12
	ldir

.vs2	ld a, 0
1	or a : jr z, 2f
	inc hl
	dec a : jr 1b
2	pop de
	call common.DownDE
	pop bc
	djnz .vsLoop

	ld a, 12 : ld (.vs1 + 1), a ; restoring

	ret


VINNNY	incbin "res/tg/vinnny.pcx", 128
