	ld hl, PART_ANIMA_F0
	ld de, #4000
	call common.Depack

loop	
	ld a, 1 : call common.SetPage
	ld b, 5
1	push bc
	call DisplayFrame
	call NextFrame
	halt
	halt
	halt
	halt
	pop bc
	djnz 1b

	ld a, 3 : call common.SetPage
	ld b, 6
1	push bc
	call DisplayFrame
	call NextFrame
	halt
	halt
	halt
	halt
	pop bc
	djnz 1b

	ld a, 4 : call common.SetPage
	ld b, 5
1	push bc
	call DisplayFrame
	call NextFrame
	halt
	halt
	halt
	halt
	pop bc
	djnz 1b

	jr loop

DisplayFrame    ld hl,FRAME_0000
                jp(hl)

NextFrame	ld HL,FRAMES
	inc hl : inc hl
	ld a,l
	cp low(FRAMES_END)
	jp nz, 1f
	ld a,h
	cp high(FRAMES_END)
	jp nz,1f
	ld hl,FRAMES
1	ld (NextFrame+1),hl
	ld e, (hl)
	inc hl
	ld d,(hl)
	ex de,hl
	ld (DisplayFrame+1),hl
	ret

FRAMES
	dw FRAME_0000
	dw FRAME_0001
	dw FRAME_0002
	dw FRAME_0003
	dw FRAME_0004
	dw FRAME_0005
	dw FRAME_0006
	dw FRAME_0007
	dw FRAME_0008
	dw FRAME_0009
	dw FRAME_000a
	dw FRAME_000b
	dw FRAME_000c
	dw FRAME_000d
	dw FRAME_000e
	dw FRAME_000f
FRAMES_END

PART_ANIMA_F0	incbin "res/anima1/first.scr.zx0"
