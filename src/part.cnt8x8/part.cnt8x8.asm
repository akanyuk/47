	; ld bc, #3437  ; starting cnt (47)
Initial	ld a, b
	ld (_st1 + 1), a
	ld a, c
	ld (_st2.1 + 1), a

	ld a, %01000010 : call common.SetScreenAttr
	ld hl, #5a00 : ld de, #5a01 : ld bc, #00ff : ld (hl), l : ldir
	jp initialState

	; ld a, 3	; number of ticks
Do	ld (_doCnt + 1), a
	ld a, (_st1 + 1)
	ld b, a
	ld a, (_st2.1 + 1)
	ld c, a
_doCnt	ld a, 0	
	push af
	push bc
	ld a, b
	ld (_st1 + 1), a
	ld a, c
	ld (_st2.1 + 1), a
	ld (_st2.2 + 1), a
	dec a
	ld (_st3 + 1), a

	call doCnt
	ld b, 10 : halt : djnz $-1
	ld hl, #5000 : ld de, #5001 : ld bc, #07ff : ld (hl), l : ldir

	ld b, 10 : halt : djnz $-1

	pop bc 
	dec c 

	pop af : dec a : jr nz, _doCnt + 2
	ret

doCnt	call initialState

	ld de, #5000
_st2.2	ld a, #37
	call PrnChar8x8Inv

	ld de, #5008
_st3	ld a, #36
	call PrnChar8x8Inv
	
	ld hl, #56e0 : ld e, %10101010 : call setMsk3
	ld hl, #57e0 : ld e, %00000000 : call setMsk3
	ld hl, #5008 : ld e, %01010101 : call setMsk3

	ld a, 1
1	push af
	call dispCnt
	call setMask
	halt
	pop af
	inc a : cp #40 : jr nz, 1b

	ret

initialState	ld de, #4807
_st1	ld a, #34
	call PrnChar8x8Inv

	ld de, #4807 + 9
_st2.1	ld a, #37
	call PrnChar8x8Inv
	jp setMask

setMask	ld hl, #4807 : ld e, %10101010 : call setMsk3 : inc hl : call setMsk3
	ld hl, #4907 : ld e, %01010101 : call setMsk3 : inc hl : call setMsk3
	ld hl, #4ee7 : ld e, %10101010 : call setMsk3 : inc hl : call setMsk3
	ld hl, #4fe7 : ld e, %01010101 : call setMsk3 : inc hl

setMsk3	ld b, 8
1	ld (hl), e : inc hl
	djnz 1b
	ret

	; a: phase 0 - 63
dispCnt	ld hl, #5000
	push af
	ld b, a
1	call common.DownHL
	djnz 1b
	pop af
	push af
	ld b, a : ld a, #40 : sub b
	ld de, #4807 + 9
1	push af
	push hl
	push de
	ld bc, 8 : ldir
	pop de : call common.DownDE
	pop hl : call common.DownHL
	pop af 
	dec a : jr nz, 1b

	pop af
	ld hl, #5008
1	push af
	push hl
	push de
	ld bc, 8 : ldir
	pop de : call common.DownDE
	pop hl : call common.DownHL
	pop af 
	dec a : jr nz, 1b

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