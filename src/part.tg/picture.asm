	call RND8
	ld l, a 
	and #5f : ld h, a

	ld de, #48c3
	call .picLine

	ld b, 54
1	push bc
	push de

	ld a, (hl) : and %0000011 : or %00000100 : ld (de), a
	inc hl : inc de

	ld b, 8
2	ld a, (hl) : inc hl : or (hl) : inc hl : or (hl) : ld (de), a
	inc de
	djnz 2b

	ld a, (hl) : and %11110000 : or %00001000 : ld (de), a
	inc hl : inc de

	pop de
	call common.DownDE
	pop bc
	djnz 1b

	; call .picLine
	; ret

.picLine	push de
	ld a, %00000011 : ld (de), a : inc de
	ld a, #ff
	ld b, 8
1	ld (de), a 
	inc de
	djnz 1b
	ld a, %11110000 : ld (de), a : inc de
	pop de
	jp common.DownDE

