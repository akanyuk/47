Init	ld a, 7 : call common.SetPage
	ld a, 1 : call common.SetScreen
	ld hl, #c000 : ld de, #c001 : ld bc, #1800 : ld (hl), l : ldir
	ld bc, #02ff : ld (hl), 7 : ldir
	xor a : call common.SetPage
	xor a : call common.SetScreen
	ret

Stop	xor a : call common.SetScreen
	ld a, %00010111 : ld bc, #7ffd : out (c), a 
	ld hl, #c000 : ld de, #c001 : ld bc, #17ff : ld (hl), l : ldir
	ld a, (common.CUR_PAGE) : or %00010000 : ld bc, #7ffd : out (c), a
	ret

Do	call common.SwapScreen
	ld a, %00010111 : ld bc, #7ffd : out (c), a

	call randomNoise
	call randomNoiseA
	
	ld a, (common.CUR_PAGE) : or %00010000 : ld bc, #7ffd : out (c), a
	ret

randomNoiseA	ld b, #c1
	call rl1

	ld b, #c9
	call rl1

	ld b, #d1
	jr rl1

randomNoise	ld b, #c0
	call rl1

	ld b, #c8
	call rl1

	ld b, #d0

rl1	call rnd16
	ld a, h : and %00000011
	rla
	or b
	ld d, a

	ld a, l : and %11100000 : ld e, a
	ld bc, 32
	push de
	call rnd16
	pop de
	ld h, 0
	ldir
	ret

;----------------------------------------
; in:  none
; out: HL = random 16bit value
;----------------------------------------
rnd16
.sd 	equ  $+1
	ld   de, 1234
	ld   a, d
	ld   h, e
	ld   l, 253
	or   a
	sbc  hl, de
	sbc  a, 0
	sbc  hl, de
	ld   d, 0
	sbc  a, d
	ld   e, a
	sbc  hl, de
	jr   nc, .st
	inc  hl
.st 	ld  (.sd), hl
    	ret