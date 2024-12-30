	push bc
	ld a, b

	ld de, #4a2f
	call PrnNum16x20

	pop bc 
	ld a, c
	ld de, #4a31
	call PrnNum16x20

	; showing `days to DiHalt`
	ld a, %01000010
	ld (#598e), a
	ld (#598f), a
	ld (#5990), a
	ld (#5991), a
	ld (#5992), a

	ld (#59ae), a
	ld (#59af), a
	ld (#59b0), a
	ld (#59b1), a
	ld (#59b2), a

	ld (#59d0), a
	ld (#59d1), a

	ld a, %01000100
	ld (#59ce), a
	ld (#59cf), a
	ld (#59ee), a
	ld (#59ef), a

	ld a, %01000001
	ld (#5a0e), a
	ld (#5a0f), a
	ld (#5a10), a
	ld (#5a11), a
	ld (#5a2e), a
	ld (#5a2f), a
	ld (#5a30), a
	ld (#5a31), a

	ld (#5a4e), a
	ld (#5a4f), a
	ld (#5a50), a
	ld (#5a51), a
	ld (#5a52), a
	ld (#5a53), a

	ld (#5a6e), a
	ld (#5a6f), a
	ld (#5a70), a
	ld (#5a71), a
	ld (#5a72), a
	ld (#5a73), a

	ld (#5a8e), a
	ld (#5a8f), a
	ld (#5a90), a
	ld (#5a91), a
	ld (#5a92), a
	ld (#5a93), a

	ret

VinnnyCntHide	; Cleaning counter digits
	ld hl, #4a2f
	ld b, 20
1	push hl
	dup 4 : ld (hl), 0 : inc hl : edup
	pop hl
	call common.DownHL
	djnz 1b

	; hidding `days to DiHalt`
	ld hl, #598e
	ld de, 32 - 6
	ld b, 9
1	dup 6 : ld (hl), 0 : inc hl : edup
	add hl, de
	djnz 1b
	
	ret

; Print one 16x20 digit
; DE - Screen address
; A  - value [0-9]
PrnNum16x20	ld hl, FONT16
	ld b, 0 : ld c, a
	add hl, bc : add hl, bc

	ld b, 20
1	push bc
	ldi : ldi
	dec de : dec de
	call common.DownDE
	ld bc, 18
	add hl, bc
	pop bc
	djnz 1b
	ret 

FONT16	incbin "res/tg/font16.pcx", 128