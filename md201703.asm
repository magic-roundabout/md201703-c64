;
; MD201703 :: THE BAT-TRO
;

; Bat Code and bat graphics by T.M.R/Cosine
; bat music by aNdy/Cosine


; Select a bat filename
		!to "md201703.prg",cbm


; Yank in bat data
		* = $1000
bat_music	!binary "data/bat_music.prg",,2

		* = $5000
bat_charset	!binary "data/bat_chars.raw"

		* = $5600
		!binary "data/bat_sprites.spr"

		* = $5c00
		!binary "data/bat_colour.raw"

		* = $6000
		!binary "data/bat_bitmap.raw"


; Bat constants
bat_rstr1p	= $00
bat_rstr2p	= $31
bat_rstr3p	= $79
bat_rstr4p	= $99
bat_rstr5p	= $b9
bat_rstr6p	= $e3

; Bat label assignments
bat_rn		= $50
bat_sync	= $51

bat_twinkle_tmr	= $52
bat_twinkle_cnt	= $53

bat_cos_at_1	= $54
bat_offset_1	= $50		; bat constant
bat_voffset_1	= $0a		; bat constant
bat_anim_tmr	= $55
bat_anim_cnt	= $56

bat_scroll_spd	= $57
bat_speed_cnt	= $58
bat_char_wd_cnt	= $59

bat_buffer_1	= $5a		; $30 bat bytes (interleaved with next two)
bat_buffer_2	= $5b		; $30 bat bytes
bat_buffer_3	= $5c		; $30 bat bytes


; Bat entry point at $2000
		* = $2000
bat_entry	sei

; Turn off bat ROMs and set up bat interrupts
		lda #$35
		sta $01

		lda #<bat_nmi
		sta $fffa
		lda #>bat_nmi
		sta $fffb

		lda #<bat_int
		sta $fffe
		lda #>bat_int
		sta $ffff

		lda #$7f
		sta $dc0d
		sta $dd0d

		lda $dc0d
		lda $dd0d

		lda #bat_rstr1p
		sta $d012

		lda #$1b
		sta $d011
		lda #$01
		sta $d019
		sta $d01a

; Clear bat label space and set some specific labels
		ldx #$50
		lda #$00
bat_nuke_zp	sta $00,x
		inx
		bne bat_nuke_zp

		lda #$01
		sta bat_rn

		lda #$02
		sta bat_scroll_spd

; Invert bat bitmap data (the logo was built in P1 V0.5, so this is needed)
		ldx #$00
bat_bmp_invert	lda $6000,x
		eor #$ff
		sta $6000,x
		inx
		bne bat_bmp_invert

		ldx bat_bmp_invert+$02
		inx
		stx bat_bmp_invert+$02
		stx bat_bmp_invert+$07
		cpx #$80
		bne bat_bmp_invert-$02

; Reset the bat scroller and add a start delay
		jsr bat_reset

		lda #$80
		sta bat_char_wd_cnt

; Initialise the bat music
		lda #$00
		jsr bat_music+$00

		cli

; Bat runtime loop to update the bat scroller
bat_main_loop	lda #$00
		sta bat_sync
		cmp bat_sync
		beq *-$02

		lda bat_scroll_spd
		sta bat_speed_cnt

bat_scroll_loop	jsr bat_scroll
		dec bat_speed_cnt
		bne bat_scroll_loop


; Self mod bat stretched char 1
		ldy #$ff
		lda bat_buffer_1+$00
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_00a+$01

		ldy #$ff
		lda bat_buffer_1+$03
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_01a+$01

		ldy #$ff
		lda bat_buffer_1+$06
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_02a+$01

		ldy #$ff
		lda bat_buffer_1+$09
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_03a+$01

		ldy #$ff
		lda bat_buffer_1+$0c
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_04a+$01

		ldy #$ff
		lda bat_buffer_1+$0f
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_05a+$01

		ldy #$ff
		lda bat_buffer_1+$12
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_06a+$01

		ldy #$ff
		lda bat_buffer_1+$15
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_07a+$01

		ldy #$ff
		lda bat_buffer_1+$18
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_08a+$01

		ldy #$ff
		lda bat_buffer_1+$1b
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_09a+$01

		ldy #$ff
		lda bat_buffer_1+$1e
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_0aa+$01

		ldy #$ff
		lda bat_buffer_1+$21
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_0ba+$01

		ldy #$ff
		lda bat_buffer_1+$24
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_0ca+$01

		ldy #$ff
		lda bat_buffer_1+$27
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_0da+$01

		ldy #$ff
		lda bat_buffer_1+$2a
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_0ea+$01

		ldy #$ff
		lda bat_buffer_1+$2d
		and #$02
		bne *+04
		ldy #$00
		sty bat_ghost_0fa+$01

; Self mod bat stretched char 2
		ldy #$ff
		lda bat_buffer_1+$00
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_00b+$01

		ldy #$ff
		lda bat_buffer_1+$03
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_01b+$01

		ldy #$ff
		lda bat_buffer_1+$06
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_02b+$01

		ldy #$ff
		lda bat_buffer_1+$09
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_03b+$01

		ldy #$ff
		lda bat_buffer_1+$0c
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_04b+$01

		ldy #$ff
		lda bat_buffer_1+$0f
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_05b+$01

		ldy #$ff
		lda bat_buffer_1+$12
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_06b+$01

		ldy #$ff
		lda bat_buffer_1+$15
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_07b+$01

		ldy #$ff
		lda bat_buffer_1+$18
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_08b+$01

		ldy #$ff
		lda bat_buffer_1+$1b
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_09b+$01

		ldy #$ff
		lda bat_buffer_1+$1e
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_0ab+$01

		ldy #$ff
		lda bat_buffer_1+$21
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_0bb+$01

		ldy #$ff
		lda bat_buffer_1+$24
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_0cb+$01

		ldy #$ff
		lda bat_buffer_1+$27
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_0db+$01

		ldy #$ff
		lda bat_buffer_1+$2a
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_0eb+$01

		ldy #$ff
		lda bat_buffer_1+$2d
		and #$01
		bne *+04
		ldy #$00
		sty bat_ghost_0fb+$01

; Self mod bat stretched char 3
		ldy #$ff
		lda bat_buffer_2+$00
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_00c+$01

		ldy #$ff
		lda bat_buffer_2+$03
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_01c+$01

		ldy #$ff
		lda bat_buffer_2+$06
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_02c+$01

		ldy #$ff
		lda bat_buffer_2+$09
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_03c+$01

		ldy #$ff
		lda bat_buffer_2+$0c
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_04c+$01

		ldy #$ff
		lda bat_buffer_2+$0f
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_05c+$01

		ldy #$ff
		lda bat_buffer_2+$12
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_06c+$01

		ldy #$ff
		lda bat_buffer_2+$15
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_07c+$01

		ldy #$ff
		lda bat_buffer_2+$18
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_08c+$01

		ldy #$ff
		lda bat_buffer_2+$1b
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_09c+$01

		ldy #$ff
		lda bat_buffer_2+$1e
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_0ac+$01

		ldy #$ff
		lda bat_buffer_2+$21
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_0bc+$01

		ldy #$ff
		lda bat_buffer_2+$24
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_0cc+$01

		ldy #$ff
		lda bat_buffer_2+$27
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_0dc+$01

		ldy #$ff
		lda bat_buffer_2+$2a
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_0ec+$01

		ldy #$ff
		lda bat_buffer_2+$2d
		and #$80
		bne *+04
		ldy #$00
		sty bat_ghost_0fc+$01

; Self mod bat stretched char 4
		ldy #$ff
		lda bat_buffer_2+$00
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_00d+$01

		ldy #$ff
		lda bat_buffer_2+$03
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_01d+$01

		ldy #$ff
		lda bat_buffer_2+$06
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_02d+$01

		ldy #$ff
		lda bat_buffer_2+$09
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_03d+$01

		ldy #$ff
		lda bat_buffer_2+$0c
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_04d+$01

		ldy #$ff
		lda bat_buffer_2+$0f
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_05d+$01

		ldy #$ff
		lda bat_buffer_2+$12
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_06d+$01

		ldy #$ff
		lda bat_buffer_2+$15
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_07d+$01

		ldy #$ff
		lda bat_buffer_2+$18
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_08d+$01

		ldy #$ff
		lda bat_buffer_2+$1b
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_09d+$01

		ldy #$ff
		lda bat_buffer_2+$1e
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_0ad+$01

		ldy #$ff
		lda bat_buffer_2+$21
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_0bd+$01

		ldy #$ff
		lda bat_buffer_2+$24
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_0cd+$01

		ldy #$ff
		lda bat_buffer_2+$27
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_0dd+$01

		ldy #$ff
		lda bat_buffer_2+$2a
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_0ed+$01

		ldy #$ff
		lda bat_buffer_2+$2d
		and #$40
		bne *+04
		ldy #$00
		sty bat_ghost_0fd+$01

		jmp bat_main_loop


; Bat IRQ interrupt
bat_int		pha
		txa
		pha
		tya
		pha

		lda $d019
		and #$01
		sta $d019
		bne bat_ya
		jmp bat_ea31

bat_ya		lda bat_rn
		cmp #$02
		bne *+$05
		jmp bat_rout2

		cmp #$03
		bne *+$05
		jmp bat_rout3

		cmp #$04
		bne *+$05
		jmp bat_rout4

		cmp #$05
		bne *+$05
		jmp bat_rout5

		cmp #$06
		bne *+$05
		jmp bat_rout6


; Bat raster split 1
bat_rout1	lda #$0b
		sta $d020
		sta $d021

		lda #$1b
		sta $d011
		lda #$08
		sta $d016
		lda #$78
		sta $d018
		lda #$c6
		sta $dd00

; Position the first set of bat sprites
		lda #$ff
		sta $d015

		ldx #$00
		ldy #$00
bat_spr_pos_1	lda bat_spr_x_1,x
		sta $d000,y
		lda bat_spr_y_1,x
		sta $d001,y
		lda bat_spr_col_1,x
		sta $d027,x
		lda bat_spr_dp_1,x
		sta $5ff8,x
		iny
		iny
		inx
		cpx #$08
		bne bat_spr_pos_1

		lda bat_spr_msb_1
		sta $d010

; Set up for the next bat raster split
		lda #$02
		sta bat_rn
		lda #bat_rstr2p
		sta $d012

		jmp bat_ea31


; Bat raster split 2
bat_rout2	ldx #$0d
		dex
		bne *-$01
		nop
		nop

; Switch to bitmap mode at the top of the bat screen
		lda #$3b
		sta $d011

; Update the bat twinkle
		ldx bat_twinkle_tmr
		inx
		cpx #$6b
		bne bat_ttxb

		lda bat_twinkle_cnt
		asl
		tax
		lda bat_twinkle_pos+$00,x
		sta bat_spr_x_1+$05
		lda bat_twinkle_pos+$01,x
		sta bat_spr_y_1+$05

		ldx bat_twinkle_cnt
		inx
		cpx #$08
		bcc *+$04
		ldx #$00
		stx bat_twinkle_cnt

bat_ttxb	stx bat_twinkle_tmr

		txa
		lsr
		lsr
		cmp #$07
		bcc *+$04
		lda #$07
		tax
		lda bat_twkl_dps,x
		sta bat_spr_dp_1+$05
		lda bat_twkl_cols,x
		sta bat_spr_col_1+$05

; Update the bat X positions
		lda bat_spr_x_1+$00
		clc
		adc bat_x_speeds+$00
		bcc bat_x_write_1
		tax
		lda bat_spr_msb_1
		eor #$01
		sta bat_spr_msb_1
		txa
bat_x_write_1	sta bat_spr_x_1+$00

		lda bat_spr_x_1+$01
		clc
		adc bat_x_speeds+$01
		bcc bat_x_write_2
		tax
		lda bat_spr_msb_1
		eor #$02
		sta bat_spr_msb_1
		txa
bat_x_write_2	sta bat_spr_x_1+$01

		lda bat_spr_x_1+$02
		clc
		adc bat_x_speeds+$02
		bcc bat_x_write_3
		tax
		lda bat_spr_msb_1
		eor #$04
		sta bat_spr_msb_1
		txa
bat_x_write_3	sta bat_spr_x_1+$02

		lda bat_spr_x_1+$03
		clc
		adc bat_x_speeds+$03
		bcc bat_x_write_4
		tax
		lda bat_spr_msb_1
		eor #$08
		sta bat_spr_msb_1
		txa
bat_x_write_4	sta bat_spr_x_1+$03

		lda bat_spr_x_1+$04
		clc
		adc bat_x_speeds+$04
		bcc bat_x_write_5
		tax
		lda bat_spr_msb_1
		eor #$10
		sta bat_spr_msb_1
		txa
bat_x_write_5	sta bat_spr_x_1+$04


; Update the bat Y positions
		ldx bat_cos_at_1
		inx
		stx bat_cos_at_1
		lda bat_cosinus,x
		clc
		adc #$52
		sta bat_spr_y_1+$00

!set bat_cnt=$01
!do {
		txa
		clc
		adc #bat_offset_1
		tax
		lda bat_cosinus,x
		clc
		adc #$52+(bat_voffset_1*bat_cnt)
		sta bat_spr_y_1+bat_cnt

		!set bat_cnt=bat_cnt+$01
} until bat_cnt=$05

; Update the bat animations
		ldx bat_anim_tmr
		inx
		cpx #$03
		bcc bat_xb

		inc bat_anim_cnt
		lda bat_anim_cnt
		and #$07
		tay

		ldx #$00
bat_anim_set	lda bat_anim_frames,y
		sta bat_spr_dp_1,x
		iny
		cpy #$08
		bne *+$04
		ldy #$00
		inx
		cpx #$05
		bne bat_anim_set

		ldx #$00
bat_xb		stx bat_anim_tmr

; Set up for the next bat raster split
		lda #$03
		sta bat_rn
		lda #bat_rstr3p
		sta $d012

		jmp bat_ea31


; Bat raster split 3
; Position the second set of bat sprites
bat_rout3	lda bat_spr_x_2+$06
		sta $d00c
		lda bat_spr_y_2+$06
		sta $d00d

		lda bat_spr_x_2+$07
		sta $d00e
		lda bat_spr_y_2+$07
		sta $d00f

		lda bat_spr_col_2+$06
		sta $d02d
		lda bat_spr_col_2+$07
		sta $d02e

		lda bat_spr_dp_2+$06
		sta $5ffe
		lda bat_spr_dp_2+$07
		sta $5fff

; Set up for the next bat raster split
		lda #$04
		sta bat_rn
		lda #bat_rstr4p
		sta $d012

		jmp bat_ea31


; Bat raster split 4
; Position the third set of bat sprites
bat_rout4	lda bat_spr_x_3+$06
		sta $d00c
		lda bat_spr_y_3+$06
		sta $d00d

		lda bat_spr_x_3+$07
		sta $d00e
		lda bat_spr_y_3+$07
		sta $d00f

		lda bat_spr_col_3+$06
		sta $d02d
		lda bat_spr_col_3+$07
		sta $d02e

		lda bat_spr_dp_3+$06
		sta $5ffe
		lda bat_spr_dp_3+$07
		sta $5fff

; Set up for the next bat raster split
		lda #$05
		sta bat_rn
		lda #bat_rstr5p
		sta $d012

		jmp bat_ea31


; Bat raster split 5
; Position the fourth set of bat sprites
bat_rout5	lda bat_spr_x_4+$06
		sta $d00c
		lda bat_spr_y_4+$06
		sta $d00d

		lda bat_spr_x_4+$07
		sta $d00e
		lda bat_spr_y_4+$07
		sta $d00f

		lda bat_spr_col_4+$06
		sta $d02d
		lda bat_spr_col_4+$07
		sta $d02e

		lda bat_spr_dp_4+$06
		sta $5ffe
		lda bat_spr_dp_4+$07
		sta $5fff

; Set up for the next bat raster split
		lda #$06
		sta bat_rn
		lda #bat_rstr6p
		sta $d012

		jmp bat_ea31


		* = ((*/$100)+$01)*$100

; Bat raster split 6
bat_rout6	ldx #$00
		lda #$58
bat_set_sprx	sta $d000,x
		clc
		adc #$18
		inx
		inx
		cpx #$10
		bne bat_set_sprx
		lda #$80
		sta $d010

		ldx #$00
		lda #$f5
bat_set_spry	sta $d001,x
		inx
		inx
		cpx #$10
		bne bat_set_spry

		ldx #$00
		lda #$50
bat_set_sdp	sta $5ff8,x
		clc
		adc #$01
		inx
		cpx #$08
		bne bat_set_sdp

		ldx #$00
		lda #$00
bat_set_sprcol	sta $d027,x
		inx
		cpx #$08
		bne bat_set_sprcol

; Bat stabilisation for the lower border scroll
		ldx #$07
		dex
		bne *-$01
		bit $ea
		lda $d012
		cmp #bat_rstr6p+$0a
		beq *+$02
;		sta $d020

		ldx #$0a
		dex
		bne *-$01
		bit $ea
		nop
		lda $d012
		cmp #bat_rstr6p+$0b
		beq *+$02
;		sta $d020

		ldx #$0a
		dex
		bne *-$01
		bit $ea
		lda $d012
		cmp #bat_rstr6p+$0c
		beq *+$02
;		sta $d020

		ldx #$0a
		dex
		bne *-$01
		bit $ea
		lda $d012
		cmp #bat_rstr6p+$0d
		beq *+$02
;		sta $d020

		ldx #$0a
		dex
		bne *-$01
		bit $ea
		lda $d012
		cmp #bat_rstr6p+$0e
		beq *+$02
;		sta $d020

; Wait for the start of the bat scroller
		ldx #$4d
		dex
		bne *-$01
		nop
		nop
		nop

; Bat lower border scroller - scanline $00
		lda #$05
		sta $d021
		ldy #$33
		sty $d011
bat_ghost_00a	lda #$00
		sta $7fff
bat_ghost_00b	ldx #$00
		ldy #$13
		sty $d011
		ldy #$00
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop

bat_ghost_00c	lda #$00
bat_ghost_00d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $01
bat_ghost_01a	lda #$00
bat_ghost_01b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_01c	lda #$00
bat_ghost_01d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $02
bat_ghost_02a	lda #$00
bat_ghost_02b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_02c	lda #$00
bat_ghost_02d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $03
bat_ghost_03a	lda #$00
bat_ghost_03b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_03c	lda #$00
bat_ghost_03d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $04
bat_ghost_04a	lda #$00
bat_ghost_04b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_04c	lda #$00
bat_ghost_04d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $05
bat_ghost_05a	lda #$00
bat_ghost_05b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_05c	lda #$00
bat_ghost_05d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $06
bat_ghost_06a	lda #$00
bat_ghost_06b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_06c	lda #$00
bat_ghost_06d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $07
bat_ghost_07a	lda #$00
bat_ghost_07b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_07c	lda #$00
bat_ghost_07d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $08
bat_ghost_08a	lda #$00
bat_ghost_08b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_08c	lda #$00
bat_ghost_08d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $09
bat_ghost_09a	lda #$00
bat_ghost_09b	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_09c	lda #$00
bat_ghost_09d	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $0a
bat_ghost_0aa	lda #$00
bat_ghost_0ab	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_0ac	lda #$00
bat_ghost_0ad	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $0b
bat_ghost_0ba	lda #$00
bat_ghost_0bb	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_0bc	lda #$00
bat_ghost_0bd	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $0c
bat_ghost_0ca	lda #$00
bat_ghost_0cb	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_0cc	lda #$00
bat_ghost_0cd	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $0d
bat_ghost_0da	lda #$00
bat_ghost_0db	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_0dc	lda #$00
bat_ghost_0dd	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $0e
bat_ghost_0ea	lda #$00
bat_ghost_0eb	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_0ec	lda #$00
bat_ghost_0ed	ldx #$00
		sta $7fff
		stx $7fff

; Bat lower border scroller - scanline $0f
bat_ghost_0fa	lda #$00
bat_ghost_0fb	ldx #$00
		sta $7fff
		stx $7fff
		sty $7fff
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
bat_ghost_0fc	lda #$00
bat_ghost_0fd	ldx #$00
		sta $7fff
		stx $7fff



		sty $7fff
		lda #$0b
		sta $d021

; Play the music
		jsr bat_music+$03

; Let the runtime code know that it's time to move
		lda #$01
		sta bat_sync

; Set up for the first bat raster split
		lda #$01
		sta bat_rn
		lda #bat_rstr1p
		sta $d012

; Exit bat interrupt
bat_ea31	pla
		tay
		pla
		tax
		pla
bat_nmi		rti


; Update the bat scroller
bat_scroll	ldx #$00
bat_mover	asl bat_buffer_3,x
		rol bat_buffer_2,x

		rol $55d1,x
		rol $55d0,x
		rol $55cf,x
		rol $5591,x
		rol $5590,x
		rol $558f,x
		rol $5551,x
		rol $5550,x
		rol $554f,x
		rol $5511,x
		rol $5510,x
		rol $550f,x

		rol $54d1,x
		rol $54d0,x
		rol $54cf,x
		rol $5491,x
		rol $5490,x
		rol $548f,x
		rol $5451,x
		rol $5450,x
		rol $544f,x
		rol $5411,x
		rol $5410,x
		rol $540f,x

		rol bat_buffer_1,x

		inx
		inx
		inx
		cpx #$30
		bne bat_mover

; Test to see if a new bat character is required
		ldx bat_char_wd_cnt
		dex
		bpl bat_chrwd_xb

; Fetch a new bat character
bat_mread	lda bat_scroll_text
		bne bat_okay
		jsr bat_reset
		jmp bat_mread

; Check for bat speed controls
bat_okay	cmp #$80
		bcc bat_okay_2

		and #$07
		sta bat_scroll_spd

		lda #$20

; Copy bat character to work buffer
bat_okay_2	tay
		asl

		sta bat_def_copy+$01
		lda #$00
		asl bat_def_copy+$01
		rol
		asl bat_def_copy+$01
		rol
		asl bat_def_copy+$01
		rol
		clc
		adc #>bat_charset
		sta bat_def_copy+$02

		lda bat_char_widths,y
		sta bat_chrwd_xb-$01

		ldx #$00
		ldy #$00
bat_def_copy	lda bat_charset,x
		sta bat_buffer_3,y
		iny
		iny
		iny
		inx
		cpx #$10
		bne bat_def_copy

		inc bat_mread+$01
		bne *+$05
		inc bat_mread+$02

		ldx #$08
bat_chrwd_xb	stx bat_char_wd_cnt

		rts

; Reset the self mod for the bat scroller
bat_reset	lda #<bat_scroll_text
		sta bat_mread+$01
		lda #>bat_scroll_text
		sta bat_mread+$02
		rts


; Bat sprite co-ordinate tables
bat_spr_x_1	!byte $50,$91,$22,$b7,$ff,$00,$55,$03
bat_spr_msb_1	!byte $80
bat_spr_y_1	!byte $50,$00,$00,$00,$00,$00,$63,$63
bat_spr_col_1	!byte $0b,$0b,$0b,$0b,$0b,$00,$0f,$0f
bat_spr_dp_1	!byte $58,$59,$5a,$5b,$5c,$68,$60,$61

bat_spr_x_2	!byte $00,$00,$00,$00,$00,$00,$33,$25
bat_spr_y_2	!byte $00,$00,$00,$00,$00,$00,$7e,$7e
bat_spr_col_2	!byte $00,$00,$00,$00,$00,$00,$01,$01
bat_spr_dp_2	!byte $00,$00,$00,$00,$00,$00,$62,$63

bat_spr_x_3	!byte $00,$00,$00,$00,$00,$00,$33,$25
bat_spr_y_3	!byte $00,$00,$00,$00,$00,$00,$a2,$a2
bat_spr_col_3	!byte $00,$00,$00,$00,$00,$00,$01,$01
bat_spr_dp_3	!byte $00,$00,$00,$00,$00,$00,$64,$65

bat_spr_x_4	!byte $00,$00,$00,$00,$00,$00,$55,$03
bat_spr_y_4	!byte $00,$00,$00,$00,$00,$00,$c0,$c0
bat_spr_col_4	!byte $00,$00,$00,$00,$00,$00,$0f,$0f
bat_spr_dp_4	!byte $00,$00,$00,$00,$00,$00,$66,$67

bat_x_speeds	!byte $02,$04,$01,$03,$02,$01,$05,$04
bat_anim_frames	!byte $58,$59,$5a,$5b,$5c,$5b,$5a,$59

; Co-ordinates for the bat twinkles
bat_twinkle_pos	!byte $4d,$4d
		!byte $66,$be
		!byte $8a,$78
		!byte $ca,$9e
		!byte $5e,$a2
		!byte $a0,$4e
		!byte $fa,$be
		!byte $d2,$78

; Data pointers and colours for the bat twinkles
bat_twkl_dps	!byte $68,$69,$6a,$6b,$6c,$6d,$6e,$6f
bat_twkl_cols	!byte $01,$07,$0f,$0c,$08,$0b,$09,$00

; Cosine curve for the bats
bat_cosinus	!byte $4f,$4f,$4f,$4f,$4f,$4f,$4f,$4f
		!byte $4f,$4f,$4e,$4e,$4e,$4d,$4d,$4d
		!byte $4c,$4c,$4c,$4b,$4b,$4a,$4a,$49
		!byte $49,$48,$48,$47,$46,$46,$45,$44
		!byte $44,$43,$42,$42,$41,$40,$3f,$3e
		!byte $3e,$3d,$3c,$3b,$3a,$39,$39,$38
		!byte $37,$36,$35,$34,$33,$32,$31,$30
		!byte $2f,$2e,$2d,$2c,$2b,$2a,$29,$28

		!byte $27,$26,$25,$24,$24,$23,$22,$21
		!byte $20,$1f,$1e,$1d,$1c,$1b,$1a,$19
		!byte $18,$17,$16,$15,$15,$14,$13,$12
		!byte $11,$10,$10,$0f,$0e,$0d,$0d,$0c
		!byte $0b,$0a,$0a,$09,$09,$08,$07,$07
		!byte $06,$06,$05,$05,$04,$04,$03,$03
		!byte $02,$02,$02,$01,$01,$01,$01,$00
		!byte $00,$00,$00,$00,$00,$00,$00,$00

		!byte $00,$00,$00,$00,$00,$00,$00,$00
		!byte $00,$01,$01,$01,$01,$02,$02,$02
		!byte $03,$03,$03,$04,$04,$05,$05,$06
		!byte $06,$07,$07,$08,$09,$09,$0a,$0b
		!byte $0b,$0c,$0d,$0e,$0e,$0f,$10,$11
		!byte $11,$12,$13,$14,$15,$16,$17,$17
		!byte $18,$19,$1a,$1b,$1c,$1d,$1e,$1f
		!byte $20,$21,$22,$23,$24,$25,$26,$27

		!byte $28,$29,$2a,$2b,$2c,$2d,$2e,$2f
		!byte $30,$30,$31,$32,$33,$34,$35,$36
		!byte $37,$38,$39,$3a,$3b,$3b,$3c,$3d
		!byte $3e,$3f,$40,$40,$41,$42,$43,$43
		!byte $44,$45,$45,$46,$47,$47,$48,$48
		!byte $49,$49,$4a,$4a,$4b,$4b,$4c,$4c
		!byte $4d,$4d,$4d,$4e,$4e,$4e,$4e,$4f
		!byte $4f,$4f,$4f,$4f,$4f,$4f,$4f,$4f


; Bat character widths
bat_char_widths	!byte $00,$08,$08,$09,$09,$08,$08,$09		; @ to G
		!byte $08,$03,$06,$08,$06,$08,$07,$09		; H to O
		!byte $08,$09,$08,$08,$07,$09,$08,$08		; P to W
		!byte $08,$07,$08,$00,$00,$00,$00,$00		; X to Z
		!byte $06,$03,$06,$00,$00,$00,$00,$03		; space ! " # $ % & '
		!byte $00,$00,$00,$07,$03,$07,$03,$07		; ( ) * + , - . /
		!byte $09,$04,$08,$08,$08,$08,$08,$07		; 0 to 7
		!byte $08,$08,$03,$03,$00,$07,$00,$08		; 8 9 : ; < = > ?

; Bat scrolling message text
bat_scroll_text	!scr $83,"...to the batmobile!"
		!scr "            "

		!scr $82,"welcome to "
		!scr "            "
		!scr $81,"--- md201703 - the bat-tro ---"
		!scr "            "

		!scr $82,"bat code and bat graphics by t.m.r with "
		!scr "bat music from andy"
		!scr "            "


		!scr $83,"this little bat-demo came about because batman "
		!scr "of batman group - they of batman forever on the "
		!scr "amstrad cpc fame - upped to the csdb a number of "
		!scr "wired images from his group's productions on other "
		!scr "platforms including a version of the logo from the "
		!scr "1989 batman film."
		!scr "        "

		!scr "a few days after these uploads appeared i was at "
		!scr "something of a loose end, so did my own conversion "
		!scr "and clean up of the logo before having the "
		!scr $22,"bright",$22," idea of turning it into a monthly "
		!scr "demo release by adding this scroller and some sprites!"
		!scr "        "

		!scr "that meant i needed some bat-themed music so i asked "
		!scr "andy for a cover of the first stage tune from "
		!scr "sunsoft's batman on the mega drive and he's done a "
		!scr "brilliant job as always."
		!scr "        "

		!scr "he's asked me to point out that it took a little over "
		!scr "three hours in total and apologise on his behalf for "
		!scr "some slight rough edges but, if there are any, that's "
		!scr "more my fault since i rocked up asking for music at "
		!scr "very short notice... again!"
		!scr "        "

		!scr "i found this music whilst searching through 8- and "
		!scr "16-bit batman games for a double height font to "
		!scr "convert - in the end i did my own version of an art "
		!scr "deco font because one of the animated series uses it "
		!scr "for the logo and that was enough of a reason to "
		!scr "include it."
		!scr "        "

		!scr "it's good to occasionally have a theme to work with "
		!scr "for these monthly demos, i'm not so keen on seasonal "
		!scr "events personally so something like batman works for "
		!scr "me; there was a cluster of bat-centric releases before "
		!scr "i got this finished so it seems others feel that way "
		!scr "too and it's fun joining in with that "
		!scr $22,"bat-mania",$22," as well."
		!scr "        "

		!scr "this isn't the first time we've covered batman at "
		!scr "cosine towers either, there's a part in our 1989 demo "
		!scr "vladivar which has a bat logo and scroll text from "
		!scr "skywave talking about what were at the time ridiculous "
		!scr "amounts of hype surrounding the tim burton batman "
		!scr "movie that looks almost subtle by today's standards."
		!scr "        "

		!scr "i enjoyed the film when i finally saw it though, batman "
		!scr "batman has always been one of my favourite super heroes "
		!scr "- mostly because he doesn't have any actual super "
		!scr "powers - and i thought michael keaton did a very "
		!scr "good job as both bruce wayne and the bat... perhaps "
		!scr "it's time to get the dvd out?  i could watch batman "
		!scr "vs superman but most of what i've heard about that has "
		!scr "been negative so i'm not in a hurry right now..."
		!scr "            "

		!scr $83,"and, after a little more waffle than i usually "
		!scr "muster and a badly written film ",$22,"review",$22,", "
		!scr "the inspiration train has been completely derailed "
		!scr "so it's time to say hello to some people!"
		!scr "            "

		!scr $82,"cosine's greetings zoom out like a well-thrown "
		!scr "batarang towards the caped crusaders in...  "
		!scr $83,"absence / "
		!scr "abyss connection / "
		!scr "arkanix labs / "
		!scr "artstate / "
		!scr "ate bit / "
		!scr "atlantis / "
		!scr "booze design / "
		!scr "camelot / "
		!scr "censor design / "
		!scr "chorus / "
		!scr "chrome / "
		!scr "cncd / "
		!scr "cpu / "
		!scr "crescent / "
		!scr "crest / "
		!scr "covert bitops / "
		!scr "defence force / "
		!scr "dekadence / "
		!scr "desire / "
		!scr "dac / "
		!scr "dmagic / "
		!scr "dualcrew / "
		!scr "exclusive on / "
		!scr "fairlight / "
		!scr "f4cg / "
		!scr "fire / "
		!scr "flat 3 / "
		!scr "focus / "
		!scr "french touch / "
		!scr "funkscientist productions / "
		!scr "genesis project / "
		!scr "gheymaid inc. / "
		!scr "hitmen / "
		!scr "hokuto force / "
		!scr "legion of doom / "
		!scr "level64 / "
		!scr "maniacs of noise / "
		!scr "mayday / "
		!scr "meanteam / "
		!scr "metalvotze / "
		!scr "noname / "
		!scr "nostalgia / "
		!scr "nuance / "
		!scr "offence / "
		!scr "onslaught / "
		!scr "orb / "
		!scr "oxyron / "
		!scr "padua / "
		!scr "performers / "
		!scr "plush / "
		!scr "professional protection cracking service / "
		!scr "psytronik / "
		!scr "reptilia / "
		!scr "resource / "
		!scr "rgcd / "
		!scr "secure / "
		!scr "shape / "
		!scr "side b / "
		!scr "singular / "
		!scr "slash / "
		!scr "slipstream / "
		!scr "success and trc / "
		!scr "style / "
		!scr "suicyco industries / "
		!scr "taquart / "
		!scr "tempest / "
		!scr "tek / "
		!scr "triad / "
		!scr "trsi / "
		!scr "viruz / "
		!scr "vision / "
		!scr "wow / "
		!scr "wrath / "
		!scr "xenon..."
		!scr "            "

		!scr $82,"and, apart from an invitation to visit the "
		!scr "batcave at",$81,"http://cosine.org.uk/",$82
		!scr "there's nothing left to write, so this has been "
		!scr "t.m.r of cosine on 2017-03-14 - join us at a "
		!scr "different bat time but on the same bat channel "
		!scr "for more 8-bit goodness... .. .  .   ."
		!scr "            "

		!byte $00		; end of bat text marker