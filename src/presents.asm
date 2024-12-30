	ld hl, PRESENTS_TEXT
	ld de, #40c8

; Print zero ended string with font 8х8
; HL - Text pointer
; DE - Text address
; PrintText 	
1	ld a, (hl)
	or a : ret z
	call PrintChar_8x8
	jr 1b

PRESENTS_TEXT	db "PACHCA PRESENTS", 0

; Print one char with ROM font
; DE - Screen memory address
; A  - char
PrintChar_8x8 	push hl, de, bc
	sub #1f
	ld hl, #3d00 - #08
	ld bc, #08
1	add hl, bc
	dec a
	jr nz, 1b

	dup 8 
	ld a, (hl) : ld (de), a
	inc d : inc l
	edup 

	pop bc, de, hl
	inc hl : inc de
	ret 
