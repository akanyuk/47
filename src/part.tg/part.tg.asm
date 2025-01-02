First	xor a : call common.SetScreenAttr

	ld hl, TG_BG
	ld de, #4000
	call common.Depack

	ld bc, 20
	ld a, 15
	call .tgMain

	call dispVinnny
	ld b, 30 : halt : djnz $-1
	ld bc, #0300
	call dispVinnnyCnt
	ld b, 100 : halt : djnz $-1
	call VinnnyCntHide
	call VinnnyHide

	ld bc, 20
	ld a, 15
	call .tgMain

	call dispVinnny
	ld b, 30 : halt : djnz $-1
	ld bc, #0200
	call dispVinnnyCnt
	ld b, 100 : halt : djnz $-1
	call VinnnyCntHide
	call VinnnyHide

	ld bc, 10
	ld a, 15
	call .tgMain

	call dispVinnny
	ld b, 30 : halt : djnz $-1
	ld bc, #0100
	call dispVinnnyCnt
	ld b, 100 : halt : djnz $-1
	call VinnnyCntHide
	call VinnnyHide

	ld bc, 40
	ld a, 1
	call .tgMain

	ret

.tgMain	ld (.tgLoopSpd + 1), a
	push bc

	call scroll ; scrolling text from previous loop

	; at begining always show avatar
	call dispAvatar
	ld a, #ff : ld (.avaState + 1), a
	
	pop bc

.tgMainLoop	push bc
.avaState	ld a, 0
	inc a : ld (.avaState + 1), a
	cp 3 : jr c, .skipAva
	call RND8
	cp #60 : jr c, .skipAva

	call dispAvatar
	xor a : ld (.avaState + 1), a

.skipAva	or a : jr z, 1f ; picture only if no avatar before
	call RND8
	cp #d0 : jr c, 1f

	call ScrollFast2x
	call ScrollFast2x
	call dispPicture	
	jr 2f
1	call dispNewMsg
2

.tgLoopSpd	ld b, 20 : halt : djnz $-1 

	call scroll
	
	pop bc
	dec bc
	ld a, b : or c : jr nz, .tgMainLoop

	call dispNewMsg
	ret	

scroll	include "scroll.asm"
dispNewMsg	include "message.asm"
dispAvatar	include "avatar.asm"
dispPicture	include "picture.asm"
dispVinnny	include "vinnny.asm"
dispVinnnyCnt	include "vinnny_cnt.asm"
TG_BG	incbin "res/tg/tg-001.scr.zx0"

RND8	ld a, 42
	ld hl, RND_TAB
	dup 5: add a,(hl): ld (hl),a: inc hl: edup
	ld (RND8 + 1), a
	ret
RND_TAB 	DB 'as^GK'