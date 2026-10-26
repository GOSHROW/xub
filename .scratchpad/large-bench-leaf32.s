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
	sub	sp, sp, #944
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
	str	wzr, [sp, #152]                 ; 4-byte Folded Spill
	mov	w28, #4096                      ; =0x1000
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
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #152]                  ; 4-byte Folded Spill
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
	mov	x26, x28
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
	cbnz	w0, LBB0_158
; %bb.10:                               ;   in Loop: Header=BB0_4 Depth=1
	add	x27, x28, #1
	cmp	w27, w20
	b.ge	LBB0_158
; %bb.11:                               ;   in Loop: Header=BB0_4 Depth=1
	ldr	x8, [x19, x27, lsl #3]
	str	x8, [sp, #72]                   ; 8-byte Folded Spill
LBB0_12:                                ;   in Loop: Header=BB0_4 Depth=1
                                        ; kill: def $w27 killed $w27 killed $x27 def $x27
	mov	x28, x26
	b	LBB0_3
LBB0_13:                                ;   in Loop: Header=BB0_4 Depth=1
	ldr	x0, [x19, x27, lsl #3]
	bl	_atoi
	mov	x28, x0
	b	LBB0_3
LBB0_14:
	str	wzr, [sp, #152]                 ; 4-byte Folded Spill
	str	xzr, [sp, #72]                  ; 8-byte Folded Spill
	fmov	d8, #5.00000000
	mov	w28, #4096                      ; =0x1000
LBB0_15:
	sub	w8, w28, #64
Lloh11:
	adrp	x26, ___stderrp@GOTPAGE
Lloh12:
	ldr	x26, [x26, ___stderrp@GOTPAGEOFF]
	ldr	x19, [x26]
	mov	w9, #16320                      ; =0x3fc0
	cmp	w8, w9
	fmov	d0, #1.00000000
	fccmp	d8, d0, #8, ls
	mov	x8, #4636737291354636288        ; =0x4059000000000000
	fmov	d0, x8
	fccmp	d8, d0, #2, ge
	b.hi	LBB0_174
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
	ldr	x0, [x26]
	mov	w8, #512                        ; =0x200
	mov	w9, #32                         ; =0x20
	stp	x9, x8, [sp]
Lloh17:
	adrp	x1, l_.str.10@PAGE
Lloh18:
	add	x1, x1, l_.str.10@PAGEOFF
	bl	_fprintf
	ldr	x3, [x26]
Lloh19:
	adrp	x0, l_.str.11@PAGE
Lloh20:
	add	x0, x0, l_.str.11@PAGEOFF
	mov	w1, #170                        ; =0xaa
	mov	w2, #1                          ; =0x1
	bl	_fwrite
	mov	x8, #0                          ; =0x0
	mov	w9, #0                          ; =0x0
Lloh21:
	adrp	x10, __MergedGlobals@PAGE
Lloh22:
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
	cbz	x0, LBB0_175
; %bb.19:
	mov	x21, x0
	bl	_BN_new
	mov	x22, x0
	str	x0, [sp, #224]
	bl	_BN_new
	str	x0, [sp, #232]
	cbz	x22, LBB0_176
; %bb.20:
	mov	x23, x0
	cbz	x0, LBB0_176
; %bb.21:
	mov	x19, #0                         ; =0x0
Lloh23:
	adrp	x8, _rng_state@PAGE
Lloh24:
	ldr	x24, [x8, _rng_state@PAGEOFF]
LBB0_22:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x19
	bl	_scalar_square32
	mul	x8, x19, x19
	cmp	x0, x8
	b.ne	LBB0_169
; %bb.23:                               ;   in Loop: Header=BB0_22 Depth=1
	add	x19, x19, #1
	cmp	x19, #16, lsl #12               ; =65536
	b.ne	LBB0_22
; %bb.24:
	mov	w25, #10000                     ; =0x2710
	mov	x19, x24
LBB0_25:                                ; =>This Inner Loop Header: Depth=1
	eor	x8, x19, x19, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x20, x8, x8, lsl #17
	eor	x8, x20, x20, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x19, x8, x8, lsl #17
	adrp	x8, _rng_state@PAGE
	str	x19, [x8, _rng_state@PAGEOFF]
	mov	x0, x20
	bl	_scalar_square32
	umull	x8, w20, w20
	cmp	x0, x8
	b.ne	LBB0_170
; %bb.26:                               ;   in Loop: Header=BB0_25 Depth=1
	mov	w27, w20
	mov	x0, x20
	mov	x1, x19
	bl	_scalar_product32
	mov	w8, w19
	umull	x8, w8, w27
	cmp	x0, x8
	b.ne	LBB0_171
; %bb.27:                               ;   in Loop: Header=BB0_25 Depth=1
	subs	w25, w25, #1
	b.ne	LBB0_25
; %bb.28:
	mov	w0, #-1                         ; =0xffffffff
	bl	_scalar_square32
	mov	x19, #-8589934591               ; =0xfffffffe00000001
	cmp	x0, x19
	b.ne	LBB0_177
; %bb.29:
	mov	w0, #-1                         ; =0xffffffff
	mov	w1, #-1                         ; =0xffffffff
	bl	_scalar_product32
	cmp	x0, x19
	b.ne	LBB0_178
; %bb.30:
	adrp	x8, _rng_state@PAGE
	str	x24, [x8, _rng_state@PAGEOFF]
	ldr	x3, [x26]
Lloh25:
	adrp	x0, l_.str.22@PAGE
Lloh26:
	add	x0, x0, l_.str.22@PAGEOFF
	mov	w1, #100                        ; =0x64
	mov	w2, #1                          ; =0x1
	bl	_fwrite
	mov	w8, #0                          ; =0x0
	mov	w9, #0                          ; =0x0
Lloh27:
	adrp	x10, __MergedGlobals@PAGE+8
Lloh28:
	add	x10, x10, __MergedGlobals@PAGEOFF+8
LBB0_31:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_32 Depth 2
	mov	w11, #0                         ; =0x0
	mov	x12, x8
LBB0_32:                                ;   Parent Loop BB0_31 Depth=1
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
	b.ne	LBB0_166
; %bb.33:                               ;   in Loop: Header=BB0_32 Depth=2
	add	w11, w11, #1
	cmp	w11, #256
	b.ne	LBB0_32
; %bb.34:                               ;   in Loop: Header=BB0_31 Depth=1
	add	w9, w9, #1
	sub	w8, w8, #1
	cmp	w9, #256
	b.ne	LBB0_31
; %bb.35:
	mov	x20, #0                         ; =0x0
Lloh29:
	adrp	x24, l___const.verify_all.edge@PAGE
Lloh30:
	add	x24, x24, l___const.verify_all.edge@PAGEOFF
LBB0_36:                                ; =>This Inner Loop Header: Depth=1
	ldr	w19, [x24, x20]
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.37:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.38:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.39:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.40:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.41:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #2                          ; =0x2
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.42:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.43:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #3                          ; =0x3
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.44:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.45:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #7                          ; =0x7
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.46:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.47:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #8                          ; =0x8
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.48:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.49:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #15                         ; =0xf
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.50:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.51:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #16                         ; =0x10
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.52:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.53:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #127                        ; =0x7f
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.54:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.55:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #128                        ; =0x80
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.56:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.57:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #255                        ; =0xff
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.58:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.59:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #256                        ; =0x100
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.60:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.61:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #257                        ; =0x101
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.62:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.63:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #65535                      ; =0xffff
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.64:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x22
	mov	x1, x19
	bl	_BN_set_word
	cbz	w0, LBB0_167
; %bb.65:                               ;   in Loop: Header=BB0_36 Depth=1
	mov	x0, x23
	mov	w1, #65536                      ; =0x10000
	bl	_BN_set_word
	cbz	w0, LBB0_168
; %bb.66:                               ;   in Loop: Header=BB0_36 Depth=1
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	add	x20, x20, #4
	cmp	x20, #60
	b.ne	LBB0_36
; %bb.67:
	mov	x0, x22
	bl	_BN_free
	mov	x0, x23
	bl	_BN_free
	mov	x24, #0                         ; =0x0
	mov	w23, #225                       ; =0xe1
Lloh31:
	adrp	x25, l___const.verify_all.widths@PAGE
Lloh32:
	add	x25, x25, l___const.verify_all.widths@PAGEOFF
	b	LBB0_69
LBB0_68:                                ;   in Loop: Header=BB0_69 Depth=1
	add	x24, x24, #4
	cmp	x24, #52
	b.eq	LBB0_75
LBB0_69:                                ; =>This Inner Loop Header: Depth=1
	ldr	w19, [x25, x24]
	cmp	w19, w28
	b.gt	LBB0_68
; %bb.70:                               ;   in Loop: Header=BB0_69 Depth=1
	bl	_BN_new
	mov	x20, x0
	str	x0, [sp, #224]
	bl	_BN_new
	str	x0, [sp, #232]
	cbz	x20, LBB0_172
; %bb.71:                               ;   in Loop: Header=BB0_69 Depth=1
	mov	x22, x0
	cbz	x0, LBB0_172
; %bb.72:                               ;   in Loop: Header=BB0_69 Depth=1
	mov	x0, x20
	mov	x1, x19
	bl	_random_bits
	mov	x0, x22
	mov	x1, x19
	bl	_random_bits
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x20
	bl	_BN_free
	mov	x0, x22
	bl	_BN_free
	bl	_BN_new
	mov	x20, x0
	str	x0, [sp, #224]
	bl	_BN_new
	str	x0, [sp, #232]
	cbz	x20, LBB0_173
; %bb.73:                               ;   in Loop: Header=BB0_69 Depth=1
	mov	x22, x0
	cbz	x0, LBB0_173
; %bb.74:                               ;   in Loop: Header=BB0_69 Depth=1
	mov	x0, x20
	mov	x1, x19
	bl	_random_bits
	mov	x0, x22
	mov	x1, x19
	bl	_random_bits
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	mov	x0, x20
	bl	_BN_free
	mov	x0, x22
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #1                          ; =0x1
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #1                          ; =0x1
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #2                          ; =0x2
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #2                          ; =0x2
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #3                          ; =0x3
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #3                          ; =0x3
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #4                          ; =0x4
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #4                          ; =0x4
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #5                          ; =0x5
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #5                          ; =0x5
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #6                          ; =0x6
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #6                          ; =0x6
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #7                          ; =0x7
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	x0, sp, #224
	mov	x1, x19
	mov	w2, #7                          ; =0x7
	bl	_make_pair
	add	x0, sp, #224
	mov	x1, x21
	bl	_verify_pair
	ldr	x0, [sp, #224]
	bl	_BN_free
	ldr	x0, [sp, #232]
	bl	_BN_free
	add	w23, w23, #16
	b	LBB0_68
LBB0_75:
	mov	x0, x21
	bl	_BN_CTX_free
	ldr	x0, [x26]
	mov	w8, #12                         ; =0xc
	stp	x23, x8, [sp]
Lloh33:
	adrp	x1, l_.str.26@PAGE
Lloh34:
	add	x1, x1, l_.str.26@PAGEOFF
	bl	_fprintf
	ldr	w8, [sp, #152]                  ; 4-byte Folded Reload
	cbz	w8, LBB0_78
LBB0_76:
	mov	w0, #0                          ; =0x0
	ldur	x8, [x29, #-128]
Lloh35:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh36:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh37:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB0_160
LBB0_77:
	bl	___stack_chk_fail
LBB0_78:
	ldr	x0, [sp, #72]                   ; 8-byte Folded Reload
	cbz	x0, LBB0_161
; %bb.79:
Lloh38:
	adrp	x1, l_.str.12@PAGE
Lloh39:
	add	x1, x1, l_.str.12@PAGEOFF
	bl	_fopen
	mov	x19, x0
	cbz	x0, LBB0_162
LBB0_80:
	str	w28, [sp, #84]                  ; 4-byte Folded Spill
	bl	_BN_CTX_new
	mov	x22, x0
	bl	_BN_new
	cbz	x22, LBB0_179
; %bb.81:
	mov	x23, x0
	cbz	x0, LBB0_179
; %bb.82:
Lloh40:
	adrp	x0, l_.str.110@PAGE
Lloh41:
	add	x0, x0, l_.str.110@PAGEOFF
	mov	w1, #74                         ; =0x4a
	mov	w2, #1                          ; =0x1
	mov	x3, x19
	bl	_fwrite
	mov	x9, #0                          ; =0x0
	add	x25, sp, #748
Lloh42:
	adrp	x8, lCPI0_0@PAGE
Lloh43:
	ldr	q0, [x8, lCPI0_0@PAGEOFF]
	str	q0, [sp, #128]                  ; 16-byte Folded Spill
Lloh44:
	adrp	x8, lCPI0_1@PAGE
Lloh45:
	ldr	q0, [x8, lCPI0_1@PAGEOFF]
	str	q0, [sp, #112]                  ; 16-byte Folded Spill
Lloh46:
	adrp	x8, lCPI0_2@PAGE
Lloh47:
	ldr	q0, [x8, lCPI0_2@PAGEOFF]
	str	q0, [sp, #96]                   ; 16-byte Folded Spill
	add	x27, sp, #160
	fmov	d9, #8.00000000
	fmov	d10, #1.00000000
	str	x19, [sp, #88]                  ; 8-byte Folded Spill
	b	LBB0_84
LBB0_83:                                ;   in Loop: Header=BB0_84 Depth=1
	ldr	x9, [sp, #152]                  ; 8-byte Folded Reload
	add	x9, x9, #1
	cmp	x9, #5
	b.eq	LBB0_155
LBB0_84:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_87 Depth 2
                                        ;       Child Loop BB0_89 Depth 3
                                        ;       Child Loop BB0_125 Depth 3
                                        ;         Child Loop BB0_131 Depth 4
                                        ;       Child Loop BB0_135 Depth 3
                                        ;         Child Loop BB0_145 Depth 4
                                        ;         Child Loop BB0_139 Depth 4
                                        ;       Child Loop BB0_150 Depth 3
	str	x9, [sp, #152]                  ; 8-byte Folded Spill
Lloh48:
	adrp	x8, l___const.measure.widths@PAGE
Lloh49:
	add	x8, x8, l___const.measure.widths@PAGEOFF
	ldr	w9, [x8, x9, lsl #2]
	ldr	w8, [sp, #84]                   ; 4-byte Folded Reload
	str	x9, [sp, #144]                  ; 8-byte Folded Spill
	cmp	w9, w8
	b.gt	LBB0_83
; %bb.85:                               ;   in Loop: Header=BB0_84 Depth=1
	mov	x24, #0                         ; =0x0
	b	LBB0_87
LBB0_86:                                ;   in Loop: Header=BB0_87 Depth=2
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
Lloh50:
	adrp	x26, ___stderrp@GOTPAGE
Lloh51:
	ldr	x26, [x26, ___stderrp@GOTPAGEOFF]
	ldr	x0, [x26]
Lloh52:
	adrp	x8, _patterns@PAGE
Lloh53:
	add	x8, x8, _patterns@PAGEOFF
	ldr	x9, [x8, x24, lsl #3]
	ldr	x8, [sp, #144]                  ; 8-byte Folded Reload
	stp	x8, x9, [sp]
Lloh54:
	adrp	x1, l_.str.115@PAGE
Lloh55:
	add	x1, x1, l_.str.115@PAGEOFF
	bl	_fprintf
	add	x24, x24, #1
	cmp	x24, #8
	b.eq	LBB0_83
LBB0_87:                                ;   Parent Loop BB0_84 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_89 Depth 3
                                        ;       Child Loop BB0_125 Depth 3
                                        ;         Child Loop BB0_131 Depth 4
                                        ;       Child Loop BB0_135 Depth 3
                                        ;         Child Loop BB0_145 Depth 4
                                        ;         Child Loop BB0_139 Depth 4
                                        ;       Child Loop BB0_150 Depth 3
	mov	x21, #0                         ; =0x0
	sub	w26, w24, #3
	b	LBB0_89
LBB0_88:                                ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x19
	bl	_BN_free
	add	x21, x21, #16
	cmp	x21, #128
	mov	x24, x28
	b.eq	LBB0_122
LBB0_89:                                ;   Parent Loop BB0_84 Depth=1
                                        ;     Parent Loop BB0_87 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	sub	x8, x29, #256
	add	x20, x8, x21
	mov	x0, x20
	ldr	x1, [sp, #144]                  ; 8-byte Folded Reload
                                        ; kill: def $w1 killed $w1 killed $x1
	mov	x2, x24
	bl	_make_pair
	bl	_BN_new
	cbz	x0, LBB0_165
; %bb.90:                               ;   in Loop: Header=BB0_89 Depth=3
	mov	x19, x0
	mov	x28, x24
	ldp	x24, x20, [x20]
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_BN_mul
	cbz	w0, LBB0_164
; %bb.91:                               ;   in Loop: Header=BB0_89 Depth=3
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
	ldr	x8, [sp, #152]                  ; 8-byte Folded Reload
	cmp	x8, #4
	b.ne	LBB0_99
; %bb.92:                               ;   in Loop: Header=BB0_89 Depth=3
	cbnz	w0, LBB0_163
; %bb.93:                               ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.94:                               ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.95:                               ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.96:                               ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.97:                               ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.98:                               ;   in Loop: Header=BB0_89 Depth=3
	cmn	w26, #2
	b.lo	LBB0_88
	b	LBB0_120
LBB0_99:                                ;   in Loop: Header=BB0_89 Depth=3
	cmn	w26, #2
	b.hs	LBB0_110
; %bb.100:                              ;   in Loop: Header=BB0_89 Depth=3
	cbnz	w0, LBB0_163
; %bb.101:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.102:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.103:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_short
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.104:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_sparse
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.105:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.106:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.107:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.108:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_set_bits
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.109:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_prefix
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbz	w0, LBB0_88
	b	LBB0_163
LBB0_110:                               ;   in Loop: Header=BB0_89 Depth=3
	cbnz	w0, LBB0_163
; %bb.111:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.112:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.113:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_short
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.114:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_shift_add_sparse
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.115:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.116:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.117:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.118:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_set_bits
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.119:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_mid_prefix
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
LBB0_120:                               ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_near_native
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB0_163
; %bb.121:                              ;   in Loop: Header=BB0_89 Depth=3
	mov	x0, x23
	mov	x1, x24
	mov	x2, x20
	mov	x3, x22
	bl	_near_recursive
	mov	x0, x23
	mov	x1, x19
	bl	_BN_cmp
	cbz	w0, LBB0_88
	b	LBB0_163
LBB0_122:                               ;   in Loop: Header=BB0_87 Depth=2
	mov	x21, #0                         ; =0x0
	ldr	x9, [sp, #152]                  ; 8-byte Folded Reload
	b	LBB0_125
LBB0_123:                               ;   in Loop: Header=BB0_125 Depth=3
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
	str	w8, [x25, x21, lsl #2]
	ldr	x9, [sp, #152]                  ; 8-byte Folded Reload
LBB0_124:                               ;   in Loop: Header=BB0_125 Depth=3
	add	x21, x21, #1
	cmp	x21, #13
	b.eq	LBB0_133
LBB0_125:                               ;   Parent Loop BB0_84 Depth=1
                                        ;     Parent Loop BB0_87 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_131 Depth 4
	mov	w8, #1                          ; =0x1
	str	w8, [x25, x21, lsl #2]
	cmn	w26, #3
	b.hi	LBB0_127
; %bb.126:                              ;   in Loop: Header=BB0_125 Depth=3
	sub	w8, w21, #11
	cmp	w8, #2
	b.lo	LBB0_124
LBB0_127:                               ;   in Loop: Header=BB0_125 Depth=3
	cmp	x9, #4
	b.ne	LBB0_130
; %bb.128:                              ;   in Loop: Header=BB0_125 Depth=3
	cmp	w21, #10
	b.hi	LBB0_130
; %bb.129:                              ;   in Loop: Header=BB0_125 Depth=3
	mov	w8, #1                          ; =0x1
	lsl	w8, w8, w21
	mov	w10, #1584                      ; =0x630
	tst	w8, w10
	b.ne	LBB0_124
LBB0_130:                               ;   in Loop: Header=BB0_125 Depth=3
	mov	w8, #24                         ; =0x18
Lloh56:
	adrp	x9, _algorithms@PAGE
Lloh57:
	add	x9, x9, _algorithms@PAGEOFF
	madd	x8, x21, x8, x9
	ldr	x20, [x8, #8]
	mov	w19, #1                         ; =0x1
	sub	x1, x29, #256
	mov	x0, x20
	mov	w2, #1                          ; =0x1
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
LBB0_131:                               ;   Parent Loop BB0_84 Depth=1
                                        ;     Parent Loop BB0_87 Depth=2
                                        ;       Parent Loop BB0_125 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov	x8, #145685290680320            ; =0x848000000000
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fcmp	d0, d1
	b.ge	LBB0_123
; %bb.132:                              ;   in Loop: Header=BB0_131 Depth=4
	mov	x24, x19
	lsl	w19, w19, #1
	sub	x1, x29, #256
	mov	x0, x20
	mov	x2, x19
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
	lsr	w8, w24, #18
	cbz	w8, LBB0_131
	b	LBB0_123
LBB0_133:                               ;   in Loop: Header=BB0_87 Depth=2
	mov	x20, #0                         ; =0x0
	b	LBB0_135
LBB0_134:                               ;   in Loop: Header=BB0_135 Depth=3
	add	x20, x20, #1
	cmp	x20, #5
	b.eq	LBB0_147
LBB0_135:                               ;   Parent Loop BB0_84 Depth=1
                                        ;     Parent Loop BB0_87 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_145 Depth 4
                                        ;         Child Loop BB0_139 Depth 4
	ldp	q0, q1, [sp, #112]              ; 32-byte Folded Reload
	stp	q1, q0, [sp, #160]
	ldr	q0, [sp, #96]                   ; 16-byte Folded Reload
	str	q0, [sp, #192]
	mov	w11, #12                        ; =0xc
	str	w11, [sp, #208]
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
	str	w10, [sp, #208]
	str	w11, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	mov	x13, #-6148914691236517206      ; =0xaaaaaaaaaaaaaaaa
	movk	x13, #43691
	umulh	x9, x8, x13
	lsr	x9, x9, #3
	msub	x9, x9, x11, x8
	ldr	w10, [sp, #204]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #204]
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
	ldr	w10, [sp, #200]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #200]
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
	ldr	w10, [sp, #196]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #196]
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
	ldr	w10, [sp, #192]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #192]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x9, x8, x8, lsl #17
	and	x8, x8, #0x7
	ldr	w10, [sp, #188]
	ldr	w11, [x27, x8, lsl #2]
	str	w11, [sp, #188]
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
	ldr	w10, [sp, #184]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #184]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	umulh	x9, x8, x13
	lsr	x9, x9, #2
	mov	w10, #6                         ; =0x6
	msub	x9, x9, x10, x8
	ldr	w10, [sp, #180]
	ldr	w11, [x27, x9, lsl #2]
	str	w11, [sp, #180]
	str	w10, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	umulh	x9, x8, x14
	lsr	x9, x9, #2
	add	x9, x9, x9, lsl #2
	sub	x9, x8, x9
	ldr	w10, [x27, x9, lsl #2]
	ldr	w11, [sp, #176]
	str	w10, [sp, #176]
	str	w11, [x27, x9, lsl #2]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x9, x8, x8, lsl #17
	ldr	w10, [sp, #172]
	add	x11, sp, #160
	bfi	x11, x8, #2, #2
	ldr	w8, [x11]
	str	w8, [sp, #172]
	str	w10, [x11]
	eor	x8, x9, x9, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	umulh	x9, x8, x13
	lsr	x9, x9, #1
	add	x9, x9, x9, lsl #1
	sub	x9, x8, x9
	ldr	w10, [sp, #168]
	orr	x9, x27, x9, lsl #2
	ldr	w11, [x9]
	str	w11, [sp, #168]
	str	w10, [x9]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	ldr	w9, [sp, #164]
	add	x10, sp, #160
	bfi	x10, x8, #2, #1
	ldr	w11, [x10]
	str	w11, [sp, #164]
	eor	x8, x8, x8, lsl #17
	str	w9, [x10]
	str	x8, [x12, _rng_state@PAGEOFF]
	ldr	x8, [sp, #152]                  ; 8-byte Folded Reload
	cmp	x8, #4
	b.ne	LBB0_142
; %bb.136:                              ;   in Loop: Header=BB0_135 Depth=3
	mov	x21, #0                         ; =0x0
	b	LBB0_139
LBB0_137:                               ;   in Loop: Header=BB0_139 Depth=4
	cmp	w24, #10
	mov	w8, #1                          ; =0x1
	lsl	w8, w8, w24
	mov	w9, #1584                       ; =0x630
	and	w8, w8, w9
	ccmp	w8, #0, #4, ls
	b.eq	LBB0_141
LBB0_138:                               ;   in Loop: Header=BB0_139 Depth=4
	add	x21, x21, #4
	cmp	x21, #52
	b.eq	LBB0_134
LBB0_139:                               ;   Parent Loop BB0_84 Depth=1
                                        ;     Parent Loop BB0_87 Depth=2
                                        ;       Parent Loop BB0_135 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ldr	w24, [x27, x21]
	cmn	w26, #3
	b.hi	LBB0_137
; %bb.140:                              ;   in Loop: Header=BB0_139 Depth=4
	sub	w8, w24, #11
	cmp	w8, #2
	b.lo	LBB0_138
	b	LBB0_137
LBB0_141:                               ;   in Loop: Header=BB0_139 Depth=4
	mov	w8, #24                         ; =0x18
Lloh58:
	adrp	x9, _algorithms@PAGE
Lloh59:
	add	x9, x9, _algorithms@PAGEOFF
	umaddl	x8, w24, w8, x9
	ldr	x0, [x8, #8]
	ldr	w19, [x25, x24, lsl #2]
	sub	x1, x29, #256
	mov	x2, x19
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
	ucvtf	d1, w19
	fmul	d1, d1, d9
	fdiv	d0, d0, d1
	mov	w8, #40                         ; =0x28
	add	x9, sp, #224
	umaddl	x8, w24, w8, x9
	str	d0, [x8, x20, lsl #3]
	b	LBB0_138
LBB0_142:                               ;   in Loop: Header=BB0_135 Depth=3
	mov	x21, #0                         ; =0x0
	b	LBB0_145
LBB0_143:                               ;   in Loop: Header=BB0_145 Depth=4
	mov	w8, #24                         ; =0x18
Lloh60:
	adrp	x9, _algorithms@PAGE
Lloh61:
	add	x9, x9, _algorithms@PAGEOFF
	umaddl	x8, w24, w8, x9
	ldr	x0, [x8, #8]
	ldr	w19, [x25, x24, lsl #2]
	sub	x1, x29, #256
	mov	x2, x19
	mov	x3, x22
	mov	x4, x23
	bl	_run_batch
	ucvtf	d1, w19
	fmul	d1, d1, d9
	fdiv	d0, d0, d1
	mov	w8, #40                         ; =0x28
	add	x9, sp, #224
	umaddl	x8, w24, w8, x9
	str	d0, [x8, x20, lsl #3]
LBB0_144:                               ;   in Loop: Header=BB0_145 Depth=4
	add	x21, x21, #4
	cmp	x21, #52
	b.eq	LBB0_134
LBB0_145:                               ;   Parent Loop BB0_84 Depth=1
                                        ;     Parent Loop BB0_87 Depth=2
                                        ;       Parent Loop BB0_135 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ldr	w24, [x27, x21]
	cmn	w26, #3
	b.hi	LBB0_143
; %bb.146:                              ;   in Loop: Header=BB0_145 Depth=4
	sub	w8, w24, #11
	cmp	w8, #2
	b.lo	LBB0_144
	b	LBB0_143
LBB0_147:                               ;   in Loop: Header=BB0_87 Depth=2
	mov	x20, #0                         ; =0x0
	add	x19, sp, #224
Lloh62:
	adrp	x21, _algorithms@PAGE
Lloh63:
	add	x21, x21, _algorithms@PAGEOFF
	mov	x24, x28
	b	LBB0_150
LBB0_148:                               ;   in Loop: Header=BB0_150 Depth=3
	mov	x0, x19
	mov	w1, #5                          ; =0x5
	mov	w2, #8                          ; =0x8
Lloh64:
	adrp	x3, _cmp_double@PAGE
Lloh65:
	add	x3, x3, _cmp_double@PAGEOFF
	bl	_qsort
Lloh66:
	adrp	x8, _patterns@PAGE
Lloh67:
	add	x8, x8, _patterns@PAGEOFF
	ldr	x8, [x8, x24, lsl #3]
	ldr	x9, [x21]
	ldr	d0, [x19, #16]
	ldr	d1, [x19]
	ldr	d2, [x19, #32]
	ldr	w10, [x25, x20, lsl #2]
	stp	d1, d2, [sp, #56]
	str	d0, [sp, #48]
	mov	w11, #5                         ; =0x5
	stp	x10, x11, [sp, #32]
	mov	w10, #8                         ; =0x8
	stp	x9, x10, [sp, #16]
	str	x8, [sp, #8]
	ldr	x8, [sp, #144]                  ; 8-byte Folded Reload
	str	x8, [sp]
	ldr	x0, [sp, #88]                   ; 8-byte Folded Reload
Lloh68:
	adrp	x1, l_.str.114@PAGE
Lloh69:
	add	x1, x1, l_.str.114@PAGEOFF
	bl	_fprintf
LBB0_149:                               ;   in Loop: Header=BB0_150 Depth=3
	add	x20, x20, #1
	add	x21, x21, #24
	add	x19, x19, #40
	cmp	x20, #13
	b.eq	LBB0_86
LBB0_150:                               ;   Parent Loop BB0_84 Depth=1
                                        ;     Parent Loop BB0_87 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	cmn	w26, #3
	b.hi	LBB0_152
; %bb.151:                              ;   in Loop: Header=BB0_150 Depth=3
	sub	w8, w20, #11
	cmp	w8, #2
	b.lo	LBB0_149
LBB0_152:                               ;   in Loop: Header=BB0_150 Depth=3
	ldr	x8, [sp, #152]                  ; 8-byte Folded Reload
	cmp	x8, #4
	b.ne	LBB0_148
; %bb.153:                              ;   in Loop: Header=BB0_150 Depth=3
	cmp	w20, #10
	b.hi	LBB0_148
; %bb.154:                              ;   in Loop: Header=BB0_150 Depth=3
	mov	w8, #1                          ; =0x1
	lsl	w8, w8, w20
	mov	w9, #1584                       ; =0x630
	tst	w8, w9
	b.ne	LBB0_149
	b	LBB0_148
LBB0_155:
	mov	x0, x23
	bl	_BN_free
	mov	x0, x22
	bl	_BN_CTX_free
	ldr	x0, [x26]
Lloh70:
	adrp	x8, __MergedGlobals@PAGE
Lloh71:
	ldr	x8, [x8, __MergedGlobals@PAGEOFF]
	str	x8, [sp]
Lloh72:
	adrp	x1, l_.str.116@PAGE
Lloh73:
	add	x1, x1, l_.str.116@PAGEOFF
	bl	_fprintf
	ldr	x8, [sp, #72]                   ; 8-byte Folded Reload
	cbz	x8, LBB0_76
; %bb.156:
	mov	x0, x19
	bl	_fclose
	cbz	w0, LBB0_159
; %bb.157:
	bl	_main.cold.15
LBB0_158:
Lloh74:
	adrp	x8, ___stderrp@GOTPAGE
Lloh75:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh76:
	ldr	x0, [x8]
	ldr	x8, [x19]
	str	x8, [sp]
Lloh77:
	adrp	x1, l_.str.4@PAGE
Lloh78:
	add	x1, x1, l_.str.4@PAGEOFF
	bl	_fprintf
	ldr	x0, [x19, x28, lsl #3]
Lloh79:
	adrp	x1, l_.str.5@PAGE
Lloh80:
	add	x1, x1, l_.str.5@PAGEOFF
	bl	_strcmp
	cmp	w0, #0
	cset	w8, ne
	lsl	w0, w8, #1
LBB0_159:
	ldur	x8, [x29, #-128]
Lloh81:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh82:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh83:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB0_77
LBB0_160:
	add	sp, sp, #944
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #16]               ; 16-byte Folded Reload
	ldp	d11, d10, [sp], #128            ; 16-byte Folded Reload
	ret
LBB0_161:
Lloh84:
	adrp	x8, ___stdoutp@GOTPAGE
Lloh85:
	ldr	x8, [x8, ___stdoutp@GOTPAGEOFF]
Lloh86:
	ldr	x19, [x8]
	cbnz	x19, LBB0_80
LBB0_162:
	bl	_main.cold.16
LBB0_163:
	bl	_main.cold.12
LBB0_164:
	bl	_main.cold.13
LBB0_165:
	bl	_main.cold.14
LBB0_166:
	bl	_main.cold.8
LBB0_167:
	bl	_main.cold.18
LBB0_168:
	bl	_main.cold.17
LBB0_169:
	bl	_main.cold.3
LBB0_170:
	bl	_main.cold.4
LBB0_171:
	bl	_main.cold.5
LBB0_172:
	bl	_main.cold.10
LBB0_173:
	bl	_main.cold.9
LBB0_174:
	mov	x0, x19
	bl	_main.cold.1
LBB0_175:
	bl	_main.cold.19
LBB0_176:
	bl	_main.cold.2
LBB0_177:
	bl	_main.cold.6
LBB0_178:
	bl	_main.cold.7
LBB0_179:
	bl	_main.cold.11
	.loh AdrpLdrGotLdr	Lloh0, Lloh1, Lloh2
	.loh AdrpAdd	Lloh9, Lloh10
	.loh AdrpAdd	Lloh7, Lloh8
	.loh AdrpAdd	Lloh5, Lloh6
	.loh AdrpAdd	Lloh3, Lloh4
	.loh AdrpLdrGot	Lloh11, Lloh12
	.loh AdrpAdd	Lloh21, Lloh22
	.loh AdrpAdd	Lloh19, Lloh20
	.loh AdrpAdd	Lloh17, Lloh18
	.loh AdrpAdd	Lloh15, Lloh16
	.loh AdrpAdd	Lloh13, Lloh14
	.loh AdrpLdr	Lloh23, Lloh24
	.loh AdrpAdd	Lloh27, Lloh28
	.loh AdrpAdd	Lloh25, Lloh26
	.loh AdrpAdd	Lloh29, Lloh30
	.loh AdrpAdd	Lloh31, Lloh32
	.loh AdrpAdd	Lloh33, Lloh34
	.loh AdrpLdrGotLdr	Lloh35, Lloh36, Lloh37
	.loh AdrpAdd	Lloh38, Lloh39
	.loh AdrpLdr	Lloh46, Lloh47
	.loh AdrpAdrp	Lloh44, Lloh46
	.loh AdrpLdr	Lloh44, Lloh45
	.loh AdrpAdrp	Lloh42, Lloh44
	.loh AdrpLdr	Lloh42, Lloh43
	.loh AdrpAdd	Lloh40, Lloh41
	.loh AdrpAdd	Lloh48, Lloh49
	.loh AdrpAdd	Lloh54, Lloh55
	.loh AdrpAdd	Lloh52, Lloh53
	.loh AdrpLdrGot	Lloh50, Lloh51
	.loh AdrpAdd	Lloh56, Lloh57
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpAdd	Lloh60, Lloh61
	.loh AdrpAdd	Lloh62, Lloh63
	.loh AdrpAdd	Lloh68, Lloh69
	.loh AdrpAdd	Lloh66, Lloh67
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpLdr	Lloh70, Lloh71
	.loh AdrpAdd	Lloh79, Lloh80
	.loh AdrpAdd	Lloh77, Lloh78
	.loh AdrpLdrGotLdr	Lloh74, Lloh75, Lloh76
	.loh AdrpLdrGotLdr	Lloh81, Lloh82, Lloh83
	.loh AdrpLdrGotLdr	Lloh84, Lloh85, Lloh86
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function scalar_square32
_scalar_square32:                       ; @scalar_square32
	.cfi_startproc
; %bb.0:
	cmp	w0, #255
	b.hi	LBB1_2
; %bb.1:
Lloh87:
	adrp	x8, __MergedGlobals@PAGE
Lloh88:
	add	x8, x8, __MergedGlobals@PAGEOFF
	add	x8, x8, w0, uxtw #1
	ldrh	w0, [x8, #8]
	ret
LBB1_2:
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
	clz	w8, w0
	mov	w9, #32                         ; =0x20
	sub	w22, w9, w8
	lsr	w23, w22, #1
	lsr	w8, w0, w23
	mov	w9, #-1                         ; =0xffffffff
	lsl	w9, w9, w23
	bic	w19, w0, w9
	sub	w9, w19, w8
	subs	w10, w8, w19
	csel	w20, w9, w10, lo
	mov	x0, x8
	bl	_scalar_square32
	mov	x21, x0
	mov	x0, x19
	bl	_scalar_square32
	mov	x19, x0
	mov	x0, x20
	bl	_scalar_square32
	and	w8, w22, #0x3e
	lsl	x8, x21, x8
	add	x9, x19, x21
	sub	x9, x9, x0
	lsl	x9, x9, x23
	add	x8, x19, x8
	add	x0, x8, x9
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh87, Lloh88
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function scalar_product32
_scalar_product32:                      ; @scalar_product32
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w9, w0, w1, lo
	cbz	w9, LBB2_4
; %bb.1:
	mov	x8, x0
	mov	x0, #0                          ; =0x0
	cmp	w8, w1
	csel	w8, w8, w1, hi
LBB2_2:                                 ; =>This Inner Loop Header: Depth=1
	rbit	w10, w9
	clz	w10, w10
	lsl	x10, x8, x10
	add	x0, x10, x0
	sub	w10, w9, #1
	ands	w9, w10, w9
	b.ne	LBB2_2
; %bb.3:
	ret
LBB2_4:
	mov	x0, #0                          ; =0x0
	ret
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
	cbz	x19, LBB3_16
; %bb.1:
	mov	x21, x0
	cbz	x0, LBB3_16
; %bb.2:
	ldp	x1, x2, [x20]
	mov	x0, x19
	mov	x3, x22
	bl	_BN_mul
	cbz	w0, LBB3_17
; %bb.3:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_native_mul
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_18
; %bb.4:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_native_equal_aware
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_19
; %bb.5:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_native_square
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_20
; %bb.6:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_shift_add_short
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_21
; %bb.7:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_shift_add_sparse
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_22
; %bb.8:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_direct_karatsuba
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_23
; %bb.9:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_recursive_equal_aware
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_24
; %bb.10:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_recursive
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_25
; %bb.11:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_set_bits
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_26
; %bb.12:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_mid_prefix
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_27
; %bb.13:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_near_native
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_28
; %bb.14:
	ldp	x1, x2, [x20]
	mov	x0, x21
	mov	x3, x22
	bl	_near_recursive
	mov	x0, x21
	mov	x1, x19
	bl	_BN_cmp
	cbnz	w0, LBB3_29
; %bb.15:
	mov	x0, x19
	bl	_BN_free
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_BN_free
LBB3_16:
	bl	_verify_pair.cold.1
LBB3_17:
	bl	_verify_pair.cold.3
LBB3_18:
Lloh89:
	adrp	x4, _algorithms@PAGE+24
Lloh90:
	add	x4, x4, _algorithms@PAGEOFF+24
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_19:
Lloh91:
	adrp	x4, _algorithms@PAGE+48
Lloh92:
	add	x4, x4, _algorithms@PAGEOFF+48
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_20:
Lloh93:
	adrp	x4, _algorithms@PAGE+72
Lloh94:
	add	x4, x4, _algorithms@PAGEOFF+72
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_21:
Lloh95:
	adrp	x4, _algorithms@PAGE+96
Lloh96:
	add	x4, x4, _algorithms@PAGEOFF+96
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_22:
Lloh97:
	adrp	x4, _algorithms@PAGE+120
Lloh98:
	add	x4, x4, _algorithms@PAGEOFF+120
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_23:
Lloh99:
	adrp	x4, _algorithms@PAGE+144
Lloh100:
	add	x4, x4, _algorithms@PAGEOFF+144
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_24:
Lloh101:
	adrp	x4, _algorithms@PAGE+168
Lloh102:
	add	x4, x4, _algorithms@PAGEOFF+168
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_25:
Lloh103:
	adrp	x4, _algorithms@PAGE+192
Lloh104:
	add	x4, x4, _algorithms@PAGEOFF+192
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_26:
Lloh105:
	adrp	x4, _algorithms@PAGE+216
Lloh106:
	add	x4, x4, _algorithms@PAGEOFF+216
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_27:
Lloh107:
	adrp	x4, _algorithms@PAGE+240
Lloh108:
	add	x4, x4, _algorithms@PAGEOFF+240
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_28:
Lloh109:
	adrp	x4, _algorithms@PAGE+264
Lloh110:
	add	x4, x4, _algorithms@PAGEOFF+264
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
LBB3_29:
Lloh111:
	adrp	x4, _algorithms@PAGE+288
Lloh112:
	add	x4, x4, _algorithms@PAGEOFF+288
	add	x1, x20, #8
	mov	x0, x20
	mov	x2, x21
	mov	x3, x19
	bl	_verify_pair.cold.2
	.loh AdrpAdd	Lloh89, Lloh90
	.loh AdrpAdd	Lloh91, Lloh92
	.loh AdrpAdd	Lloh93, Lloh94
	.loh AdrpAdd	Lloh95, Lloh96
	.loh AdrpAdd	Lloh97, Lloh98
	.loh AdrpAdd	Lloh99, Lloh100
	.loh AdrpAdd	Lloh101, Lloh102
	.loh AdrpAdd	Lloh103, Lloh104
	.loh AdrpAdd	Lloh105, Lloh106
	.loh AdrpAdd	Lloh107, Lloh108
	.loh AdrpAdd	Lloh109, Lloh110
	.loh AdrpAdd	Lloh111, Lloh112
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
	b.eq	LBB4_39
; %bb.1:
	mov	x1, x20
	bl	_random_bits
	ldr	x0, [x19, #8]
	mov	x1, x20
	bl	_random_bits
	cmp	w21, #3
	b.le	LBB4_7
; %bb.2:
	cmp	w21, #5
	b.gt	LBB4_17
; %bb.3:
	cmp	w21, #4
	b.eq	LBB4_28
; %bb.4:
	cmp	w21, #5
	b.ne	LBB4_38
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
	cbnz	w0, LBB4_38
; %bb.6:
	bl	_make_pair.cold.6
LBB4_7:
	cmp	w21, #1
	b.eq	LBB4_24
; %bb.8:
	cmp	w21, #2
	b.eq	LBB4_37
; %bb.9:
	cmp	w21, #3
	b.ne	LBB4_38
; %bb.10:
	ldr	x0, [x19]
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbz	w0, LBB4_42
; %bb.11:
	ldr	x0, [x19, #8]
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbz	w0, LBB4_47
; %bb.12:
	ldr	x0, [x19]
	sub	w21, w20, #1
	mov	x1, x21
	bl	_BN_set_bit
	cbz	w0, LBB4_50
; %bb.13:
	ldr	x0, [x19, #8]
	mov	x1, x21
	bl	_BN_set_bit
	cbz	w0, LBB4_53
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
	cbz	w0, LBB4_55
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
	cbnz	w0, LBB4_38
; %bb.16:
	bl	_make_pair.cold.13
LBB4_17:
	cmp	w21, #6
	b.eq	LBB4_35
; %bb.18:
	cmp	w21, #7
	b.ne	LBB4_38
; %bb.19:
	ldr	x0, [x19]
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB4_43
; %bb.20:
	ldr	x0, [x19]
	sub	w1, w20, #1
	bl	_BN_set_bit
	cbz	w0, LBB4_48
; %bb.21:
	ldr	x0, [x19, #8]
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB4_51
; %bb.22:
	ldr	x0, [x19, #8]
	add	w8, w20, w20, lsr #31
	asr	w1, w8, #1
	bl	_BN_set_bit
	cbnz	w0, LBB4_38
; %bb.23:
	bl	_make_pair.cold.1
LBB4_24:
	ldr	x0, [x19]
	mov	w1, #8                          ; =0x8
	bl	_BN_clear_bit
	cbz	w0, LBB4_40
; %bb.25:
	ldp	x1, x0, [x19]
	bl	_BN_copy
	cbz	x0, LBB4_45
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
	cbnz	w0, LBB4_38
; %bb.27:
	bl	_make_pair.cold.20
LBB4_28:
	ldr	x0, [x19]
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB4_41
; %bb.29:
	ldr	x0, [x19]
	mov	x1, x20
	bl	_BN_set_bit
	cbz	w0, LBB4_46
; %bb.30:
	ldr	x0, [x19]
	mov	w1, #1                          ; =0x1
	bl	_BN_sub_word
	cbz	w0, LBB4_49
; %bb.31:
	ldp	x1, x0, [x19]
	bl	_BN_copy
	cbz	x0, LBB4_52
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
	cbz	w0, LBB4_54
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
	cbnz	w0, LBB4_38
; %bb.34:
	bl	_make_pair.cold.7
LBB4_35:
	ldr	x0, [x19, #8]
	mov	w1, #1                          ; =0x1
	bl	_BN_set_word
	cbnz	w0, LBB4_38
; %bb.36:
	bl	_make_pair.cold.5
LBB4_37:
	ldp	x1, x0, [x19]
	bl	_BN_copy
	cbz	x0, LBB4_44
LBB4_38:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB4_39:
	bl	_make_pair.cold.23
LBB4_40:
	bl	_make_pair.cold.22
LBB4_41:
	bl	_make_pair.cold.12
LBB4_42:
	bl	_make_pair.cold.18
LBB4_43:
	bl	_make_pair.cold.4
LBB4_44:
	bl	_make_pair.cold.19
LBB4_45:
	bl	_make_pair.cold.21
LBB4_46:
	bl	_make_pair.cold.11
LBB4_47:
	bl	_make_pair.cold.17
LBB4_48:
	bl	_make_pair.cold.3
LBB4_49:
	bl	_make_pair.cold.10
LBB4_50:
	bl	_make_pair.cold.16
LBB4_51:
	bl	_make_pair.cold.2
LBB4_52:
	bl	_make_pair.cold.9
LBB4_53:
	bl	_make_pair.cold.15
LBB4_54:
	bl	_make_pair.cold.8
LBB4_55:
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
	cbz	x0, LBB5_2
; %bb.1:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
LBB5_2:
Lloh113:
	adrp	x8, ___stderrp@GOTPAGE
Lloh114:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh115:
	ldr	x0, [x8]
Lloh116:
	adrp	x8, l_.str.43@PAGE
Lloh117:
	add	x8, x8, l_.str.43@PAGEOFF
	mov	w9, #254                        ; =0xfe
	stp	x9, x8, [sp]
Lloh118:
	adrp	x1, l_.str.6@PAGE
Lloh119:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh118, Lloh119
	.loh AdrpAdd	Lloh116, Lloh117
	.loh AdrpLdrGotLdr	Lloh113, Lloh114, Lloh115
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
	cbz	w0, LBB6_2
; %bb.1:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
LBB6_2:
Lloh120:
	adrp	x8, ___stderrp@GOTPAGE
Lloh121:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh122:
	ldr	x0, [x8]
Lloh123:
	adrp	x8, l_.str.44@PAGE
Lloh124:
	add	x8, x8, l_.str.44@PAGEOFF
	mov	w9, #226                        ; =0xe2
	stp	x9, x8, [sp]
Lloh125:
	adrp	x1, l_.str.6@PAGE
Lloh126:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh125, Lloh126
	.loh AdrpAdd	Lloh123, Lloh124
	.loh AdrpLdrGotLdr	Lloh120, Lloh121, Lloh122
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
	cbz	w0, LBB7_3
; %bb.1:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x21
	mov	x3, x19
	bl	_BN_mul
	cbnz	w0, LBB7_4
; %bb.2:
Lloh127:
	adrp	x8, ___stderrp@GOTPAGE
Lloh128:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh129:
	ldr	x0, [x8]
Lloh130:
	adrp	x8, l_.str.46@PAGE
Lloh131:
	add	x8, x8, l_.str.46@PAGEOFF
	mov	w9, #231                        ; =0xe7
	stp	x9, x8, [sp]
Lloh132:
	adrp	x1, l_.str.6@PAGE
Lloh133:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB7_3:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x19
	bl	_BN_sqr
	cbz	w0, LBB7_5
LBB7_4:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB7_5:
Lloh134:
	adrp	x8, ___stderrp@GOTPAGE
Lloh135:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh136:
	ldr	x0, [x8]
Lloh137:
	adrp	x8, l_.str.45@PAGE
Lloh138:
	add	x8, x8, l_.str.45@PAGEOFF
	mov	w9, #230                        ; =0xe6
	stp	x9, x8, [sp]
Lloh139:
	adrp	x1, l_.str.6@PAGE
Lloh140:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh132, Lloh133
	.loh AdrpAdd	Lloh130, Lloh131
	.loh AdrpLdrGotLdr	Lloh127, Lloh128, Lloh129
	.loh AdrpAdd	Lloh139, Lloh140
	.loh AdrpAdd	Lloh137, Lloh138
	.loh AdrpLdrGotLdr	Lloh134, Lloh135, Lloh136
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
	b.ge	LBB9_2
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
LBB9_2:
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
	b.lt	LBB10_8
; %bb.1:
	mov	x23, x0
	mov	w25, #0                         ; =0x0
	mov	w24, #0                         ; =0x0
LBB10_2:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x21
	mov	x1, x24
	bl	_BN_is_bit_set
	add	w25, w0, w25
	add	w24, w24, #1
	cmp	w23, w24
	b.ne	LBB10_2
; %bb.3:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB10_9
LBB10_4:
	mov	x23, x0
	mov	w26, #0                         ; =0x0
	mov	w24, #0                         ; =0x0
LBB10_5:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x20
	mov	x1, x24
	bl	_BN_is_bit_set
	add	w26, w0, w26
	add	w24, w24, #1
	cmp	w23, w24
	b.ne	LBB10_5
; %bb.6:
	mov	x0, x22
	cmp	w25, w26
	b.hs	LBB10_10
LBB10_7:
	mov	x1, x20
	mov	x2, x21
	b	LBB10_11
LBB10_8:
	mov	w25, #0                         ; =0x0
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.ge	LBB10_4
LBB10_9:
	mov	w26, #0                         ; =0x0
	mov	x0, x22
	cmp	w25, w26
	b.lo	LBB10_7
LBB10_10:
	mov	x1, x21
	mov	x2, x20
LBB10_11:
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
	mov	x24, x2
	mov	x22, x1
	mov	x19, x0
	mov	x0, x1
	bl	_BN_num_bits
	mov	x21, x0
	mov	x0, x24
	bl	_BN_num_bits
	cbz	w21, LBB11_6
; %bb.1:
	cbz	w0, LBB11_6
; %bb.2:
	cmp	w21, #8
	b.gt	LBB11_8
; %bb.3:
	cmp	w0, #8
	b.gt	LBB11_8
; %bb.4:
	mov	x0, x22
	bl	_BN_get_word
	mov	x20, x0
	mov	x0, x24
	bl	_BN_get_word
	cmp	w20, w0
	csel	w8, w20, w0, hi
	csel	w9, w20, w0, lo
	sub	w8, w8, w9
	lsr	w10, w8, #1
	add	w11, w10, w9
Lloh141:
	adrp	x12, __MergedGlobals@PAGE+8
Lloh142:
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
	cbnz	w0, LBB11_7
; %bb.5:
Lloh143:
	adrp	x8, ___stderrp@GOTPAGE
Lloh144:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh145:
	ldr	x0, [x8]
Lloh146:
	adrp	x8, l_.str.57@PAGE
Lloh147:
	add	x8, x8, l_.str.57@PAGEOFF
	mov	w9, #198                        ; =0xc6
	stp	x9, x8, [sp]
Lloh148:
	adrp	x1, l_.str.6@PAGE
Lloh149:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_6:
	mov	x0, x19
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB11_46
LBB11_7:
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #144]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #128]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #176
	ret
LBB11_8:
	cmp	w21, #32
	b.gt	LBB11_12
; %bb.9:
	cmp	w0, #32
	b.gt	LBB11_12
; %bb.10:
	mov	x0, x22
	bl	_BN_get_word
	mov	x20, x0
	mov	x0, x24
	bl	_BN_get_word
	mov	x1, x0
	mov	x0, x20
                                        ; kill: def $w1 killed $w1 killed $x1
	bl	_scalar_product32
	mov	x1, x0
	mov	x0, x19
	bl	_BN_set_word
	cbnz	w0, LBB11_7
; %bb.11:
Lloh150:
	adrp	x8, ___stderrp@GOTPAGE
Lloh151:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh152:
	ldr	x0, [x8]
Lloh153:
	adrp	x8, l_.str.58@PAGE
Lloh154:
	add	x8, x8, l_.str.58@PAGEOFF
	mov	w9, #203                        ; =0xcb
	stp	x9, x8, [sp]
Lloh155:
	adrp	x1, l_.str.6@PAGE
Lloh156:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_12:
	cmp	w21, #9
	b.lt	LBB11_28
; %bb.13:
	cmp	w0, #8
	b.le	LBB11_28
; %bb.14:
	cmp	w21, w0
	csel	w27, w21, w0, hi
	mov	x0, x20
	bl	_BN_CTX_start
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB11_45
; %bb.15:
	mov	x25, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #72]                   ; 8-byte Folded Spill
	cbz	x0, LBB11_45
; %bb.16:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB11_45
; %bb.17:
	mov	x28, x0
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB11_45
; %bb.18:
	mov	x21, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #64]                   ; 8-byte Folded Spill
	cbz	x0, LBB11_45
; %bb.19:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB11_45
; %bb.20:
	mov	x23, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #56]                   ; 8-byte Folded Spill
	cbz	x0, LBB11_45
; %bb.21:
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #48]                   ; 8-byte Folded Spill
	cbz	x0, LBB11_45
; %bb.22:
	str	x23, [sp, #40]                  ; 8-byte Folded Spill
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #32]                   ; 8-byte Folded Spill
	cbz	x0, LBB11_45
; %bb.23:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB11_45
; %bb.24:
	mov	x23, x0
	str	w27, [sp, #28]                  ; 4-byte Folded Spill
	lsr	w27, w27, #1
	mov	x0, x25
	mov	x1, x22
	mov	x2, x27
	bl	_BN_rshift
	cbz	w0, LBB11_48
; %bb.25:
	ldr	x26, [sp, #72]                  ; 8-byte Folded Reload
	mov	x0, x26
	mov	x1, x22
	mov	x2, x27
	bl	_low_bits
	mov	x0, x28
	mov	x1, x24
	mov	x2, x27
	bl	_BN_rshift
	cbz	w0, LBB11_49
; %bb.26:
	mov	x0, x21
	mov	x1, x24
	mov	x2, x27
	bl	_low_bits
	mov	x0, x25
	mov	x1, x26
	bl	_BN_cmp
	mov	x22, x0
	tbnz	w0, #31, LBB11_29
; %bb.27:
	ldr	x0, [sp, #64]                   ; 8-byte Folded Reload
	mov	x1, x25
	mov	x2, x26
	b	LBB11_30
LBB11_28:
	mov	x0, x19
	mov	x1, x22
	mov	x2, x24
	mov	x3, x20
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #144]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #128]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #176
	b	_shift_add_short
LBB11_29:
	ldr	x0, [sp, #64]                   ; 8-byte Folded Reload
	mov	x1, x26
	mov	x2, x25
LBB11_30:
	bl	_BN_sub
	cbz	w0, LBB11_47
; %bb.31:
	mov	x0, x28
	mov	x1, x21
	bl	_BN_cmp
	mov	x24, x0
	str	w22, [sp, #24]                  ; 4-byte Folded Spill
	tbnz	w0, #31, LBB11_33
; %bb.32:
	ldr	x26, [sp, #40]                  ; 8-byte Folded Reload
	mov	x0, x26
	mov	x1, x28
	mov	x2, x21
	b	LBB11_34
LBB11_33:
	ldr	x26, [sp, #40]                  ; 8-byte Folded Reload
	mov	x0, x26
	mov	x1, x21
	mov	x2, x28
LBB11_34:
	bl	_BN_sub
	cbz	w0, LBB11_47
; %bb.35:
	ldr	x22, [sp, #56]                  ; 8-byte Folded Reload
	mov	x0, x22
	mov	x1, x25
	mov	x2, x28
	mov	x3, x20
	bl	_direct_karatsuba
	ldr	x25, [sp, #48]                  ; 8-byte Folded Reload
	mov	x0, x25
	ldr	x1, [sp, #72]                   ; 8-byte Folded Reload
	mov	x2, x21
	mov	x3, x20
	bl	_direct_karatsuba
	ldr	x21, [sp, #32]                  ; 8-byte Folded Reload
	mov	x0, x21
	ldr	x1, [sp, #64]                   ; 8-byte Folded Reload
	mov	x2, x26
	mov	x3, x20
	bl	_direct_karatsuba
	mov	x0, x23
	mov	x1, x22
	mov	x2, x25
	bl	_BN_add
	cbz	w0, LBB11_50
; %bb.36:
	ldr	w8, [sp, #24]                   ; 4-byte Folded Reload
	mov	x0, x23
	mov	x1, x23
	mov	x2, x21
	eor	w8, w24, w8
	tbnz	w8, #31, LBB11_43
; %bb.37:
	bl	_BN_sub
	cbz	w0, LBB11_44
LBB11_38:
	ldr	w8, [sp, #28]                   ; 4-byte Folded Reload
	and	w2, w8, #0x7ffffffe
	mov	x0, x19
	ldr	x1, [sp, #56]                   ; 8-byte Folded Reload
	bl	_BN_lshift
	cbz	w0, LBB11_51
; %bb.39:
	mov	x0, x23
	mov	x1, x23
	mov	x2, x27
	bl	_BN_lshift
	cbz	w0, LBB11_52
; %bb.40:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x23
	bl	_BN_add
	cbz	w0, LBB11_53
; %bb.41:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x25
	bl	_BN_add
	cbz	w0, LBB11_54
; %bb.42:
	mov	x0, x20
	ldp	x29, x30, [sp, #160]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #144]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #128]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #112]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #96]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #176
	b	_BN_CTX_end
LBB11_43:
	bl	_BN_add
	cbnz	w0, LBB11_38
LBB11_44:
Lloh157:
	adrp	x8, ___stderrp@GOTPAGE
Lloh158:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh159:
	ldr	x0, [x8]
Lloh160:
	adrp	x8, l_.str.62@PAGE
Lloh161:
	add	x8, x8, l_.str.62@PAGEOFF
	mov	w9, #219                        ; =0xdb
	stp	x9, x8, [sp]
Lloh162:
	adrp	x1, l_.str.6@PAGE
Lloh163:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_45:
Lloh164:
	adrp	x8, ___stderrp@GOTPAGE
Lloh165:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh166:
	ldr	x0, [x8]
Lloh167:
	adrp	x8, l_.str.52@PAGE
Lloh168:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh169:
	adrp	x1, l_.str.6@PAGE
Lloh170:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_46:
Lloh171:
	adrp	x8, ___stderrp@GOTPAGE
Lloh172:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh173:
	ldr	x0, [x8]
Lloh174:
	adrp	x8, l_.str.54@PAGE
Lloh175:
	add	x8, x8, l_.str.54@PAGEOFF
	mov	w9, #193                        ; =0xc1
	stp	x9, x8, [sp]
Lloh176:
	adrp	x1, l_.str.6@PAGE
Lloh177:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_47:
Lloh178:
	adrp	x8, ___stderrp@GOTPAGE
Lloh179:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh180:
	ldr	x0, [x8]
Lloh181:
	adrp	x8, l_.str.69@PAGE
Lloh182:
	add	x8, x8, l_.str.69@PAGEOFF
	mov	w9, #61                         ; =0x3d
	stp	x9, x8, [sp]
Lloh183:
	adrp	x1, l_.str.6@PAGE
Lloh184:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_48:
Lloh185:
	adrp	x8, ___stderrp@GOTPAGE
Lloh186:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh187:
	ldr	x0, [x8]
Lloh188:
	adrp	x8, l_.str.59@PAGE
Lloh189:
	add	x8, x8, l_.str.59@PAGEOFF
	mov	w9, #213                        ; =0xd5
	stp	x9, x8, [sp]
Lloh190:
	adrp	x1, l_.str.6@PAGE
Lloh191:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_49:
Lloh192:
	adrp	x8, ___stderrp@GOTPAGE
Lloh193:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh194:
	ldr	x0, [x8]
Lloh195:
	adrp	x8, l_.str.60@PAGE
Lloh196:
	add	x8, x8, l_.str.60@PAGEOFF
	mov	w9, #214                        ; =0xd6
	stp	x9, x8, [sp]
Lloh197:
	adrp	x1, l_.str.6@PAGE
Lloh198:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_50:
Lloh199:
	adrp	x8, ___stderrp@GOTPAGE
Lloh200:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh201:
	ldr	x0, [x8]
Lloh202:
	adrp	x8, l_.str.61@PAGE
Lloh203:
	add	x8, x8, l_.str.61@PAGEOFF
	mov	w9, #218                        ; =0xda
	stp	x9, x8, [sp]
Lloh204:
	adrp	x1, l_.str.6@PAGE
Lloh205:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_51:
Lloh206:
	adrp	x8, ___stderrp@GOTPAGE
Lloh207:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh208:
	ldr	x0, [x8]
Lloh209:
	adrp	x8, l_.str.63@PAGE
Lloh210:
	add	x8, x8, l_.str.63@PAGEOFF
	mov	w9, #220                        ; =0xdc
	stp	x9, x8, [sp]
Lloh211:
	adrp	x1, l_.str.6@PAGE
Lloh212:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_52:
Lloh213:
	adrp	x8, ___stderrp@GOTPAGE
Lloh214:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh215:
	ldr	x0, [x8]
Lloh216:
	adrp	x8, l_.str.64@PAGE
Lloh217:
	add	x8, x8, l_.str.64@PAGEOFF
	mov	w9, #220                        ; =0xdc
	stp	x9, x8, [sp]
Lloh218:
	adrp	x1, l_.str.6@PAGE
Lloh219:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_53:
Lloh220:
	adrp	x8, ___stderrp@GOTPAGE
Lloh221:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh222:
	ldr	x0, [x8]
Lloh223:
	adrp	x8, l_.str.65@PAGE
Lloh224:
	add	x8, x8, l_.str.65@PAGEOFF
	mov	w9, #221                        ; =0xdd
	stp	x9, x8, [sp]
Lloh225:
	adrp	x1, l_.str.6@PAGE
Lloh226:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB11_54:
Lloh227:
	adrp	x8, ___stderrp@GOTPAGE
Lloh228:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh229:
	ldr	x0, [x8]
Lloh230:
	adrp	x8, l_.str.66@PAGE
Lloh231:
	add	x8, x8, l_.str.66@PAGEOFF
	mov	w9, #221                        ; =0xdd
	stp	x9, x8, [sp]
Lloh232:
	adrp	x1, l_.str.6@PAGE
Lloh233:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh141, Lloh142
	.loh AdrpAdd	Lloh148, Lloh149
	.loh AdrpAdd	Lloh146, Lloh147
	.loh AdrpLdrGotLdr	Lloh143, Lloh144, Lloh145
	.loh AdrpAdd	Lloh155, Lloh156
	.loh AdrpAdd	Lloh153, Lloh154
	.loh AdrpLdrGotLdr	Lloh150, Lloh151, Lloh152
	.loh AdrpAdd	Lloh162, Lloh163
	.loh AdrpAdd	Lloh160, Lloh161
	.loh AdrpLdrGotLdr	Lloh157, Lloh158, Lloh159
	.loh AdrpAdd	Lloh169, Lloh170
	.loh AdrpAdd	Lloh167, Lloh168
	.loh AdrpLdrGotLdr	Lloh164, Lloh165, Lloh166
	.loh AdrpAdd	Lloh176, Lloh177
	.loh AdrpAdd	Lloh174, Lloh175
	.loh AdrpLdrGotLdr	Lloh171, Lloh172, Lloh173
	.loh AdrpAdd	Lloh183, Lloh184
	.loh AdrpAdd	Lloh181, Lloh182
	.loh AdrpLdrGotLdr	Lloh178, Lloh179, Lloh180
	.loh AdrpAdd	Lloh190, Lloh191
	.loh AdrpAdd	Lloh188, Lloh189
	.loh AdrpLdrGotLdr	Lloh185, Lloh186, Lloh187
	.loh AdrpAdd	Lloh197, Lloh198
	.loh AdrpAdd	Lloh195, Lloh196
	.loh AdrpLdrGotLdr	Lloh192, Lloh193, Lloh194
	.loh AdrpAdd	Lloh204, Lloh205
	.loh AdrpAdd	Lloh202, Lloh203
	.loh AdrpLdrGotLdr	Lloh199, Lloh200, Lloh201
	.loh AdrpAdd	Lloh211, Lloh212
	.loh AdrpAdd	Lloh209, Lloh210
	.loh AdrpLdrGotLdr	Lloh206, Lloh207, Lloh208
	.loh AdrpAdd	Lloh218, Lloh219
	.loh AdrpAdd	Lloh216, Lloh217
	.loh AdrpLdrGotLdr	Lloh213, Lloh214, Lloh215
	.loh AdrpAdd	Lloh225, Lloh226
	.loh AdrpAdd	Lloh223, Lloh224
	.loh AdrpLdrGotLdr	Lloh220, Lloh221, Lloh222
	.loh AdrpAdd	Lloh232, Lloh233
	.loh AdrpAdd	Lloh230, Lloh231
	.loh AdrpLdrGotLdr	Lloh227, Lloh228, Lloh229
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
	cbz	w0, LBB12_2
; %bb.1:
	mov	x0, x22
	mov	x1, x20
	mov	x2, x21
	mov	x3, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_direct_karatsuba
LBB12_2:
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
Lloh234:
	adrp	x4, _square_recursive@PAGE
Lloh235:
	add	x4, x4, _square_recursive@PAGEOFF
	b	_midpoint
	.loh AdrpAdd	Lloh234, Lloh235
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mid_set_bits
_mid_set_bits:                          ; @mid_set_bits
	.cfi_startproc
; %bb.0:
Lloh236:
	adrp	x4, _square_set_bits@PAGE
Lloh237:
	add	x4, x4, _square_set_bits@PAGEOFF
	b	_midpoint
	.loh AdrpAdd	Lloh236, Lloh237
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mid_prefix
_mid_prefix:                            ; @mid_prefix
	.cfi_startproc
; %bb.0:
Lloh238:
	adrp	x4, _square_prefix@PAGE
Lloh239:
	add	x4, x4, _square_prefix@PAGEOFF
	b	_midpoint
	.loh AdrpAdd	Lloh238, Lloh239
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
	cbz	x0, LBB18_11
; %bb.1:
	mov	x26, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB18_11
; %bb.2:
	mov	x23, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB18_11
; %bb.3:
	mov	x25, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB18_11
; %bb.4:
	mov	x24, x0
	mov	x0, x26
	mov	x1, x27
	mov	x2, x21
	bl	_BN_sub
	cbz	w0, LBB18_12
; %bb.5:
	mov	x0, x26
	bl	_BN_is_odd
	mov	x27, x0
	mov	x0, x23
	mov	x1, x26
	bl	_BN_rshift1
	cbz	w0, LBB18_13
; %bb.6:
	mov	x0, x25
	mov	x1, x21
	mov	x2, x23
	bl	_BN_add
	cbz	w0, LBB18_14
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
	cbz	w0, LBB18_16
; %bb.8:
	cbz	w27, LBB18_10
; %bb.9:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x21
	bl	_BN_add
	cbz	w0, LBB18_17
LBB18_10:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	b	_BN_CTX_end
LBB18_11:
Lloh240:
	adrp	x8, ___stderrp@GOTPAGE
Lloh241:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh242:
	ldr	x0, [x8]
Lloh243:
	adrp	x8, l_.str.52@PAGE
Lloh244:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh245:
	adrp	x1, l_.str.6@PAGE
Lloh246:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB18_12:
Lloh247:
	adrp	x8, ___stderrp@GOTPAGE
Lloh248:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh249:
	ldr	x0, [x8]
Lloh250:
	adrp	x8, l_.str.47@PAGE
Lloh251:
	add	x8, x8, l_.str.47@PAGEOFF
	mov	w9, #149                        ; =0x95
	stp	x9, x8, [sp]
Lloh252:
	adrp	x1, l_.str.6@PAGE
Lloh253:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB18_13:
Lloh254:
	adrp	x8, ___stderrp@GOTPAGE
Lloh255:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh256:
	ldr	x0, [x8]
Lloh257:
	adrp	x8, l_.str.48@PAGE
Lloh258:
	add	x8, x8, l_.str.48@PAGEOFF
	b	LBB18_15
LBB18_14:
Lloh259:
	adrp	x8, ___stderrp@GOTPAGE
Lloh260:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh261:
	ldr	x0, [x8]
Lloh262:
	adrp	x8, l_.str.49@PAGE
Lloh263:
	add	x8, x8, l_.str.49@PAGEOFF
LBB18_15:
	mov	w9, #151                        ; =0x97
	stp	x9, x8, [sp]
Lloh264:
	adrp	x1, l_.str.6@PAGE
Lloh265:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB18_16:
Lloh266:
	adrp	x8, ___stderrp@GOTPAGE
Lloh267:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh268:
	ldr	x0, [x8]
Lloh269:
	adrp	x8, l_.str.50@PAGE
Lloh270:
	add	x8, x8, l_.str.50@PAGEOFF
	mov	w9, #153                        ; =0x99
	stp	x9, x8, [sp]
Lloh271:
	adrp	x1, l_.str.6@PAGE
Lloh272:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB18_17:
Lloh273:
	adrp	x8, ___stderrp@GOTPAGE
Lloh274:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh275:
	ldr	x0, [x8]
Lloh276:
	adrp	x8, l_.str.51@PAGE
Lloh277:
	add	x8, x8, l_.str.51@PAGEOFF
	mov	w9, #154                        ; =0x9a
	stp	x9, x8, [sp]
Lloh278:
	adrp	x1, l_.str.6@PAGE
Lloh279:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh245, Lloh246
	.loh AdrpAdd	Lloh243, Lloh244
	.loh AdrpLdrGotLdr	Lloh240, Lloh241, Lloh242
	.loh AdrpAdd	Lloh252, Lloh253
	.loh AdrpAdd	Lloh250, Lloh251
	.loh AdrpLdrGotLdr	Lloh247, Lloh248, Lloh249
	.loh AdrpAdd	Lloh257, Lloh258
	.loh AdrpLdrGotLdr	Lloh254, Lloh255, Lloh256
	.loh AdrpAdd	Lloh262, Lloh263
	.loh AdrpLdrGotLdr	Lloh259, Lloh260, Lloh261
	.loh AdrpAdd	Lloh264, Lloh265
	.loh AdrpAdd	Lloh271, Lloh272
	.loh AdrpAdd	Lloh269, Lloh270
	.loh AdrpLdrGotLdr	Lloh266, Lloh267, Lloh268
	.loh AdrpAdd	Lloh278, Lloh279
	.loh AdrpAdd	Lloh276, Lloh277
	.loh AdrpLdrGotLdr	Lloh273, Lloh274, Lloh275
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
	cbz	x0, LBB19_11
; %bb.1:
	mov	x23, x0
	mov	x0, x22
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB19_12
; %bb.2:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB19_9
; %bb.3:
	mov	x24, x0
	mov	w25, #0                         ; =0x0
	b	LBB19_5
LBB19_4:                                ;   in Loop: Header=BB19_5 Depth=1
	add	w25, w25, #1
	cmp	w24, w25
	b.eq	LBB19_9
LBB19_5:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x20
	mov	x1, x25
	bl	_BN_is_bit_set
	cbz	w0, LBB19_4
; %bb.6:                                ;   in Loop: Header=BB19_5 Depth=1
	mov	x0, x23
	mov	x1, x21
	mov	x2, x25
	bl	_BN_lshift
	cbz	w0, LBB19_10
; %bb.7:                                ;   in Loop: Header=BB19_5 Depth=1
	mov	x0, x22
	mov	x1, x22
	mov	x2, x23
	bl	_BN_add
	cbnz	w0, LBB19_4
; %bb.8:
	bl	_shift_add_selected.cold.1
LBB19_9:
	mov	x0, x19
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_BN_CTX_end
LBB19_10:
	bl	_shift_add_selected.cold.2
LBB19_11:
	bl	_shift_add_selected.cold.4
LBB19_12:
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
	cbz	x0, LBB20_4
; %bb.1:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, w19
	b.le	LBB20_3
; %bb.2:
	mov	x0, x20
	mov	x1, x19
	bl	_BN_mask_bits
	cbz	w0, LBB20_5
LBB20_3:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB20_4:
	bl	_low_bits.cold.2
LBB20_5:
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
	mov	x26, x1
	mov	x19, x0
	mov	x0, x1
	bl	_BN_num_bits
	cmp	w0, #8
	b.gt	LBB21_3
; %bb.1:
	mov	x0, x26
	bl	_BN_get_word
Lloh280:
	adrp	x8, __MergedGlobals@PAGE
Lloh281:
	add	x8, x8, __MergedGlobals@PAGEOFF
	add	x8, x8, x0, lsl #1
	ldrh	w1, [x8, #8]
	mov	x0, x19
	bl	_BN_set_word
	cbnz	w0, LBB21_5
; %bb.2:
Lloh282:
	adrp	x8, ___stderrp@GOTPAGE
Lloh283:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh284:
	ldr	x0, [x8]
Lloh285:
	adrp	x8, l_.str.70@PAGE
Lloh286:
	add	x8, x8, l_.str.70@PAGEOFF
	mov	w9, #121                        ; =0x79
	stp	x9, x8, [sp]
Lloh287:
	adrp	x1, l_.str.6@PAGE
Lloh288:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_3:
	mov	x21, x0
	cmp	w0, #32
	b.hi	LBB21_6
; %bb.4:
	mov	x0, x26
	bl	_BN_get_word
                                        ; kill: def $w0 killed $w0 killed $x0
	bl	_scalar_square32
	mov	x1, x0
	mov	x0, x19
	bl	_BN_set_word
	cbz	w0, LBB21_26
LBB21_5:
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
LBB21_6:
	mov	x0, x20
	bl	_BN_CTX_start
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB21_25
; %bb.7:
	mov	x25, x0
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB21_25
; %bb.8:
	mov	x27, x0
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB21_25
; %bb.9:
	mov	x24, x0
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB21_25
; %bb.10:
	mov	x23, x0
	mov	x0, x20
	bl	_BN_CTX_get
	str	x0, [sp, #24]                   ; 8-byte Folded Spill
	cbz	x0, LBB21_25
; %bb.11:
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB21_25
; %bb.12:
	mov	x22, x0
	str	x24, [sp, #16]                  ; 8-byte Folded Spill
	mov	x0, x20
	bl	_BN_CTX_get
	cbz	x0, LBB21_25
; %bb.13:
	mov	x24, x0
	lsr	w28, w21, #1
	mov	x0, x25
	mov	x1, x26
	mov	x2, x28
	bl	_BN_rshift
	cbz	w0, LBB21_27
; %bb.14:
	mov	x0, x27
	mov	x1, x26
	mov	x2, x28
	bl	_low_bits
	mov	x0, x25
	mov	x1, x27
	bl	_BN_cmp
	mov	x26, x28
	tbnz	w0, #31, LBB21_23
; %bb.15:
	ldr	x28, [sp, #16]                  ; 8-byte Folded Reload
	mov	x0, x28
	mov	x1, x25
	mov	x2, x27
	bl	_BN_sub
	cbz	w0, LBB21_24
LBB21_16:
	mov	x0, x23
	mov	x1, x25
	mov	x2, x20
	bl	_square_recursive
	ldr	x25, [sp, #24]                  ; 8-byte Folded Reload
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
	cbz	w0, LBB21_28
; %bb.17:
	mov	x0, x24
	mov	x1, x24
	mov	x2, x22
	bl	_BN_sub
	cbz	w0, LBB21_29
; %bb.18:
	and	w2, w21, #0x7ffffffe
	mov	x0, x19
	mov	x1, x23
	bl	_BN_lshift
	cbz	w0, LBB21_31
; %bb.19:
	mov	x0, x24
	mov	x1, x24
	mov	x2, x26
	bl	_BN_lshift
	cbz	w0, LBB21_32
; %bb.20:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x24
	bl	_BN_add
	cbz	w0, LBB21_33
; %bb.21:
	mov	x0, x19
	mov	x1, x19
	mov	x2, x25
	bl	_BN_add
	cbz	w0, LBB21_34
; %bb.22:
	mov	x0, x20
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #128
	b	_BN_CTX_end
LBB21_23:
	ldr	x28, [sp, #16]                  ; 8-byte Folded Reload
	mov	x0, x28
	mov	x1, x27
	mov	x2, x25
	bl	_BN_sub
	cbnz	w0, LBB21_16
LBB21_24:
Lloh289:
	adrp	x8, ___stderrp@GOTPAGE
Lloh290:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh291:
	ldr	x0, [x8]
Lloh292:
	adrp	x8, l_.str.69@PAGE
Lloh293:
	add	x8, x8, l_.str.69@PAGEOFF
	mov	w9, #61                         ; =0x3d
	stp	x9, x8, [sp]
Lloh294:
	adrp	x1, l_.str.6@PAGE
Lloh295:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_25:
Lloh296:
	adrp	x8, ___stderrp@GOTPAGE
Lloh297:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh298:
	ldr	x0, [x8]
Lloh299:
	adrp	x8, l_.str.52@PAGE
Lloh300:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh301:
	adrp	x1, l_.str.6@PAGE
Lloh302:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_26:
Lloh303:
	adrp	x8, ___stderrp@GOTPAGE
Lloh304:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh305:
	ldr	x0, [x8]
Lloh306:
	adrp	x8, l_.str.71@PAGE
Lloh307:
	add	x8, x8, l_.str.71@PAGEOFF
	mov	w9, #123                        ; =0x7b
	stp	x9, x8, [sp]
Lloh308:
	adrp	x1, l_.str.6@PAGE
Lloh309:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_27:
Lloh310:
	adrp	x8, ___stderrp@GOTPAGE
Lloh311:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh312:
	ldr	x0, [x8]
Lloh313:
	adrp	x8, l_.str.72@PAGE
Lloh314:
	add	x8, x8, l_.str.72@PAGEOFF
	mov	w9, #129                        ; =0x81
	stp	x9, x8, [sp]
Lloh315:
	adrp	x1, l_.str.6@PAGE
Lloh316:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_28:
Lloh317:
	adrp	x8, ___stderrp@GOTPAGE
Lloh318:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh319:
	ldr	x0, [x8]
Lloh320:
	adrp	x8, l_.str.61@PAGE
Lloh321:
	add	x8, x8, l_.str.61@PAGEOFF
	b	LBB21_30
LBB21_29:
Lloh322:
	adrp	x8, ___stderrp@GOTPAGE
Lloh323:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh324:
	ldr	x0, [x8]
Lloh325:
	adrp	x8, l_.str.73@PAGE
Lloh326:
	add	x8, x8, l_.str.73@PAGEOFF
LBB21_30:
	mov	w9, #133                        ; =0x85
	stp	x9, x8, [sp]
Lloh327:
	adrp	x1, l_.str.6@PAGE
Lloh328:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_31:
Lloh329:
	adrp	x8, ___stderrp@GOTPAGE
Lloh330:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh331:
	ldr	x0, [x8]
Lloh332:
	adrp	x8, l_.str.74@PAGE
Lloh333:
	add	x8, x8, l_.str.74@PAGEOFF
	mov	w9, #134                        ; =0x86
	stp	x9, x8, [sp]
Lloh334:
	adrp	x1, l_.str.6@PAGE
Lloh335:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_32:
Lloh336:
	adrp	x8, ___stderrp@GOTPAGE
Lloh337:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh338:
	ldr	x0, [x8]
Lloh339:
	adrp	x8, l_.str.64@PAGE
Lloh340:
	add	x8, x8, l_.str.64@PAGEOFF
	mov	w9, #134                        ; =0x86
	stp	x9, x8, [sp]
Lloh341:
	adrp	x1, l_.str.6@PAGE
Lloh342:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_33:
Lloh343:
	adrp	x8, ___stderrp@GOTPAGE
Lloh344:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh345:
	ldr	x0, [x8]
Lloh346:
	adrp	x8, l_.str.65@PAGE
Lloh347:
	add	x8, x8, l_.str.65@PAGEOFF
	mov	w9, #135                        ; =0x87
	stp	x9, x8, [sp]
Lloh348:
	adrp	x1, l_.str.6@PAGE
Lloh349:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB21_34:
Lloh350:
	adrp	x8, ___stderrp@GOTPAGE
Lloh351:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh352:
	ldr	x0, [x8]
Lloh353:
	adrp	x8, l_.str.66@PAGE
Lloh354:
	add	x8, x8, l_.str.66@PAGEOFF
	mov	w9, #135                        ; =0x87
	stp	x9, x8, [sp]
Lloh355:
	adrp	x1, l_.str.6@PAGE
Lloh356:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh280, Lloh281
	.loh AdrpAdd	Lloh287, Lloh288
	.loh AdrpAdd	Lloh285, Lloh286
	.loh AdrpLdrGotLdr	Lloh282, Lloh283, Lloh284
	.loh AdrpAdd	Lloh294, Lloh295
	.loh AdrpAdd	Lloh292, Lloh293
	.loh AdrpLdrGotLdr	Lloh289, Lloh290, Lloh291
	.loh AdrpAdd	Lloh301, Lloh302
	.loh AdrpAdd	Lloh299, Lloh300
	.loh AdrpLdrGotLdr	Lloh296, Lloh297, Lloh298
	.loh AdrpAdd	Lloh308, Lloh309
	.loh AdrpAdd	Lloh306, Lloh307
	.loh AdrpLdrGotLdr	Lloh303, Lloh304, Lloh305
	.loh AdrpAdd	Lloh315, Lloh316
	.loh AdrpAdd	Lloh313, Lloh314
	.loh AdrpLdrGotLdr	Lloh310, Lloh311, Lloh312
	.loh AdrpAdd	Lloh320, Lloh321
	.loh AdrpLdrGotLdr	Lloh317, Lloh318, Lloh319
	.loh AdrpAdd	Lloh325, Lloh326
	.loh AdrpLdrGotLdr	Lloh322, Lloh323, Lloh324
	.loh AdrpAdd	Lloh327, Lloh328
	.loh AdrpAdd	Lloh334, Lloh335
	.loh AdrpAdd	Lloh332, Lloh333
	.loh AdrpLdrGotLdr	Lloh329, Lloh330, Lloh331
	.loh AdrpAdd	Lloh341, Lloh342
	.loh AdrpAdd	Lloh339, Lloh340
	.loh AdrpLdrGotLdr	Lloh336, Lloh337, Lloh338
	.loh AdrpAdd	Lloh348, Lloh349
	.loh AdrpAdd	Lloh346, Lloh347
	.loh AdrpLdrGotLdr	Lloh343, Lloh344, Lloh345
	.loh AdrpAdd	Lloh355, Lloh356
	.loh AdrpAdd	Lloh353, Lloh354
	.loh AdrpLdrGotLdr	Lloh350, Lloh351, Lloh352
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
	cbz	x0, LBB22_18
; %bb.1:
	mov	x22, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB22_18
; %bb.2:
	mov	x23, x0
	mov	x0, x22
	mov	x1, x20
	bl	_BN_copy
	cbz	x0, LBB22_19
; %bb.3:
	mov	x0, x21
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB22_20
; %bb.4:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB22_14
; %bb.5:
	mov	x24, x0
	mov	w25, #0                         ; =0x0
	b	LBB22_8
LBB22_6:                                ;   in Loop: Header=BB22_8 Depth=1
	add	w25, w25, #1
LBB22_7:                                ;   in Loop: Header=BB22_8 Depth=1
	cmp	w25, w24
	b.eq	LBB22_14
LBB22_8:                                ; =>This Inner Loop Header: Depth=1
	mov	x0, x20
	mov	x1, x25
	bl	_BN_is_bit_set
	cbz	w0, LBB22_6
; %bb.9:                                ;   in Loop: Header=BB22_8 Depth=1
	mov	x0, x22
	mov	x1, x25
	bl	_BN_clear_bit
	cbz	w0, LBB22_17
; %bb.10:                               ;   in Loop: Header=BB22_8 Depth=1
	add	w26, w25, #1
	mov	x0, x23
	mov	x1, x22
	mov	x2, x26
	bl	_BN_lshift
	cbz	w0, LBB22_15
; %bb.11:                               ;   in Loop: Header=BB22_8 Depth=1
	lsl	w1, w25, #1
	mov	x0, x23
	bl	_BN_set_bit
	cbz	w0, LBB22_16
; %bb.12:                               ;   in Loop: Header=BB22_8 Depth=1
	mov	x0, x21
	mov	x1, x21
	mov	x2, x23
	bl	_BN_add
	mov	x25, x26
	cbnz	w0, LBB22_7
; %bb.13:
Lloh357:
	adrp	x8, ___stderrp@GOTPAGE
Lloh358:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh359:
	ldr	x0, [x8]
Lloh360:
	adrp	x8, l_.str.56@PAGE
Lloh361:
	add	x8, x8, l_.str.56@PAGEOFF
	mov	w9, #114                        ; =0x72
	stp	x9, x8, [sp]
Lloh362:
	adrp	x1, l_.str.6@PAGE
Lloh363:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB22_14:
	mov	x0, x19
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	b	_BN_CTX_end
LBB22_15:
Lloh364:
	adrp	x8, ___stderrp@GOTPAGE
Lloh365:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh366:
	ldr	x0, [x8]
Lloh367:
	adrp	x8, l_.str.77@PAGE
Lloh368:
	add	x8, x8, l_.str.77@PAGEOFF
	mov	w9, #112                        ; =0x70
	stp	x9, x8, [sp]
Lloh369:
	adrp	x1, l_.str.6@PAGE
Lloh370:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB22_16:
Lloh371:
	adrp	x8, ___stderrp@GOTPAGE
Lloh372:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh373:
	ldr	x0, [x8]
Lloh374:
	adrp	x8, l_.str.78@PAGE
Lloh375:
	add	x8, x8, l_.str.78@PAGEOFF
	mov	w9, #113                        ; =0x71
	stp	x9, x8, [sp]
Lloh376:
	adrp	x1, l_.str.6@PAGE
Lloh377:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB22_17:
Lloh378:
	adrp	x8, ___stderrp@GOTPAGE
Lloh379:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh380:
	ldr	x0, [x8]
Lloh381:
	adrp	x8, l_.str.76@PAGE
Lloh382:
	add	x8, x8, l_.str.76@PAGEOFF
	mov	w9, #111                        ; =0x6f
	stp	x9, x8, [sp]
Lloh383:
	adrp	x1, l_.str.6@PAGE
Lloh384:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB22_18:
Lloh385:
	adrp	x8, ___stderrp@GOTPAGE
Lloh386:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh387:
	ldr	x0, [x8]
Lloh388:
	adrp	x8, l_.str.52@PAGE
Lloh389:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh390:
	adrp	x1, l_.str.6@PAGE
Lloh391:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB22_19:
Lloh392:
	adrp	x8, ___stderrp@GOTPAGE
Lloh393:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh394:
	ldr	x0, [x8]
Lloh395:
	adrp	x8, l_.str.75@PAGE
Lloh396:
	add	x8, x8, l_.str.75@PAGEOFF
	mov	w9, #107                        ; =0x6b
	stp	x9, x8, [sp]
Lloh397:
	adrp	x1, l_.str.6@PAGE
Lloh398:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB22_20:
Lloh399:
	adrp	x8, ___stderrp@GOTPAGE
Lloh400:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh401:
	ldr	x0, [x8]
Lloh402:
	adrp	x8, l_.str.54@PAGE
Lloh403:
	add	x8, x8, l_.str.54@PAGEOFF
	mov	w9, #107                        ; =0x6b
	stp	x9, x8, [sp]
Lloh404:
	adrp	x1, l_.str.6@PAGE
Lloh405:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh362, Lloh363
	.loh AdrpAdd	Lloh360, Lloh361
	.loh AdrpLdrGotLdr	Lloh357, Lloh358, Lloh359
	.loh AdrpAdd	Lloh369, Lloh370
	.loh AdrpAdd	Lloh367, Lloh368
	.loh AdrpLdrGotLdr	Lloh364, Lloh365, Lloh366
	.loh AdrpAdd	Lloh376, Lloh377
	.loh AdrpAdd	Lloh374, Lloh375
	.loh AdrpLdrGotLdr	Lloh371, Lloh372, Lloh373
	.loh AdrpAdd	Lloh383, Lloh384
	.loh AdrpAdd	Lloh381, Lloh382
	.loh AdrpLdrGotLdr	Lloh378, Lloh379, Lloh380
	.loh AdrpAdd	Lloh390, Lloh391
	.loh AdrpAdd	Lloh388, Lloh389
	.loh AdrpLdrGotLdr	Lloh385, Lloh386, Lloh387
	.loh AdrpAdd	Lloh397, Lloh398
	.loh AdrpAdd	Lloh395, Lloh396
	.loh AdrpLdrGotLdr	Lloh392, Lloh393, Lloh394
	.loh AdrpAdd	Lloh404, Lloh405
	.loh AdrpAdd	Lloh402, Lloh403
	.loh AdrpLdrGotLdr	Lloh399, Lloh400, Lloh401
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
	cbz	x0, LBB23_22
; %bb.1:
	mov	x22, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB23_22
; %bb.2:
	mov	x23, x0
	mov	x0, x22
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB23_23
; %bb.3:
	mov	x0, x21
	mov	x1, #0                          ; =0x0
	bl	_BN_set_word
	cbz	w0, LBB23_24
; %bb.4:
	mov	x0, x20
	bl	_BN_num_bits
	cmp	w0, #1
	b.lt	LBB23_16
; %bb.5:
	add	w25, w0, #1
	b	LBB23_8
LBB23_6:                                ;   in Loop: Header=BB23_8 Depth=1
	mov	x0, x22
	mov	x1, x22
	bl	_BN_lshift1
	cbz	w0, LBB23_18
LBB23_7:                                ;   in Loop: Header=BB23_8 Depth=1
	sub	w25, w25, #1
	cmp	w25, #1
	b.ls	LBB23_16
LBB23_8:                                ; =>This Inner Loop Header: Depth=1
	sub	w1, w25, #2
	mov	x0, x20
	bl	_BN_is_bit_set
	mov	x24, x0
	mov	x0, x21
	mov	x1, x21
	mov	w2, #2                          ; =0x2
	bl	_BN_lshift
	cbz	w0, LBB23_17
; %bb.9:                                ;   in Loop: Header=BB23_8 Depth=1
	cbz	w24, LBB23_6
; %bb.10:                               ;   in Loop: Header=BB23_8 Depth=1
	mov	x0, x23
	mov	x1, x22
	mov	w2, #2                          ; =0x2
	bl	_BN_lshift
	cbz	w0, LBB23_19
; %bb.11:                               ;   in Loop: Header=BB23_8 Depth=1
	mov	x0, x23
	mov	w1, #1                          ; =0x1
	bl	_BN_add_word
	cbz	w0, LBB23_20
; %bb.12:                               ;   in Loop: Header=BB23_8 Depth=1
	mov	x0, x21
	mov	x1, x21
	mov	x2, x23
	bl	_BN_add
	cbz	w0, LBB23_21
; %bb.13:                               ;   in Loop: Header=BB23_8 Depth=1
	mov	x0, x22
	mov	x1, x22
	bl	_BN_lshift1
	cbz	w0, LBB23_18
; %bb.14:                               ;   in Loop: Header=BB23_8 Depth=1
	mov	x0, x22
	mov	w1, #1                          ; =0x1
	bl	_BN_add_word
	cbnz	w0, LBB23_7
; %bb.15:
Lloh406:
	adrp	x8, ___stderrp@GOTPAGE
Lloh407:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh408:
	ldr	x0, [x8]
Lloh409:
	adrp	x8, l_.str.84@PAGE
Lloh410:
	add	x8, x8, l_.str.84@PAGEOFF
	mov	w9, #99                         ; =0x63
	stp	x9, x8, [sp]
Lloh411:
	adrp	x1, l_.str.6@PAGE
Lloh412:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_16:
	mov	x0, x19
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	b	_BN_CTX_end
LBB23_17:
Lloh413:
	adrp	x8, ___stderrp@GOTPAGE
Lloh414:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh415:
	ldr	x0, [x8]
Lloh416:
	adrp	x8, l_.str.80@PAGE
Lloh417:
	add	x8, x8, l_.str.80@PAGEOFF
	mov	w9, #93                         ; =0x5d
	stp	x9, x8, [sp]
Lloh418:
	adrp	x1, l_.str.6@PAGE
Lloh419:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_18:
Lloh420:
	adrp	x8, ___stderrp@GOTPAGE
Lloh421:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh422:
	ldr	x0, [x8]
Lloh423:
	adrp	x8, l_.str.83@PAGE
Lloh424:
	add	x8, x8, l_.str.83@PAGEOFF
	mov	w9, #98                         ; =0x62
	stp	x9, x8, [sp]
Lloh425:
	adrp	x1, l_.str.6@PAGE
Lloh426:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_19:
Lloh427:
	adrp	x8, ___stderrp@GOTPAGE
Lloh428:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh429:
	ldr	x0, [x8]
Lloh430:
	adrp	x8, l_.str.81@PAGE
Lloh431:
	add	x8, x8, l_.str.81@PAGEOFF
	mov	w9, #95                         ; =0x5f
	stp	x9, x8, [sp]
Lloh432:
	adrp	x1, l_.str.6@PAGE
Lloh433:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_20:
Lloh434:
	adrp	x8, ___stderrp@GOTPAGE
Lloh435:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh436:
	ldr	x0, [x8]
Lloh437:
	adrp	x8, l_.str.82@PAGE
Lloh438:
	add	x8, x8, l_.str.82@PAGEOFF
	mov	w9, #96                         ; =0x60
	stp	x9, x8, [sp]
Lloh439:
	adrp	x1, l_.str.6@PAGE
Lloh440:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_21:
Lloh441:
	adrp	x8, ___stderrp@GOTPAGE
Lloh442:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh443:
	ldr	x0, [x8]
Lloh444:
	adrp	x8, l_.str.56@PAGE
Lloh445:
	add	x8, x8, l_.str.56@PAGEOFF
	mov	w9, #96                         ; =0x60
	stp	x9, x8, [sp]
Lloh446:
	adrp	x1, l_.str.6@PAGE
Lloh447:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_22:
Lloh448:
	adrp	x8, ___stderrp@GOTPAGE
Lloh449:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh450:
	ldr	x0, [x8]
Lloh451:
	adrp	x8, l_.str.52@PAGE
Lloh452:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh453:
	adrp	x1, l_.str.6@PAGE
Lloh454:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_23:
Lloh455:
	adrp	x8, ___stderrp@GOTPAGE
Lloh456:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh457:
	ldr	x0, [x8]
Lloh458:
	adrp	x8, l_.str.79@PAGE
Lloh459:
	add	x8, x8, l_.str.79@PAGEOFF
	mov	w9, #90                         ; =0x5a
	stp	x9, x8, [sp]
Lloh460:
	adrp	x1, l_.str.6@PAGE
Lloh461:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB23_24:
Lloh462:
	adrp	x8, ___stderrp@GOTPAGE
Lloh463:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh464:
	ldr	x0, [x8]
Lloh465:
	adrp	x8, l_.str.54@PAGE
Lloh466:
	add	x8, x8, l_.str.54@PAGEOFF
	mov	w9, #90                         ; =0x5a
	stp	x9, x8, [sp]
Lloh467:
	adrp	x1, l_.str.6@PAGE
Lloh468:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh411, Lloh412
	.loh AdrpAdd	Lloh409, Lloh410
	.loh AdrpLdrGotLdr	Lloh406, Lloh407, Lloh408
	.loh AdrpAdd	Lloh418, Lloh419
	.loh AdrpAdd	Lloh416, Lloh417
	.loh AdrpLdrGotLdr	Lloh413, Lloh414, Lloh415
	.loh AdrpAdd	Lloh425, Lloh426
	.loh AdrpAdd	Lloh423, Lloh424
	.loh AdrpLdrGotLdr	Lloh420, Lloh421, Lloh422
	.loh AdrpAdd	Lloh432, Lloh433
	.loh AdrpAdd	Lloh430, Lloh431
	.loh AdrpLdrGotLdr	Lloh427, Lloh428, Lloh429
	.loh AdrpAdd	Lloh439, Lloh440
	.loh AdrpAdd	Lloh437, Lloh438
	.loh AdrpLdrGotLdr	Lloh434, Lloh435, Lloh436
	.loh AdrpAdd	Lloh446, Lloh447
	.loh AdrpAdd	Lloh444, Lloh445
	.loh AdrpLdrGotLdr	Lloh441, Lloh442, Lloh443
	.loh AdrpAdd	Lloh453, Lloh454
	.loh AdrpAdd	Lloh451, Lloh452
	.loh AdrpLdrGotLdr	Lloh448, Lloh449, Lloh450
	.loh AdrpAdd	Lloh460, Lloh461
	.loh AdrpAdd	Lloh458, Lloh459
	.loh AdrpLdrGotLdr	Lloh455, Lloh456, Lloh457
	.loh AdrpAdd	Lloh467, Lloh468
	.loh AdrpAdd	Lloh465, Lloh466
	.loh AdrpLdrGotLdr	Lloh462, Lloh463, Lloh464
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
	cbz	x0, LBB24_10
; %bb.1:
	mov	x23, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB24_11
; %bb.2:
	mov	x22, x0
	mov	x0, x23
	mov	x1, x25
	mov	x2, x21
	bl	_BN_sub
	cbz	w0, LBB24_12
; %bb.3:
	mov	x0, x20
	mov	x1, x21
	mov	x2, x19
	cbz	w24, LBB24_8
; %bb.4:
	bl	_BN_sqr
	cbz	w0, LBB24_13
; %bb.5:
	mov	x0, x22
	mov	x1, x21
	mov	x2, x23
	mov	x3, x19
	bl	_BN_mul
	cbz	w0, LBB24_14
; %bb.6:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x22
	bl	_BN_add
	cbz	w0, LBB24_9
LBB24_7:
	mov	x0, x19
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_BN_CTX_end
LBB24_8:
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
	cbnz	w0, LBB24_7
LBB24_9:
	bl	_near_identity.cold.3
LBB24_10:
	bl	_near_identity.cold.6
LBB24_11:
	bl	_near_identity.cold.5
LBB24_12:
	bl	_near_identity.cold.4
LBB24_13:
	bl	_near_identity.cold.2
LBB24_14:
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
	cbz	x0, LBB25_8
; %bb.1:
	mov	x20, x0
	asr	w1, w22, #3
	cmp	w1, #1
	b.lt	LBB25_5
; %bb.2:
	mov	x9, #0                          ; =0x0
	adrp	x8, _rng_state@PAGE
	ldr	x10, [x8, _rng_state@PAGEOFF]
LBB25_3:                                ; =>This Inner Loop Header: Depth=1
	eor	x10, x10, x10, lsl #13
	eor	x11, x10, x10, lsr #7
	eor	x10, x11, x11, lsl #17
	strb	w11, [x20, x9]
	add	x9, x9, #1
	cmp	x1, x9
	b.ne	LBB25_3
; %bb.4:
	str	x10, [x8, _rng_state@PAGEOFF]
	ldrb	w8, [x20]
	b	LBB25_6
LBB25_5:
                                        ; implicit-def: $w8
LBB25_6:
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
	cbz	x0, LBB25_9
; %bb.7:
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_free
LBB25_8:
	bl	_random_bits.cold.2
LBB25_9:
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
	cbnz	w0, LBB26_5
; %bb.1:
	ldp	x25, x24, [sp]
	mov	x26, #0                         ; =0x0
	cbz	w21, LBB26_3
LBB26_2:                                ; =>This Inner Loop Header: Depth=1
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
	b.ne	LBB26_2
LBB26_3:
	mov	x1, sp
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB26_6
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
LBB26_5:
	bl	_run_batch.cold.1
LBB26_6:
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
	cbz	x0, LBB28_13
; %bb.1:
	mov	x26, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB28_13
; %bb.2:
	mov	x22, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB28_13
; %bb.3:
	mov	x24, x0
	mov	x0, x19
	bl	_BN_CTX_get
	cbz	x0, LBB28_13
; %bb.4:
	mov	x23, x0
	mov	x0, x26
	mov	x1, x25
	mov	x2, x21
	bl	_BN_sub
	cbz	w0, LBB28_15
; %bb.5:
	mov	x0, x26
	bl	_BN_is_odd
	mov	x25, x0
	mov	x0, x22
	mov	x1, x26
	bl	_BN_rshift1
	cbz	w0, LBB28_16
; %bb.6:
	mov	x0, x24
	mov	x1, x21
	mov	x2, x22
	bl	_BN_add
	cbz	w0, LBB28_17
; %bb.7:
	mov	x0, x20
	mov	x1, x24
	mov	x2, x19
	bl	_BN_sqr
	cbz	w0, LBB28_14
; %bb.8:
	mov	x0, x23
	mov	x1, x22
	mov	x2, x19
	bl	_BN_sqr
	cbz	w0, LBB28_14
; %bb.9:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x23
	bl	_BN_sub
	cbz	w0, LBB28_19
; %bb.10:
	cbz	w25, LBB28_12
; %bb.11:
	mov	x0, x20
	mov	x1, x20
	mov	x2, x21
	bl	_BN_add
	cbz	w0, LBB28_20
LBB28_12:
	mov	x0, x19
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #96
	b	_BN_CTX_end
LBB28_13:
Lloh469:
	adrp	x8, ___stderrp@GOTPAGE
Lloh470:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh471:
	ldr	x0, [x8]
Lloh472:
	adrp	x8, l_.str.52@PAGE
Lloh473:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh474:
	adrp	x1, l_.str.6@PAGE
Lloh475:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB28_14:
Lloh476:
	adrp	x8, ___stderrp@GOTPAGE
Lloh477:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh478:
	ldr	x0, [x8]
Lloh479:
	adrp	x8, l_.str.53@PAGE
Lloh480:
	add	x8, x8, l_.str.53@PAGEOFF
	mov	w9, #140                        ; =0x8c
	stp	x9, x8, [sp]
Lloh481:
	adrp	x1, l_.str.6@PAGE
Lloh482:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB28_15:
Lloh483:
	adrp	x8, ___stderrp@GOTPAGE
Lloh484:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh485:
	ldr	x0, [x8]
Lloh486:
	adrp	x8, l_.str.47@PAGE
Lloh487:
	add	x8, x8, l_.str.47@PAGEOFF
	mov	w9, #149                        ; =0x95
	stp	x9, x8, [sp]
Lloh488:
	adrp	x1, l_.str.6@PAGE
Lloh489:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB28_16:
Lloh490:
	adrp	x8, ___stderrp@GOTPAGE
Lloh491:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh492:
	ldr	x0, [x8]
Lloh493:
	adrp	x8, l_.str.48@PAGE
Lloh494:
	add	x8, x8, l_.str.48@PAGEOFF
	b	LBB28_18
LBB28_17:
Lloh495:
	adrp	x8, ___stderrp@GOTPAGE
Lloh496:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh497:
	ldr	x0, [x8]
Lloh498:
	adrp	x8, l_.str.49@PAGE
Lloh499:
	add	x8, x8, l_.str.49@PAGEOFF
LBB28_18:
	mov	w9, #151                        ; =0x97
	stp	x9, x8, [sp]
Lloh500:
	adrp	x1, l_.str.6@PAGE
Lloh501:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB28_19:
Lloh502:
	adrp	x8, ___stderrp@GOTPAGE
Lloh503:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh504:
	ldr	x0, [x8]
Lloh505:
	adrp	x8, l_.str.50@PAGE
Lloh506:
	add	x8, x8, l_.str.50@PAGEOFF
	mov	w9, #153                        ; =0x99
	stp	x9, x8, [sp]
Lloh507:
	adrp	x1, l_.str.6@PAGE
Lloh508:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
LBB28_20:
Lloh509:
	adrp	x8, ___stderrp@GOTPAGE
Lloh510:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh511:
	ldr	x0, [x8]
Lloh512:
	adrp	x8, l_.str.51@PAGE
Lloh513:
	add	x8, x8, l_.str.51@PAGEOFF
	mov	w9, #154                        ; =0x9a
	stp	x9, x8, [sp]
Lloh514:
	adrp	x1, l_.str.6@PAGE
Lloh515:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh474, Lloh475
	.loh AdrpAdd	Lloh472, Lloh473
	.loh AdrpLdrGotLdr	Lloh469, Lloh470, Lloh471
	.loh AdrpAdd	Lloh481, Lloh482
	.loh AdrpAdd	Lloh479, Lloh480
	.loh AdrpLdrGotLdr	Lloh476, Lloh477, Lloh478
	.loh AdrpAdd	Lloh488, Lloh489
	.loh AdrpAdd	Lloh486, Lloh487
	.loh AdrpLdrGotLdr	Lloh483, Lloh484, Lloh485
	.loh AdrpAdd	Lloh493, Lloh494
	.loh AdrpLdrGotLdr	Lloh490, Lloh491, Lloh492
	.loh AdrpAdd	Lloh498, Lloh499
	.loh AdrpLdrGotLdr	Lloh495, Lloh496, Lloh497
	.loh AdrpAdd	Lloh500, Lloh501
	.loh AdrpAdd	Lloh507, Lloh508
	.loh AdrpAdd	Lloh505, Lloh506
	.loh AdrpLdrGotLdr	Lloh502, Lloh503, Lloh504
	.loh AdrpAdd	Lloh514, Lloh515
	.loh AdrpAdd	Lloh512, Lloh513
	.loh AdrpLdrGotLdr	Lloh509, Lloh510, Lloh511
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
Lloh516:
	adrp	x8, l_.str.7@PAGE
Lloh517:
	add	x8, x8, l_.str.7@PAGEOFF
	mov	w9, #450                        ; =0x1c2
	stp	x9, x8, [sp]
Lloh518:
	adrp	x1, l_.str.6@PAGE
Lloh519:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh518, Lloh519
	.loh AdrpAdd	Lloh516, Lloh517
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
Lloh520:
	adrp	x8, ___stderrp@GOTPAGE
Lloh521:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh522:
	ldr	x0, [x8]
Lloh523:
	adrp	x8, l_.str.16@PAGE
Lloh524:
	add	x8, x8, l_.str.16@PAGEOFF
	mov	w9, #332                        ; =0x14c
	stp	x9, x8, [sp]
Lloh525:
	adrp	x1, l_.str.6@PAGE
Lloh526:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh525, Lloh526
	.loh AdrpAdd	Lloh523, Lloh524
	.loh AdrpLdrGotLdr	Lloh520, Lloh521, Lloh522
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
Lloh527:
	adrp	x8, ___stderrp@GOTPAGE
Lloh528:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh529:
	ldr	x0, [x8]
Lloh530:
	adrp	x8, l_.str.17@PAGE
Lloh531:
	add	x8, x8, l_.str.17@PAGEOFF
	mov	w9, #337                        ; =0x151
	stp	x9, x8, [sp]
Lloh532:
	adrp	x1, l_.str.6@PAGE
Lloh533:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh532, Lloh533
	.loh AdrpAdd	Lloh530, Lloh531
	.loh AdrpLdrGotLdr	Lloh527, Lloh528, Lloh529
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
Lloh534:
	adrp	x8, ___stderrp@GOTPAGE
Lloh535:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh536:
	ldr	x0, [x8]
Lloh537:
	adrp	x8, l_.str.18@PAGE
Lloh538:
	add	x8, x8, l_.str.18@PAGEOFF
	mov	w9, #340                        ; =0x154
	stp	x9, x8, [sp]
Lloh539:
	adrp	x1, l_.str.6@PAGE
Lloh540:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh539, Lloh540
	.loh AdrpAdd	Lloh537, Lloh538
	.loh AdrpLdrGotLdr	Lloh534, Lloh535, Lloh536
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
Lloh541:
	adrp	x8, ___stderrp@GOTPAGE
Lloh542:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh543:
	ldr	x0, [x8]
Lloh544:
	adrp	x8, l_.str.19@PAGE
Lloh545:
	add	x8, x8, l_.str.19@PAGEOFF
	mov	w9, #341                        ; =0x155
	stp	x9, x8, [sp]
Lloh546:
	adrp	x1, l_.str.6@PAGE
Lloh547:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh546, Lloh547
	.loh AdrpAdd	Lloh544, Lloh545
	.loh AdrpLdrGotLdr	Lloh541, Lloh542, Lloh543
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
Lloh548:
	adrp	x8, ___stderrp@GOTPAGE
Lloh549:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh550:
	ldr	x0, [x8]
Lloh551:
	adrp	x8, l_.str.20@PAGE
Lloh552:
	add	x8, x8, l_.str.20@PAGEOFF
	mov	w9, #343                        ; =0x157
	stp	x9, x8, [sp]
Lloh553:
	adrp	x1, l_.str.6@PAGE
Lloh554:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh553, Lloh554
	.loh AdrpAdd	Lloh551, Lloh552
	.loh AdrpLdrGotLdr	Lloh548, Lloh549, Lloh550
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
Lloh555:
	adrp	x8, ___stderrp@GOTPAGE
Lloh556:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh557:
	ldr	x0, [x8]
Lloh558:
	adrp	x8, l_.str.21@PAGE
Lloh559:
	add	x8, x8, l_.str.21@PAGEOFF
	mov	w9, #344                        ; =0x158
	stp	x9, x8, [sp]
Lloh560:
	adrp	x1, l_.str.6@PAGE
Lloh561:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh560, Lloh561
	.loh AdrpAdd	Lloh558, Lloh559
	.loh AdrpLdrGotLdr	Lloh555, Lloh556, Lloh557
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
Lloh562:
	adrp	x8, ___stderrp@GOTPAGE
Lloh563:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh564:
	ldr	x0, [x8]
Lloh565:
	adrp	x8, l_.str.23@PAGE
Lloh566:
	add	x8, x8, l_.str.23@PAGEOFF
	mov	w9, #351                        ; =0x15f
	stp	x9, x8, [sp]
Lloh567:
	adrp	x1, l_.str.6@PAGE
Lloh568:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh567, Lloh568
	.loh AdrpAdd	Lloh565, Lloh566
	.loh AdrpLdrGotLdr	Lloh562, Lloh563, Lloh564
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
Lloh569:
	adrp	x8, ___stderrp@GOTPAGE
Lloh570:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh571:
	ldr	x0, [x8]
Lloh572:
	adrp	x8, l_.str.89@PAGE
Lloh573:
	add	x8, x8, l_.str.89@PAGEOFF
	mov	w9, #286                        ; =0x11e
	stp	x9, x8, [sp]
Lloh574:
	adrp	x1, l_.str.6@PAGE
Lloh575:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh574, Lloh575
	.loh AdrpAdd	Lloh572, Lloh573
	.loh AdrpLdrGotLdr	Lloh569, Lloh570, Lloh571
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
Lloh576:
	adrp	x8, ___stderrp@GOTPAGE
Lloh577:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh578:
	ldr	x0, [x8]
Lloh579:
	adrp	x8, l_.str.89@PAGE
Lloh580:
	add	x8, x8, l_.str.89@PAGEOFF
	mov	w9, #286                        ; =0x11e
	stp	x9, x8, [sp]
Lloh581:
	adrp	x1, l_.str.6@PAGE
Lloh582:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh581, Lloh582
	.loh AdrpAdd	Lloh579, Lloh580
	.loh AdrpLdrGotLdr	Lloh576, Lloh577, Lloh578
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
Lloh583:
	adrp	x8, ___stderrp@GOTPAGE
Lloh584:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh585:
	ldr	x0, [x8]
Lloh586:
	adrp	x8, l_.str.109@PAGE
Lloh587:
	add	x8, x8, l_.str.109@PAGEOFF
	mov	w9, #386                        ; =0x182
	stp	x9, x8, [sp]
Lloh588:
	adrp	x1, l_.str.6@PAGE
Lloh589:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh588, Lloh589
	.loh AdrpAdd	Lloh586, Lloh587
	.loh AdrpLdrGotLdr	Lloh583, Lloh584, Lloh585
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
Lloh590:
	adrp	x8, ___stderrp@GOTPAGE
Lloh591:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh592:
	ldr	x0, [x8]
Lloh593:
	adrp	x8, l_.str.113@PAGE
Lloh594:
	add	x8, x8, l_.str.113@PAGEOFF
	mov	w9, #399                        ; =0x18f
	stp	x9, x8, [sp]
Lloh595:
	adrp	x1, l_.str.6@PAGE
Lloh596:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh595, Lloh596
	.loh AdrpAdd	Lloh593, Lloh594
	.loh AdrpLdrGotLdr	Lloh590, Lloh591, Lloh592
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
Lloh597:
	adrp	x8, ___stderrp@GOTPAGE
Lloh598:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh599:
	ldr	x0, [x8]
Lloh600:
	adrp	x8, l_.str.112@PAGE
Lloh601:
	add	x8, x8, l_.str.112@PAGEOFF
	mov	w9, #396                        ; =0x18c
	stp	x9, x8, [sp]
Lloh602:
	adrp	x1, l_.str.6@PAGE
Lloh603:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh602, Lloh603
	.loh AdrpAdd	Lloh600, Lloh601
	.loh AdrpLdrGotLdr	Lloh597, Lloh598, Lloh599
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
Lloh604:
	adrp	x8, ___stderrp@GOTPAGE
Lloh605:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh606:
	ldr	x0, [x8]
Lloh607:
	adrp	x8, l_.str.111@PAGE
Lloh608:
	add	x8, x8, l_.str.111@PAGEOFF
	mov	w9, #395                        ; =0x18b
	stp	x9, x8, [sp]
Lloh609:
	adrp	x1, l_.str.6@PAGE
Lloh610:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh609, Lloh610
	.loh AdrpAdd	Lloh607, Lloh608
	.loh AdrpLdrGotLdr	Lloh604, Lloh605, Lloh606
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.15
_main.cold.15:                          ; @main.cold.15
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh611:
	adrp	x8, ___stderrp@GOTPAGE
Lloh612:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh613:
	ldr	x0, [x8]
Lloh614:
	adrp	x8, l_.str.14@PAGE
Lloh615:
	add	x8, x8, l_.str.14@PAGEOFF
	mov	w9, #458                        ; =0x1ca
	stp	x9, x8, [sp]
Lloh616:
	adrp	x1, l_.str.6@PAGE
Lloh617:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh616, Lloh617
	.loh AdrpAdd	Lloh614, Lloh615
	.loh AdrpLdrGotLdr	Lloh611, Lloh612, Lloh613
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.16
_main.cold.16:                          ; @main.cold.16
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh618:
	adrp	x8, ___stderrp@GOTPAGE
Lloh619:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh620:
	ldr	x0, [x8]
Lloh621:
	adrp	x8, l_.str.13@PAGE
Lloh622:
	add	x8, x8, l_.str.13@PAGEOFF
	mov	w9, #456                        ; =0x1c8
	stp	x9, x8, [sp]
Lloh623:
	adrp	x1, l_.str.6@PAGE
Lloh624:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh623, Lloh624
	.loh AdrpAdd	Lloh621, Lloh622
	.loh AdrpLdrGotLdr	Lloh618, Lloh619, Lloh620
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.17
_main.cold.17:                          ; @main.cold.17
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh625:
	adrp	x8, ___stderrp@GOTPAGE
Lloh626:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh627:
	ldr	x0, [x8]
Lloh628:
	adrp	x8, l_.str.25@PAGE
Lloh629:
	add	x8, x8, l_.str.25@PAGEOFF
	mov	w9, #355                        ; =0x163
	stp	x9, x8, [sp]
Lloh630:
	adrp	x1, l_.str.6@PAGE
Lloh631:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh630, Lloh631
	.loh AdrpAdd	Lloh628, Lloh629
	.loh AdrpLdrGotLdr	Lloh625, Lloh626, Lloh627
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.18
_main.cold.18:                          ; @main.cold.18
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh632:
	adrp	x8, ___stderrp@GOTPAGE
Lloh633:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh634:
	ldr	x0, [x8]
Lloh635:
	adrp	x8, l_.str.24@PAGE
Lloh636:
	add	x8, x8, l_.str.24@PAGEOFF
	mov	w9, #355                        ; =0x163
	stp	x9, x8, [sp]
Lloh637:
	adrp	x1, l_.str.6@PAGE
Lloh638:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh637, Lloh638
	.loh AdrpAdd	Lloh635, Lloh636
	.loh AdrpLdrGotLdr	Lloh632, Lloh633, Lloh634
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.19
_main.cold.19:                          ; @main.cold.19
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh639:
	adrp	x8, ___stderrp@GOTPAGE
Lloh640:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh641:
	ldr	x0, [x8]
Lloh642:
	adrp	x8, l_.str.15@PAGE
Lloh643:
	add	x8, x8, l_.str.15@PAGEOFF
	mov	w9, #331                        ; =0x14b
	stp	x9, x8, [sp]
Lloh644:
	adrp	x1, l_.str.6@PAGE
Lloh645:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh644, Lloh645
	.loh AdrpAdd	Lloh642, Lloh643
	.loh AdrpLdrGotLdr	Lloh639, Lloh640, Lloh641
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
Lloh646:
	adrp	x8, ___stderrp@GOTPAGE
Lloh647:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh648:
	ldr	x0, [x8]
Lloh649:
	adrp	x8, l_.str.27@PAGE
Lloh650:
	add	x8, x8, l_.str.27@PAGEOFF
	mov	w9, #318                        ; =0x13e
	stp	x9, x8, [sp]
Lloh651:
	adrp	x1, l_.str.6@PAGE
Lloh652:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh651, Lloh652
	.loh AdrpAdd	Lloh649, Lloh650
	.loh AdrpLdrGotLdr	Lloh646, Lloh647, Lloh648
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
Lloh653:
	adrp	x8, ___stderrp@GOTPAGE
Lloh654:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh655:
	ldr	x8, [x8]
	ldr	x9, [x19]
	stp	x21, x0, [sp, #24]
	stp	x23, x22, [sp, #8]
	str	x9, [sp]
Lloh656:
	adrp	x1, l_.str.29@PAGE
Lloh657:
	add	x1, x1, l_.str.29@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh656, Lloh657
	.loh AdrpLdrGotLdr	Lloh653, Lloh654, Lloh655
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
Lloh658:
	adrp	x8, ___stderrp@GOTPAGE
Lloh659:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh660:
	ldr	x0, [x8]
Lloh661:
	adrp	x8, l_.str.28@PAGE
Lloh662:
	add	x8, x8, l_.str.28@PAGEOFF
	mov	w9, #319                        ; =0x13f
	stp	x9, x8, [sp]
Lloh663:
	adrp	x1, l_.str.6@PAGE
Lloh664:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh663, Lloh664
	.loh AdrpAdd	Lloh661, Lloh662
	.loh AdrpLdrGotLdr	Lloh658, Lloh659, Lloh660
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
Lloh665:
	adrp	x8, ___stderrp@GOTPAGE
Lloh666:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh667:
	ldr	x0, [x8]
Lloh668:
	adrp	x8, l_.str.106@PAGE
Lloh669:
	add	x8, x8, l_.str.106@PAGEOFF
	mov	w9, #307                        ; =0x133
	stp	x9, x8, [sp]
Lloh670:
	adrp	x1, l_.str.6@PAGE
Lloh671:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh670, Lloh671
	.loh AdrpAdd	Lloh668, Lloh669
	.loh AdrpLdrGotLdr	Lloh665, Lloh666, Lloh667
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
Lloh672:
	adrp	x8, ___stderrp@GOTPAGE
Lloh673:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh674:
	ldr	x0, [x8]
Lloh675:
	adrp	x8, l_.str.105@PAGE
Lloh676:
	add	x8, x8, l_.str.105@PAGEOFF
	mov	w9, #307                        ; =0x133
	stp	x9, x8, [sp]
Lloh677:
	adrp	x1, l_.str.6@PAGE
Lloh678:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh677, Lloh678
	.loh AdrpAdd	Lloh675, Lloh676
	.loh AdrpLdrGotLdr	Lloh672, Lloh673, Lloh674
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
Lloh679:
	adrp	x8, ___stderrp@GOTPAGE
Lloh680:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh681:
	ldr	x0, [x8]
Lloh682:
	adrp	x8, l_.str.95@PAGE
Lloh683:
	add	x8, x8, l_.str.95@PAGEOFF
	mov	w9, #306                        ; =0x132
	stp	x9, x8, [sp]
Lloh684:
	adrp	x1, l_.str.6@PAGE
Lloh685:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh684, Lloh685
	.loh AdrpAdd	Lloh682, Lloh683
	.loh AdrpLdrGotLdr	Lloh679, Lloh680, Lloh681
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
Lloh686:
	adrp	x8, ___stderrp@GOTPAGE
Lloh687:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh688:
	ldr	x0, [x8]
Lloh689:
	adrp	x8, l_.str.99@PAGE
Lloh690:
	add	x8, x8, l_.str.99@PAGEOFF
	mov	w9, #306                        ; =0x132
	stp	x9, x8, [sp]
Lloh691:
	adrp	x1, l_.str.6@PAGE
Lloh692:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh691, Lloh692
	.loh AdrpAdd	Lloh689, Lloh690
	.loh AdrpLdrGotLdr	Lloh686, Lloh687, Lloh688
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
Lloh693:
	adrp	x8, ___stderrp@GOTPAGE
Lloh694:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh695:
	ldr	x0, [x8]
Lloh696:
	adrp	x8, l_.str.94@PAGE
Lloh697:
	add	x8, x8, l_.str.94@PAGEOFF
	mov	w9, #304                        ; =0x130
	stp	x9, x8, [sp]
Lloh698:
	adrp	x1, l_.str.6@PAGE
Lloh699:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh698, Lloh699
	.loh AdrpAdd	Lloh696, Lloh697
	.loh AdrpLdrGotLdr	Lloh693, Lloh694, Lloh695
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
Lloh700:
	adrp	x8, ___stderrp@GOTPAGE
Lloh701:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh702:
	ldr	x0, [x8]
Lloh703:
	adrp	x8, l_.str.104@PAGE
Lloh704:
	add	x8, x8, l_.str.104@PAGEOFF
	mov	w9, #303                        ; =0x12f
	stp	x9, x8, [sp]
Lloh705:
	adrp	x1, l_.str.6@PAGE
Lloh706:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh705, Lloh706
	.loh AdrpAdd	Lloh703, Lloh704
	.loh AdrpLdrGotLdr	Lloh700, Lloh701, Lloh702
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
Lloh707:
	adrp	x8, ___stderrp@GOTPAGE
Lloh708:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh709:
	ldr	x0, [x8]
Lloh710:
	adrp	x8, l_.str.103@PAGE
Lloh711:
	add	x8, x8, l_.str.103@PAGEOFF
	mov	w9, #302                        ; =0x12e
	stp	x9, x8, [sp]
Lloh712:
	adrp	x1, l_.str.6@PAGE
Lloh713:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh712, Lloh713
	.loh AdrpAdd	Lloh710, Lloh711
	.loh AdrpLdrGotLdr	Lloh707, Lloh708, Lloh709
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
Lloh714:
	adrp	x8, ___stderrp@GOTPAGE
Lloh715:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh716:
	ldr	x0, [x8]
Lloh717:
	adrp	x8, l_.str.102@PAGE
Lloh718:
	add	x8, x8, l_.str.102@PAGEOFF
	mov	w9, #301                        ; =0x12d
	stp	x9, x8, [sp]
Lloh719:
	adrp	x1, l_.str.6@PAGE
Lloh720:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh719, Lloh720
	.loh AdrpAdd	Lloh717, Lloh718
	.loh AdrpLdrGotLdr	Lloh714, Lloh715, Lloh716
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
Lloh721:
	adrp	x8, ___stderrp@GOTPAGE
Lloh722:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh723:
	ldr	x0, [x8]
Lloh724:
	adrp	x8, l_.str.91@PAGE
Lloh725:
	add	x8, x8, l_.str.91@PAGEOFF
	mov	w9, #300                        ; =0x12c
	stp	x9, x8, [sp]
Lloh726:
	adrp	x1, l_.str.6@PAGE
Lloh727:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh726, Lloh727
	.loh AdrpAdd	Lloh724, Lloh725
	.loh AdrpLdrGotLdr	Lloh721, Lloh722, Lloh723
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
Lloh728:
	adrp	x8, ___stderrp@GOTPAGE
Lloh729:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh730:
	ldr	x0, [x8]
Lloh731:
	adrp	x8, l_.str.101@PAGE
Lloh732:
	add	x8, x8, l_.str.101@PAGEOFF
	mov	w9, #300                        ; =0x12c
	stp	x9, x8, [sp]
Lloh733:
	adrp	x1, l_.str.6@PAGE
Lloh734:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh733, Lloh734
	.loh AdrpAdd	Lloh731, Lloh732
	.loh AdrpLdrGotLdr	Lloh728, Lloh729, Lloh730
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
Lloh735:
	adrp	x8, ___stderrp@GOTPAGE
Lloh736:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh737:
	ldr	x0, [x8]
Lloh738:
	adrp	x8, l_.str.100@PAGE
Lloh739:
	add	x8, x8, l_.str.100@PAGEOFF
	mov	w9, #299                        ; =0x12b
	stp	x9, x8, [sp]
Lloh740:
	adrp	x1, l_.str.6@PAGE
Lloh741:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh740, Lloh741
	.loh AdrpAdd	Lloh738, Lloh739
	.loh AdrpLdrGotLdr	Lloh735, Lloh736, Lloh737
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
Lloh742:
	adrp	x8, ___stderrp@GOTPAGE
Lloh743:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh744:
	ldr	x0, [x8]
Lloh745:
	adrp	x8, l_.str.99@PAGE
Lloh746:
	add	x8, x8, l_.str.99@PAGEOFF
	mov	w9, #299                        ; =0x12b
	stp	x9, x8, [sp]
Lloh747:
	adrp	x1, l_.str.6@PAGE
Lloh748:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh747, Lloh748
	.loh AdrpAdd	Lloh745, Lloh746
	.loh AdrpLdrGotLdr	Lloh742, Lloh743, Lloh744
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
Lloh749:
	adrp	x8, ___stderrp@GOTPAGE
Lloh750:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh751:
	ldr	x0, [x8]
Lloh752:
	adrp	x8, l_.str.98@PAGE
Lloh753:
	add	x8, x8, l_.str.98@PAGEOFF
	mov	w9, #297                        ; =0x129
	stp	x9, x8, [sp]
Lloh754:
	adrp	x1, l_.str.6@PAGE
Lloh755:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh754, Lloh755
	.loh AdrpAdd	Lloh752, Lloh753
	.loh AdrpLdrGotLdr	Lloh749, Lloh750, Lloh751
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
Lloh756:
	adrp	x8, ___stderrp@GOTPAGE
Lloh757:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh758:
	ldr	x0, [x8]
Lloh759:
	adrp	x8, l_.str.97@PAGE
Lloh760:
	add	x8, x8, l_.str.97@PAGEOFF
	mov	w9, #296                        ; =0x128
	stp	x9, x8, [sp]
Lloh761:
	adrp	x1, l_.str.6@PAGE
Lloh762:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh761, Lloh762
	.loh AdrpAdd	Lloh759, Lloh760
	.loh AdrpLdrGotLdr	Lloh756, Lloh757, Lloh758
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
Lloh763:
	adrp	x8, ___stderrp@GOTPAGE
Lloh764:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh765:
	ldr	x0, [x8]
Lloh766:
	adrp	x8, l_.str.96@PAGE
Lloh767:
	add	x8, x8, l_.str.96@PAGEOFF
	mov	w9, #295                        ; =0x127
	stp	x9, x8, [sp]
Lloh768:
	adrp	x1, l_.str.6@PAGE
Lloh769:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh768, Lloh769
	.loh AdrpAdd	Lloh766, Lloh767
	.loh AdrpLdrGotLdr	Lloh763, Lloh764, Lloh765
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
Lloh770:
	adrp	x8, ___stderrp@GOTPAGE
Lloh771:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh772:
	ldr	x0, [x8]
Lloh773:
	adrp	x8, l_.str.95@PAGE
Lloh774:
	add	x8, x8, l_.str.95@PAGEOFF
	mov	w9, #295                        ; =0x127
	stp	x9, x8, [sp]
Lloh775:
	adrp	x1, l_.str.6@PAGE
Lloh776:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh775, Lloh776
	.loh AdrpAdd	Lloh773, Lloh774
	.loh AdrpLdrGotLdr	Lloh770, Lloh771, Lloh772
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
Lloh777:
	adrp	x8, ___stderrp@GOTPAGE
Lloh778:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh779:
	ldr	x0, [x8]
Lloh780:
	adrp	x8, l_.str.94@PAGE
Lloh781:
	add	x8, x8, l_.str.94@PAGEOFF
	mov	w9, #294                        ; =0x126
	stp	x9, x8, [sp]
Lloh782:
	adrp	x1, l_.str.6@PAGE
Lloh783:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh782, Lloh783
	.loh AdrpAdd	Lloh780, Lloh781
	.loh AdrpLdrGotLdr	Lloh777, Lloh778, Lloh779
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
Lloh784:
	adrp	x8, ___stderrp@GOTPAGE
Lloh785:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh786:
	ldr	x0, [x8]
Lloh787:
	adrp	x8, l_.str.93@PAGE
Lloh788:
	add	x8, x8, l_.str.93@PAGEOFF
	mov	w9, #294                        ; =0x126
	stp	x9, x8, [sp]
Lloh789:
	adrp	x1, l_.str.6@PAGE
Lloh790:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh789, Lloh790
	.loh AdrpAdd	Lloh787, Lloh788
	.loh AdrpLdrGotLdr	Lloh784, Lloh785, Lloh786
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
Lloh791:
	adrp	x8, ___stderrp@GOTPAGE
Lloh792:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh793:
	ldr	x0, [x8]
Lloh794:
	adrp	x8, l_.str.91@PAGE
Lloh795:
	add	x8, x8, l_.str.91@PAGEOFF
	mov	w9, #292                        ; =0x124
	stp	x9, x8, [sp]
Lloh796:
	adrp	x1, l_.str.6@PAGE
Lloh797:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh796, Lloh797
	.loh AdrpAdd	Lloh794, Lloh795
	.loh AdrpLdrGotLdr	Lloh791, Lloh792, Lloh793
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
Lloh798:
	adrp	x8, ___stderrp@GOTPAGE
Lloh799:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh800:
	ldr	x0, [x8]
Lloh801:
	adrp	x8, l_.str.92@PAGE
Lloh802:
	add	x8, x8, l_.str.92@PAGEOFF
	mov	w9, #291                        ; =0x123
	stp	x9, x8, [sp]
Lloh803:
	adrp	x1, l_.str.6@PAGE
Lloh804:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh803, Lloh804
	.loh AdrpAdd	Lloh801, Lloh802
	.loh AdrpLdrGotLdr	Lloh798, Lloh799, Lloh800
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
Lloh805:
	adrp	x8, ___stderrp@GOTPAGE
Lloh806:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh807:
	ldr	x0, [x8]
Lloh808:
	adrp	x8, l_.str.91@PAGE
Lloh809:
	add	x8, x8, l_.str.91@PAGEOFF
	mov	w9, #290                        ; =0x122
	stp	x9, x8, [sp]
Lloh810:
	adrp	x1, l_.str.6@PAGE
Lloh811:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh810, Lloh811
	.loh AdrpAdd	Lloh808, Lloh809
	.loh AdrpLdrGotLdr	Lloh805, Lloh806, Lloh807
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
Lloh812:
	adrp	x8, ___stderrp@GOTPAGE
Lloh813:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh814:
	ldr	x0, [x8]
Lloh815:
	adrp	x8, l_.str.90@PAGE
Lloh816:
	add	x8, x8, l_.str.90@PAGEOFF
	mov	w9, #290                        ; =0x122
	stp	x9, x8, [sp]
Lloh817:
	adrp	x1, l_.str.6@PAGE
Lloh818:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh817, Lloh818
	.loh AdrpAdd	Lloh815, Lloh816
	.loh AdrpLdrGotLdr	Lloh812, Lloh813, Lloh814
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
Lloh819:
	adrp	x8, ___stderrp@GOTPAGE
Lloh820:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh821:
	ldr	x0, [x8]
Lloh822:
	adrp	x8, l_.str.89@PAGE
Lloh823:
	add	x8, x8, l_.str.89@PAGEOFF
	mov	w9, #286                        ; =0x11e
	stp	x9, x8, [sp]
Lloh824:
	adrp	x1, l_.str.6@PAGE
Lloh825:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh824, Lloh825
	.loh AdrpAdd	Lloh822, Lloh823
	.loh AdrpLdrGotLdr	Lloh819, Lloh820, Lloh821
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
Lloh826:
	adrp	x8, ___stderrp@GOTPAGE
Lloh827:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh828:
	ldr	x0, [x8]
Lloh829:
	adrp	x8, l_.str.56@PAGE
Lloh830:
	add	x8, x8, l_.str.56@PAGEOFF
	mov	w9, #175                        ; =0xaf
	stp	x9, x8, [sp]
Lloh831:
	adrp	x1, l_.str.6@PAGE
Lloh832:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh831, Lloh832
	.loh AdrpAdd	Lloh829, Lloh830
	.loh AdrpLdrGotLdr	Lloh826, Lloh827, Lloh828
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
Lloh833:
	adrp	x8, ___stderrp@GOTPAGE
Lloh834:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh835:
	ldr	x0, [x8]
Lloh836:
	adrp	x8, l_.str.55@PAGE
Lloh837:
	add	x8, x8, l_.str.55@PAGEOFF
	mov	w9, #175                        ; =0xaf
	stp	x9, x8, [sp]
Lloh838:
	adrp	x1, l_.str.6@PAGE
Lloh839:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh838, Lloh839
	.loh AdrpAdd	Lloh836, Lloh837
	.loh AdrpLdrGotLdr	Lloh833, Lloh834, Lloh835
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
Lloh840:
	adrp	x8, ___stderrp@GOTPAGE
Lloh841:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh842:
	ldr	x0, [x8]
Lloh843:
	adrp	x8, l_.str.54@PAGE
Lloh844:
	add	x8, x8, l_.str.54@PAGEOFF
	mov	w9, #172                        ; =0xac
	stp	x9, x8, [sp]
Lloh845:
	adrp	x1, l_.str.6@PAGE
Lloh846:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh845, Lloh846
	.loh AdrpAdd	Lloh843, Lloh844
	.loh AdrpLdrGotLdr	Lloh840, Lloh841, Lloh842
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
Lloh847:
	adrp	x8, ___stderrp@GOTPAGE
Lloh848:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh849:
	ldr	x0, [x8]
Lloh850:
	adrp	x8, l_.str.52@PAGE
Lloh851:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh852:
	adrp	x1, l_.str.6@PAGE
Lloh853:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh852, Lloh853
	.loh AdrpAdd	Lloh850, Lloh851
	.loh AdrpLdrGotLdr	Lloh847, Lloh848, Lloh849
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
Lloh854:
	adrp	x8, ___stderrp@GOTPAGE
Lloh855:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh856:
	ldr	x0, [x8]
Lloh857:
	adrp	x8, l_.str.68@PAGE
Lloh858:
	add	x8, x8, l_.str.68@PAGEOFF
	mov	w9, #57                         ; =0x39
	stp	x9, x8, [sp]
Lloh859:
	adrp	x1, l_.str.6@PAGE
Lloh860:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh859, Lloh860
	.loh AdrpAdd	Lloh857, Lloh858
	.loh AdrpLdrGotLdr	Lloh854, Lloh855, Lloh856
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
Lloh861:
	adrp	x8, ___stderrp@GOTPAGE
Lloh862:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh863:
	ldr	x0, [x8]
Lloh864:
	adrp	x8, l_.str.67@PAGE
Lloh865:
	add	x8, x8, l_.str.67@PAGEOFF
	mov	w9, #56                         ; =0x38
	stp	x9, x8, [sp]
Lloh866:
	adrp	x1, l_.str.6@PAGE
Lloh867:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh866, Lloh867
	.loh AdrpAdd	Lloh864, Lloh865
	.loh AdrpLdrGotLdr	Lloh861, Lloh862, Lloh863
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
Lloh868:
	adrp	x8, ___stderrp@GOTPAGE
Lloh869:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh870:
	ldr	x0, [x8]
Lloh871:
	adrp	x8, l_.str.87@PAGE
Lloh872:
	add	x8, x8, l_.str.87@PAGEOFF
	mov	w9, #245                        ; =0xf5
	stp	x9, x8, [sp]
Lloh873:
	adrp	x1, l_.str.6@PAGE
Lloh874:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh873, Lloh874
	.loh AdrpAdd	Lloh871, Lloh872
	.loh AdrpLdrGotLdr	Lloh868, Lloh869, Lloh870
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
Lloh875:
	adrp	x8, ___stderrp@GOTPAGE
Lloh876:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh877:
	ldr	x0, [x8]
Lloh878:
	adrp	x8, l_.str.86@PAGE
Lloh879:
	add	x8, x8, l_.str.86@PAGEOFF
	mov	w9, #245                        ; =0xf5
	stp	x9, x8, [sp]
Lloh880:
	adrp	x1, l_.str.6@PAGE
Lloh881:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh880, Lloh881
	.loh AdrpAdd	Lloh878, Lloh879
	.loh AdrpLdrGotLdr	Lloh875, Lloh876, Lloh877
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
Lloh882:
	adrp	x8, ___stderrp@GOTPAGE
Lloh883:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh884:
	ldr	x0, [x8]
Lloh885:
	adrp	x8, l_.str.88@PAGE
Lloh886:
	add	x8, x8, l_.str.88@PAGEOFF
	mov	w9, #249                        ; =0xf9
	stp	x9, x8, [sp]
Lloh887:
	adrp	x1, l_.str.6@PAGE
Lloh888:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh887, Lloh888
	.loh AdrpAdd	Lloh885, Lloh886
	.loh AdrpLdrGotLdr	Lloh882, Lloh883, Lloh884
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
Lloh889:
	adrp	x8, ___stderrp@GOTPAGE
Lloh890:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh891:
	ldr	x0, [x8]
Lloh892:
	adrp	x8, l_.str.85@PAGE
Lloh893:
	add	x8, x8, l_.str.85@PAGEOFF
	mov	w9, #243                        ; =0xf3
	stp	x9, x8, [sp]
Lloh894:
	adrp	x1, l_.str.6@PAGE
Lloh895:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh894, Lloh895
	.loh AdrpAdd	Lloh892, Lloh893
	.loh AdrpLdrGotLdr	Lloh889, Lloh890, Lloh891
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
Lloh896:
	adrp	x8, ___stderrp@GOTPAGE
Lloh897:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh898:
	ldr	x0, [x8]
Lloh899:
	adrp	x8, l_.str.52@PAGE
Lloh900:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh901:
	adrp	x1, l_.str.6@PAGE
Lloh902:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh901, Lloh902
	.loh AdrpAdd	Lloh899, Lloh900
	.loh AdrpLdrGotLdr	Lloh896, Lloh897, Lloh898
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
Lloh903:
	adrp	x8, ___stderrp@GOTPAGE
Lloh904:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh905:
	ldr	x0, [x8]
Lloh906:
	adrp	x8, l_.str.52@PAGE
Lloh907:
	add	x8, x8, l_.str.52@PAGEOFF
	mov	w9, #53                         ; =0x35
	stp	x9, x8, [sp]
Lloh908:
	adrp	x1, l_.str.6@PAGE
Lloh909:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh908, Lloh909
	.loh AdrpAdd	Lloh906, Lloh907
	.loh AdrpLdrGotLdr	Lloh903, Lloh904, Lloh905
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
Lloh910:
	adrp	x8, ___stderrp@GOTPAGE
Lloh911:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh912:
	ldr	x0, [x8]
Lloh913:
	adrp	x8, l_.str.108@PAGE
Lloh914:
	add	x8, x8, l_.str.108@PAGEOFF
	mov	w9, #283                        ; =0x11b
	stp	x9, x8, [sp]
Lloh915:
	adrp	x1, l_.str.6@PAGE
Lloh916:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh915, Lloh916
	.loh AdrpAdd	Lloh913, Lloh914
	.loh AdrpLdrGotLdr	Lloh910, Lloh911, Lloh912
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
Lloh917:
	adrp	x8, ___stderrp@GOTPAGE
Lloh918:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh919:
	ldr	x0, [x8]
Lloh920:
	adrp	x8, l_.str.107@PAGE
Lloh921:
	add	x8, x8, l_.str.107@PAGEOFF
	mov	w9, #279                        ; =0x117
	stp	x9, x8, [sp]
Lloh922:
	adrp	x1, l_.str.6@PAGE
Lloh923:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh922, Lloh923
	.loh AdrpAdd	Lloh920, Lloh921
	.loh AdrpLdrGotLdr	Lloh917, Lloh918, Lloh919
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
Lloh924:
	adrp	x8, ___stderrp@GOTPAGE
Lloh925:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh926:
	ldr	x0, [x8]
Lloh927:
	adrp	x8, l_.str.117@PAGE
Lloh928:
	add	x8, x8, l_.str.117@PAGEOFF
	mov	w9, #42                         ; =0x2a
	stp	x9, x8, [sp]
Lloh929:
	adrp	x1, l_.str.6@PAGE
Lloh930:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh929, Lloh930
	.loh AdrpAdd	Lloh927, Lloh928
	.loh AdrpLdrGotLdr	Lloh924, Lloh925, Lloh926
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
Lloh931:
	adrp	x8, ___stderrp@GOTPAGE
Lloh932:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh933:
	ldr	x0, [x8]
Lloh934:
	adrp	x8, l_.str.117@PAGE
Lloh935:
	add	x8, x8, l_.str.117@PAGEOFF
	mov	w9, #42                         ; =0x2a
	stp	x9, x8, [sp]
Lloh936:
	adrp	x1, l_.str.6@PAGE
Lloh937:
	add	x1, x1, l_.str.6@PAGEOFF
	bl	_fprintf
	bl	_abort
	.loh AdrpAdd	Lloh936, Lloh937
	.loh AdrpAdd	Lloh934, Lloh935
	.loh AdrpLdrGotLdr	Lloh931, Lloh932, Lloh933
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
	.asciz	"scalar_leaf_bits=%d; square_table_entries=256; table_bytes=%zu\n"

l_.str.11:                              ; @.str.11
	.asciz	"Prototype uses shared OpenSSL BIGNUM primitives and reusable BN_CTX; API overhead is included. Warm tables/allocations. CPU frequency and core affinity are uncontrolled.\n"

l_.str.12:                              ; @.str.12
	.asciz	"w"

l_.str.13:                              ; @.str.13
	.asciz	"file"

l_.str.14:                              ; @.str.14
	.asciz	"fclose(file)==0"

l_.str.15:                              ; @.str.15
	.asciz	"ctx"

l_.str.16:                              ; @.str.16
	.asciz	"p.x && p.y"

	.section	__DATA,__data
	.p2align	3, 0x0                          ; @rng_state
_rng_state:
	.quad	-8134700638765165263            ; 0x8f1bbcde58425531

	.section	__TEXT,__cstring,cstring_literals
l_.str.17:                              ; @.str.17
	.asciz	"scalar_square32(v)==(uint64_t)v*v"

l_.str.18:                              ; @.str.18
	.asciz	"scalar_square32(x)==(uint64_t)x*x"

l_.str.19:                              ; @.str.19
	.asciz	"scalar_product32(x,y)==(uint64_t)x*y"

l_.str.20:                              ; @.str.20
	.asciz	"scalar_square32(UINT32_MAX)==(uint64_t)UINT32_MAX*UINT32_MAX"

l_.str.21:                              ; @.str.21
	.asciz	"scalar_product32(UINT32_MAX,UINT32_MAX)==(uint64_t)UINT32_MAX*UINT32_MAX"

l_.str.22:                              ; @.str.22
	.asciz	"verified scalar leaves: 65536 small squares, 10000 random32 squares/products, UINT32_MAX boundaries\n"

l_.str.23:                              ; @.str.23
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
l_.str.24:                              ; @.str.24
	.asciz	"BN_set_word(p.x,edge[i])"

l_.str.25:                              ; @.str.25
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
l_.str.26:                              ; @.str.26
	.asciz	"verified 65536 table products and %u BIGNUM pairs across all %zu product algorithms\n"

l_.str.27:                              ; @.str.27
	.asciz	"expected && out"

l_.str.28:                              ; @.str.28
	.asciz	"BN_mul(expected,p->x,p->y,ctx)"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @algorithms
_algorithms:
	.quad	l_.str.30
	.quad	_copy_control
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.quad	l_.str.31
	.quad	_native_mul
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.32
	.quad	_native_equal_aware
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.33
	.quad	_mid_native_square
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.34
	.quad	_shift_add_short
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.35
	.quad	_shift_add_sparse
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.36
	.quad	_direct_karatsuba
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.37
	.quad	_recursive_equal_aware
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.38
	.quad	_mid_recursive
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.39
	.quad	_mid_set_bits
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.40
	.quad	_mid_prefix
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	l_.str.41
	.quad	_near_native
	.long	1                               ; 0x1
	.long	0                               ; 0x0
	.quad	l_.str.42
	.quad	_near_recursive
	.long	1                               ; 0x1
	.long	0                               ; 0x0

	.section	__TEXT,__cstring,cstring_literals
l_.str.29:                              ; @.str.29
	.asciz	"mismatch %s x=%s y=%s got=%s expected=%s\n"

l_.str.30:                              ; @.str.30
	.asciz	"copy_control"

l_.str.31:                              ; @.str.31
	.asciz	"native_mul"

l_.str.32:                              ; @.str.32
	.asciz	"native_equal_aware"

l_.str.33:                              ; @.str.33
	.asciz	"mid_native_square"

l_.str.34:                              ; @.str.34
	.asciz	"shift_add_short"

l_.str.35:                              ; @.str.35
	.asciz	"shift_add_sparse"

l_.str.36:                              ; @.str.36
	.asciz	"direct_karatsuba"

l_.str.37:                              ; @.str.37
	.asciz	"recursive_equal_aware"

l_.str.38:                              ; @.str.38
	.asciz	"mid_recursive"

l_.str.39:                              ; @.str.39
	.asciz	"mid_set_bits"

l_.str.40:                              ; @.str.40
	.asciz	"mid_prefix"

l_.str.41:                              ; @.str.41
	.asciz	"near_native"

l_.str.42:                              ; @.str.42
	.asciz	"near_recursive"

l_.str.43:                              ; @.str.43
	.asciz	"BN_copy(out,x)"

l_.str.44:                              ; @.str.44
	.asciz	"BN_mul(out, x, y, ctx)"

l_.str.45:                              ; @.str.45
	.asciz	"BN_sqr(out,x,ctx)"

l_.str.46:                              ; @.str.46
	.asciz	"BN_mul(out,x,y,ctx)"

l_.str.47:                              ; @.str.47
	.asciz	"BN_sub(delta, b, a)"

l_.str.48:                              ; @.str.48
	.asciz	"BN_rshift1(d, delta)"

l_.str.49:                              ; @.str.49
	.asciz	"BN_add(h, a, d)"

l_.str.50:                              ; @.str.50
	.asciz	"BN_sub(out, out, dsq)"

l_.str.51:                              ; @.str.51
	.asciz	"BN_add(out, out, a)"

l_.str.52:                              ; @.str.52
	.asciz	"v != NULL"

l_.str.53:                              ; @.str.53
	.asciz	"BN_sqr(out, x, ctx)"

l_.str.54:                              ; @.str.54
	.asciz	"BN_set_word(out, 0)"

l_.str.55:                              ; @.str.55
	.asciz	"BN_lshift(row, value, i)"

l_.str.56:                              ; @.str.56
	.asciz	"BN_add(out, out, row)"

l_.str.57:                              ; @.str.57
	.asciz	"BN_set_word(out, squares[h]-squares[d]+((delta&1) ? a : 0))"

l_.str.58:                              ; @.str.58
	.asciz	"BN_set_word(out, scalar_product32((uint32_t)BN_get_word(x),(uint32_t)BN_get_word(y)))"

l_.str.59:                              ; @.str.59
	.asciz	"BN_rshift(xh, x, r)"

l_.str.60:                              ; @.str.60
	.asciz	"BN_rshift(yh, y, r)"

l_.str.61:                              ; @.str.61
	.asciz	"BN_add(cross, u, v)"

l_.str.62:                              ; @.str.62
	.asciz	"sign ? BN_add(cross, cross, w) : BN_sub(cross, cross, w)"

l_.str.63:                              ; @.str.63
	.asciz	"BN_lshift(out, u, r+r)"

l_.str.64:                              ; @.str.64
	.asciz	"BN_lshift(cross, cross, r)"

l_.str.65:                              ; @.str.65
	.asciz	"BN_add(out, out, cross)"

l_.str.66:                              ; @.str.66
	.asciz	"BN_add(out, out, v)"

l_.str.67:                              ; @.str.67
	.asciz	"BN_copy(out, x)"

l_.str.68:                              ; @.str.68
	.asciz	"BN_mask_bits(out, n)"

l_.str.69:                              ; @.str.69
	.asciz	"sign >= 0 ? BN_sub(out, x, y) : BN_sub(out, y, x)"

l_.str.70:                              ; @.str.70
	.asciz	"BN_set_word(out, squares[BN_get_word(x)])"

l_.str.71:                              ; @.str.71
	.asciz	"BN_set_word(out, scalar_square32((uint32_t)BN_get_word(x)))"

l_.str.72:                              ; @.str.72
	.asciz	"BN_rshift(hi, x, r)"

l_.str.73:                              ; @.str.73
	.asciz	"BN_sub(cross, cross, w)"

l_.str.74:                              ; @.str.74
	.asciz	"BN_lshift(out, u, r + r)"

l_.str.75:                              ; @.str.75
	.asciz	"BN_copy(remaining, x)"

l_.str.76:                              ; @.str.76
	.asciz	"BN_clear_bit(remaining, i)"

l_.str.77:                              ; @.str.77
	.asciz	"BN_lshift(row, remaining, i + 1)"

l_.str.78:                              ; @.str.78
	.asciz	"BN_set_bit(row, i + i)"

l_.str.79:                              ; @.str.79
	.asciz	"BN_set_word(prefix, 0)"

l_.str.80:                              ; @.str.80
	.asciz	"BN_lshift(out, out, 2)"

l_.str.81:                              ; @.str.81
	.asciz	"BN_lshift(row, prefix, 2)"

l_.str.82:                              ; @.str.82
	.asciz	"BN_add_word(row, 1)"

l_.str.83:                              ; @.str.83
	.asciz	"BN_lshift1(prefix, prefix)"

l_.str.84:                              ; @.str.84
	.asciz	"BN_add_word(prefix, 1)"

l_.str.85:                              ; @.str.85
	.asciz	"BN_sub(delta,b,a)"

l_.str.86:                              ; @.str.86
	.asciz	"BN_sqr(out,a,ctx)"

l_.str.87:                              ; @.str.87
	.asciz	"BN_mul(cross,a,delta,ctx)"

l_.str.88:                              ; @.str.88
	.asciz	"BN_add(out,out,cross)"

l_.str.89:                              ; @.str.89
	.asciz	"p->x && p->y"

l_.str.90:                              ; @.str.90
	.asciz	"BN_clear_bit(p->x,8)"

l_.str.91:                              ; @.str.91
	.asciz	"BN_copy(p->y,p->x)"

l_.str.92:                              ; @.str.92
	.asciz	"BN_add_word(p->y,1+(random_u64()%255))"

l_.str.93:                              ; @.str.93
	.asciz	"BN_set_word(p->x,1)"

l_.str.94:                              ; @.str.94
	.asciz	"BN_set_word(p->y,1)"

l_.str.95:                              ; @.str.95
	.asciz	"BN_set_bit(p->x,bits-1)"

l_.str.96:                              ; @.str.96
	.asciz	"BN_set_bit(p->y,bits-1)"

l_.str.97:                              ; @.str.97
	.asciz	"BN_set_bit(p->x,(int)(random_u64()%(unsigned)(bits-2))+1)"

l_.str.98:                              ; @.str.98
	.asciz	"BN_set_bit(p->y,(int)(random_u64()%(unsigned)(bits-2))+1)"

l_.str.99:                              ; @.str.99
	.asciz	"BN_set_word(p->x,0)"

l_.str.100:                             ; @.str.100
	.asciz	"BN_set_bit(p->x,bits)"

l_.str.101:                             ; @.str.101
	.asciz	"BN_sub_word(p->x,1)"

l_.str.102:                             ; @.str.102
	.asciz	"BN_clear_bit(p->x,(int)(random_u64()%(unsigned)(bits-1)))"

l_.str.103:                             ; @.str.103
	.asciz	"BN_clear_bit(p->y,(int)(random_u64()%(unsigned)(bits-1)))"

l_.str.104:                             ; @.str.104
	.asciz	"BN_set_word(p->y,128+(random_u64()&127))"

l_.str.105:                             ; @.str.105
	.asciz	"BN_set_word(p->y,0)"

l_.str.106:                             ; @.str.106
	.asciz	"BN_set_bit(p->y,bits/2)"

l_.str.107:                             ; @.str.107
	.asciz	"buf"

l_.str.108:                             ; @.str.108
	.asciz	"BN_bin2bn(buf,n,x)"

	.section	__TEXT,__const
	.p2align	2, 0x0                          ; @__const.measure.widths
l___const.measure.widths:
	.long	64                              ; 0x40
	.long	256                             ; 0x100
	.long	1024                            ; 0x400
	.long	4096                            ; 0x1000
	.long	16384                           ; 0x4000

	.section	__TEXT,__cstring,cstring_literals
l_.str.109:                             ; @.str.109
	.asciz	"ctx && out"

l_.str.110:                             ; @.str.110
	.asciz	"bits,pattern,algorithm,samples,repetitions,trials,median_ns,min_ns,max_ns\n"

l_.str.111:                             ; @.str.111
	.asciz	"expected"

l_.str.112:                             ; @.str.112
	.asciz	"BN_mul(expected,pairs[i].x,pairs[i].y,ctx)"

l_.str.113:                             ; @.str.113
	.asciz	"BN_cmp(out,expected)==0"

l_.str.114:                             ; @.str.114
	.asciz	"%d,%s,%s,%d,%u,%d,%.3f,%.3f,%.3f\n"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @patterns
_patterns:
	.quad	l_.str.118
	.quad	l_.str.119
	.quad	l_.str.120
	.quad	l_.str.121
	.quad	l_.str.122
	.quad	l_.str.123
	.quad	l_.str.124
	.quad	l_.str.125

	.section	__TEXT,__cstring,cstring_literals
l_.str.115:                             ; @.str.115
	.asciz	"finished bits=%d pattern=%s\n"

l_.str.116:                             ; @.str.116
	.asciz	"observable checksum=%llu\n"

l_.str.117:                             ; @.str.117
	.asciz	"clock_gettime(CLOCK_MONOTONIC, &t) == 0"

l_.str.118:                             ; @.str.118
	.asciz	"random"

l_.str.119:                             ; @.str.119
	.asciz	"near"

l_.str.120:                             ; @.str.120
	.asciz	"equal"

l_.str.121:                             ; @.str.121
	.asciz	"sparse"

l_.str.122:                             ; @.str.122
	.asciz	"dense"

l_.str.123:                             ; @.str.123
	.asciz	"short8"

l_.str.124:                             ; @.str.124
	.asciz	"one"

l_.str.125:                             ; @.str.125
	.asciz	"power2"

.zerofill __DATA,__bss,__MergedGlobals,520,3 ; @_MergedGlobals
.subsections_via_symbols
