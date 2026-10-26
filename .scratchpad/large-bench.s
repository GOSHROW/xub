	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 5	sdk_version 15, 5
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function main
lCPI0_0:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	3                               ; 0x3
lCPI0_1:
	.long	4                               ; 0x4
	.long	5                               ; 0x5
	.long	6                               ; 0x6
	.long	7                               ; 0x7
lCPI0_2:
	.long	8                               ; 0x8
	.long	9                               ; 0x9
	.long	10                              ; 0xa
	.long	11                              ; 0xb
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	stp	d11, d10, [sp, #-128]!          ; 16-byte Folded Spill
	stp	d9, d8, [sp, #16]               ; 16-byte Folded Spill
	stp	x28, x27, [sp, #32]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	sub	sp, sp, #960
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	.cfi_offset b8, -104
	.cfi_offset b9, -112
	.cfi_offset b10, -120
	.cfi_offset b11, -128
Lloh0:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh2:
	ldr	x8, [x8]
	stur	x8, [x29, #-128]
	cmp	w0, #2
	b.lt	LBB0_14
; %bb.1:
	mov	x19, x1
	mov	x20, x0
	str	xzr, [sp, #72]                  ; 8-byte Folded Spill
	mov	w26, #0                         ; =0x0
	mov	w8, #4096                       ; =0x1000
	str	w8, [sp, #84]                   ; 4-byte Folded Spill
	fmov	d8, #5.00000000
	mov	w27, #1                         ; =0x1
Lloh3:
	adrp	x21, l_.str@PAGE
Lloh4:
	add	x21, x21, l_.str@PAGEOFF
Lloh5:
	adrp	x22, l_.str.1@PAGE
Lloh6:
	add	x22, x22, l_.str.1@PAGEOFF
Lloh7:
	adrp	x23, l_.str.2@PAGE
Lloh8:
	add	x23, x23, l_.str.2@PAGEOFF
Lloh9:
	adrp	x24, l_.str.3@PAGE
Lloh10:
	add	x24, x24, l_.str.3@PAGEOFF
	b	LBB0_4
LBB0_2:                                 ;   in Loop: Header=BB0_4 Depth=1
	mov	w26, #1                         ; =0x1
LBB0_3:                                 ;   in Loop: Header=BB0_4 Depth=1
	add	w27, w27, #1
	cmp	w27, w20
	b.ge	LBB0_15
LBB0_4:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x25, [x19, w27, sxtw #3]
	mov	x0, x25
	mov	x1, x21
	bl	_strcmp
	cbz	w0, LBB0_2
; %bb.5:                                ;   in Loop: Header=BB0_4 Depth=1
                                        ; kill: def $w27 killed $w27 killed $x27 def $x27
	sxtw	x28, w27
	mov	x0, x25
	mov	x1, x22
	bl	_strcmp
	cmp	w0, #0
	add	x27, x28, #1
	ccmp	w27, w20, #0, eq
	b.lt	LBB0_13
; %bb.6:                                ;   in Loop: Header=BB0_4 Depth=1
	mov	x0, x25
	mov	x1, x23
	bl	_strcmp
	cbnz	w0, LBB0_9
; %bb.7:                                ;   in Loop: Header=BB0_4 Depth=1
	add	x27, x28, #1
	cmp	w27, w20
	b.ge	LBB0_9
; %bb.8:                                ;   in Loop: Header=BB0_4 Depth=1
	ldr	x0, [x19, x27, lsl #3]
	bl	_atof
	fmov	d8, d0
	b	LBB0_12
LBB0_9:                                 ;   in Loop: Header=BB0_4 Depth=1
	mov	x0, x25
	mov	x1, x24
	bl	_strcmp
	cbnz	w0, LBB0_149
; %bb.10:                               ;   in Loop: Header=BB0_4 Depth=1
	add	x27, x28, #1
	cmp	w27, w20
	b.ge	LBB0_149
; %bb.11:                               ;   in Loop: Header=BB0_4 Depth=1
	ldr	x8, [x19, x27, lsl #3]
	str	x8, [sp, #72]                   ; 8-byte Folded Spill
LBB0_12:                                ;   in Loop: Header=BB0_4 Depth=1
                                        ; kill: def $w27 killed $w27 killed $x27 def $x27
	b	LBB0_3
LBB0_13:                                ;   in Loop: Header=BB0_4 Depth=1
	ldr	x0, [x19, x27, lsl #3]
	bl	_atoi
	str	w0, [sp, #84]                   ; 4-byte Folded Spill
	b	LBB0_3
LBB0_14:
	mov	w26, #0                         ; =0x0
	str	xzr, [sp, #72]                  ; 8-byte Folded Spill
	fmov	d8, #5.00000000
	mov	w8, #4096                       ; =0x1000
	str	w8, [sp, #84]                   ; 4-byte Folded Spill
LBB0_15:
	ldr	w27, [sp, #84]                  ; 4-byte Folded Reload
	sub	w8, w27, #64
Lloh11:
	adrp	x28, ___stderrp@GOTPAGE
Lloh12:
	ldr	x28, [x28, ___stderrp@GOTPAGEOFF]
	ldr	x19, [x28]
	mov	w9, #16320                      ; =0x3fc0
	cmp	w8, w9
	fmov	d0, #1.00000000
	fccmp	d8, d0, #8, ls
	mov	x8, #4636737291354636288        ; =0x4059000000000000
	fmov	d0, x8
	fccmp	d8, d0, #2, ge
	b.hi	LBB0_162
; %bb.16:
	mov	w0, #0                          ; =0x0
	bl	_OpenSSL_version
	str	d8, [sp, #32]
	mov	w8, #8                          ; =0x8
	mov	w9, #5                          ; =0x5
	stp	x9, x8, [sp, #16]
Lloh13:
	adrp	x8, l_.str.9@PAGE
Lloh14:
	add	x8, x8, l_.str.9@PAGEOFF
	stp	x0, x8, [sp]
Lloh15:
	adrp	x1, l_.str.8@PAGE
Lloh16:
	add	x1, x1, l_.str.8@PAGEOFF
	mov	x0, x19
	bl	_fprintf
	ldr	x3, [x28]
Lloh17:
	adrp	x0, l_.str.10@PAGE
Lloh18:
	add	x0, x0, l_.str.10@PAGEOFF
	mov	w1, #170                        ; =0xaa
	mov	w2, #1                          ; =0x1
	bl	_fwrite
	mov	x8, #0                          ; =0x0
	mov	w9, #0                          ; =0x0
Lloh19:
	adrp	x10, __MergedGlobals@PAGE
Lloh20:
	add	x10, x10, __MergedGlobals@PAGEOFF
LBB0_17:                                ; =>This Inner Loop Header: Depth=1
	add	w11, w8, w9
	add	x12, x10, x8
	strh	w9, [x12, #8]
	add	w9, w11, #1
	add	x8, x8, #2
	cmp	x8, #512
	b.ne	LBB0_17
; %bb.18:
	bl	_BN_CTX_new
	cbz	x0, LBB0_163
; %bb.19:
	mov	x21, x0
	bl	_BN_new
	mov	x19, x0
	str	x0, [sp, #240]
	bl	_BN_new
	str	x0, [sp, #248]
	cbz	x19, LBB0_164
; %bb.20:
	mov	x22, x0
	cbz	x0, LBB0_164
; %bb.21:
	mov	w8, #0                          ; =0x0
	mov	w9, #0                          ; =0x0
Lloh21:
	adrp	x10, __MergedGlobals@PAGE+8
Lloh22:
	add	x10, x10, __MergedGlobals@PAGEOFF+8
LBB0_22:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_23 Depth 2
	mov	w11, #0                         ; =0x0
	mov	x12, x8
LBB0_23:                                ;   Parent Loop BB0_22 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	w9, w11
	csel	w13, w9, w11, lo
	csel	w14, w9, w11, hi
	sub	w14, w14, w13
	lsr	w15, w14, #1
	add	w16, w15, w13
	ldrh	w16, [x10, w16, uxtw #1]
	lsl	w15, w15, #1
	ldrh	w15, [x10, w15, uxtw]
	sbfx	w14, w14, #0, #1
	and	w13, w14, w13
	sub	w13, w13, w15
	add	w13, w13, w16
	add	w12, w12, w9
	cmp	w12, w13
	b.ne	LBB0_157
; %bb.24:                               ;   in Loop: Header=BB0_23 Depth=2
	add	w11, w11, #1
	cmp	w11, #256
	b.ne	LBB0_23
; %bb.25:                               ;   in Loop: Header=BB0_22 Depth=1
	add	w9, w9, #1
	sub	w8, w8, #1
	cmp	w9, #256
	b.ne	LBB0_22
; %bb.26:
	mov	x23, #0                         ; =0x0
Lloh23:
	adrp	x24, l___const.verify_all.edge@PAGE
Lloh24:
	add	x24, x24, l___const.verify_all.edge@PAGEOFF
LBB0_27:                                ; =>This Inner Loop Header: Depth=1
	ldr	w20, [x24, x23]
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.28:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.29:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.30:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.31:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.32:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #2                          ; =0x2
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.33:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.34:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #3                          ; =0x3
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.35:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.36:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #7                          ; =0x7
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.37:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.38:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #8                          ; =0x8
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.39:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.40:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #15                         ; =0xf
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.41:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.42:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #16                         ; =0x10
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.43:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.44:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #127                        ; =0x7f
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.45:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.46:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #128                        ; =0x80
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.47:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.48:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #255                        ; =0xff
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.49:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.50:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #256                        ; =0x100
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.51:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.52:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #257                        ; =0x101
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.53:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.54:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #65535                      ; =0xffff
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.55:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x19
	mov	x1, x20
	bl	_BN_set_word
	cbz	w0, LBB0_158
; %bb.56:                               ;   in Loop: Header=BB0_27 Depth=1
	mov	x0, x22
	mov	w1, #65536                      ; =0x10000
	bl	_BN_set_word
	cbz	w0, LBB0_159
; %bb.57:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	add	x23, x23, #4
	cmp	x23, #60
	b.ne	LBB0_27
; %bb.58:
	mov	x0, x19
	bl	_BN_free
	mov	x0, x22
	bl	_BN_free
	mov	x24, #0                         ; =0x0
	mov	w23, #225                       ; =0xe1
Lloh25:
	adrp	x25, l___const.verify_all.widths@PAGE
Lloh26:
	add	x25, x25, l___const.verify_all.widths@PAGEOFF
	b	LBB0_60
LBB0_59:                                ;   in Loop: Header=BB0_60 Depth=1
	add	x24, x24, #4
	cmp	x24, #52
	b.eq	LBB0_66
LBB0_60:                                ; =>This Inner Loop Header: Depth=1
	ldr	w19, [x25, x24]
	cmp	w19, w27
	b.gt	LBB0_59
; %bb.61:                               ;   in Loop: Header=BB0_60 Depth=1
	bl	_BN_new
	mov	x20, x0
	str	x0, [sp, #240]
	bl	_BN_new
	str	x0, [sp, #248]
	cbz	x20, LBB0_160
; %bb.62:                               ;   in Loop: Header=BB0_60 Depth=1
	mov	x22, x0
	cbz	x0, LBB0_160
; %bb.63:                               ;   in Loop: Header=BB0_60 Depth=1
	mov	x0, x20
	mov	x1, x19
	bl	_random_bits
	mov	x0, x22
	mov	x1, x19
	bl	_random_bits
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x20
	bl	_BN_free
	mov	x0, x22
	bl	_BN_free
	bl	_BN_new
	mov	x20, x0
	str	x0, [sp, #240]
	bl	_BN_new
	str	x0, [sp, #248]
	cbz	x20, LBB0_161
; %bb.64:                               ;   in Loop: Header=BB0_60 Depth=1
	mov	x22, x0
	cbz	x0, LBB0_161
; %bb.65:                               ;   in Loop: Header=BB0_60 Depth=1
	mov	x0, x20
	mov	x1, x19
	bl	_random_bits
	mov	x0, x22
	mov	x1, x19
	bl	_random_bits
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x20
	bl	_BN_free
	mov	x0, x22
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #1                          ; =0x1
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #1                          ; =0x1
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #2                          ; =0x2
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #2                          ; =0x2
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #3                          ; =0x3
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #3                          ; =0x3
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #4                          ; =0x4
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #4                          ; =0x4
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #5                          ; =0x5
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #5                          ; =0x5
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #6                          ; =0x6
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #6                          ; =0x6
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #7                          ; =0x7
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	x0, sp, #240
	mov	x1, x19
	mov	w2, #7                          ; =0x7
	bl	_make_pair
	add	x0, sp, #240
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #240]
	bl	_BN_free
	ldr	x0, [sp, #248]
	bl	_BN_free
	add	w23, w23, #16
	b	LBB0_59
LBB0_66:
	mov	x0, x21
	bl	_BN_CTX_free
	ldr	x0, [x28]
	mov	w8, #12                         ; =0xc
	stp	x23, x8, [sp]
Lloh27:
	adrp	x1, l_.str.19@PAGE
Lloh28:
	add	x1, x1, l_.str.19@PAGEOFF
	bl	_fprintf
	cbz	w26, LBB0_69
LBB0_67:
	mov	w0, #0                          ; =0x0
	ldur	x8, [x29, #-128]
Lloh29:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh30:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh31:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB0_151
LBB0_68:
	bl	___stack_chk_fail
LBB0_69:
	ldr	x0, [sp, #72]                   ; 8-byte Folded Reload
	cbz	x0, LBB0_152
; %bb.70:
Lloh32:
	adrp	x1, l_.str.11@PAGE
Lloh33:
	add	x1, x1, l_.str.11@PAGEOFF
	bl	_fopen
	mov	x19, x0
	cbz	x0, LBB0_153
LBB0_71:
	bl	_BN_CTX_new
	mov	x22, x0
	bl	_BN_new
	cbz	x22, LBB0_165
; %bb.72:
	mov	x23, x0
	cbz	x0, LBB0_165
; %bb.73:
Lloh34:
	adrp	x0, l_.str.101@PAGE
Lloh35:
	add	x0, x0, l_.str.101@PAGEOFF
	mov	w1, #74                         ; =0x4a
	mov	w2, #1                          ; =0x1
	mov	x3, x19
	bl	_fwrite
	mov	x26, #0                         ; =0x0
	add	x21, sp, #764
Lloh36:
	adrp	x8, lCPI0_0@PAGE
Lloh37:
	ldr	q0, [x8, lCPI0_0@PAGEOFF]
	str	q0, [sp, #128]                  ; 16-byte Folded Spill
Lloh38:
	adrp	x8, lCPI0_1@PAGE
Lloh39:
	ldr	q0, [x8, lCPI0_1@PAGEOFF]
	str	q0, [sp, #112]                  ; 16-byte Folded Spill
Lloh40:
	adrp	x8, lCPI0_2@PAGE
Lloh41:
	ldr	q0, [x8, lCPI0_2@PAGEOFF]
	str	q0, [sp, #96]                   ; 16-byte Folded Spill
	add	x27, sp, #176
Lloh42:
	adrp	x28, _algorithms@PAGE
Lloh43:
	add	x28, x28, _algorithms@PAGEOFF
	fmov	d9, #8.00000000
	fmov	d10, #1.00000000
	str	x19, [sp, #88]                  ; 8-byte Folded Spill
	b	LBB0_75
LBB0_74:                                ;   in Loop: Header=BB0_75 Depth=1
	add	x26, x26, #1
	cmp	x26, #5
	b.eq	LBB0_146
LBB0_75:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_78 Depth 2
                                        ;       Child Loop BB0_80 Depth 3
                                        ;       Child Loop BB0_116 Depth 3
                                        ;         Child Loop BB0_122 Depth 4
                                        ;       Child Loop BB0_126 Depth 3
                                        ;         Child Loop BB0_136 Depth 4
                                        ;         Child Loop BB0_130 Depth 4
                                        ;       Child Loop BB0_141 Depth 3
Lloh44:
	adrp	x8, l___const.measure.widths@PAGE
Lloh45:
	add	x8, x8, l___const.measure.widths@PAGEOFF
	ldr	w9, [x8, x26, lsl #2]
	ldr	w8, [sp, #84]                   ; 4-byte Folded Reload
	str	x9, [sp, #152]                  ; 8-byte Folded Spill
	cmp	w9, w8
	b.gt	LBB0_74
; %bb.76:                               ;   in Loop: Header=BB0_75 Depth=1
	mov	x24, #0                         ; =0x0
	str	x26, [sp, #168]                 ; 8-byte Folded Spill
	b	LBB0_78
LBB0_77:                                ;   in Loop: Header=BB0_78 Depth=2
	ldr	x19, [sp, #88]                  ; 8-byte Folded Reload
	mov	x0, x19
	bl	_fflush
	ldur	x0, [x29, #-256]
	bl	_BN_free
	ldur	x0, [x29, #-248]
	bl	_BN_free
	ldur	x0, [x29, #-240]
	bl	_BN_free
	ldur	x0, [x29, #-232]
	bl	_BN_free
	ldur	x0, [x29, #-224]
	bl	_BN_free
	ldur	x0, [x29, #-216]
	bl	_BN_free
	ldur	x0, [x29, #-208]
	bl	_BN_free
	ldur	x0, [x29, #-200]
	bl	_BN_free
	ldur	x0, [x29, #-192]
	bl	_BN_free
	ldur	x0, [x29, #-184]
	bl	_BN_free
	ldur	x0, [x29, #-176]
	bl	_BN_free
	ldur	x0, [x29, #-168]
	bl	_BN_free
	ldur	x0, [x29, #-160]
	bl	_BN_free
	ldur	x0, [x29, #-152]
	bl	_BN_free
	ldur	x0, [x29, #-144]
	bl	_BN_free
	ldur	x0, [x29, #-136]
	bl	_BN_free
Lloh46:
	adrp	x8, ___stderrp@GOTPAGE
Lloh47:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh48:
	ldr	x0, [x8]
Lloh49:
	adrp	x8, _patterns@PAGE
Lloh50:
	add	x8, x8, _patterns@PAGEOFF
	ldr	x24, [sp, #160]                 ; 8-byte Folded Reload
	ldr	x9, [x8, x24, lsl #3]
	ldr	x8, [sp, #152]                  ; 8-byte Folded Reload
	stp	x8, x9, [sp]
Lloh51:
	adrp	x1, l_.str.106@PAGE
Lloh52:
	add	x1, x1, l_.str.106@PAGEOFF
	bl	_fprintf
	add	x24, x24, #1
	cmp	x24, #8
	b.eq	LBB0_74
LBB0_78:                                ;   Parent Loop BB0_75 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_80 Depth 3
                                        ;       Child Loop BB0_116 Depth 3
                                        ;         Child Loop BB0_122 Depth 4
                                        ;       Child Loop BB0_126 Depth 3
                                        ;         Child Loop BB0_136 Depth 4
                                        ;         Child Loop BB0_130 Depth 4
                                        ;       Child Loop BB0_141 Depth 3
	mov	x26, #0                         ; =0x0
	sub	w25, w24, #3
	str	x24, [sp, #160]                 ; 8-byte Folded Spill
	b	LBB0_80
LBB0_79:                                ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x19
	bl	_BN_free
	add	x26, x26, #16
	cmp	x26, #128
	ldr	x24, [sp, #160]                 ; 8-byte Folded Reload
	b.eq	LBB0_113
LBB0_80:                                ;   Parent Loop BB0_75 Depth=1
                                        ;     Parent Loop BB0_78 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	sub	x8, x29, #256
	add	x20, x8, x26
	mov	x0, x20
	ldr	x1, [sp, #152]                  ; 8-byte Folded Reload
                                        ; kill: def $w1 killed $w1 killed $x1
	mov	x2, x24
	bl	_make_pair
	bl	_BN_new
	cbz	x0, LBB0_156
; %bb.81:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x19, x0
	ldp	x24, x20, [x20]
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_BN_mul
	cbz	w0, LBB0_155
; %bb.82:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	bl	_copy_control
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_native_mul
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	ldr	x8, [sp, #168]                  ; 8-byte Folded Reload
	cmp	x8, #4
	b.ne	LBB0_90
; %bb.83:                               ;   in Loop: Header=BB0_80 Depth=3
	cbnz	w0, LBB0_154
; %bb.84:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.85:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.86:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.87:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.88:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.89:                               ;   in Loop: Header=BB0_80 Depth=3
	cmn	w25, #2
	b.lo	LBB0_79
	b	LBB0_111
LBB0_90:                                ;   in Loop: Header=BB0_80 Depth=3
	cmn	w25, #2
	b.hs	LBB0_101
; %bb.91:                               ;   in Loop: Header=BB0_80 Depth=3
	cbnz	w0, LBB0_154
; %bb.92:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.93:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.94:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_short
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.95:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_sparse
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.96:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.97:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.98:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.99:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_set_bits
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.100:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_prefix
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbz	w0, LBB0_79
	b	LBB0_154
LBB0_101:                               ;   in Loop: Header=BB0_80 Depth=3
	cbnz	w0, LBB0_154
; %bb.102:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.103:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.104:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_short
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.105:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_sparse
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.106:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.107:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.108:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.109:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_set_bits
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.110:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_prefix
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
LBB0_111:                               ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_near_native
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_154
; %bb.112:                              ;   in Loop: Header=BB0_80 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_near_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbz	w0, LBB0_79
	b	LBB0_154
LBB0_113:                               ;   in Loop: Header=BB0_78 Depth=2
	mov	x24, #0                         ; =0x0
	ldr	x26, [sp, #168]                 ; 8-byte Folded Reload
	b	LBB0_116
LBB0_114:                               ;   in Loop: Header=BB0_116 Depth=3
	ucvtf	d1, w19
	fmul	d1, d8, d1
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d2, x8
	fmul	d1, d1, d2
	fcmp	d0, #0.0
	fcsel	d0, d0, d10, gt
	fdiv	d0, d1, d0
	fadd	d1, d0, d10
	fcvtzu	w8, d1
	mov	w9, #16960                      ; =0x4240
	movk	w9, #15, lsl #16
	cmp	w8, w9
	csel	w8, w8, w9, lo
	fcmp	d0, d10
	csinc	w8, w8, wzr, gt
	str	w8, [x21, x24, lsl #2]
	ldr	x26, [sp, #168]                 ; 8-byte Folded Reload
LBB0_115:                               ;   in Loop: Header=BB0_116 Depth=3
	add	x24, x24, #1
	cmp	x24, #13
	b.eq	LBB0_124
LBB0_116:                               ;   Parent Loop BB0_75 Depth=1
                                        ;     Parent Loop BB0_78 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_122 Depth 4
	mov	w8, #1                          ; =0x1
	str	w8, [x21, x24, lsl #2]
	cmn	w25, #3
	b.hi	LBB0_118
; %bb.117:                              ;   in Loop: Header=BB0_116 Depth=3
	sub	w8, w24, #11
	cmp	w8, #2
	b.lo	LBB0_115
LBB0_118:                               ;   in Loop: Header=BB0_116 Depth=3
	cmp	x26, #4
	b.ne	LBB0_121
; %bb.119:                              ;   in Loop: Header=BB0_116 Depth=3
	cmp	w24, #10
	b.hi	LBB0_121
; %bb.120:                              ;   in Loop: Header=BB0_116 Depth=3
	mov	w8, #1                          ; =0x1
	lsl	w8, w8, w24
	mov	w9, #1584                       ; =0x630
	tst	w8, w9
	b.ne	LBB0_115
LBB0_121:                               ;   in Loop: Header=BB0_116 Depth=3
	mov	w8, #24                         ; =0x18
	madd	x8, x24, x8, x28
	ldr	x20, [x8, #8]
	mov	w19, #1                         ; =0x1
	sub	x1, x29, #256
	mov	x0, x20
	mov	w2, #1                          ; =0x1
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
LBB0_122:                               ;   Parent Loop BB0_75 Depth=1
                                        ;     Parent Loop BB0_78 Depth=2
                                        ;       Parent Loop BB0_116 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fcmp	d0, d1
	b.ge	LBB0_114
; %bb.123:                              ;   in Loop: Header=BB0_122 Depth=4
	mov	x26, x19
	lsl	w19, w19, #1
	sub	x1, x29, #256
	mov	x0, x20
	mov	x2, x19
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
	lsr	w8, w26, #18
	cbz	w8, LBB0_122
	b	LBB0_114
LBB0_124:                               ;   in Loop: Header=BB0_78 Depth=2
	mov	x20, #0                         ; =0x0
	b	LBB0_126
LBB0_125:                               ;   in Loop: Header=BB0_126 Depth=3
	add	x20, x20, #1
	cmp	x20, #5
	ldr	x26, [sp, #168]                 ; 8-byte Folded Reload
	b.eq	LBB0_138
LBB0_126:                               ;   Parent Loop BB0_75 Depth=1
                                        ;     Parent Loop BB0_78 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_136 Depth 4
                                        ;         Child Loop BB0_130 Depth 4
	ldp	q0, q1, [sp, #112]              ; 32-byte Folded Reload
	stp	q1, q0, [sp, #176]
	ldr	q0, [sp, #96]                   ; 16-byte Folded Reload
	str	q0, [sp, #208]
	mov	w11, #12                        ; =0xc
	str	w11, [sp, #224]
	adrp	x12, _rng_state@PAGE
	ldr	x8, [x12, _rng_state@PAGEOFF]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	mov	x9, #20165                      ; =0x4ec5
	movk	x9, #50412, lsl #16
	movk	x9, #60494, lsl #32
	movk	x9, #20164, lsl #48
	umulh	x9, x8, x9
	lsr	x9, x9, #2
	mov	w10, #13                        ; =0xd
	msub	x9, x9, x10, x8
	ldr	w10, [x27, x9, lsl #2]
	str	w10, [sp, #224]
	str	w11, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	mov	x13, #-6148914691236517206      ; =0xaaaaaaaaaaaaaaaa
	movk	x13, #43691
	umulh	x9, x8, x13
	lsr	x9, x9, #3
	msub	x9, x9, x11, x8
	ldr	w10, [sp, #220]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #220]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	mov	x9, #35747                      ; =0x8ba3
	movk	x9, #47662, lsl #16
	movk	x9, #41704, lsl #32
	movk	x9, #11915, lsl #48
	umulh	x9, x8, x9
	lsr	x9, x9, #1
	mov	w10, #11                        ; =0xb
	msub	x9, x9, x10, x8
	ldr	w10, [sp, #216]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #216]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	mov	x14, #-3689348814741910324      ; =0xcccccccccccccccc
	movk	x14, #52429
	umulh	x9, x8, x14
	lsr	x9, x9, #3
	mov	w10, #10                        ; =0xa
	msub	x9, x9, x10, x8
	ldr	w10, [sp, #212]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #212]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	mov	x9, #58255                      ; =0xe38f
	movk	x9, #36408, lsl #16
	movk	x9, #14563, lsl #32
	movk	x9, #58254, lsl #48
	umulh	x9, x8, x9
	lsr	x9, x9, #3
	add	x9, x9, x9, lsl #3
	sub	x9, x8, x9
	ldr	w10, [sp, #208]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #208]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x9, x8, x8, lsl #17
	and	x8, x8, #0x7
	ldr	w10, [sp, #204]
	ldr	w11, [x27, x8, lsl #2]
	str	w11, [sp, #204]
	str	w10, [x27, x8, lsl #2]
	eor	x8, x9, x9, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	mov	x9, #9363                       ; =0x2493
	movk	x9, #37449, lsl #16
	movk	x9, #18724, lsl #32
	movk	x9, #9362, lsl #48
	umulh	x9, x8, x9
	sub	x10, x8, x9
	add	x9, x9, x10, lsr #1
	lsr	x9, x9, #2
	sub	x9, x9, x9, lsl #3
	add	x9, x8, x9
	ldr	w10, [sp, #200]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #200]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	umulh	x9, x8, x13
	lsr	x9, x9, #2
	mov	w10, #6                         ; =0x6
	msub	x9, x9, x10, x8
	ldr	w10, [sp, #196]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #196]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	umulh	x9, x8, x14
	lsr	x9, x9, #2
	add	x9, x9, x9, lsl #2
	sub	x9, x8, x9
	ldr	w10, [x27, x9, lsl #2]
	ldr	w11, [sp, #192]
	str	w10, [sp, #192]
	str	w11, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x9, x8, x8, lsl #17
	ldr	w10, [sp, #188]
	add	x11, sp, #176
	bfi	x11, x8, #2, #2
	ldr	w8, [x11]
	str	w8, [sp, #188]
	str	w10, [x11]
	eor	x8, x9, x9, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	umulh	x9, x8, x13
	lsr	x9, x9, #1
	add	x9, x9, x9, lsl #1
	sub	x9, x8, x9
	ldr	w10, [sp, #184]
	orr	x9, x27, x9, lsl #2
	ldr	w11, [x9]
	str	w11, [sp, #184]
	str	w10, [x9]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	ldr	w9, [sp, #180]
	add	x10, sp, #176
	bfi	x10, x8, #2, #1
	ldr	w11, [x10]
	str	w11, [sp, #180]
	eor	x8, x8, x8, lsl #17
	str	w9, [x10]
	str	x8, [x12, _rng_state@PAGEOFF]
	cmp	x26, #4
	b.ne	LBB0_133
; %bb.127:                              ;   in Loop: Header=BB0_126 Depth=3
	mov	x24, #0                         ; =0x0
	b	LBB0_130
LBB0_128:                               ;   in Loop: Header=BB0_130 Depth=4
	cmp	w26, #10
	mov	w8, #1                          ; =0x1
	lsl	w8, w8, w26
	mov	w9, #1584                       ; =0x630
	and	w8, w8, w9
	ccmp	w8, #0, #4, ls
	b.eq	LBB0_132
LBB0_129:                               ;   in Loop: Header=BB0_130 Depth=4
	add	x24, x24, #4
	cmp	x24, #52
	b.eq	LBB0_125
LBB0_130:                               ;   Parent Loop BB0_75 Depth=1
                                        ;     Parent Loop BB0_78 Depth=2
                                        ;       Parent Loop BB0_126 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ldr	w26, [x27, x24]
	cmn	w25, #3
	b.hi	LBB0_128
; %bb.131:                              ;   in Loop: Header=BB0_130 Depth=4
	sub	w8, w26, #11
	cmp	w8, #2
	b.lo	LBB0_129
	b	LBB0_128
LBB0_132:                               ;   in Loop: Header=BB0_130 Depth=4
	mov	w8, #24                         ; =0x18
	umaddl	x8, w26, w8, x28
	ldr	x0, [x8, #8]
	ldr	w19, [x21, x26, lsl #2]
	sub	x1, x29, #256
	mov	x2, x19
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
	ucvtf	d1, w19
	fmul	d1, d1, d9
	fdiv	d0, d0, d1
	mov	w8, #40                         ; =0x28
	add	x9, sp, #240
	umaddl	x8, w26, w8, x9
	str	d0, [x8, x20, lsl #3]
	b	LBB0_129
LBB0_133:                               ;   in Loop: Header=BB0_126 Depth=3
	mov	x24, #0                         ; =0x0
	b	LBB0_136
LBB0_134:                               ;   in Loop: Header=BB0_136 Depth=4
	mov	w8, #24                         ; =0x18
	umaddl	x8, w26, w8, x28
	ldr	x0, [x8, #8]
	ldr	w19, [x21, x26, lsl #2]
	sub	x1, x29, #256
	mov	x2, x19
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
	ucvtf	d1, w19
	fmul	d1, d1, d9
	fdiv	d0, d0, d1
	mov	w8, #40                         ; =0x28
	add	x9, sp, #240
	umaddl	x8, w26, w8, x9
	str	d0, [x8, x20, lsl #3]
LBB0_135:                               ;   in Loop: Header=BB0_136 Depth=4
	add	x24, x24, #4
	cmp	x24, #52
	b.eq	LBB0_125
LBB0_136:                               ;   Parent Loop BB0_75 Depth=1
                                        ;     Parent Loop BB0_78 Depth=2
                                        ;       Parent Loop BB0_126 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ldr	w26, [x27, x24]
	cmn	w25, #3
	b.hi	LBB0_134
; %bb.137:                              ;   in Loop: Header=BB0_136 Depth=4
	sub	w8, w26, #11
	cmp	w8, #2
	b.lo	LBB0_135
	b	LBB0_134
LBB0_138:                               ;   in Loop: Header=BB0_78 Depth=2
	mov	x20, #0                         ; =0x0
	add	x19, sp, #240
	mov	x24, x28
	b	LBB0_141
LBB0_139:                               ;   in Loop: Header=BB0_141 Depth=3
	mov	x0, x19
	mov	w1, #5                          ; =0x5
	mov	w2, #8                          ; =0x8
Lloh53:
	adrp	x3, _cmp_double@PAGE
Lloh54:
	add	x3, x3, _cmp_double@PAGEOFF
	bl	_qsort
Lloh55:
	adrp	x8, _patterns@PAGE
Lloh56:
	add	x8, x8, _patterns@PAGEOFF
	ldr	x9, [sp, #160]                  ; 8-byte Folded Reload
	ldr	x8, [x8, x9, lsl #3]
	ldr	x9, [x24]
	ldr	d0, [x19, #16]
	ldr	d1, [x19]
	ldr	d2, [x19, #32]
	ldr	w10, [x21, x20, lsl #2]
	stp	d1, d2, [sp, #56]
	str	d0, [sp, #48]
	mov	w11, #5                         ; =0x5
	stp	x10, x11, [sp, #32]
	mov	w10, #8                         ; =0x8
	stp	x9, x10, [sp, #16]
	str	x8, [sp, #8]
	ldr	x8, [sp, #152]                  ; 8-byte Folded Reload
	str	x8, [sp]
	ldr	x0, [sp, #88]                   ; 8-byte Folded Reload
Lloh57:
	adrp	x1, l_.str.105@PAGE
Lloh58:
	add	x1, x1, l_.str.105@PAGEOFF
	bl	_fprintf
LBB0_140:                               ;   in Loop: Header=BB0_141 Depth=3
	add	x20, x20, #1
	add	x24, x24, #24
	add	x19, x19, #40
	cmp	x20, #13
	b.eq	LBB0_77
LBB0_141:                               ;   Parent Loop BB0_75 Depth=1
                                        ;     Parent Loop BB0_78 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	cmn	w25, #3
	b.hi	LBB0_143
; %bb.142:                              ;   in Loop: Header=BB0_141 Depth=3
	sub	w8, w20, #11
	cmp	w8, #2
	b.lo	LBB0_140
LBB0_143:                               ;   in Loop: Header=BB0_141 Depth=3
	cmp	x26, #4
	b.ne	LBB0_139
; %bb.144:                              ;   in Loop: Header=BB0_141 Depth=3
	cmp	w20, #10
	b.hi	LBB0_139
; %bb.145:                              ;   in Loop: Header=BB0_141 Depth=3
	mov	w8, #1                          ; =0x1
	lsl	w8, w8, w20
	mov	w9, #1584                       ; =0x630
	tst	w8, w9
	b.ne	LBB0_140
	b	LBB0_139
LBB0_146:
	mov	x0, x23
	bl	_BN_free
	mov	x0, x22
	bl	_BN_CTX_free
Lloh59:
	adrp	x8, ___stderrp@GOTPAGE
Lloh60:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh61:
	ldr	x0, [x8]
Lloh62:
	adrp	x8, __MergedGlobals@PAGE
Lloh63:
	ldr	x8, [x8, __MergedGlobals@PAGEOFF]
	str	x8, [sp]
Lloh64:
	adrp	x1, l_.str.107@PAGE
Lloh65:
	add	x1, x1, l_.str.107@PAGEOFF
	bl	_fprintf
	ldr	x8, [sp, #72]                   ; 8-byte Folded Reload
	cbz	x8, LBB0_67
; %bb.147:
	mov	x0, x19
	bl	_fclose
	cbz	w0, LBB0_150
; %bb.148:
	bl	_main.cold.10
LBB0_149:
Lloh66:
	adrp	x8, ___stderrp@GOTPAGE
Lloh67:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh68:
	ldr	x0, [x8]
	ldr	x8, [x19]
	str	x8, [sp]
Lloh69:
	adrp	x1, l_.str.4@PAGE
Lloh70:
	add	x1, x1, l_.str.4@PAGEOFF
	bl	_fprintf
	ldr	x0, [x19, x28, lsl #3]
Lloh71:
	adrp	x1, l_.str.5@PAGE
Lloh72:
	add	x1, x1, l_.str.5@PAGEOFF
	bl	_strcmp
	cmp	w0, #0
	cset	w8, ne
	lsl	w0, w8, #1
LBB0_150:
	ldur	x8, [x29, #-128]
Lloh73:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh74:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh75:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB0_68
LBB0_151:
	add	sp, sp, #960
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #16]               ; 16-byte Folded Reload
	ldp	d11, d10, [sp], #128            ; 16-byte Folded Reload
	ret
LBB0_152:
Lloh76:
	adrp	x8, ___stdoutp@GOTPAGE
Lloh77:
	ldr	x8, [x8, ___stdoutp@GOTPAGEOFF]
Lloh78:
	ldr	x19, [x8]
	cbnz	x19, LBB0_71
LBB0_153:
	bl	_main.cold.11
LBB0_154:
	bl	_main.cold.7
LBB0_155:
	bl	_main.cold.8
LBB0_156:
	bl	_main.cold.9
LBB0_157:
	bl	_main.cold.3
LBB0_158:
	bl	_main.cold.13
LBB0_159:
	bl	_main.cold.12
LBB0_160:
	bl	_main.cold.5
LBB0_161:
	bl	_main.cold.4
LBB0_162:
	mov	x0, x19
	bl	_main.cold.1
LBB0_163:
	bl	_main.cold.14
LBB0_164:
	bl	_main.cold.2
LBB0_165:
	bl	_main.cold.6
	.loh AdrpLdrGotLdr	Lloh0, Lloh1, Lloh2
	.loh AdrpAdd	Lloh9, Lloh10
	.loh AdrpAdd	Lloh7, Lloh8
	.loh AdrpAdd	Lloh5, Lloh6
	.loh AdrpAdd	Lloh3, Lloh4
	.loh AdrpLdrGot	Lloh11, Lloh12
	.loh AdrpAdd	Lloh19, Lloh20
	.loh AdrpAdd	Lloh17, Lloh18
	.loh AdrpAdd	Lloh15, Lloh16
	.loh AdrpAdd	Lloh13, Lloh14
	.loh AdrpAdd	Lloh21, Lloh22
	.loh AdrpAdd	Lloh23, Lloh24
	.loh AdrpAdd	Lloh25, Lloh26
	.loh AdrpAdd	Lloh27, Lloh28
	.loh AdrpLdrGotLdr	Lloh29, Lloh30, Lloh31
	.loh AdrpAdd	Lloh32, Lloh33
	.loh AdrpAdd	Lloh42, Lloh43
	.loh AdrpLdr	Lloh40, Lloh41
	.loh AdrpAdrp	Lloh38, Lloh40
	.loh AdrpLdr	Lloh38, Lloh39
	.loh AdrpAdrp	Lloh36, Lloh38
	.loh AdrpLdr	Lloh36, Lloh37
	.loh AdrpAdd	Lloh34, Lloh35
	.loh AdrpAdd	Lloh44, Lloh45
	.loh AdrpAdd	Lloh51, Lloh52
	.loh AdrpAdd	Lloh49, Lloh50
	.loh AdrpLdrGotLdr	Lloh46, Lloh47, Lloh48
	.loh AdrpAdd	Lloh57, Lloh58
	.loh AdrpAdd	Lloh55, Lloh56
	.loh AdrpAdd	Lloh53, Lloh54
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpLdr	Lloh62, Lloh63
	.loh AdrpLdrGotLdr	Lloh59, Lloh60, Lloh61
	.loh AdrpAdd	Lloh71, Lloh72
	.loh AdrpAdd	Lloh69, Lloh70
	.loh AdrpLdrGotLdr	Lloh66, Lloh67, Lloh68
	.loh AdrpLdrGotLdr	Lloh73, Lloh74, Lloh75
	.loh AdrpLdrGotLdr	Lloh76, Lloh77, Lloh78
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function verify_pair
_verify_pair:                           ; @verify_pair
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x22, x1
	mov	x20, x0
	bl	_BN_new
	mov	x19, x0
	bl	_BN_new
	cbz	x19, LBB1_16
; %bb.1:
	mov	x21, x0
	cbz	x0, LBB1_16
; %bb.2:
	ldp	x1, x2, [x20]
	mov	x0, x19
	mov	x3, x22
	bl	_BN_mul
	cbz	w0, LBB1_17
; %bb.3:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_native_mul
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_18
; %bb.4:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_19
; %bb.5:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_20
; %bb.6:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_shift_add_short
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_21
; %bb.7:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_shift_add_sparse
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_22
; %bb.8:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_23
; %bb.9:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_24
; %bb.10:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_25
; %bb.11:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_set_bits
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_26
; %bb.12:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_prefix
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_27
; %bb.13:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_near_native
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_28
; %bb.14:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_near_recursive
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB1_29
; %bb.15:
	mov	x0, x19
	bl	_BN_free
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_BN_free
LBB1_16:
	bl	_verify_pair.cold.1
LBB1_17:
	bl	_verify_pair.cold.3
LBB1_18:
Lloh79:
	adrp	x4, _algorithms@PAGE+24
Lloh80:
	add	x4, x4, _algorithms@PAGEOFF+24
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_19:
Lloh81:
	adrp	x4, _algorithms@PAGE+48
Lloh82:
	add	x4, x4, _algorithms@PAGEOFF+48
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_20:
Lloh83:
	adrp	x4, _algorithms@PAGE+72
Lloh84:
	add	x4, x4, _algorithms@PAGEOFF+72
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_21:
Lloh85:
	adrp	x4, _algorithms@PAGE+96
Lloh86:
	add	x4, x4, _algorithms@PAGEOFF+96
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_22:
Lloh87:
	adrp	x4, _algorithms@PAGE+120
Lloh88:
	add	x4, x4, _algorithms@PAGEOFF+120
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_23:
Lloh89:
	adrp	x4, _algorithms@PAGE+144
Lloh90:
	add	x4, x4, _algorithms@PAGEOFF+144
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_24:
Lloh91:
	adrp	x4, _algorithms@PAGE+168
Lloh92:
	add	x4, x4, _algorithms@PAGEOFF+168
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_25:
Lloh93:
	adrp	x4, _algorithms@PAGE+192
Lloh94:
	add	x4, x4, _algorithms@PAGEOFF+192
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_26:
Lloh95:
	adrp	x4, _algorithms@PAGE+216
Lloh96:
	add	x4, x4, _algorithms@PAGEOFF+216
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_27:
Lloh97:
	adrp	x4, _algorithms@PAGE+240
Lloh98:
	add	x4, x4, _algorithms@PAGEOFF+240
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_28:
Lloh99:
	adrp	x4, _algorithms@PAGE+264
Lloh100:
	add	x4, x4, _algorithms@PAGEOFF+264
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB1_29:
Lloh101:
	adrp	x4, _algorithms@PAGE+288
Lloh102:
	add	x4, x4, _algorithms@PAGEOFF+288
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
	.loh AdrpAdd	Lloh79, Lloh80
	.loh AdrpAdd	Lloh81, Lloh82
	.loh AdrpAdd	Lloh83, Lloh84
	.loh AdrpAdd	Lloh85, Lloh86
	.loh AdrpAdd	Lloh87, Lloh88
	.loh AdrpAdd	Lloh89, Lloh90
	.loh AdrpAdd	Lloh91, Lloh92
	.loh AdrpAdd	Lloh93, Lloh94
	.loh AdrpAdd	Lloh95, Lloh96
	.loh AdrpAdd	Lloh97, Lloh98
	.loh AdrpAdd	Lloh99, Lloh100
	.loh AdrpAdd	Lloh101, Lloh102
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair
_make_pair:                             ; @make_pair
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x21, x2
	mov	x20, x1
	mov	x19, x0
	bl	_BN_new
	str	x0, [x19]
	bl	_BN_new
	mov	x8, x0
	str	x0, [x19, #8]
	ldr	x0, [x19]
	cmp	x0, #0
	ccmp	x8, #0, #4, ne
	b.eq	LBB2_39
; %bb.1:
	mov	x1, x20
	bl	_random_bits
	ldr	x0, [x19, #8]
	mov	x1, x20
	bl	_random_bits
	cmp	w21, #3
	b.le	LBB2_7
; %bb.2:
	cmp	w21, #5
	b.gt	LBB2_17
; %bb.3:
	cmp	w21, #4
	b.eq	LBB2_28
; %bb.4:
	cmp	w21, #5
	b.ne	LBB2_38
; %bb.5:
	ldr	x0, [x19, #8]
	adrp	x8, _rng_state@PAGE
	ldr	x9, [x8, _rng_state@PAGEOFF]
	eor	x9, x9, x9, lsl #13
	eor	x9, x9, x9, lsr #7
	eor	x10, x9, x9, lsl #17
	str	x10, [x8, _rng_state@PAGEOFF]
	mov	w1, #128                        ; =0x80
	bfxil	x1, x9, #0, #7
	bl	_BN_set_word
	cbnz	w0, LBB2_38
; %bb.6:
	bl	_make_pair.cold.6
LBB2_7:
	cmp	w21, #1
	b.eq	LBB2_24
; %bb.8:
	cmp	w21, #2
	b.eq	LBB2_37
; %bb.9:
	cmp	w21, #3
	b.ne	LBB2_38
; %bb.10:
	ldr	x0, [x19]
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbz	w0, LBB2_42
; %bb.11:
	ldr	x0, [x19, #8]
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbz	w0, LBB2_47
; %bb.12:
	ldr	x0, [x19]
	sub	w21, w20, #1
	mov	x1, x21
	bl	_BN_set_bit
	cbz	w0, LBB2_50
; %bb.13:
	ldr	x0, [x19, #8]
	mov	x1, x21
	bl	_BN_set_bit
	cbz	w0, LBB2_53
; %bb.14:
	ldr	x0, [x19]
	adrp	x21, _rng_state@PAGE
	ldr	x8, [x21, _rng_state@PAGEOFF]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	str	x8, [x21, _rng_state@PAGEOFF]
	sub	w20, w20, #2
	udiv	x9, x8, x20
	msub	w8, w9, w20, w8
	add	w1, w8, #1
	bl	_BN_set_bit
	cbz	w0, LBB2_55
; %bb.15:
	ldr	x0, [x19, #8]
	ldr	x8, [x21, _rng_state@PAGEOFF]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	str	x8, [x21, _rng_state@PAGEOFF]
	udiv	x9, x8, x20
	msub	w8, w9, w20, w8
	add	w1, w8, #1
	bl	_BN_set_bit
	cbnz	w0, LBB2_38
; %bb.16:
	bl	_make_pair.cold.13
LBB2_17:
	cmp	w21, #6
	b.eq	LBB2_35
; %bb.18:
	cmp	w21, #7
	b.ne	LBB2_38
; %bb.19:
	ldr	x0, [x19]
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB2_43
; %bb.20:
	ldr	x0, [x19]
	sub	w1, w20, #1
	bl	_BN_set_bit
	cbz	w0, LBB2_48
; %bb.21:
	ldr	x0, [x19, #8]
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB2_51
; %bb.22:
	ldr	x0, [x19, #8]
	add	w8, w20, w20, lsr #31
	asr	w1, w8, #1
	bl	_BN_set_bit
	cbnz	w0, LBB2_38
; %bb.23:
	bl	_make_pair.cold.1
LBB2_24:
	ldr	x0, [x19]
	mov	w1, #8                          ; =0x8
	bl	_BN_clear_bit
	cbz	w0, LBB2_40
; %bb.25:
	ldp	x1, x0, [x19]
	bl	_BN_copy
	cbz	x0, LBB2_45
; %bb.26:
	ldr	x0, [x19, #8]
	adrp	x8, _rng_state@PAGE
	ldr	x9, [x8, _rng_state@PAGEOFF]
	eor	x9, x9, x9, lsl #13
	eor	x9, x9, x9, lsr #7
	eor	x9, x9, x9, lsl #17
	str	x9, [x8, _rng_state@PAGEOFF]
	mov	x8, #-9187201950435737472       ; =0x8080808080808080
	movk	x8, #32897
	umulh	x8, x9, x8
	lsr	x8, x8, #7
	sub	x8, x8, x8, lsl #8
	add	x8, x9, x8
	add	x1, x8, #1
	bl	_BN_add_word
	cbnz	w0, LBB2_38
; %bb.27:
	bl	_make_pair.cold.20
LBB2_28:
	ldr	x0, [x19]
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB2_41
; %bb.29:
	ldr	x0, [x19]
	mov	x1, x20
	bl	_BN_set_bit
	cbz	w0, LBB2_46
; %bb.30:
	ldr	x0, [x19]
	mov	w1, #1                          ; =0x1
	bl	_BN_sub_word
	cbz	w0, LBB2_49
; %bb.31:
	ldp	x1, x0, [x19]
	bl	_BN_copy
	cbz	x0, LBB2_52
; %bb.32:
	ldr	x0, [x19]
	adrp	x21, _rng_state@PAGE
	ldr	x8, [x21, _rng_state@PAGEOFF]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	str	x8, [x21, _rng_state@PAGEOFF]
	sub	w20, w20, #1
	udiv	x9, x8, x20
	msub	w1, w9, w20, w8
	bl	_BN_clear_bit
	cbz	w0, LBB2_54
; %bb.33:
	ldr	x0, [x19, #8]
	ldr	x8, [x21, _rng_state@PAGEOFF]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	str	x8, [x21, _rng_state@PAGEOFF]
	udiv	x9, x8, x20
	msub	w1, w9, w20, w8
	bl	_BN_clear_bit
	cbnz	w0, LBB2_38
; %bb.34:
	bl	_make_pair.cold.7
LBB2_35:
	ldr	x0, [x19, #8]
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbnz	w0, LBB2_38
; %bb.36:
	bl	_make_pair.cold.5
LBB2_37:
	ldp	x1, x0, [x19]
	bl	_BN_copy
	cbz	x0, LBB2_44
LBB2_38:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB2_39:
	bl	_make_pair.cold.23
LBB2_40:
	bl	_make_pair.cold.22
LBB2_41:
	bl	_make_pair.cold.12
LBB2_42:
	bl	_make_pair.cold.18
LBB2_43:
	bl	_make_pair.cold.4
LBB2_44:
	bl	_make_pair.cold.19
LBB2_45:
	bl	_make_pair.cold.21
LBB2_46:
	bl	_make_pair.cold.11
LBB2_47:
	bl	_make_pair.cold.17
LBB2_48:
	bl	_make_pair.cold.3
LBB2_49:
	bl	_make_pair.cold.10
LBB2_50:
	bl	_make_pair.cold.16
LBB2_51:
	bl	_make_pair.cold.2
LBB2_52:
	bl	_make_pair.cold.9
LBB2_53:
	bl	_make_pair.cold.15
LBB2_54:
	bl	_make_pair.cold.8
LBB2_55:
	bl	_make_pair.cold.14
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function copy_control
_copy_control:                          ; @copy_control
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_BN_copy
	cbz	x0, LBB3_2
; %bb.1:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
LBB3_2:
Lloh103:
	adrp	x8, ___stderrp@GOTPAGE
Lloh104:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh105:
	ldr	x0, [x8]
Lloh106:
	adrp	x8, l_.str.36@PAGE
Lloh107:
	add	x8, x8, l_.str.36@PAGEOFF
	mov	w9, #214                        ; =0xd6
	stp	x9, x8, [sp]
Lloh108:
	adrp	x1, l_.str.6@PAGE
Lloh109:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh108, Lloh109
	.loh AdrpAdd	Lloh106, Lloh107
	.loh AdrpLdrGotLdr	Lloh103, Lloh104, Lloh105
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function native_mul
_native_mul:                            ; @native_mul
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_BN_mul
	cbz	w0, LBB4_2
; %bb.1:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
LBB4_2:
Lloh110:
	adrp	x8, ___stderrp@GOTPAGE
Lloh111:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh112:
	ldr	x0, [x8]
Lloh113:
	adrp	x8, l_.str.37@PAGE
Lloh114:
	add	x8, x8, l_.str.37@PAGEOFF
	mov	w9, #186                        ; =0xba
	stp	x9, x8, [sp]
Lloh115:
	adrp	x1, l_.str.6@PAGE
Lloh116:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh115, Lloh116
	.loh AdrpAdd	Lloh113, Lloh114
	.loh AdrpLdrGotLdr	Lloh110, Lloh111, Lloh112
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function native_equal_aware
_native_equal_aware:                    ; @native_equal_aware
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x3
	mov	x21, x2
	mov	x20, x1
	mov	x22, x0
	mov	x0, x1
	mov	x1, x2
	bl	_BN_cmp
	cbz	w0, LBB5_3
; %bb.1:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x21
	mov	x3, x19
	bl	_BN_mul
	cbnz	w0, LBB5_4
; %bb.2:
Lloh117:
	adrp	x8, ___stderrp@GOTPAGE
Lloh118:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh119:
	ldr	x0, [x8]
Lloh120:
	adrp	x8, l_.str.39@PAGE
Lloh121:
	add	x8, x8, l_.str.39@PAGEOFF
	mov	w9, #191                        ; =0xbf
	stp	x9, x8, [sp]
Lloh122:
	adrp	x1, l_.str.6@PAGE
Lloh123:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB5_3:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x19
	bl	_BN_sqr
	cbz	w0, LBB5_5
LBB5_4:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB5_5:
Lloh124:
	adrp	x8, ___stderrp@GOTPAGE
Lloh125:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh126:
	ldr	x0, [x8]
Lloh127:
	adrp	x8, l_.str.38@PAGE
Lloh128:
	add	x8, x8, l_.str.38@PAGEOFF
	mov	w9, #190                        ; =0xbe
	stp	x9, x8, [sp]
Lloh129:
	adrp	x1, l_.str.6@PAGE
Lloh130:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh122, Lloh123
	.loh AdrpAdd	Lloh120, Lloh121
	.loh AdrpLdrGotLdr	Lloh117, Lloh118, Lloh119
	.loh AdrpAdd	Lloh129, Lloh130
	.loh AdrpAdd	Lloh127, Lloh128
	.loh AdrpLdrGotLdr	Lloh124, Lloh125, Lloh126
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mid_native_square
_mid_native_square:                     ; @mid_native_square
	.cfi_startproc
; %bb.0:
	b	_midpoint.specialized.1
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add_short
_shift_add_short:                       ; @shift_add_short
	.cfi_startproc
; %bb.0:
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x19, x3
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	mov	x0, x1
	bl	_BN_num_bits
	mov	x23, x0
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w23, w0
	b.ge	LBB7_2
; %bb.1:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x21
	mov	x3, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	b	_shift_add_selected
LBB7_2:
	mov	x0, x22
	mov	x1, x21
	mov	x2, x20
	mov	x3, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	b	_shift_add_selected
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add_sparse
_shift_add_sparse:                      ; @shift_add_sparse
	.cfi_startproc
; %bb.0:
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x3
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	mov	x0, x1
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB8_8
; %bb.1:
	mov	x23, x0
	mov	w25, #0                         ; =0x0
	mov	w24, #0                         ; =0x0
LBB8_2:                                 ; =>This Inner Loop Header: Depth=1
	mov	x0, x21
	mov	x1, x24
	bl	_BN_is_bit_set
	add	w25, w0, w25
	add	w24, w24, #1
	cmp	w23, w24
	b.ne	LBB8_2
; %bb.3:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB8_9
LBB8_4:
	mov	x23, x0
	mov	w26, #0                         ; =0x0
	mov	w24, #0                         ; =0x0
LBB8_5:                                 ; =>This Inner Loop Header: Depth=1
	mov	x0, x20
	mov	x1, x24
	bl	_BN_is_bit_set
	add	w26, w0, w26
	add	w24, w24, #1
	cmp	w23, w24
	b.ne	LBB8_5
; %bb.6:
	mov	x0, x22
	cmp	w25, w26
	b.hs	LBB8_10
LBB8_7:
	mov	x1, x20
	mov	x2, x21
	b	LBB8_11
LBB8_8:
	mov	w25, #0                         ; =0x0
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.ge	LBB8_4
LBB8_9:
	mov	w26, #0                         ; =0x0
	mov	x0, x22
	cmp	w25, w26
	b.lo	LBB8_7
LBB8_10:
	mov	x1, x21
	mov	x2, x20
LBB8_11:
	mov	x3, x19
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_shift_add_selected
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function direct_karatsuba
_direct_karatsuba:                      ; @direct_karatsuba
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #176
	stp	x28, x27, [sp, #80]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #96]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #112]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #128]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #144]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #160]            ; 16-byte Folded Spill
	add	x29, sp, #160
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x20, x3
	mov	x27, x2
	mov	x22, x1
	mov	x19, x0
	mov	x0, x1
	bl	_BN_num_bits
	mov	x21, x0
	mov	x0, x27
	bl	_BN_num_bits
	cbz	w21, LBB9_6
; %bb.1:
	cbz	w0, LBB9_6
; %bb.2:
	cmp	w21, #8
	b.gt	LBB9_8
; %bb.3:
	cmp	w0, #8
	b.gt	LBB9_8
; %bb.4:
	mov	x0, x22
	bl	_BN_get_word
	mov	x20, x0
	mov	x0, x27
	bl	_BN_get_word
	cmp	w20, w0
	csel	w8, w20, w0, hi
	csel	w9, w20, w0, lo
	sub	w8, w8, w9
	lsr	w10, w8, #1
	add	w11, w10, w9
Lloh131:
	adrp	x12, __MergedGlobals@PAGE+8
Lloh132:
	add	x12, x12, __MergedGlobals@PAGEOFF+8
	ldrh	w11, [x12, w11, uxtw #1]
	lsl	w10, w10, #1
	ldrh	w10, [x12, w10, uxtw]
	sbfx	w8, w8, #0, #1
	and	w8, w8, w9
	sub	w8, w8, w10
	add	w1, w8, w11
	mov	x0, x19
	bl	_BN_set_word
	cbnz	w0, LBB9_7
; %bb.5:
Lloh133:
	adrp	x8, ___stderrp@GOTPAGE
Lloh134:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh135:
	ldr	x0, [x8]
Lloh136:
	adrp	x8, l_.str.50@PAGE
Lloh137:
	add	x8, x8, l_.str.50@PAGEOFF
	mov	w9, #164                        ; =0xa4
	stp	x9, x8, [sp]
Lloh138:
	adrp	x1, l_.str.6@PAGE
Lloh139:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_6:
	mov	x0, x19
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB9_41
LBB9_7:
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #144]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #128]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #176
	ret
LBB9_8:
	cmp	w21, #9
	b.lt	LBB9_24
; %bb.9:
	cmp	w0, #8
	b.le	LBB9_24
; %bb.10:
	cmp	w21, w0
	csel	w26, w21, w0, hi
	mov	x0, x20
	bl	_BN_CTX_start
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB9_40
; %bb.11:
	mov	x24, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #72]                   ; 8-byte Folded Spill
	cbz	x0, LBB9_40
; %bb.12:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB9_40
; %bb.13:
	mov	x28, x0
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB9_40
; %bb.14:
	mov	x21, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #64]                   ; 8-byte Folded Spill
	cbz	x0, LBB9_40
; %bb.15:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB9_40
; %bb.16:
	mov	x23, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #56]                   ; 8-byte Folded Spill
	cbz	x0, LBB9_40
; %bb.17:
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #48]                   ; 8-byte Folded Spill
	cbz	x0, LBB9_40
; %bb.18:
	str	x23, [sp, #40]                  ; 8-byte Folded Spill
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #32]                   ; 8-byte Folded Spill
	cbz	x0, LBB9_40
; %bb.19:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB9_40
; %bb.20:
	mov	x23, x0
	str	w26, [sp, #28]                  ; 4-byte Folded Spill
	lsr	w26, w26, #1
	mov	x0, x24
	mov	x1, x22
	mov	x2, x26
	bl	_BN_rshift
	cbz	w0, LBB9_42
; %bb.21:
	ldr	x25, [sp, #72]                  ; 8-byte Folded Reload
	mov	x0, x25
	mov	x1, x22
	mov	x2, x26
	bl	_low_bits
	mov	x0, x28
	mov	x1, x27
	mov	x2, x26
	bl	_BN_rshift
	cbz	w0, LBB9_43
; %bb.22:
	mov	x0, x21
	mov	x1, x27
	mov	x2, x26
	bl	_low_bits
	mov	x0, x24
	mov	x1, x25
	bl	_BN_cmp
	mov	x22, x0
	tbnz	w0, #31, LBB9_25
; %bb.23:
	ldr	x0, [sp, #64]                   ; 8-byte Folded Reload
	mov	x1, x24
	mov	x2, x25
	bl	_BN_sub
	cbnz	w0, LBB9_26
	b	LBB9_37
LBB9_24:
	mov	x0, x19
	mov	x1, x22
	mov	x2, x27
	mov	x3, x20
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #144]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #128]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #176
	b	_shift_add_short
LBB9_25:
	ldr	x0, [sp, #64]                   ; 8-byte Folded Reload
	mov	x1, x25
	mov	x2, x24
	bl	_BN_sub
	cbz	w0, LBB9_37
LBB9_26:
	mov	x0, x28
	mov	x1, x21
	bl	_BN_cmp
	mov	x27, x0
	str	w22, [sp, #24]                  ; 4-byte Folded Spill
	tbnz	w0, #31, LBB9_36
; %bb.27:
	ldr	x25, [sp, #40]                  ; 8-byte Folded Reload
	mov	x0, x25
	mov	x1, x28
	mov	x2, x21
	bl	_BN_sub
	cbz	w0, LBB9_37
LBB9_28:
	ldr	x22, [sp, #56]                  ; 8-byte Folded Reload
	mov	x0, x22
	mov	x1, x24
	mov	x2, x28
	mov	x3, x20
	bl	_direct_karatsuba
	ldr	x24, [sp, #48]                  ; 8-byte Folded Reload
	mov	x0, x24
	ldr	x1, [sp, #72]                   ; 8-byte Folded Reload
	mov	x2, x21
	mov	x3, x20
	bl	_direct_karatsuba
	ldr	x21, [sp, #32]                  ; 8-byte Folded Reload
	mov	x0, x21
	ldr	x1, [sp, #64]                   ; 8-byte Folded Reload
	mov	x2, x25
	mov	x3, x20
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x22
	mov	x2, x24
	bl	_BN_add
	cbz	w0, LBB9_44
; %bb.29:
	ldr	w8, [sp, #24]                   ; 4-byte Folded Reload
	mov	x0, x23
	mov	x1, x23
	mov	x2, x21
	eor	w8, w27, w8
	tbnz	w8, #31, LBB9_38
; %bb.30:
	bl	_BN_sub
	cbz	w0, LBB9_39
LBB9_31:
	ldr	w8, [sp, #28]                   ; 4-byte Folded Reload
	and	w2, w8, #0x7ffffffe
	mov	x0, x19
	ldr	x1, [sp, #56]                   ; 8-byte Folded Reload
	bl	_BN_lshift
	cbz	w0, LBB9_45
; %bb.32:
	mov	x0, x23
	mov	x1, x23
	mov	x2, x26
	bl	_BN_lshift
	cbz	w0, LBB9_46
; %bb.33:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x23
	bl	_BN_add
	cbz	w0, LBB9_47
; %bb.34:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x24
	bl	_BN_add
	cbz	w0, LBB9_48
; %bb.35:
	mov	x0, x20
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #144]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #128]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #176
	b	_BN_CTX_end
LBB9_36:
	ldr	x25, [sp, #40]                  ; 8-byte Folded Reload
	mov	x0, x25
	mov	x1, x21
	mov	x2, x28
	bl	_BN_sub
	cbnz	w0, LBB9_28
LBB9_37:
Lloh140:
	adrp	x8, ___stderrp@GOTPAGE
Lloh141:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh142:
	ldr	x0, [x8]
Lloh143:
	adrp	x8, l_.str.61@PAGE
Lloh144:
	add	x8, x8, l_.str.61@PAGEOFF
	mov	w9, #52                         ; =0x34
	stp	x9, x8, [sp]
Lloh145:
	adrp	x1, l_.str.6@PAGE
Lloh146:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_38:
	bl	_BN_add
	cbnz	w0, LBB9_31
LBB9_39:
Lloh147:
	adrp	x8, ___stderrp@GOTPAGE
Lloh148:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh149:
	ldr	x0, [x8]
Lloh150:
	adrp	x8, l_.str.54@PAGE
Lloh151:
	add	x8, x8, l_.str.54@PAGEOFF
	mov	w9, #179                        ; =0xb3
	stp	x9, x8, [sp]
Lloh152:
	adrp	x1, l_.str.6@PAGE
Lloh153:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_40:
Lloh154:
	adrp	x8, ___stderrp@GOTPAGE
Lloh155:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh156:
	ldr	x0, [x8]
Lloh157:
	adrp	x8, l_.str.45@PAGE
Lloh158:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh159:
	adrp	x1, l_.str.6@PAGE
Lloh160:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_41:
Lloh161:
	adrp	x8, ___stderrp@GOTPAGE
Lloh162:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh163:
	ldr	x0, [x8]
Lloh164:
	adrp	x8, l_.str.47@PAGE
Lloh165:
	add	x8, x8, l_.str.47@PAGEOFF
	mov	w9, #159                        ; =0x9f
	stp	x9, x8, [sp]
Lloh166:
	adrp	x1, l_.str.6@PAGE
Lloh167:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_42:
Lloh168:
	adrp	x8, ___stderrp@GOTPAGE
Lloh169:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh170:
	ldr	x0, [x8]
Lloh171:
	adrp	x8, l_.str.51@PAGE
Lloh172:
	add	x8, x8, l_.str.51@PAGEOFF
	mov	w9, #173                        ; =0xad
	stp	x9, x8, [sp]
Lloh173:
	adrp	x1, l_.str.6@PAGE
Lloh174:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_43:
Lloh175:
	adrp	x8, ___stderrp@GOTPAGE
Lloh176:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh177:
	ldr	x0, [x8]
Lloh178:
	adrp	x8, l_.str.52@PAGE
Lloh179:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #174                        ; =0xae
	stp	x9, x8, [sp]
Lloh180:
	adrp	x1, l_.str.6@PAGE
Lloh181:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_44:
Lloh182:
	adrp	x8, ___stderrp@GOTPAGE
Lloh183:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh184:
	ldr	x0, [x8]
Lloh185:
	adrp	x8, l_.str.53@PAGE
Lloh186:
	add	x8, x8, l_.str.53@PAGEOFF
	mov	w9, #178                        ; =0xb2
	stp	x9, x8, [sp]
Lloh187:
	adrp	x1, l_.str.6@PAGE
Lloh188:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_45:
Lloh189:
	adrp	x8, ___stderrp@GOTPAGE
Lloh190:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh191:
	ldr	x0, [x8]
Lloh192:
	adrp	x8, l_.str.55@PAGE
Lloh193:
	add	x8, x8, l_.str.55@PAGEOFF
	mov	w9, #180                        ; =0xb4
	stp	x9, x8, [sp]
Lloh194:
	adrp	x1, l_.str.6@PAGE
Lloh195:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_46:
Lloh196:
	adrp	x8, ___stderrp@GOTPAGE
Lloh197:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh198:
	ldr	x0, [x8]
Lloh199:
	adrp	x8, l_.str.56@PAGE
Lloh200:
	add	x8, x8, l_.str.56@PAGEOFF
	mov	w9, #180                        ; =0xb4
	stp	x9, x8, [sp]
Lloh201:
	adrp	x1, l_.str.6@PAGE
Lloh202:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_47:
Lloh203:
	adrp	x8, ___stderrp@GOTPAGE
Lloh204:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh205:
	ldr	x0, [x8]
Lloh206:
	adrp	x8, l_.str.57@PAGE
Lloh207:
	add	x8, x8, l_.str.57@PAGEOFF
	mov	w9, #181                        ; =0xb5
	stp	x9, x8, [sp]
Lloh208:
	adrp	x1, l_.str.6@PAGE
Lloh209:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB9_48:
Lloh210:
	adrp	x8, ___stderrp@GOTPAGE
Lloh211:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh212:
	ldr	x0, [x8]
Lloh213:
	adrp	x8, l_.str.58@PAGE
Lloh214:
	add	x8, x8, l_.str.58@PAGEOFF
	mov	w9, #181                        ; =0xb5
	stp	x9, x8, [sp]
Lloh215:
	adrp	x1, l_.str.6@PAGE
Lloh216:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh131, Lloh132
	.loh AdrpAdd	Lloh138, Lloh139
	.loh AdrpAdd	Lloh136, Lloh137
	.loh AdrpLdrGotLdr	Lloh133, Lloh134, Lloh135
	.loh AdrpAdd	Lloh145, Lloh146
	.loh AdrpAdd	Lloh143, Lloh144
	.loh AdrpLdrGotLdr	Lloh140, Lloh141, Lloh142
	.loh AdrpAdd	Lloh152, Lloh153
	.loh AdrpAdd	Lloh150, Lloh151
	.loh AdrpLdrGotLdr	Lloh147, Lloh148, Lloh149
	.loh AdrpAdd	Lloh159, Lloh160
	.loh AdrpAdd	Lloh157, Lloh158
	.loh AdrpLdrGotLdr	Lloh154, Lloh155, Lloh156
	.loh AdrpAdd	Lloh166, Lloh167
	.loh AdrpAdd	Lloh164, Lloh165
	.loh AdrpLdrGotLdr	Lloh161, Lloh162, Lloh163
	.loh AdrpAdd	Lloh173, Lloh174
	.loh AdrpAdd	Lloh171, Lloh172
	.loh AdrpLdrGotLdr	Lloh168, Lloh169, Lloh170
	.loh AdrpAdd	Lloh180, Lloh181
	.loh AdrpAdd	Lloh178, Lloh179
	.loh AdrpLdrGotLdr	Lloh175, Lloh176, Lloh177
	.loh AdrpAdd	Lloh187, Lloh188
	.loh AdrpAdd	Lloh185, Lloh186
	.loh AdrpLdrGotLdr	Lloh182, Lloh183, Lloh184
	.loh AdrpAdd	Lloh194, Lloh195
	.loh AdrpAdd	Lloh192, Lloh193
	.loh AdrpLdrGotLdr	Lloh189, Lloh190, Lloh191
	.loh AdrpAdd	Lloh201, Lloh202
	.loh AdrpAdd	Lloh199, Lloh200
	.loh AdrpLdrGotLdr	Lloh196, Lloh197, Lloh198
	.loh AdrpAdd	Lloh208, Lloh209
	.loh AdrpAdd	Lloh206, Lloh207
	.loh AdrpLdrGotLdr	Lloh203, Lloh204, Lloh205
	.loh AdrpAdd	Lloh215, Lloh216
	.loh AdrpAdd	Lloh213, Lloh214
	.loh AdrpLdrGotLdr	Lloh210, Lloh211, Lloh212
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function recursive_equal_aware
_recursive_equal_aware:                 ; @recursive_equal_aware
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x3
	mov	x21, x2
	mov	x20, x1
	mov	x22, x0
	mov	x0, x1
	mov	x1, x2
	bl	_BN_cmp
	cbz	w0, LBB10_2
; %bb.1:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x21
	mov	x3, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_direct_karatsuba
LBB10_2:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_square_recursive
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mid_recursive
_mid_recursive:                         ; @mid_recursive
	.cfi_startproc
; %bb.0:
Lloh217:
	adrp	x4, _square_recursive@PAGE
Lloh218:
	add	x4, x4, _square_recursive@PAGEOFF
	b	_midpoint
	.loh AdrpAdd	Lloh217, Lloh218
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mid_set_bits
_mid_set_bits:                          ; @mid_set_bits
	.cfi_startproc
; %bb.0:
Lloh219:
	adrp	x4, _square_set_bits@PAGE
Lloh220:
	add	x4, x4, _square_set_bits@PAGEOFF
	b	_midpoint
	.loh AdrpAdd	Lloh219, Lloh220
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mid_prefix
_mid_prefix:                            ; @mid_prefix
	.cfi_startproc
; %bb.0:
Lloh221:
	adrp	x4, _square_prefix@PAGE
Lloh222:
	add	x4, x4, _square_prefix@PAGEOFF
	b	_midpoint
	.loh AdrpAdd	Lloh221, Lloh222
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_native
_near_native:                           ; @near_native
	.cfi_startproc
; %bb.0:
	mov	w4, #1                          ; =0x1
	b	_near_identity
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_recursive
_near_recursive:                        ; @near_recursive
	.cfi_startproc
; %bb.0:
	mov	w4, #0                          ; =0x0
	b	_near_identity
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function midpoint
_midpoint:                              ; @midpoint
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x22, x4
	mov	x19, x3
	mov	x21, x2
	mov	x23, x1
	mov	x20, x0
	mov	x0, x1
	mov	x1, x2
	bl	_BN_cmp
	cmp	w0, #0
	csel	x27, x23, x21, gt
	csel	x21, x21, x23, gt
	mov	x0, x19
	bl	_BN_CTX_start
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB16_11
; %bb.1:
	mov	x26, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB16_11
; %bb.2:
	mov	x23, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB16_11
; %bb.3:
	mov	x25, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB16_11
; %bb.4:
	mov	x24, x0
	mov	x0, x26
	mov	x1, x27
	mov	x2, x21
	bl	_BN_sub
	cbz	w0, LBB16_12
; %bb.5:
	mov	x0, x26
	bl	_BN_is_odd
	mov	x27, x0
	mov	x0, x23
	mov	x1, x26
	bl	_BN_rshift1
	cbz	w0, LBB16_13
; %bb.6:
	mov	x0, x25
	mov	x1, x21
	mov	x2, x23
	bl	_BN_add
	cbz	w0, LBB16_14
; %bb.7:
	mov	x0, x20
	mov	x1, x25
	mov	x2, x19
	blr	x22
	mov	x0, x24
	mov	x1, x23
	mov	x2, x19
	blr	x22
	mov	x0, x20
	mov	x1, x20
	mov	x2, x24
	bl	_BN_sub
	cbz	w0, LBB16_16
; %bb.8:
	cbz	w27, LBB16_10
; %bb.9:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x21
	bl	_BN_add
	cbz	w0, LBB16_17
LBB16_10:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	b	_BN_CTX_end
LBB16_11:
Lloh223:
	adrp	x8, ___stderrp@GOTPAGE
Lloh224:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh225:
	ldr	x0, [x8]
Lloh226:
	adrp	x8, l_.str.45@PAGE
Lloh227:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh228:
	adrp	x1, l_.str.6@PAGE
Lloh229:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB16_12:
Lloh230:
	adrp	x8, ___stderrp@GOTPAGE
Lloh231:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh232:
	ldr	x0, [x8]
Lloh233:
	adrp	x8, l_.str.40@PAGE
Lloh234:
	add	x8, x8, l_.str.40@PAGEOFF
	mov	w9, #115                        ; =0x73
	stp	x9, x8, [sp]
Lloh235:
	adrp	x1, l_.str.6@PAGE
Lloh236:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB16_13:
Lloh237:
	adrp	x8, ___stderrp@GOTPAGE
Lloh238:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh239:
	ldr	x0, [x8]
Lloh240:
	adrp	x8, l_.str.41@PAGE
Lloh241:
	add	x8, x8, l_.str.41@PAGEOFF
	b	LBB16_15
LBB16_14:
Lloh242:
	adrp	x8, ___stderrp@GOTPAGE
Lloh243:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh244:
	ldr	x0, [x8]
Lloh245:
	adrp	x8, l_.str.42@PAGE
Lloh246:
	add	x8, x8, l_.str.42@PAGEOFF
LBB16_15:
	mov	w9, #117                        ; =0x75
	stp	x9, x8, [sp]
Lloh247:
	adrp	x1, l_.str.6@PAGE
Lloh248:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB16_16:
Lloh249:
	adrp	x8, ___stderrp@GOTPAGE
Lloh250:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh251:
	ldr	x0, [x8]
Lloh252:
	adrp	x8, l_.str.43@PAGE
Lloh253:
	add	x8, x8, l_.str.43@PAGEOFF
	mov	w9, #119                        ; =0x77
	stp	x9, x8, [sp]
Lloh254:
	adrp	x1, l_.str.6@PAGE
Lloh255:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB16_17:
Lloh256:
	adrp	x8, ___stderrp@GOTPAGE
Lloh257:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh258:
	ldr	x0, [x8]
Lloh259:
	adrp	x8, l_.str.44@PAGE
Lloh260:
	add	x8, x8, l_.str.44@PAGEOFF
	mov	w9, #120                        ; =0x78
	stp	x9, x8, [sp]
Lloh261:
	adrp	x1, l_.str.6@PAGE
Lloh262:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh228, Lloh229
	.loh AdrpAdd	Lloh226, Lloh227
	.loh AdrpLdrGotLdr	Lloh223, Lloh224, Lloh225
	.loh AdrpAdd	Lloh235, Lloh236
	.loh AdrpAdd	Lloh233, Lloh234
	.loh AdrpLdrGotLdr	Lloh230, Lloh231, Lloh232
	.loh AdrpAdd	Lloh240, Lloh241
	.loh AdrpLdrGotLdr	Lloh237, Lloh238, Lloh239
	.loh AdrpAdd	Lloh245, Lloh246
	.loh AdrpLdrGotLdr	Lloh242, Lloh243, Lloh244
	.loh AdrpAdd	Lloh247, Lloh248
	.loh AdrpAdd	Lloh254, Lloh255
	.loh AdrpAdd	Lloh252, Lloh253
	.loh AdrpLdrGotLdr	Lloh249, Lloh250, Lloh251
	.loh AdrpAdd	Lloh261, Lloh262
	.loh AdrpAdd	Lloh259, Lloh260
	.loh AdrpLdrGotLdr	Lloh256, Lloh257, Lloh258
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add_selected
_shift_add_selected:                    ; @shift_add_selected
	.cfi_startproc
; %bb.0:
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x3
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	mov	x0, x3
	bl	_BN_CTX_start
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB17_11
; %bb.1:
	mov	x23, x0
	mov	x0, x22
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB17_12
; %bb.2:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB17_9
; %bb.3:
	mov	x24, x0
	mov	w25, #0                         ; =0x0
	b	LBB17_5
LBB17_4:                                ;   in Loop: Header=BB17_5 Depth=1
	add	w25, w25, #1
	cmp	w24, w25
	b.eq	LBB17_9
LBB17_5:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x20
	mov	x1, x25
	bl	_BN_is_bit_set
	cbz	w0, LBB17_4
; %bb.6:                                ;   in Loop: Header=BB17_5 Depth=1
	mov	x0, x23
	mov	x1, x21
	mov	x2, x25
	bl	_BN_lshift
	cbz	w0, LBB17_10
; %bb.7:                                ;   in Loop: Header=BB17_5 Depth=1
	mov	x0, x22
	mov	x1, x22
	mov	x2, x23
	bl	_BN_add
	cbnz	w0, LBB17_4
; %bb.8:
	bl	_shift_add_selected.cold.1
LBB17_9:
	mov	x0, x19
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_BN_CTX_end
LBB17_10:
	bl	_shift_add_selected.cold.2
LBB17_11:
	bl	_shift_add_selected.cold.4
LBB17_12:
	bl	_shift_add_selected.cold.3
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function low_bits
_low_bits:                              ; @low_bits
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x2
	mov	x20, x0
	bl	_BN_copy
	cbz	x0, LBB18_4
; %bb.1:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, w19
	b.le	LBB18_3
; %bb.2:
	mov	x0, x20
	mov	x1, x19
	bl	_BN_mask_bits
	cbz	w0, LBB18_5
LBB18_3:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB18_4:
	bl	_low_bits.cold.2
LBB18_5:
	bl	_low_bits.cold.1
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function square_recursive
_square_recursive:                      ; @square_recursive
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #128
	stp	x28, x27, [sp, #32]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	mov	x20, x2
	mov	x28, x1
	mov	x19, x0
	mov	x0, x1
	bl	_BN_num_bits
	cmp	w0, #8
	b.gt	LBB19_3
; %bb.1:
	mov	x0, x28
	bl	_BN_get_word
Lloh263:
	adrp	x8, __MergedGlobals@PAGE
Lloh264:
	add	x8, x8, __MergedGlobals@PAGEOFF
	add	x8, x8, x0, lsl #1
	ldrh	w1, [x8, #8]
	mov	x0, x19
	bl	_BN_set_word
	cbz	w0, LBB19_23
; %bb.2:
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
LBB19_3:
	mov	x21, x0
	mov	x0, x20
	bl	_BN_CTX_start
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB19_22
; %bb.4:
	mov	x25, x0
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB19_22
; %bb.5:
	mov	x27, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #24]                   ; 8-byte Folded Spill
	cbz	x0, LBB19_22
; %bb.6:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB19_22
; %bb.7:
	mov	x23, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #16]                   ; 8-byte Folded Spill
	cbz	x0, LBB19_22
; %bb.8:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB19_22
; %bb.9:
	mov	x22, x0
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB19_22
; %bb.10:
	mov	x24, x0
	lsr	w26, w21, #1
	mov	x0, x25
	mov	x1, x28
	mov	x2, x26
	bl	_BN_rshift
	cbz	w0, LBB19_24
; %bb.11:
	mov	x0, x27
	mov	x1, x28
	mov	x2, x26
	bl	_low_bits
	mov	x0, x25
	mov	x1, x27
	bl	_BN_cmp
	tbnz	w0, #31, LBB19_20
; %bb.12:
	ldr	x28, [sp, #24]                  ; 8-byte Folded Reload
	mov	x0, x28
	mov	x1, x25
	mov	x2, x27
	bl	_BN_sub
	cbz	w0, LBB19_21
LBB19_13:
	mov	x0, x23
	mov	x1, x25
	mov	x2, x20
	bl	_square_recursive
	ldr	x25, [sp, #16]                  ; 8-byte Folded Reload
	mov	x0, x25
	mov	x1, x27
	mov	x2, x20
	bl	_square_recursive
	mov	x0, x22
	mov	x1, x28
	mov	x2, x20
	bl	_square_recursive
	mov	x0, x24
	mov	x1, x23
	mov	x2, x25
	bl	_BN_add
	cbz	w0, LBB19_25
; %bb.14:
	mov	x0, x24
	mov	x1, x24
	mov	x2, x22
	bl	_BN_sub
	cbz	w0, LBB19_26
; %bb.15:
	and	w2, w21, #0x7ffffffe
	mov	x0, x19
	mov	x1, x23
	bl	_BN_lshift
	cbz	w0, LBB19_28
; %bb.16:
	mov	x0, x24
	mov	x1, x24
	mov	x2, x26
	bl	_BN_lshift
	cbz	w0, LBB19_29
; %bb.17:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x24
	bl	_BN_add
	cbz	w0, LBB19_30
; %bb.18:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x25
	bl	_BN_add
	cbz	w0, LBB19_31
; %bb.19:
	mov	x0, x20
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #128
	b	_BN_CTX_end
LBB19_20:
	ldr	x28, [sp, #24]                  ; 8-byte Folded Reload
	mov	x0, x28
	mov	x1, x27
	mov	x2, x25
	bl	_BN_sub
	cbnz	w0, LBB19_13
LBB19_21:
Lloh265:
	adrp	x8, ___stderrp@GOTPAGE
Lloh266:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh267:
	ldr	x0, [x8]
Lloh268:
	adrp	x8, l_.str.61@PAGE
Lloh269:
	add	x8, x8, l_.str.61@PAGEOFF
	mov	w9, #52                         ; =0x34
	stp	x9, x8, [sp]
Lloh270:
	adrp	x1, l_.str.6@PAGE
Lloh271:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_22:
Lloh272:
	adrp	x8, ___stderrp@GOTPAGE
Lloh273:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh274:
	ldr	x0, [x8]
Lloh275:
	adrp	x8, l_.str.45@PAGE
Lloh276:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh277:
	adrp	x1, l_.str.6@PAGE
Lloh278:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_23:
Lloh279:
	adrp	x8, ___stderrp@GOTPAGE
Lloh280:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh281:
	ldr	x0, [x8]
Lloh282:
	adrp	x8, l_.str.62@PAGE
Lloh283:
	add	x8, x8, l_.str.62@PAGEOFF
	mov	w9, #90                         ; =0x5a
	stp	x9, x8, [sp]
Lloh284:
	adrp	x1, l_.str.6@PAGE
Lloh285:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_24:
Lloh286:
	adrp	x8, ___stderrp@GOTPAGE
Lloh287:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh288:
	ldr	x0, [x8]
Lloh289:
	adrp	x8, l_.str.63@PAGE
Lloh290:
	add	x8, x8, l_.str.63@PAGEOFF
	mov	w9, #95                         ; =0x5f
	stp	x9, x8, [sp]
Lloh291:
	adrp	x1, l_.str.6@PAGE
Lloh292:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_25:
Lloh293:
	adrp	x8, ___stderrp@GOTPAGE
Lloh294:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh295:
	ldr	x0, [x8]
Lloh296:
	adrp	x8, l_.str.53@PAGE
Lloh297:
	add	x8, x8, l_.str.53@PAGEOFF
	b	LBB19_27
LBB19_26:
Lloh298:
	adrp	x8, ___stderrp@GOTPAGE
Lloh299:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh300:
	ldr	x0, [x8]
Lloh301:
	adrp	x8, l_.str.64@PAGE
Lloh302:
	add	x8, x8, l_.str.64@PAGEOFF
LBB19_27:
	mov	w9, #99                         ; =0x63
	stp	x9, x8, [sp]
Lloh303:
	adrp	x1, l_.str.6@PAGE
Lloh304:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_28:
Lloh305:
	adrp	x8, ___stderrp@GOTPAGE
Lloh306:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh307:
	ldr	x0, [x8]
Lloh308:
	adrp	x8, l_.str.65@PAGE
Lloh309:
	add	x8, x8, l_.str.65@PAGEOFF
	mov	w9, #100                        ; =0x64
	stp	x9, x8, [sp]
Lloh310:
	adrp	x1, l_.str.6@PAGE
Lloh311:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_29:
Lloh312:
	adrp	x8, ___stderrp@GOTPAGE
Lloh313:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh314:
	ldr	x0, [x8]
Lloh315:
	adrp	x8, l_.str.56@PAGE
Lloh316:
	add	x8, x8, l_.str.56@PAGEOFF
	mov	w9, #100                        ; =0x64
	stp	x9, x8, [sp]
Lloh317:
	adrp	x1, l_.str.6@PAGE
Lloh318:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_30:
Lloh319:
	adrp	x8, ___stderrp@GOTPAGE
Lloh320:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh321:
	ldr	x0, [x8]
Lloh322:
	adrp	x8, l_.str.57@PAGE
Lloh323:
	add	x8, x8, l_.str.57@PAGEOFF
	mov	w9, #101                        ; =0x65
	stp	x9, x8, [sp]
Lloh324:
	adrp	x1, l_.str.6@PAGE
Lloh325:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB19_31:
Lloh326:
	adrp	x8, ___stderrp@GOTPAGE
Lloh327:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh328:
	ldr	x0, [x8]
Lloh329:
	adrp	x8, l_.str.58@PAGE
Lloh330:
	add	x8, x8, l_.str.58@PAGEOFF
	mov	w9, #101                        ; =0x65
	stp	x9, x8, [sp]
Lloh331:
	adrp	x1, l_.str.6@PAGE
Lloh332:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh263, Lloh264
	.loh AdrpAdd	Lloh270, Lloh271
	.loh AdrpAdd	Lloh268, Lloh269
	.loh AdrpLdrGotLdr	Lloh265, Lloh266, Lloh267
	.loh AdrpAdd	Lloh277, Lloh278
	.loh AdrpAdd	Lloh275, Lloh276
	.loh AdrpLdrGotLdr	Lloh272, Lloh273, Lloh274
	.loh AdrpAdd	Lloh284, Lloh285
	.loh AdrpAdd	Lloh282, Lloh283
	.loh AdrpLdrGotLdr	Lloh279, Lloh280, Lloh281
	.loh AdrpAdd	Lloh291, Lloh292
	.loh AdrpAdd	Lloh289, Lloh290
	.loh AdrpLdrGotLdr	Lloh286, Lloh287, Lloh288
	.loh AdrpAdd	Lloh296, Lloh297
	.loh AdrpLdrGotLdr	Lloh293, Lloh294, Lloh295
	.loh AdrpAdd	Lloh301, Lloh302
	.loh AdrpLdrGotLdr	Lloh298, Lloh299, Lloh300
	.loh AdrpAdd	Lloh303, Lloh304
	.loh AdrpAdd	Lloh310, Lloh311
	.loh AdrpAdd	Lloh308, Lloh309
	.loh AdrpLdrGotLdr	Lloh305, Lloh306, Lloh307
	.loh AdrpAdd	Lloh317, Lloh318
	.loh AdrpAdd	Lloh315, Lloh316
	.loh AdrpLdrGotLdr	Lloh312, Lloh313, Lloh314
	.loh AdrpAdd	Lloh324, Lloh325
	.loh AdrpAdd	Lloh322, Lloh323
	.loh AdrpLdrGotLdr	Lloh319, Lloh320, Lloh321
	.loh AdrpAdd	Lloh331, Lloh332
	.loh AdrpAdd	Lloh329, Lloh330
	.loh AdrpLdrGotLdr	Lloh326, Lloh327, Lloh328
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function square_set_bits
_square_set_bits:                       ; @square_set_bits
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x2
	mov	x20, x1
	mov	x21, x0
	mov	x0, x2
	bl	_BN_CTX_start
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB20_18
; %bb.1:
	mov	x22, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB20_18
; %bb.2:
	mov	x23, x0
	mov	x0, x22
	mov	x1, x20
	bl	_BN_copy
	cbz	x0, LBB20_19
; %bb.3:
	mov	x0, x21
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB20_20
; %bb.4:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB20_14
; %bb.5:
	mov	x24, x0
	mov	w25, #0                         ; =0x0
	b	LBB20_8
LBB20_6:                                ;   in Loop: Header=BB20_8 Depth=1
	add	w25, w25, #1
LBB20_7:                                ;   in Loop: Header=BB20_8 Depth=1
	cmp	w25, w24
	b.eq	LBB20_14
LBB20_8:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x20
	mov	x1, x25
	bl	_BN_is_bit_set
	cbz	w0, LBB20_6
; %bb.9:                                ;   in Loop: Header=BB20_8 Depth=1
	mov	x0, x22
	mov	x1, x25
	bl	_BN_clear_bit
	cbz	w0, LBB20_17
; %bb.10:                               ;   in Loop: Header=BB20_8 Depth=1
	add	w26, w25, #1
	mov	x0, x23
	mov	x1, x22
	mov	x2, x26
	bl	_BN_lshift
	cbz	w0, LBB20_15
; %bb.11:                               ;   in Loop: Header=BB20_8 Depth=1
	lsl	w1, w25, #1
	mov	x0, x23
	bl	_BN_set_bit
	cbz	w0, LBB20_16
; %bb.12:                               ;   in Loop: Header=BB20_8 Depth=1
	mov	x0, x21
	mov	x1, x21
	mov	x2, x23
	bl	_BN_add
	mov	x25, x26
	cbnz	w0, LBB20_7
; %bb.13:
Lloh333:
	adrp	x8, ___stderrp@GOTPAGE
Lloh334:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh335:
	ldr	x0, [x8]
Lloh336:
	adrp	x8, l_.str.49@PAGE
Lloh337:
	add	x8, x8, l_.str.49@PAGEOFF
	mov	w9, #83                         ; =0x53
	stp	x9, x8, [sp]
Lloh338:
	adrp	x1, l_.str.6@PAGE
Lloh339:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB20_14:
	mov	x0, x19
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	b	_BN_CTX_end
LBB20_15:
Lloh340:
	adrp	x8, ___stderrp@GOTPAGE
Lloh341:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh342:
	ldr	x0, [x8]
Lloh343:
	adrp	x8, l_.str.68@PAGE
Lloh344:
	add	x8, x8, l_.str.68@PAGEOFF
	mov	w9, #81                         ; =0x51
	stp	x9, x8, [sp]
Lloh345:
	adrp	x1, l_.str.6@PAGE
Lloh346:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB20_16:
Lloh347:
	adrp	x8, ___stderrp@GOTPAGE
Lloh348:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh349:
	ldr	x0, [x8]
Lloh350:
	adrp	x8, l_.str.69@PAGE
Lloh351:
	add	x8, x8, l_.str.69@PAGEOFF
	mov	w9, #82                         ; =0x52
	stp	x9, x8, [sp]
Lloh352:
	adrp	x1, l_.str.6@PAGE
Lloh353:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB20_17:
Lloh354:
	adrp	x8, ___stderrp@GOTPAGE
Lloh355:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh356:
	ldr	x0, [x8]
Lloh357:
	adrp	x8, l_.str.67@PAGE
Lloh358:
	add	x8, x8, l_.str.67@PAGEOFF
	mov	w9, #80                         ; =0x50
	stp	x9, x8, [sp]
Lloh359:
	adrp	x1, l_.str.6@PAGE
Lloh360:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB20_18:
Lloh361:
	adrp	x8, ___stderrp@GOTPAGE
Lloh362:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh363:
	ldr	x0, [x8]
Lloh364:
	adrp	x8, l_.str.45@PAGE
Lloh365:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh366:
	adrp	x1, l_.str.6@PAGE
Lloh367:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB20_19:
Lloh368:
	adrp	x8, ___stderrp@GOTPAGE
Lloh369:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh370:
	ldr	x0, [x8]
Lloh371:
	adrp	x8, l_.str.66@PAGE
Lloh372:
	add	x8, x8, l_.str.66@PAGEOFF
	mov	w9, #76                         ; =0x4c
	stp	x9, x8, [sp]
Lloh373:
	adrp	x1, l_.str.6@PAGE
Lloh374:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB20_20:
Lloh375:
	adrp	x8, ___stderrp@GOTPAGE
Lloh376:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh377:
	ldr	x0, [x8]
Lloh378:
	adrp	x8, l_.str.47@PAGE
Lloh379:
	add	x8, x8, l_.str.47@PAGEOFF
	mov	w9, #76                         ; =0x4c
	stp	x9, x8, [sp]
Lloh380:
	adrp	x1, l_.str.6@PAGE
Lloh381:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh338, Lloh339
	.loh AdrpAdd	Lloh336, Lloh337
	.loh AdrpLdrGotLdr	Lloh333, Lloh334, Lloh335
	.loh AdrpAdd	Lloh345, Lloh346
	.loh AdrpAdd	Lloh343, Lloh344
	.loh AdrpLdrGotLdr	Lloh340, Lloh341, Lloh342
	.loh AdrpAdd	Lloh352, Lloh353
	.loh AdrpAdd	Lloh350, Lloh351
	.loh AdrpLdrGotLdr	Lloh347, Lloh348, Lloh349
	.loh AdrpAdd	Lloh359, Lloh360
	.loh AdrpAdd	Lloh357, Lloh358
	.loh AdrpLdrGotLdr	Lloh354, Lloh355, Lloh356
	.loh AdrpAdd	Lloh366, Lloh367
	.loh AdrpAdd	Lloh364, Lloh365
	.loh AdrpLdrGotLdr	Lloh361, Lloh362, Lloh363
	.loh AdrpAdd	Lloh373, Lloh374
	.loh AdrpAdd	Lloh371, Lloh372
	.loh AdrpLdrGotLdr	Lloh368, Lloh369, Lloh370
	.loh AdrpAdd	Lloh380, Lloh381
	.loh AdrpAdd	Lloh378, Lloh379
	.loh AdrpLdrGotLdr	Lloh375, Lloh376, Lloh377
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function square_prefix
_square_prefix:                         ; @square_prefix
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x2
	mov	x20, x1
	mov	x21, x0
	mov	x0, x2
	bl	_BN_CTX_start
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB21_22
; %bb.1:
	mov	x22, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB21_22
; %bb.2:
	mov	x23, x0
	mov	x0, x22
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB21_23
; %bb.3:
	mov	x0, x21
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB21_24
; %bb.4:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB21_16
; %bb.5:
	add	w25, w0, #1
	b	LBB21_8
LBB21_6:                                ;   in Loop: Header=BB21_8 Depth=1
	mov	x0, x22
	mov	x1, x22
	bl	_BN_lshift1
	cbz	w0, LBB21_18
LBB21_7:                                ;   in Loop: Header=BB21_8 Depth=1
	sub	w25, w25, #1
	cmp	w25, #1
	b.ls	LBB21_16
LBB21_8:                                ; =>This Inner Loop Header: Depth=1
	sub	w1, w25, #2
	mov	x0, x20
	bl	_BN_is_bit_set
	mov	x24, x0
	mov	x0, x21
	mov	x1, x21
	mov	w2, #2                          ; =0x2
	bl	_BN_lshift
	cbz	w0, LBB21_17
; %bb.9:                                ;   in Loop: Header=BB21_8 Depth=1
	cbz	w24, LBB21_6
; %bb.10:                               ;   in Loop: Header=BB21_8 Depth=1
	mov	x0, x23
	mov	x1, x22
	mov	w2, #2                          ; =0x2
	bl	_BN_lshift
	cbz	w0, LBB21_19
; %bb.11:                               ;   in Loop: Header=BB21_8 Depth=1
	mov	x0, x23
	mov	w1, #1                          ; =0x1
	bl	_BN_add_word
	cbz	w0, LBB21_20
; %bb.12:                               ;   in Loop: Header=BB21_8 Depth=1
	mov	x0, x21
	mov	x1, x21
	mov	x2, x23
	bl	_BN_add
	cbz	w0, LBB21_21
; %bb.13:                               ;   in Loop: Header=BB21_8 Depth=1
	mov	x0, x22
	mov	x1, x22
	bl	_BN_lshift1
	cbz	w0, LBB21_18
; %bb.14:                               ;   in Loop: Header=BB21_8 Depth=1
	mov	x0, x22
	mov	w1, #1                          ; =0x1
	bl	_BN_add_word
	cbnz	w0, LBB21_7
; %bb.15:
Lloh382:
	adrp	x8, ___stderrp@GOTPAGE
Lloh383:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh384:
	ldr	x0, [x8]
Lloh385:
	adrp	x8, l_.str.75@PAGE
Lloh386:
	add	x8, x8, l_.str.75@PAGEOFF
	mov	w9, #68                         ; =0x44
	stp	x9, x8, [sp]
Lloh387:
	adrp	x1, l_.str.6@PAGE
Lloh388:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_16:
	mov	x0, x19
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	b	_BN_CTX_end
LBB21_17:
Lloh389:
	adrp	x8, ___stderrp@GOTPAGE
Lloh390:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh391:
	ldr	x0, [x8]
Lloh392:
	adrp	x8, l_.str.71@PAGE
Lloh393:
	add	x8, x8, l_.str.71@PAGEOFF
	mov	w9, #62                         ; =0x3e
	stp	x9, x8, [sp]
Lloh394:
	adrp	x1, l_.str.6@PAGE
Lloh395:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_18:
Lloh396:
	adrp	x8, ___stderrp@GOTPAGE
Lloh397:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh398:
	ldr	x0, [x8]
Lloh399:
	adrp	x8, l_.str.74@PAGE
Lloh400:
	add	x8, x8, l_.str.74@PAGEOFF
	mov	w9, #67                         ; =0x43
	stp	x9, x8, [sp]
Lloh401:
	adrp	x1, l_.str.6@PAGE
Lloh402:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_19:
Lloh403:
	adrp	x8, ___stderrp@GOTPAGE
Lloh404:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh405:
	ldr	x0, [x8]
Lloh406:
	adrp	x8, l_.str.72@PAGE
Lloh407:
	add	x8, x8, l_.str.72@PAGEOFF
	mov	w9, #64                         ; =0x40
	stp	x9, x8, [sp]
Lloh408:
	adrp	x1, l_.str.6@PAGE
Lloh409:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_20:
Lloh410:
	adrp	x8, ___stderrp@GOTPAGE
Lloh411:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh412:
	ldr	x0, [x8]
Lloh413:
	adrp	x8, l_.str.73@PAGE
Lloh414:
	add	x8, x8, l_.str.73@PAGEOFF
	mov	w9, #65                         ; =0x41
	stp	x9, x8, [sp]
Lloh415:
	adrp	x1, l_.str.6@PAGE
Lloh416:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_21:
Lloh417:
	adrp	x8, ___stderrp@GOTPAGE
Lloh418:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh419:
	ldr	x0, [x8]
Lloh420:
	adrp	x8, l_.str.49@PAGE
Lloh421:
	add	x8, x8, l_.str.49@PAGEOFF
	mov	w9, #65                         ; =0x41
	stp	x9, x8, [sp]
Lloh422:
	adrp	x1, l_.str.6@PAGE
Lloh423:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_22:
Lloh424:
	adrp	x8, ___stderrp@GOTPAGE
Lloh425:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh426:
	ldr	x0, [x8]
Lloh427:
	adrp	x8, l_.str.45@PAGE
Lloh428:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh429:
	adrp	x1, l_.str.6@PAGE
Lloh430:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_23:
Lloh431:
	adrp	x8, ___stderrp@GOTPAGE
Lloh432:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh433:
	ldr	x0, [x8]
Lloh434:
	adrp	x8, l_.str.70@PAGE
Lloh435:
	add	x8, x8, l_.str.70@PAGEOFF
	mov	w9, #59                         ; =0x3b
	stp	x9, x8, [sp]
Lloh436:
	adrp	x1, l_.str.6@PAGE
Lloh437:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_24:
Lloh438:
	adrp	x8, ___stderrp@GOTPAGE
Lloh439:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh440:
	ldr	x0, [x8]
Lloh441:
	adrp	x8, l_.str.47@PAGE
Lloh442:
	add	x8, x8, l_.str.47@PAGEOFF
	mov	w9, #59                         ; =0x3b
	stp	x9, x8, [sp]
Lloh443:
	adrp	x1, l_.str.6@PAGE
Lloh444:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh387, Lloh388
	.loh AdrpAdd	Lloh385, Lloh386
	.loh AdrpLdrGotLdr	Lloh382, Lloh383, Lloh384
	.loh AdrpAdd	Lloh394, Lloh395
	.loh AdrpAdd	Lloh392, Lloh393
	.loh AdrpLdrGotLdr	Lloh389, Lloh390, Lloh391
	.loh AdrpAdd	Lloh401, Lloh402
	.loh AdrpAdd	Lloh399, Lloh400
	.loh AdrpLdrGotLdr	Lloh396, Lloh397, Lloh398
	.loh AdrpAdd	Lloh408, Lloh409
	.loh AdrpAdd	Lloh406, Lloh407
	.loh AdrpLdrGotLdr	Lloh403, Lloh404, Lloh405
	.loh AdrpAdd	Lloh415, Lloh416
	.loh AdrpAdd	Lloh413, Lloh414
	.loh AdrpLdrGotLdr	Lloh410, Lloh411, Lloh412
	.loh AdrpAdd	Lloh422, Lloh423
	.loh AdrpAdd	Lloh420, Lloh421
	.loh AdrpLdrGotLdr	Lloh417, Lloh418, Lloh419
	.loh AdrpAdd	Lloh429, Lloh430
	.loh AdrpAdd	Lloh427, Lloh428
	.loh AdrpLdrGotLdr	Lloh424, Lloh425, Lloh426
	.loh AdrpAdd	Lloh436, Lloh437
	.loh AdrpAdd	Lloh434, Lloh435
	.loh AdrpLdrGotLdr	Lloh431, Lloh432, Lloh433
	.loh AdrpAdd	Lloh443, Lloh444
	.loh AdrpAdd	Lloh441, Lloh442
	.loh AdrpLdrGotLdr	Lloh438, Lloh439, Lloh440
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_identity
_near_identity:                         ; @near_identity
	.cfi_startproc
; %bb.0:
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x24, x4
	mov	x19, x3
	mov	x21, x2
	mov	x22, x1
	mov	x20, x0
	mov	x0, x1
	mov	x1, x2
	bl	_BN_cmp
	cmp	w0, #0
	csel	x25, x22, x21, gt
	csel	x21, x21, x22, gt
	mov	x0, x19
	bl	_BN_CTX_start
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB22_10
; %bb.1:
	mov	x23, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB22_11
; %bb.2:
	mov	x22, x0
	mov	x0, x23
	mov	x1, x25
	mov	x2, x21
	bl	_BN_sub
	cbz	w0, LBB22_12
; %bb.3:
	mov	x0, x20
	mov	x1, x21
	mov	x2, x19
	cbz	w24, LBB22_8
; %bb.4:
	bl	_BN_sqr
	cbz	w0, LBB22_13
; %bb.5:
	mov	x0, x22
	mov	x1, x21
	mov	x2, x23
	mov	x3, x19
	bl	_BN_mul
	cbz	w0, LBB22_14
; %bb.6:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x22
	bl	_BN_add
	cbz	w0, LBB22_9
LBB22_7:
	mov	x0, x19
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_BN_CTX_end
LBB22_8:
	bl	_square_recursive
	mov	x0, x22
	mov	x1, x21
	mov	x2, x23
	mov	x3, x19
	bl	_shift_add_short
	mov	x0, x20
	mov	x1, x20
	mov	x2, x22
	bl	_BN_add
	cbnz	w0, LBB22_7
LBB22_9:
	bl	_near_identity.cold.3
LBB22_10:
	bl	_near_identity.cold.6
LBB22_11:
	bl	_near_identity.cold.5
LBB22_12:
	bl	_near_identity.cold.4
LBB22_13:
	bl	_near_identity.cold.2
LBB22_14:
	bl	_near_identity.cold.1
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function random_bits
_random_bits:                           ; @random_bits
	.cfi_startproc
; %bb.0:
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x21, x1
	mov	x19, x0
	add	w22, w1, #7
	sbfx	x0, x22, #3, #29
	bl	_malloc
	cbz	x0, LBB23_8
; %bb.1:
	mov	x20, x0
	asr	w1, w22, #3
	cmp	w1, #1
	b.lt	LBB23_5
; %bb.2:
	mov	x9, #0                          ; =0x0
	adrp	x8, _rng_state@PAGE
	ldr	x10, [x8, _rng_state@PAGEOFF]
LBB23_3:                                ; =>This Inner Loop Header: Depth=1
	eor	x10, x10, x10, lsl #13
	eor	x11, x10, x10, lsr #7
	eor	x10, x11, x11, lsl #17
	strb	w11, [x20, x9]
	add	x9, x9, #1
	cmp	x1, x9
	b.ne	LBB23_3
; %bb.4:
	str	x10, [x8, _rng_state@PAGEOFF]
	ldrb	w8, [x20]
	b	LBB23_6
LBB23_5:
                                        ; implicit-def: $w8
LBB23_6:
	neg	w9, w21
	and	w9, w9, #0x7
	mov	w10, #255                       ; =0xff
	lsr	w9, w10, w9
	and	w8, w8, w9
	and	w9, w22, #0x7
	mov	w10, #1                         ; =0x1
	lsl	w9, w10, w9
	orr	w8, w8, w9
	strb	w8, [x20]
	mov	x0, x20
                                        ; kill: def $w1 killed $w1 killed $x1
	mov	x2, x19
	bl	_BN_bin2bn
	cbz	x0, LBB23_9
; %bb.7:
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_free
LBB23_8:
	bl	_random_bits.cold.2
LBB23_9:
	bl	_random_bits.cold.1
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function run_batch
_run_batch:                             ; @run_batch
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x4
	mov	x20, x3
	mov	x21, x2
	mov	x22, x1
	mov	x23, x0
	mov	x1, sp
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB24_5
; %bb.1:
	ldp	x25, x24, [sp]
	mov	x26, #0                         ; =0x0
	cbz	w21, LBB24_3
LBB24_2:                                ; =>This Inner Loop Header: Depth=1
	ldp	x1, x2, [x22]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	ldp	x1, x2, [x22, #16]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	ldp	x1, x2, [x22, #32]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	ldp	x1, x2, [x22, #48]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	ldp	x1, x2, [x22, #64]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	ldp	x1, x2, [x22, #80]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	ldp	x1, x2, [x22, #96]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	ldp	x1, x2, [x22, #112]
	mov	x0, x19
	mov	x3, x20
	blr	x23
	mov	x0, x19
	bl	_BN_num_bits
	add	x26, x26, w0, sxtw
	subs	w21, w21, #1
	b.ne	LBB24_2
LBB24_3:
	mov	x1, sp
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB24_6
; %bb.4:
	ldp	x8, x9, [sp]
	adrp	x10, __MergedGlobals@PAGE
	ldr	x11, [x10, __MergedGlobals@PAGEOFF]
	eor	x11, x11, x26
	str	x11, [x10, __MergedGlobals@PAGEOFF]
	sub	x8, x8, x25
	mov	w10, #51712                     ; =0xca00
	movk	w10, #15258, lsl #16
	sub	x9, x9, x24
	madd	x8, x8, x10, x9
	ucvtf	d0, x8
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
LBB24_5:
	bl	_run_batch.cold.1
LBB24_6:
	bl	_run_batch.cold.2
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function cmp_double
_cmp_double:                            ; @cmp_double
	.cfi_startproc
; %bb.0:
	ldr	d0, [x0]
	ldr	d1, [x1]
	fcmp	d0, d1
	cset	w8, gt
	cset	w9, mi
	sub	w0, w8, w9
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function midpoint.specialized.1
_midpoint.specialized.1:                ; @midpoint.specialized.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x3
	mov	x21, x2
	mov	x22, x1
	mov	x20, x0
	mov	x0, x1
	mov	x1, x2
	bl	_BN_cmp
	cmp	w0, #0
	csel	x25, x22, x21, gt
	csel	x21, x21, x22, gt
	mov	x0, x19
	bl	_BN_CTX_start
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB26_13
; %bb.1:
	mov	x26, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB26_13
; %bb.2:
	mov	x22, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB26_13
; %bb.3:
	mov	x24, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB26_13
; %bb.4:
	mov	x23, x0
	mov	x0, x26
	mov	x1, x25
	mov	x2, x21
	bl	_BN_sub
	cbz	w0, LBB26_15
; %bb.5:
	mov	x0, x26
	bl	_BN_is_odd
	mov	x25, x0
	mov	x0, x22
	mov	x1, x26
	bl	_BN_rshift1
	cbz	w0, LBB26_16
; %bb.6:
	mov	x0, x24
	mov	x1, x21
	mov	x2, x22
	bl	_BN_add
	cbz	w0, LBB26_17
; %bb.7:
	mov	x0, x20
	mov	x1, x24
	mov	x2, x19
	bl	_BN_sqr
	cbz	w0, LBB26_14
; %bb.8:
	mov	x0, x23
	mov	x1, x22
	mov	x2, x19
	bl	_BN_sqr
	cbz	w0, LBB26_14
; %bb.9:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x23
	bl	_BN_sub
	cbz	w0, LBB26_19
; %bb.10:
	cbz	w25, LBB26_12
; %bb.11:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x21
	bl	_BN_add
	cbz	w0, LBB26_20
LBB26_12:
	mov	x0, x19
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	b	_BN_CTX_end
LBB26_13:
Lloh445:
	adrp	x8, ___stderrp@GOTPAGE
Lloh446:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh447:
	ldr	x0, [x8]
Lloh448:
	adrp	x8, l_.str.45@PAGE
Lloh449:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh450:
	adrp	x1, l_.str.6@PAGE
Lloh451:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB26_14:
Lloh452:
	adrp	x8, ___stderrp@GOTPAGE
Lloh453:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh454:
	ldr	x0, [x8]
Lloh455:
	adrp	x8, l_.str.46@PAGE
Lloh456:
	add	x8, x8, l_.str.46@PAGEOFF
	mov	w9, #106                        ; =0x6a
	stp	x9, x8, [sp]
Lloh457:
	adrp	x1, l_.str.6@PAGE
Lloh458:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB26_15:
Lloh459:
	adrp	x8, ___stderrp@GOTPAGE
Lloh460:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh461:
	ldr	x0, [x8]
Lloh462:
	adrp	x8, l_.str.40@PAGE
Lloh463:
	add	x8, x8, l_.str.40@PAGEOFF
	mov	w9, #115                        ; =0x73
	stp	x9, x8, [sp]
Lloh464:
	adrp	x1, l_.str.6@PAGE
Lloh465:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB26_16:
Lloh466:
	adrp	x8, ___stderrp@GOTPAGE
Lloh467:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh468:
	ldr	x0, [x8]
Lloh469:
	adrp	x8, l_.str.41@PAGE
Lloh470:
	add	x8, x8, l_.str.41@PAGEOFF
	b	LBB26_18
LBB26_17:
Lloh471:
	adrp	x8, ___stderrp@GOTPAGE
Lloh472:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh473:
	ldr	x0, [x8]
Lloh474:
	adrp	x8, l_.str.42@PAGE
Lloh475:
	add	x8, x8, l_.str.42@PAGEOFF
LBB26_18:
	mov	w9, #117                        ; =0x75
	stp	x9, x8, [sp]
Lloh476:
	adrp	x1, l_.str.6@PAGE
Lloh477:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB26_19:
Lloh478:
	adrp	x8, ___stderrp@GOTPAGE
Lloh479:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh480:
	ldr	x0, [x8]
Lloh481:
	adrp	x8, l_.str.43@PAGE
Lloh482:
	add	x8, x8, l_.str.43@PAGEOFF
	mov	w9, #119                        ; =0x77
	stp	x9, x8, [sp]
Lloh483:
	adrp	x1, l_.str.6@PAGE
Lloh484:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB26_20:
Lloh485:
	adrp	x8, ___stderrp@GOTPAGE
Lloh486:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh487:
	ldr	x0, [x8]
Lloh488:
	adrp	x8, l_.str.44@PAGE
Lloh489:
	add	x8, x8, l_.str.44@PAGEOFF
	mov	w9, #120                        ; =0x78
	stp	x9, x8, [sp]
Lloh490:
	adrp	x1, l_.str.6@PAGE
Lloh491:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh450, Lloh451
	.loh AdrpAdd	Lloh448, Lloh449
	.loh AdrpLdrGotLdr	Lloh445, Lloh446, Lloh447
	.loh AdrpAdd	Lloh457, Lloh458
	.loh AdrpAdd	Lloh455, Lloh456
	.loh AdrpLdrGotLdr	Lloh452, Lloh453, Lloh454
	.loh AdrpAdd	Lloh464, Lloh465
	.loh AdrpAdd	Lloh462, Lloh463
	.loh AdrpLdrGotLdr	Lloh459, Lloh460, Lloh461
	.loh AdrpAdd	Lloh469, Lloh470
	.loh AdrpLdrGotLdr	Lloh466, Lloh467, Lloh468
	.loh AdrpAdd	Lloh474, Lloh475
	.loh AdrpLdrGotLdr	Lloh471, Lloh472, Lloh473
	.loh AdrpAdd	Lloh476, Lloh477
	.loh AdrpAdd	Lloh483, Lloh484
	.loh AdrpAdd	Lloh481, Lloh482
	.loh AdrpLdrGotLdr	Lloh478, Lloh479, Lloh480
	.loh AdrpAdd	Lloh490, Lloh491
	.loh AdrpAdd	Lloh488, Lloh489
	.loh AdrpLdrGotLdr	Lloh485, Lloh486, Lloh487
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.1
_main.cold.1:                           ; @main.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh492:
	adrp	x8, l_.str.7@PAGE
Lloh493:
	add	x8, x8, l_.str.7@PAGEOFF
	mov	w9, #396                        ; =0x18c
	stp	x9, x8, [sp]
Lloh494:
	adrp	x1, l_.str.6@PAGE
Lloh495:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh494, Lloh495
	.loh AdrpAdd	Lloh492, Lloh493
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.2
_main.cold.2:                           ; @main.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh496:
	adrp	x8, ___stderrp@GOTPAGE
Lloh497:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh498:
	ldr	x0, [x8]
Lloh499:
	adrp	x8, l_.str.15@PAGE
Lloh500:
	add	x8, x8, l_.str.15@PAGEOFF
	mov	w9, #292                        ; =0x124
	stp	x9, x8, [sp]
Lloh501:
	adrp	x1, l_.str.6@PAGE
Lloh502:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh501, Lloh502
	.loh AdrpAdd	Lloh499, Lloh500
	.loh AdrpLdrGotLdr	Lloh496, Lloh497, Lloh498
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.3
_main.cold.3:                           ; @main.cold.3
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh503:
	adrp	x8, ___stderrp@GOTPAGE
Lloh504:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh505:
	ldr	x0, [x8]
Lloh506:
	adrp	x8, l_.str.16@PAGE
Lloh507:
	add	x8, x8, l_.str.16@PAGEOFF
	mov	w9, #297                        ; =0x129
	stp	x9, x8, [sp]
Lloh508:
	adrp	x1, l_.str.6@PAGE
Lloh509:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh508, Lloh509
	.loh AdrpAdd	Lloh506, Lloh507
	.loh AdrpLdrGotLdr	Lloh503, Lloh504, Lloh505
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.4
_main.cold.4:                           ; @main.cold.4
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh510:
	adrp	x8, ___stderrp@GOTPAGE
Lloh511:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh512:
	ldr	x0, [x8]
Lloh513:
	adrp	x8, l_.str.80@PAGE
Lloh514:
	add	x8, x8, l_.str.80@PAGEOFF
	mov	w9, #246                        ; =0xf6
	stp	x9, x8, [sp]
Lloh515:
	adrp	x1, l_.str.6@PAGE
Lloh516:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh515, Lloh516
	.loh AdrpAdd	Lloh513, Lloh514
	.loh AdrpLdrGotLdr	Lloh510, Lloh511, Lloh512
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.5
_main.cold.5:                           ; @main.cold.5
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh517:
	adrp	x8, ___stderrp@GOTPAGE
Lloh518:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh519:
	ldr	x0, [x8]
Lloh520:
	adrp	x8, l_.str.80@PAGE
Lloh521:
	add	x8, x8, l_.str.80@PAGEOFF
	mov	w9, #246                        ; =0xf6
	stp	x9, x8, [sp]
Lloh522:
	adrp	x1, l_.str.6@PAGE
Lloh523:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh522, Lloh523
	.loh AdrpAdd	Lloh520, Lloh521
	.loh AdrpLdrGotLdr	Lloh517, Lloh518, Lloh519
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.6
_main.cold.6:                           ; @main.cold.6
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh524:
	adrp	x8, ___stderrp@GOTPAGE
Lloh525:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh526:
	ldr	x0, [x8]
Lloh527:
	adrp	x8, l_.str.100@PAGE
Lloh528:
	add	x8, x8, l_.str.100@PAGEOFF
	mov	w9, #332                        ; =0x14c
	stp	x9, x8, [sp]
Lloh529:
	adrp	x1, l_.str.6@PAGE
Lloh530:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh529, Lloh530
	.loh AdrpAdd	Lloh527, Lloh528
	.loh AdrpLdrGotLdr	Lloh524, Lloh525, Lloh526
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.7
_main.cold.7:                           ; @main.cold.7
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh531:
	adrp	x8, ___stderrp@GOTPAGE
Lloh532:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh533:
	ldr	x0, [x8]
Lloh534:
	adrp	x8, l_.str.104@PAGE
Lloh535:
	add	x8, x8, l_.str.104@PAGEOFF
	mov	w9, #345                        ; =0x159
	stp	x9, x8, [sp]
Lloh536:
	adrp	x1, l_.str.6@PAGE
Lloh537:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh536, Lloh537
	.loh AdrpAdd	Lloh534, Lloh535
	.loh AdrpLdrGotLdr	Lloh531, Lloh532, Lloh533
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.8
_main.cold.8:                           ; @main.cold.8
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh538:
	adrp	x8, ___stderrp@GOTPAGE
Lloh539:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh540:
	ldr	x0, [x8]
Lloh541:
	adrp	x8, l_.str.103@PAGE
Lloh542:
	add	x8, x8, l_.str.103@PAGEOFF
	mov	w9, #342                        ; =0x156
	stp	x9, x8, [sp]
Lloh543:
	adrp	x1, l_.str.6@PAGE
Lloh544:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh543, Lloh544
	.loh AdrpAdd	Lloh541, Lloh542
	.loh AdrpLdrGotLdr	Lloh538, Lloh539, Lloh540
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.9
_main.cold.9:                           ; @main.cold.9
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh545:
	adrp	x8, ___stderrp@GOTPAGE
Lloh546:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh547:
	ldr	x0, [x8]
Lloh548:
	adrp	x8, l_.str.102@PAGE
Lloh549:
	add	x8, x8, l_.str.102@PAGEOFF
	mov	w9, #341                        ; =0x155
	stp	x9, x8, [sp]
Lloh550:
	adrp	x1, l_.str.6@PAGE
Lloh551:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh550, Lloh551
	.loh AdrpAdd	Lloh548, Lloh549
	.loh AdrpLdrGotLdr	Lloh545, Lloh546, Lloh547
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.10
_main.cold.10:                          ; @main.cold.10
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh552:
	adrp	x8, ___stderrp@GOTPAGE
Lloh553:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh554:
	ldr	x0, [x8]
Lloh555:
	adrp	x8, l_.str.13@PAGE
Lloh556:
	add	x8, x8, l_.str.13@PAGEOFF
	mov	w9, #403                        ; =0x193
	stp	x9, x8, [sp]
Lloh557:
	adrp	x1, l_.str.6@PAGE
Lloh558:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh557, Lloh558
	.loh AdrpAdd	Lloh555, Lloh556
	.loh AdrpLdrGotLdr	Lloh552, Lloh553, Lloh554
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.11
_main.cold.11:                          ; @main.cold.11
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh559:
	adrp	x8, ___stderrp@GOTPAGE
Lloh560:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh561:
	ldr	x0, [x8]
Lloh562:
	adrp	x8, l_.str.12@PAGE
Lloh563:
	add	x8, x8, l_.str.12@PAGEOFF
	mov	w9, #401                        ; =0x191
	stp	x9, x8, [sp]
Lloh564:
	adrp	x1, l_.str.6@PAGE
Lloh565:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh564, Lloh565
	.loh AdrpAdd	Lloh562, Lloh563
	.loh AdrpLdrGotLdr	Lloh559, Lloh560, Lloh561
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.12
_main.cold.12:                          ; @main.cold.12
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh566:
	adrp	x8, ___stderrp@GOTPAGE
Lloh567:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh568:
	ldr	x0, [x8]
Lloh569:
	adrp	x8, l_.str.18@PAGE
Lloh570:
	add	x8, x8, l_.str.18@PAGEOFF
	mov	w9, #301                        ; =0x12d
	stp	x9, x8, [sp]
Lloh571:
	adrp	x1, l_.str.6@PAGE
Lloh572:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh571, Lloh572
	.loh AdrpAdd	Lloh569, Lloh570
	.loh AdrpLdrGotLdr	Lloh566, Lloh567, Lloh568
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.13
_main.cold.13:                          ; @main.cold.13
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh573:
	adrp	x8, ___stderrp@GOTPAGE
Lloh574:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh575:
	ldr	x0, [x8]
Lloh576:
	adrp	x8, l_.str.17@PAGE
Lloh577:
	add	x8, x8, l_.str.17@PAGEOFF
	mov	w9, #301                        ; =0x12d
	stp	x9, x8, [sp]
Lloh578:
	adrp	x1, l_.str.6@PAGE
Lloh579:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh578, Lloh579
	.loh AdrpAdd	Lloh576, Lloh577
	.loh AdrpLdrGotLdr	Lloh573, Lloh574, Lloh575
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.14
_main.cold.14:                          ; @main.cold.14
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh580:
	adrp	x8, ___stderrp@GOTPAGE
Lloh581:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh582:
	ldr	x0, [x8]
Lloh583:
	adrp	x8, l_.str.14@PAGE
Lloh584:
	add	x8, x8, l_.str.14@PAGEOFF
	mov	w9, #291                        ; =0x123
	stp	x9, x8, [sp]
Lloh585:
	adrp	x1, l_.str.6@PAGE
Lloh586:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh585, Lloh586
	.loh AdrpAdd	Lloh583, Lloh584
	.loh AdrpLdrGotLdr	Lloh580, Lloh581, Lloh582
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function verify_pair.cold.1
_verify_pair.cold.1:                    ; @verify_pair.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh587:
	adrp	x8, ___stderrp@GOTPAGE
Lloh588:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh589:
	ldr	x0, [x8]
Lloh590:
	adrp	x8, l_.str.20@PAGE
Lloh591:
	add	x8, x8, l_.str.20@PAGEOFF
	mov	w9, #278                        ; =0x116
	stp	x9, x8, [sp]
Lloh592:
	adrp	x1, l_.str.6@PAGE
Lloh593:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh592, Lloh593
	.loh AdrpAdd	Lloh590, Lloh591
	.loh AdrpLdrGotLdr	Lloh587, Lloh588, Lloh589
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function verify_pair.cold.2
_verify_pair.cold.2:                    ; @verify_pair.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	x19, x4
	mov	x20, x3
	mov	x21, x2
	mov	x22, x1
	ldr	x0, [x0]
	bl	_BN_bn2hex
	mov	x23, x0
	ldr	x0, [x22]
	bl	_BN_bn2hex
	mov	x22, x0
	mov	x0, x21
	bl	_BN_bn2hex
	mov	x21, x0
	mov	x0, x20
	bl	_BN_bn2hex
Lloh594:
	adrp	x8, ___stderrp@GOTPAGE
Lloh595:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh596:
	ldr	x8, [x8]
	ldr	x9, [x19]
	stp	x21, x0, [sp, #24]
	stp	x23, x22, [sp, #8]
	str	x9, [sp]
Lloh597:
	adrp	x1, l_.str.22@PAGE
Lloh598:
	add	x1, x1, l_.str.22@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh597, Lloh598
	.loh AdrpLdrGotLdr	Lloh594, Lloh595, Lloh596
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function verify_pair.cold.3
_verify_pair.cold.3:                    ; @verify_pair.cold.3
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh599:
	adrp	x8, ___stderrp@GOTPAGE
Lloh600:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh601:
	ldr	x0, [x8]
Lloh602:
	adrp	x8, l_.str.21@PAGE
Lloh603:
	add	x8, x8, l_.str.21@PAGEOFF
	mov	w9, #279                        ; =0x117
	stp	x9, x8, [sp]
Lloh604:
	adrp	x1, l_.str.6@PAGE
Lloh605:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh604, Lloh605
	.loh AdrpAdd	Lloh602, Lloh603
	.loh AdrpLdrGotLdr	Lloh599, Lloh600, Lloh601
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.1
_make_pair.cold.1:                      ; @make_pair.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh606:
	adrp	x8, ___stderrp@GOTPAGE
Lloh607:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh608:
	ldr	x0, [x8]
Lloh609:
	adrp	x8, l_.str.97@PAGE
Lloh610:
	add	x8, x8, l_.str.97@PAGEOFF
	mov	w9, #267                        ; =0x10b
	stp	x9, x8, [sp]
Lloh611:
	adrp	x1, l_.str.6@PAGE
Lloh612:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh611, Lloh612
	.loh AdrpAdd	Lloh609, Lloh610
	.loh AdrpLdrGotLdr	Lloh606, Lloh607, Lloh608
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.2
_make_pair.cold.2:                      ; @make_pair.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh613:
	adrp	x8, ___stderrp@GOTPAGE
Lloh614:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh615:
	ldr	x0, [x8]
Lloh616:
	adrp	x8, l_.str.96@PAGE
Lloh617:
	add	x8, x8, l_.str.96@PAGEOFF
	mov	w9, #267                        ; =0x10b
	stp	x9, x8, [sp]
Lloh618:
	adrp	x1, l_.str.6@PAGE
Lloh619:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh618, Lloh619
	.loh AdrpAdd	Lloh616, Lloh617
	.loh AdrpLdrGotLdr	Lloh613, Lloh614, Lloh615
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.3
_make_pair.cold.3:                      ; @make_pair.cold.3
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh620:
	adrp	x8, ___stderrp@GOTPAGE
Lloh621:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh622:
	ldr	x0, [x8]
Lloh623:
	adrp	x8, l_.str.86@PAGE
Lloh624:
	add	x8, x8, l_.str.86@PAGEOFF
	mov	w9, #266                        ; =0x10a
	stp	x9, x8, [sp]
Lloh625:
	adrp	x1, l_.str.6@PAGE
Lloh626:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh625, Lloh626
	.loh AdrpAdd	Lloh623, Lloh624
	.loh AdrpLdrGotLdr	Lloh620, Lloh621, Lloh622
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.4
_make_pair.cold.4:                      ; @make_pair.cold.4
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh627:
	adrp	x8, ___stderrp@GOTPAGE
Lloh628:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh629:
	ldr	x0, [x8]
Lloh630:
	adrp	x8, l_.str.90@PAGE
Lloh631:
	add	x8, x8, l_.str.90@PAGEOFF
	mov	w9, #266                        ; =0x10a
	stp	x9, x8, [sp]
Lloh632:
	adrp	x1, l_.str.6@PAGE
Lloh633:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh632, Lloh633
	.loh AdrpAdd	Lloh630, Lloh631
	.loh AdrpLdrGotLdr	Lloh627, Lloh628, Lloh629
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.5
_make_pair.cold.5:                      ; @make_pair.cold.5
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh634:
	adrp	x8, ___stderrp@GOTPAGE
Lloh635:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh636:
	ldr	x0, [x8]
Lloh637:
	adrp	x8, l_.str.85@PAGE
Lloh638:
	add	x8, x8, l_.str.85@PAGEOFF
	mov	w9, #264                        ; =0x108
	stp	x9, x8, [sp]
Lloh639:
	adrp	x1, l_.str.6@PAGE
Lloh640:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh639, Lloh640
	.loh AdrpAdd	Lloh637, Lloh638
	.loh AdrpLdrGotLdr	Lloh634, Lloh635, Lloh636
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.6
_make_pair.cold.6:                      ; @make_pair.cold.6
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh641:
	adrp	x8, ___stderrp@GOTPAGE
Lloh642:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh643:
	ldr	x0, [x8]
Lloh644:
	adrp	x8, l_.str.95@PAGE
Lloh645:
	add	x8, x8, l_.str.95@PAGEOFF
	mov	w9, #263                        ; =0x107
	stp	x9, x8, [sp]
Lloh646:
	adrp	x1, l_.str.6@PAGE
Lloh647:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh646, Lloh647
	.loh AdrpAdd	Lloh644, Lloh645
	.loh AdrpLdrGotLdr	Lloh641, Lloh642, Lloh643
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.7
_make_pair.cold.7:                      ; @make_pair.cold.7
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh648:
	adrp	x8, ___stderrp@GOTPAGE
Lloh649:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh650:
	ldr	x0, [x8]
Lloh651:
	adrp	x8, l_.str.94@PAGE
Lloh652:
	add	x8, x8, l_.str.94@PAGEOFF
	mov	w9, #262                        ; =0x106
	stp	x9, x8, [sp]
Lloh653:
	adrp	x1, l_.str.6@PAGE
Lloh654:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh653, Lloh654
	.loh AdrpAdd	Lloh651, Lloh652
	.loh AdrpLdrGotLdr	Lloh648, Lloh649, Lloh650
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.8
_make_pair.cold.8:                      ; @make_pair.cold.8
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh655:
	adrp	x8, ___stderrp@GOTPAGE
Lloh656:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh657:
	ldr	x0, [x8]
Lloh658:
	adrp	x8, l_.str.93@PAGE
Lloh659:
	add	x8, x8, l_.str.93@PAGEOFF
	mov	w9, #261                        ; =0x105
	stp	x9, x8, [sp]
Lloh660:
	adrp	x1, l_.str.6@PAGE
Lloh661:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh660, Lloh661
	.loh AdrpAdd	Lloh658, Lloh659
	.loh AdrpLdrGotLdr	Lloh655, Lloh656, Lloh657
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.9
_make_pair.cold.9:                      ; @make_pair.cold.9
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh662:
	adrp	x8, ___stderrp@GOTPAGE
Lloh663:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh664:
	ldr	x0, [x8]
Lloh665:
	adrp	x8, l_.str.82@PAGE
Lloh666:
	add	x8, x8, l_.str.82@PAGEOFF
	mov	w9, #260                        ; =0x104
	stp	x9, x8, [sp]
Lloh667:
	adrp	x1, l_.str.6@PAGE
Lloh668:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh667, Lloh668
	.loh AdrpAdd	Lloh665, Lloh666
	.loh AdrpLdrGotLdr	Lloh662, Lloh663, Lloh664
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.10
_make_pair.cold.10:                     ; @make_pair.cold.10
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh669:
	adrp	x8, ___stderrp@GOTPAGE
Lloh670:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh671:
	ldr	x0, [x8]
Lloh672:
	adrp	x8, l_.str.92@PAGE
Lloh673:
	add	x8, x8, l_.str.92@PAGEOFF
	mov	w9, #260                        ; =0x104
	stp	x9, x8, [sp]
Lloh674:
	adrp	x1, l_.str.6@PAGE
Lloh675:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh674, Lloh675
	.loh AdrpAdd	Lloh672, Lloh673
	.loh AdrpLdrGotLdr	Lloh669, Lloh670, Lloh671
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.11
_make_pair.cold.11:                     ; @make_pair.cold.11
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh676:
	adrp	x8, ___stderrp@GOTPAGE
Lloh677:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh678:
	ldr	x0, [x8]
Lloh679:
	adrp	x8, l_.str.91@PAGE
Lloh680:
	add	x8, x8, l_.str.91@PAGEOFF
	mov	w9, #259                        ; =0x103
	stp	x9, x8, [sp]
Lloh681:
	adrp	x1, l_.str.6@PAGE
Lloh682:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh681, Lloh682
	.loh AdrpAdd	Lloh679, Lloh680
	.loh AdrpLdrGotLdr	Lloh676, Lloh677, Lloh678
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.12
_make_pair.cold.12:                     ; @make_pair.cold.12
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh683:
	adrp	x8, ___stderrp@GOTPAGE
Lloh684:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh685:
	ldr	x0, [x8]
Lloh686:
	adrp	x8, l_.str.90@PAGE
Lloh687:
	add	x8, x8, l_.str.90@PAGEOFF
	mov	w9, #259                        ; =0x103
	stp	x9, x8, [sp]
Lloh688:
	adrp	x1, l_.str.6@PAGE
Lloh689:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh688, Lloh689
	.loh AdrpAdd	Lloh686, Lloh687
	.loh AdrpLdrGotLdr	Lloh683, Lloh684, Lloh685
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.13
_make_pair.cold.13:                     ; @make_pair.cold.13
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh690:
	adrp	x8, ___stderrp@GOTPAGE
Lloh691:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh692:
	ldr	x0, [x8]
Lloh693:
	adrp	x8, l_.str.89@PAGE
Lloh694:
	add	x8, x8, l_.str.89@PAGEOFF
	mov	w9, #257                        ; =0x101
	stp	x9, x8, [sp]
Lloh695:
	adrp	x1, l_.str.6@PAGE
Lloh696:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh695, Lloh696
	.loh AdrpAdd	Lloh693, Lloh694
	.loh AdrpLdrGotLdr	Lloh690, Lloh691, Lloh692
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.14
_make_pair.cold.14:                     ; @make_pair.cold.14
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh697:
	adrp	x8, ___stderrp@GOTPAGE
Lloh698:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh699:
	ldr	x0, [x8]
Lloh700:
	adrp	x8, l_.str.88@PAGE
Lloh701:
	add	x8, x8, l_.str.88@PAGEOFF
	mov	w9, #256                        ; =0x100
	stp	x9, x8, [sp]
Lloh702:
	adrp	x1, l_.str.6@PAGE
Lloh703:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh702, Lloh703
	.loh AdrpAdd	Lloh700, Lloh701
	.loh AdrpLdrGotLdr	Lloh697, Lloh698, Lloh699
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.15
_make_pair.cold.15:                     ; @make_pair.cold.15
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh704:
	adrp	x8, ___stderrp@GOTPAGE
Lloh705:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh706:
	ldr	x0, [x8]
Lloh707:
	adrp	x8, l_.str.87@PAGE
Lloh708:
	add	x8, x8, l_.str.87@PAGEOFF
	mov	w9, #255                        ; =0xff
	stp	x9, x8, [sp]
Lloh709:
	adrp	x1, l_.str.6@PAGE
Lloh710:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh709, Lloh710
	.loh AdrpAdd	Lloh707, Lloh708
	.loh AdrpLdrGotLdr	Lloh704, Lloh705, Lloh706
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.16
_make_pair.cold.16:                     ; @make_pair.cold.16
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh711:
	adrp	x8, ___stderrp@GOTPAGE
Lloh712:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh713:
	ldr	x0, [x8]
Lloh714:
	adrp	x8, l_.str.86@PAGE
Lloh715:
	add	x8, x8, l_.str.86@PAGEOFF
	mov	w9, #255                        ; =0xff
	stp	x9, x8, [sp]
Lloh716:
	adrp	x1, l_.str.6@PAGE
Lloh717:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh716, Lloh717
	.loh AdrpAdd	Lloh714, Lloh715
	.loh AdrpLdrGotLdr	Lloh711, Lloh712, Lloh713
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.17
_make_pair.cold.17:                     ; @make_pair.cold.17
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh718:
	adrp	x8, ___stderrp@GOTPAGE
Lloh719:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh720:
	ldr	x0, [x8]
Lloh721:
	adrp	x8, l_.str.85@PAGE
Lloh722:
	add	x8, x8, l_.str.85@PAGEOFF
	mov	w9, #254                        ; =0xfe
	stp	x9, x8, [sp]
Lloh723:
	adrp	x1, l_.str.6@PAGE
Lloh724:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh723, Lloh724
	.loh AdrpAdd	Lloh721, Lloh722
	.loh AdrpLdrGotLdr	Lloh718, Lloh719, Lloh720
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.18
_make_pair.cold.18:                     ; @make_pair.cold.18
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh725:
	adrp	x8, ___stderrp@GOTPAGE
Lloh726:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh727:
	ldr	x0, [x8]
Lloh728:
	adrp	x8, l_.str.84@PAGE
Lloh729:
	add	x8, x8, l_.str.84@PAGEOFF
	mov	w9, #254                        ; =0xfe
	stp	x9, x8, [sp]
Lloh730:
	adrp	x1, l_.str.6@PAGE
Lloh731:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh730, Lloh731
	.loh AdrpAdd	Lloh728, Lloh729
	.loh AdrpLdrGotLdr	Lloh725, Lloh726, Lloh727
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.19
_make_pair.cold.19:                     ; @make_pair.cold.19
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh732:
	adrp	x8, ___stderrp@GOTPAGE
Lloh733:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh734:
	ldr	x0, [x8]
Lloh735:
	adrp	x8, l_.str.82@PAGE
Lloh736:
	add	x8, x8, l_.str.82@PAGEOFF
	mov	w9, #252                        ; =0xfc
	stp	x9, x8, [sp]
Lloh737:
	adrp	x1, l_.str.6@PAGE
Lloh738:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh737, Lloh738
	.loh AdrpAdd	Lloh735, Lloh736
	.loh AdrpLdrGotLdr	Lloh732, Lloh733, Lloh734
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.20
_make_pair.cold.20:                     ; @make_pair.cold.20
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh739:
	adrp	x8, ___stderrp@GOTPAGE
Lloh740:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh741:
	ldr	x0, [x8]
Lloh742:
	adrp	x8, l_.str.83@PAGE
Lloh743:
	add	x8, x8, l_.str.83@PAGEOFF
	mov	w9, #251                        ; =0xfb
	stp	x9, x8, [sp]
Lloh744:
	adrp	x1, l_.str.6@PAGE
Lloh745:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh744, Lloh745
	.loh AdrpAdd	Lloh742, Lloh743
	.loh AdrpLdrGotLdr	Lloh739, Lloh740, Lloh741
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.21
_make_pair.cold.21:                     ; @make_pair.cold.21
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh746:
	adrp	x8, ___stderrp@GOTPAGE
Lloh747:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh748:
	ldr	x0, [x8]
Lloh749:
	adrp	x8, l_.str.82@PAGE
Lloh750:
	add	x8, x8, l_.str.82@PAGEOFF
	mov	w9, #250                        ; =0xfa
	stp	x9, x8, [sp]
Lloh751:
	adrp	x1, l_.str.6@PAGE
Lloh752:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh751, Lloh752
	.loh AdrpAdd	Lloh749, Lloh750
	.loh AdrpLdrGotLdr	Lloh746, Lloh747, Lloh748
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.22
_make_pair.cold.22:                     ; @make_pair.cold.22
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh753:
	adrp	x8, ___stderrp@GOTPAGE
Lloh754:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh755:
	ldr	x0, [x8]
Lloh756:
	adrp	x8, l_.str.81@PAGE
Lloh757:
	add	x8, x8, l_.str.81@PAGEOFF
	mov	w9, #250                        ; =0xfa
	stp	x9, x8, [sp]
Lloh758:
	adrp	x1, l_.str.6@PAGE
Lloh759:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh758, Lloh759
	.loh AdrpAdd	Lloh756, Lloh757
	.loh AdrpLdrGotLdr	Lloh753, Lloh754, Lloh755
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function make_pair.cold.23
_make_pair.cold.23:                     ; @make_pair.cold.23
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh760:
	adrp	x8, ___stderrp@GOTPAGE
Lloh761:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh762:
	ldr	x0, [x8]
Lloh763:
	adrp	x8, l_.str.80@PAGE
Lloh764:
	add	x8, x8, l_.str.80@PAGEOFF
	mov	w9, #246                        ; =0xf6
	stp	x9, x8, [sp]
Lloh765:
	adrp	x1, l_.str.6@PAGE
Lloh766:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh765, Lloh766
	.loh AdrpAdd	Lloh763, Lloh764
	.loh AdrpLdrGotLdr	Lloh760, Lloh761, Lloh762
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add_selected.cold.1
_shift_add_selected.cold.1:             ; @shift_add_selected.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh767:
	adrp	x8, ___stderrp@GOTPAGE
Lloh768:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh769:
	ldr	x0, [x8]
Lloh770:
	adrp	x8, l_.str.49@PAGE
Lloh771:
	add	x8, x8, l_.str.49@PAGEOFF
	mov	w9, #141                        ; =0x8d
	stp	x9, x8, [sp]
Lloh772:
	adrp	x1, l_.str.6@PAGE
Lloh773:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh772, Lloh773
	.loh AdrpAdd	Lloh770, Lloh771
	.loh AdrpLdrGotLdr	Lloh767, Lloh768, Lloh769
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add_selected.cold.2
_shift_add_selected.cold.2:             ; @shift_add_selected.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh774:
	adrp	x8, ___stderrp@GOTPAGE
Lloh775:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh776:
	ldr	x0, [x8]
Lloh777:
	adrp	x8, l_.str.48@PAGE
Lloh778:
	add	x8, x8, l_.str.48@PAGEOFF
	mov	w9, #141                        ; =0x8d
	stp	x9, x8, [sp]
Lloh779:
	adrp	x1, l_.str.6@PAGE
Lloh780:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh779, Lloh780
	.loh AdrpAdd	Lloh777, Lloh778
	.loh AdrpLdrGotLdr	Lloh774, Lloh775, Lloh776
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add_selected.cold.3
_shift_add_selected.cold.3:             ; @shift_add_selected.cold.3
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh781:
	adrp	x8, ___stderrp@GOTPAGE
Lloh782:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh783:
	ldr	x0, [x8]
Lloh784:
	adrp	x8, l_.str.47@PAGE
Lloh785:
	add	x8, x8, l_.str.47@PAGEOFF
	mov	w9, #138                        ; =0x8a
	stp	x9, x8, [sp]
Lloh786:
	adrp	x1, l_.str.6@PAGE
Lloh787:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh786, Lloh787
	.loh AdrpAdd	Lloh784, Lloh785
	.loh AdrpLdrGotLdr	Lloh781, Lloh782, Lloh783
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add_selected.cold.4
_shift_add_selected.cold.4:             ; @shift_add_selected.cold.4
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh788:
	adrp	x8, ___stderrp@GOTPAGE
Lloh789:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh790:
	ldr	x0, [x8]
Lloh791:
	adrp	x8, l_.str.45@PAGE
Lloh792:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh793:
	adrp	x1, l_.str.6@PAGE
Lloh794:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh793, Lloh794
	.loh AdrpAdd	Lloh791, Lloh792
	.loh AdrpLdrGotLdr	Lloh788, Lloh789, Lloh790
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function low_bits.cold.1
_low_bits.cold.1:                       ; @low_bits.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh795:
	adrp	x8, ___stderrp@GOTPAGE
Lloh796:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh797:
	ldr	x0, [x8]
Lloh798:
	adrp	x8, l_.str.60@PAGE
Lloh799:
	add	x8, x8, l_.str.60@PAGEOFF
	mov	w9, #48                         ; =0x30
	stp	x9, x8, [sp]
Lloh800:
	adrp	x1, l_.str.6@PAGE
Lloh801:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh800, Lloh801
	.loh AdrpAdd	Lloh798, Lloh799
	.loh AdrpLdrGotLdr	Lloh795, Lloh796, Lloh797
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function low_bits.cold.2
_low_bits.cold.2:                       ; @low_bits.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh802:
	adrp	x8, ___stderrp@GOTPAGE
Lloh803:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh804:
	ldr	x0, [x8]
Lloh805:
	adrp	x8, l_.str.59@PAGE
Lloh806:
	add	x8, x8, l_.str.59@PAGEOFF
	mov	w9, #47                         ; =0x2f
	stp	x9, x8, [sp]
Lloh807:
	adrp	x1, l_.str.6@PAGE
Lloh808:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh807, Lloh808
	.loh AdrpAdd	Lloh805, Lloh806
	.loh AdrpLdrGotLdr	Lloh802, Lloh803, Lloh804
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_identity.cold.1
_near_identity.cold.1:                  ; @near_identity.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh809:
	adrp	x8, ___stderrp@GOTPAGE
Lloh810:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh811:
	ldr	x0, [x8]
Lloh812:
	adrp	x8, l_.str.78@PAGE
Lloh813:
	add	x8, x8, l_.str.78@PAGEOFF
	mov	w9, #205                        ; =0xcd
	stp	x9, x8, [sp]
Lloh814:
	adrp	x1, l_.str.6@PAGE
Lloh815:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh814, Lloh815
	.loh AdrpAdd	Lloh812, Lloh813
	.loh AdrpLdrGotLdr	Lloh809, Lloh810, Lloh811
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_identity.cold.2
_near_identity.cold.2:                  ; @near_identity.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh816:
	adrp	x8, ___stderrp@GOTPAGE
Lloh817:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh818:
	ldr	x0, [x8]
Lloh819:
	adrp	x8, l_.str.77@PAGE
Lloh820:
	add	x8, x8, l_.str.77@PAGEOFF
	mov	w9, #205                        ; =0xcd
	stp	x9, x8, [sp]
Lloh821:
	adrp	x1, l_.str.6@PAGE
Lloh822:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh821, Lloh822
	.loh AdrpAdd	Lloh819, Lloh820
	.loh AdrpLdrGotLdr	Lloh816, Lloh817, Lloh818
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_identity.cold.3
_near_identity.cold.3:                  ; @near_identity.cold.3
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh823:
	adrp	x8, ___stderrp@GOTPAGE
Lloh824:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh825:
	ldr	x0, [x8]
Lloh826:
	adrp	x8, l_.str.79@PAGE
Lloh827:
	add	x8, x8, l_.str.79@PAGEOFF
	mov	w9, #209                        ; =0xd1
	stp	x9, x8, [sp]
Lloh828:
	adrp	x1, l_.str.6@PAGE
Lloh829:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh828, Lloh829
	.loh AdrpAdd	Lloh826, Lloh827
	.loh AdrpLdrGotLdr	Lloh823, Lloh824, Lloh825
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_identity.cold.4
_near_identity.cold.4:                  ; @near_identity.cold.4
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh830:
	adrp	x8, ___stderrp@GOTPAGE
Lloh831:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh832:
	ldr	x0, [x8]
Lloh833:
	adrp	x8, l_.str.76@PAGE
Lloh834:
	add	x8, x8, l_.str.76@PAGEOFF
	mov	w9, #203                        ; =0xcb
	stp	x9, x8, [sp]
Lloh835:
	adrp	x1, l_.str.6@PAGE
Lloh836:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh835, Lloh836
	.loh AdrpAdd	Lloh833, Lloh834
	.loh AdrpLdrGotLdr	Lloh830, Lloh831, Lloh832
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_identity.cold.5
_near_identity.cold.5:                  ; @near_identity.cold.5
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh837:
	adrp	x8, ___stderrp@GOTPAGE
Lloh838:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh839:
	ldr	x0, [x8]
Lloh840:
	adrp	x8, l_.str.45@PAGE
Lloh841:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh842:
	adrp	x1, l_.str.6@PAGE
Lloh843:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh842, Lloh843
	.loh AdrpAdd	Lloh840, Lloh841
	.loh AdrpLdrGotLdr	Lloh837, Lloh838, Lloh839
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function near_identity.cold.6
_near_identity.cold.6:                  ; @near_identity.cold.6
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh844:
	adrp	x8, ___stderrp@GOTPAGE
Lloh845:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh846:
	ldr	x0, [x8]
Lloh847:
	adrp	x8, l_.str.45@PAGE
Lloh848:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #44                         ; =0x2c
	stp	x9, x8, [sp]
Lloh849:
	adrp	x1, l_.str.6@PAGE
Lloh850:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh849, Lloh850
	.loh AdrpAdd	Lloh847, Lloh848
	.loh AdrpLdrGotLdr	Lloh844, Lloh845, Lloh846
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function random_bits.cold.1
_random_bits.cold.1:                    ; @random_bits.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh851:
	adrp	x8, ___stderrp@GOTPAGE
Lloh852:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh853:
	ldr	x0, [x8]
Lloh854:
	adrp	x8, l_.str.99@PAGE
Lloh855:
	add	x8, x8, l_.str.99@PAGEOFF
	mov	w9, #243                        ; =0xf3
	stp	x9, x8, [sp]
Lloh856:
	adrp	x1, l_.str.6@PAGE
Lloh857:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh856, Lloh857
	.loh AdrpAdd	Lloh854, Lloh855
	.loh AdrpLdrGotLdr	Lloh851, Lloh852, Lloh853
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function random_bits.cold.2
_random_bits.cold.2:                    ; @random_bits.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh858:
	adrp	x8, ___stderrp@GOTPAGE
Lloh859:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh860:
	ldr	x0, [x8]
Lloh861:
	adrp	x8, l_.str.98@PAGE
Lloh862:
	add	x8, x8, l_.str.98@PAGEOFF
	mov	w9, #239                        ; =0xef
	stp	x9, x8, [sp]
Lloh863:
	adrp	x1, l_.str.6@PAGE
Lloh864:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh863, Lloh864
	.loh AdrpAdd	Lloh861, Lloh862
	.loh AdrpLdrGotLdr	Lloh858, Lloh859, Lloh860
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function run_batch.cold.1
_run_batch.cold.1:                      ; @run_batch.cold.1
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh865:
	adrp	x8, ___stderrp@GOTPAGE
Lloh866:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh867:
	ldr	x0, [x8]
Lloh868:
	adrp	x8, l_.str.108@PAGE
Lloh869:
	add	x8, x8, l_.str.108@PAGEOFF
	mov	w9, #33                         ; =0x21
	stp	x9, x8, [sp]
Lloh870:
	adrp	x1, l_.str.6@PAGE
Lloh871:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh870, Lloh871
	.loh AdrpAdd	Lloh868, Lloh869
	.loh AdrpLdrGotLdr	Lloh865, Lloh866, Lloh867
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function run_batch.cold.2
_run_batch.cold.2:                      ; @run_batch.cold.2
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh872:
	adrp	x8, ___stderrp@GOTPAGE
Lloh873:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh874:
	ldr	x0, [x8]
Lloh875:
	adrp	x8, l_.str.108@PAGE
Lloh876:
	add	x8, x8, l_.str.108@PAGEOFF
	mov	w9, #33                         ; =0x21
	stp	x9, x8, [sp]
Lloh877:
	adrp	x1, l_.str.6@PAGE
Lloh878:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh877, Lloh878
	.loh AdrpAdd	Lloh875, Lloh876
	.loh AdrpLdrGotLdr	Lloh872, Lloh873, Lloh874
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"--verify-only"

l_.str.1:                               ; @.str.1
	.asciz	"--max-bits"

l_.str.2:                               ; @.str.2
	.asciz	"--target-ms"

l_.str.3:                               ; @.str.3
	.asciz	"--output"

l_.str.4:                               ; @.str.4
	.asciz	"Usage: %s [--verify-only] [--max-bits 4096|16384] [--target-ms 5] [--output results.csv]\n"

l_.str.5:                               ; @.str.5
	.asciz	"--help"

l_.str.6:                               ; @.str.6
	.asciz	"failure line %d: %s\n"

l_.str.7:                               ; @.str.7
	.asciz	"maxbits>=64 && maxbits<=16384 && target_ms>=1 && target_ms<=100"

l_.str.8:                               ; @.str.8
	.asciz	"%s\ncompiler=%s\nseed=0x8f1bbcde58425531, trials=%d, samples=%d, target_ms=%.3f\n"

l_.str.9:                               ; @.str.9
	.asciz	"Apple LLVM 17.0.0 (clang-1700.0.13.5)"

l_.str.10:                              ; @.str.10
	.asciz	"Prototype uses shared OpenSSL BIGNUM primitives and reusable BN_CTX; API overhead is included. Warm tables/allocations. CPU frequency and core affinity are uncontrolled.\n"

l_.str.11:                              ; @.str.11
	.asciz	"w"

l_.str.12:                              ; @.str.12
	.asciz	"file"

l_.str.13:                              ; @.str.13
	.asciz	"fclose(file)==0"

l_.str.14:                              ; @.str.14
	.asciz	"ctx"

l_.str.15:                              ; @.str.15
	.asciz	"p.x && p.y"

l_.str.16:                              ; @.str.16
	.asciz	"(unsigned)(squares[h]-squares[d]+(((b-a)&1)?a:0)) == x*y"

	.section	__TEXT,__const
	.p2align	2, 0x0                          ; @__const.verify_all.edge
l___const.verify_all.edge:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	3                               ; 0x3
	.long	7                               ; 0x7
	.long	8                               ; 0x8
	.long	15                              ; 0xf
	.long	16                              ; 0x10
	.long	127                             ; 0x7f
	.long	128                             ; 0x80
	.long	255                             ; 0xff
	.long	256                             ; 0x100
	.long	257                             ; 0x101
	.long	65535                           ; 0xffff
	.long	65536                           ; 0x10000

	.section	__TEXT,__cstring,cstring_literals
l_.str.17:                              ; @.str.17
	.asciz	"BN_set_word(p.x,edge[i])"

l_.str.18:                              ; @.str.18
	.asciz	"BN_set_word(p.y,edge[j])"

	.section	__TEXT,__const
	.p2align	2, 0x0                          ; @__const.verify_all.widths
l___const.verify_all.widths:
	.long	31                              ; 0x1f
	.long	32                              ; 0x20
	.long	33                              ; 0x21
	.long	63                              ; 0x3f
	.long	64                              ; 0x40
	.long	65                              ; 0x41
	.long	127                             ; 0x7f
	.long	128                             ; 0x80
	.long	129                             ; 0x81
	.long	256                             ; 0x100
	.long	511                             ; 0x1ff
	.long	1024                            ; 0x400
	.long	4096                            ; 0x1000

	.section	__TEXT,__cstring,cstring_literals
l_.str.19:                              ; @.str.19
	.asciz	"verified 65536 table products and %u BIGNUM pairs across all %zu product algorithms\n"

l_.str.20:                              ; @.str.20
	.asciz	"expected && out"

l_.str.21:                              ; @.str.21
	.asciz	"BN_mul(expected,p->x,p->y,ctx)"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @algorithms
_algorithms:
	.quad	l_.str.23
	.quad	_copy_control
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.quad	l_.str.24
	.quad	_native_mul
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.25
	.quad	_native_equal_aware
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.26
	.quad	_mid_native_square
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.27
	.quad	_shift_add_short
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.28
	.quad	_shift_add_sparse
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.29
	.quad	_direct_karatsuba
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.30
	.quad	_recursive_equal_aware
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.31
	.quad	_mid_recursive
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.32
	.quad	_mid_set_bits
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.33
	.quad	_mid_prefix
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.34
	.quad	_near_native
	.long	1                               ; 0x1
	.long	0                               ; 0x0
	.quad	l_.str.35
	.quad	_near_recursive
	.long	1                               ; 0x1
	.long	0                               ; 0x0

	.section	__TEXT,__cstring,cstring_literals
l_.str.22:                              ; @.str.22
	.asciz	"mismatch %s x=%s y=%s got=%s expected=%s\n"

l_.str.23:                              ; @.str.23
	.asciz	"copy_control"

l_.str.24:                              ; @.str.24
	.asciz	"native_mul"

l_.str.25:                              ; @.str.25
	.asciz	"native_equal_aware"

l_.str.26:                              ; @.str.26
	.asciz	"mid_native_square"

l_.str.27:                              ; @.str.27
	.asciz	"shift_add_short"

l_.str.28:                              ; @.str.28
	.asciz	"shift_add_sparse"

l_.str.29:                              ; @.str.29
	.asciz	"direct_karatsuba"

l_.str.30:                              ; @.str.30
	.asciz	"recursive_equal_aware"

l_.str.31:                              ; @.str.31
	.asciz	"mid_recursive"

l_.str.32:                              ; @.str.32
	.asciz	"mid_set_bits"

l_.str.33:                              ; @.str.33
	.asciz	"mid_prefix"

l_.str.34:                              ; @.str.34
	.asciz	"near_native"

l_.str.35:                              ; @.str.35
	.asciz	"near_recursive"

l_.str.36:                              ; @.str.36
	.asciz	"BN_copy(out,x)"

l_.str.37:                              ; @.str.37
	.asciz	"BN_mul(out, x, y, ctx)"

l_.str.38:                              ; @.str.38
	.asciz	"BN_sqr(out,x,ctx)"

l_.str.39:                              ; @.str.39
	.asciz	"BN_mul(out,x,y,ctx)"

l_.str.40:                              ; @.str.40
	.asciz	"BN_sub(delta, b, a)"

l_.str.41:                              ; @.str.41
	.asciz	"BN_rshift1(d, delta)"

l_.str.42:                              ; @.str.42
	.asciz	"BN_add(h, a, d)"

l_.str.43:                              ; @.str.43
	.asciz	"BN_sub(out, out, dsq)"

l_.str.44:                              ; @.str.44
	.asciz	"BN_add(out, out, a)"

l_.str.45:                              ; @.str.45
	.asciz	"v != NULL"

l_.str.46:                              ; @.str.46
	.asciz	"BN_sqr(out, x, ctx)"

l_.str.47:                              ; @.str.47
	.asciz	"BN_set_word(out, 0)"

l_.str.48:                              ; @.str.48
	.asciz	"BN_lshift(row, value, i)"

l_.str.49:                              ; @.str.49
	.asciz	"BN_add(out, out, row)"

l_.str.50:                              ; @.str.50
	.asciz	"BN_set_word(out, squares[h]-squares[d]+((delta&1) ? a : 0))"

l_.str.51:                              ; @.str.51
	.asciz	"BN_rshift(xh, x, r)"

l_.str.52:                              ; @.str.52
	.asciz	"BN_rshift(yh, y, r)"

l_.str.53:                              ; @.str.53
	.asciz	"BN_add(cross, u, v)"

l_.str.54:                              ; @.str.54
	.asciz	"sign ? BN_add(cross, cross, w) : BN_sub(cross, cross, w)"

l_.str.55:                              ; @.str.55
	.asciz	"BN_lshift(out, u, r+r)"

l_.str.56:                              ; @.str.56
	.asciz	"BN_lshift(cross, cross, r)"

l_.str.57:                              ; @.str.57
	.asciz	"BN_add(out, out, cross)"

l_.str.58:                              ; @.str.58
	.asciz	"BN_add(out, out, v)"

l_.str.59:                              ; @.str.59
	.asciz	"BN_copy(out, x)"

l_.str.60:                              ; @.str.60
	.asciz	"BN_mask_bits(out, n)"

l_.str.61:                              ; @.str.61
	.asciz	"sign >= 0 ? BN_sub(out, x, y) : BN_sub(out, y, x)"

l_.str.62:                              ; @.str.62
	.asciz	"BN_set_word(out, squares[BN_get_word(x)])"

l_.str.63:                              ; @.str.63
	.asciz	"BN_rshift(hi, x, r)"

l_.str.64:                              ; @.str.64
	.asciz	"BN_sub(cross, cross, w)"

l_.str.65:                              ; @.str.65
	.asciz	"BN_lshift(out, u, r + r)"

l_.str.66:                              ; @.str.66
	.asciz	"BN_copy(remaining, x)"

l_.str.67:                              ; @.str.67
	.asciz	"BN_clear_bit(remaining, i)"

l_.str.68:                              ; @.str.68
	.asciz	"BN_lshift(row, remaining, i + 1)"

l_.str.69:                              ; @.str.69
	.asciz	"BN_set_bit(row, i + i)"

l_.str.70:                              ; @.str.70
	.asciz	"BN_set_word(prefix, 0)"

l_.str.71:                              ; @.str.71
	.asciz	"BN_lshift(out, out, 2)"

l_.str.72:                              ; @.str.72
	.asciz	"BN_lshift(row, prefix, 2)"

l_.str.73:                              ; @.str.73
	.asciz	"BN_add_word(row, 1)"

l_.str.74:                              ; @.str.74
	.asciz	"BN_lshift1(prefix, prefix)"

l_.str.75:                              ; @.str.75
	.asciz	"BN_add_word(prefix, 1)"

l_.str.76:                              ; @.str.76
	.asciz	"BN_sub(delta,b,a)"

l_.str.77:                              ; @.str.77
	.asciz	"BN_sqr(out,a,ctx)"

l_.str.78:                              ; @.str.78
	.asciz	"BN_mul(cross,a,delta,ctx)"

l_.str.79:                              ; @.str.79
	.asciz	"BN_add(out,out,cross)"

l_.str.80:                              ; @.str.80
	.asciz	"p->x && p->y"

l_.str.81:                              ; @.str.81
	.asciz	"BN_clear_bit(p->x,8)"

l_.str.82:                              ; @.str.82
	.asciz	"BN_copy(p->y,p->x)"

l_.str.83:                              ; @.str.83
	.asciz	"BN_add_word(p->y,1+(random_u64()%255))"

l_.str.84:                              ; @.str.84
	.asciz	"BN_set_word(p->x,1)"

l_.str.85:                              ; @.str.85
	.asciz	"BN_set_word(p->y,1)"

l_.str.86:                              ; @.str.86
	.asciz	"BN_set_bit(p->x,bits-1)"

l_.str.87:                              ; @.str.87
	.asciz	"BN_set_bit(p->y,bits-1)"

l_.str.88:                              ; @.str.88
	.asciz	"BN_set_bit(p->x,(int)(random_u64()%(unsigned)(bits-2))+1)"

l_.str.89:                              ; @.str.89
	.asciz	"BN_set_bit(p->y,(int)(random_u64()%(unsigned)(bits-2))+1)"

l_.str.90:                              ; @.str.90
	.asciz	"BN_set_word(p->x,0)"

l_.str.91:                              ; @.str.91
	.asciz	"BN_set_bit(p->x,bits)"

l_.str.92:                              ; @.str.92
	.asciz	"BN_sub_word(p->x,1)"

l_.str.93:                              ; @.str.93
	.asciz	"BN_clear_bit(p->x,(int)(random_u64()%(unsigned)(bits-1)))"

l_.str.94:                              ; @.str.94
	.asciz	"BN_clear_bit(p->y,(int)(random_u64()%(unsigned)(bits-1)))"

l_.str.95:                              ; @.str.95
	.asciz	"BN_set_word(p->y,128+(random_u64()&127))"

l_.str.96:                              ; @.str.96
	.asciz	"BN_set_word(p->y,0)"

l_.str.97:                              ; @.str.97
	.asciz	"BN_set_bit(p->y,bits/2)"

l_.str.98:                              ; @.str.98
	.asciz	"buf"

l_.str.99:                              ; @.str.99
	.asciz	"BN_bin2bn(buf,n,x)"

	.section	__DATA,__data
	.p2align	3, 0x0                          ; @rng_state
_rng_state:
	.quad	-8134700638765165263            ; 0x8f1bbcde58425531

	.section	__TEXT,__const
	.p2align	2, 0x0                          ; @__const.measure.widths
l___const.measure.widths:
	.long	64                              ; 0x40
	.long	256                             ; 0x100
	.long	1024                            ; 0x400
	.long	4096                            ; 0x1000
	.long	16384                           ; 0x4000

	.section	__TEXT,__cstring,cstring_literals
l_.str.100:                             ; @.str.100
	.asciz	"ctx && out"

l_.str.101:                             ; @.str.101
	.asciz	"bits,pattern,algorithm,samples,repetitions,trials,median_ns,min_ns,max_ns\n"

l_.str.102:                             ; @.str.102
	.asciz	"expected"

l_.str.103:                             ; @.str.103
	.asciz	"BN_mul(expected,pairs[i].x,pairs[i].y,ctx)"

l_.str.104:                             ; @.str.104
	.asciz	"BN_cmp(out,expected)==0"

l_.str.105:                             ; @.str.105
	.asciz	"%d,%s,%s,%d,%u,%d,%.3f,%.3f,%.3f\n"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @patterns
_patterns:
	.quad	l_.str.109
	.quad	l_.str.110
	.quad	l_.str.111
	.quad	l_.str.112
	.quad	l_.str.113
	.quad	l_.str.114
	.quad	l_.str.115
	.quad	l_.str.116

	.section	__TEXT,__cstring,cstring_literals
l_.str.106:                             ; @.str.106
	.asciz	"finished bits=%d pattern=%s\n"

l_.str.107:                             ; @.str.107
	.asciz	"observable checksum=%llu\n"

l_.str.108:                             ; @.str.108
	.asciz	"clock_gettime(CLOCK_MONOTONIC, &t) == 0"

l_.str.109:                             ; @.str.109
	.asciz	"random"

l_.str.110:                             ; @.str.110
	.asciz	"near"

l_.str.111:                             ; @.str.111
	.asciz	"equal"

l_.str.112:                             ; @.str.112
	.asciz	"sparse"

l_.str.113:                             ; @.str.113
	.asciz	"dense"

l_.str.114:                             ; @.str.114
	.asciz	"short8"

l_.str.115:                             ; @.str.115
	.asciz	"one"

l_.str.116:                             ; @.str.116
	.asciz	"power2"

.zerofill __DATA,__bss,__MergedGlobals,520,3 ; @_MergedGlobals
.subsections_via_symbols
