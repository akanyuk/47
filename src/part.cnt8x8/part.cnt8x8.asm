	ld de, #40e8
	ld a, #34
	call PrnChar8x8Inv
	
	ld de, #40e8 + 9
	ld a, #37
	call PrnChar8x8Inv

	ld de, #5008 + 9
	ld a, #36
	call PrnChar8x8Inv

	call scrollCnt

	ret

scrollCnt	ld hl, #4808 + 9
	ld de, #47e8 + 9
	ld a, 128
2	push af
	push hl
	push de
	ld bc, 8
	ldir
	pop de
	call common.DownDE
	pop hl
	call common.DownHL
	pop af
	dec a : jr nz, 2b
	ret

; Print one inverted 8x8 char with ROM font
; DE - Screen address
; A  - char
PrnChar8x8Inv	sub #1f
	ld hl, #3d00 - #08
	ld bc, #08
1	add hl, bc
	dec a
	jr nz, 1b
	ex de, hl

	ld b, 8
1	push bc
	push hl

	ld a, (de) 
	ld b, 8
2	sla a : jr c, 3f
	push af
	push hl
	ld (hl), #ff : inc h
	ld (hl), #ff : inc h
	ld (hl), #ff : inc h
	ld (hl), #ff : inc h
	ld (hl), #ff : inc h
	ld (hl), #ff : inc h
	ld (hl), #ff : inc h
	ld (hl), #ff
	call common.DownHL
	pop hl
	pop af
3	inc hl
	djnz 2b

	inc de

	pop hl
	call downHL8

	pop bc
	djnz 1b

	ret 

downHL8	ld a, 8 : add h : ld h, a : ld a,l : sub #e0 : ld l,a : sbc a,a : and #f8 : add a,h : ld h,a : ret