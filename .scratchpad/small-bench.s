	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 5	sdk_version 15, 5
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	w9, #34048                      ; =0x8500
Lloh0:
	adrp	x16, ___chkstk_darwin@GOTPAGE
Lloh1:
	ldr	x16, [x16, ___chkstk_darwin@GOTPAGEOFF]
	blr	x16
	sub	sp, sp, #8, lsl #12             ; =32768
	sub	sp, sp, #1280
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
	mov	x19, x1
	mov	x20, x0
Lloh2:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh3:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh4:
	ldr	x8, [x8]
	stur	x8, [x29, #-96]
	add	x1, sp, #1264
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB0_75
; %bb.1:
	ldr	x21, [sp, #1264]
	ldr	x22, [sp, #1272]
	bl	_initialize_table8
	bl	_initialize_table16
	bl	_initialize_quarter8
	bl	_initialize_products8
	add	x1, sp, #1264
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB0_75
; %bb.2:
	mov	w11, #51712                     ; =0xca00
	movk	w11, #15258, lsl #16
	mov	w10, #19264                     ; =0x4b40
	movk	w10, #76, lsl #16
	ldr	x8, [sp, #1264]
	ldr	x9, [sp, #1272]
	sub	x8, x8, x21
	sub	x9, x9, x22
	madd	x8, x8, x11, x9
Lloh5:
	adrp	x9, ___stderrp@GOTPAGE
Lloh6:
	ldr	x9, [x9, ___stderrp@GOTPAGEOFF]
Lloh7:
	ldr	x0, [x9]
	stp	x10, x8, [sp, #32]
	mov	w8, #7                          ; =0x7
	mov	w9, #4096                       ; =0x1000
	stp	x9, x8, [sp, #16]
	mov	w8, #64                         ; =0x40
Lloh8:
	adrp	x9, l_.str.1@PAGE
Lloh9:
	add	x9, x9, l_.str.1@PAGEOFF
	stp	x9, x8, [sp]
Lloh10:
	adrp	x1, l_.str@PAGE
Lloh11:
	add	x1, x1, l_.str@PAGEOFF
	bl	_fprintf
	mov	w21, #0                         ; =0x0
LBB0_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_4 Depth 2
	mov	w22, #0                         ; =0x0
LBB0_4:                                 ;   Parent Loop BB0_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x0, x21
	mov	x1, x22
	bl	_check_pair
	add	w22, w22, #1
	cmp	w22, #256
	b.ne	LBB0_4
; %bb.5:                                ;   in Loop: Header=BB0_3 Depth=1
	add	w21, w21, #1
	cmp	w21, #256
	b.ne	LBB0_3
; %bb.6:
	mov	w21, #34464                     ; =0x86a0
	movk	w21, #1, lsl #16
	adrp	x22, _random_state@PAGE
LBB0_7:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x22, _random_state@PAGEOFF]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x0, x8, x8, lsl #17
	eor	x8, x0, x0, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x1, x8, x8, lsl #17
	str	x1, [x22, _random_state@PAGEOFF]
                                        ; kill: def $w0 killed $w0 killed $x0
                                        ; kill: def $w1 killed $w1 killed $x1
	bl	_check_pair
	subs	w21, w21, #1
	b.ne	LBB0_7
; %bb.8:
	mov	x22, #0                         ; =0x0
Lloh12:
	adrp	x23, l___const.verify.cases@PAGE
Lloh13:
	add	x23, x23, l___const.verify.cases@PAGEOFF
LBB0_9:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w21, [x23, x22]
	mov	x0, x21
	mov	w1, #0                          ; =0x0
	bl	_check_pair
	mov	x0, x21
	mov	w1, #1                          ; =0x1
	bl	_check_pair
	mov	x0, x21
	mov	w1, #2                          ; =0x2
	bl	_check_pair
	mov	x0, x21
	mov	w1, #3                          ; =0x3
	bl	_check_pair
	mov	x0, x21
	mov	w1, #127                        ; =0x7f
	bl	_check_pair
	mov	x0, x21
	mov	w1, #128                        ; =0x80
	bl	_check_pair
	mov	x0, x21
	mov	w1, #255                        ; =0xff
	bl	_check_pair
	mov	x0, x21
	mov	w1, #256                        ; =0x100
	bl	_check_pair
	mov	x0, x21
	mov	w1, #257                        ; =0x101
	bl	_check_pair
	mov	x0, x21
	mov	w1, #65535                      ; =0xffff
	bl	_check_pair
	mov	x0, x21
	mov	w1, #65536                      ; =0x10000
	bl	_check_pair
	mov	x0, x21
	mov	w1, #2147483647                 ; =0x7fffffff
	bl	_check_pair
	mov	x0, x21
	mov	w1, #-2147483648                ; =0x80000000
	bl	_check_pair
	mov	x0, x21
	mov	w1, #-1                         ; =0xffffffff
	bl	_check_pair
	add	x22, x22, #4
	cmp	x22, #56
	b.ne	LBB0_9
; %bb.10:
	mov	x21, #0                         ; =0x0
LBB0_11:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_13 Depth 2
                                        ;     Child Loop BB0_16 Depth 2
	mul	x22, x21, x21
	mov	x8, #0                          ; =0x0
	cbz	x21, LBB0_17
; %bb.12:                               ;   in Loop: Header=BB0_11 Depth=1
	mov	x9, #0                          ; =0x0
	clz	w10, w21
	eor	w10, w10, #0x1f
LBB0_13:                                ;   Parent Loop BB0_11 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	lsr	w11, w21, w10
	lsl	x12, x9, #2
	ands	w11, w11, #0x1
	csinc	x12, xzr, x12, eq
	add	x8, x12, x8, lsl #2
	orr	x9, x11, x9, lsl #1
	sub	w10, w10, #1
	cmn	w10, #1
	b.ne	LBB0_13
; %bb.14:                               ;   in Loop: Header=BB0_11 Depth=1
	cmp	x8, x22
	b.ne	LBB0_74
; %bb.15:                               ;   in Loop: Header=BB0_11 Depth=1
	mov	x8, #0                          ; =0x0
	mov	x9, x21
LBB0_16:                                ;   Parent Loop BB0_11 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	sub	w10, w9, #1
	ands	w10, w10, w9
	eor	w9, w10, w9
	rbit	w11, w9
	clz	w11, w11
	lsl	x9, x9, x11
	add	w11, w11, #1
	lsl	x11, x10, x11
	orr	x9, x11, x9
	add	x8, x9, x8
	mov	x9, x10
	b.ne	LBB0_16
LBB0_17:                                ;   in Loop: Header=BB0_11 Depth=1
	cmp	x8, x22
	b.ne	LBB0_72
; %bb.18:                               ;   in Loop: Header=BB0_11 Depth=1
	mov	x0, x21
	bl	_square_recursive
	cmp	x0, x22
	b.ne	LBB0_73
; %bb.19:                               ;   in Loop: Header=BB0_11 Depth=1
	add	x21, x21, #1
	cmp	x21, #16, lsl #12               ; =65536
	b.ne	LBB0_11
; %bb.20:
Lloh14:
	adrp	x8, ___stderrp@GOTPAGE
Lloh15:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh16:
	ldr	x3, [x8]
Lloh17:
	adrp	x0, l_.str.19@PAGE
Lloh18:
	add	x0, x0, l_.str.19@PAGEOFF
	mov	w1, #125                        ; =0x7d
	mov	w2, #1                          ; =0x1
	bl	_fwrite
	cmp	w20, #1
	b.eq	LBB0_26
; %bb.21:
	cmp	w20, #2
	b.ne	LBB0_23
; %bb.22:
	ldr	x0, [x19, #8]
Lloh19:
	adrp	x1, l_.str.2@PAGE
Lloh20:
	add	x1, x1, l_.str.2@PAGEOFF
	bl	_strcmp
	cbz	w0, LBB0_24
LBB0_23:
Lloh21:
	adrp	x8, ___stderrp@GOTPAGE
Lloh22:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh23:
	ldr	x0, [x8]
	ldr	x8, [x19]
	str	x8, [sp]
Lloh24:
	adrp	x1, l_.str.3@PAGE
Lloh25:
	add	x1, x1, l_.str.3@PAGEOFF
	bl	_fprintf
	mov	w0, #1                          ; =0x1
LBB0_24:
	ldur	x8, [x29, #-96]
Lloh26:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh27:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh28:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB0_71
LBB0_25:
	add	sp, sp, #8, lsl #12             ; =32768
	add	sp, sp, #1280
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB0_26:
	mov	x21, #0                         ; =0x0
Lloh29:
	adrp	x22, l___const.measure_table_builds.builders@PAGE
Lloh30:
	add	x22, x22, l___const.measure_table_builds.builders@PAGEOFF
	add	x24, sp, #1264
Lloh31:
	adrp	x25, __MergedGlobals@PAGE
Lloh32:
	add	x25, x25, __MergedGlobals@PAGEOFF
	adrp	x26, _table16@PAGE+262140
	adrp	x27, _products8@PAGE+131070
LBB0_27:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_28 Depth 2
	mov	x19, #0                         ; =0x0
LBB0_28:                                ;   Parent Loop BB0_27 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	x1, sp, #296
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB0_75
; %bb.29:                               ;   in Loop: Header=BB0_28 Depth=2
	ldp	x28, x20, [sp, #296]
	ldr	x23, [x22, x21, lsl #3]
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	blr	x23
	add	x1, sp, #296
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB0_75
; %bb.30:                               ;   in Loop: Header=BB0_28 Depth=2
	ldp	x8, x9, [sp, #296]
	sub	x8, x8, x28
	sub	x9, x9, x20
	mov	w10, #51712                     ; =0xca00
	movk	w10, #15258, lsl #16
	madd	x8, x8, x10, x9
	ucvtf	d0, x8, #7
	str	d0, [x24, x19]
	ldrh	w8, [x25, #518]
	ldr	w9, [x26, _table16@PAGEOFF+262140]
	add	w8, w9, w8
	ldrh	w9, [x25, #1540]
	ldrh	w10, [x27, _products8@PAGEOFF+131070]
	add	w9, w9, w10
	add	w8, w8, w9
	ldr	x9, [x25]
	eor	x8, x9, x8
	str	x8, [x25]
	add	x19, x19, #8
	cmp	x19, #56
	b.ne	LBB0_28
; %bb.31:                               ;   in Loop: Header=BB0_27 Depth=1
	add	x0, sp, #1264
	mov	w1, #7                          ; =0x7
	mov	w2, #8                          ; =0x8
Lloh33:
	adrp	x3, _compare_double@PAGE
Lloh34:
	add	x3, x3, _compare_double@PAGEOFF
	bl	_qsort
Lloh35:
	adrp	x8, ___stderrp@GOTPAGE
Lloh36:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh37:
	ldr	x0, [x8]
Lloh38:
	adrp	x8, l___const.measure_table_builds.names@PAGE
Lloh39:
	add	x8, x8, l___const.measure_table_builds.names@PAGEOFF
	ldr	x8, [x8, x21, lsl #3]
	ldr	d0, [sp, #1288]
	ldr	d1, [sp, #1264]
	ldr	d2, [sp, #1312]
	stp	d1, d2, [sp, #40]
	str	d0, [sp, #32]
	mov	w9, #7                          ; =0x7
	str	x9, [sp, #24]
	mov	w9, #128                        ; =0x80
	str	x9, [sp, #16]
Lloh40:
	adrp	x9, l___const.measure_table_builds.bytes@PAGE
Lloh41:
	add	x9, x9, l___const.measure_table_builds.bytes@PAGEOFF
	ldr	w9, [x9, x21, lsl #2]
	stp	x8, x9, [sp]
Lloh42:
	adrp	x1, l_.str.25@PAGE
Lloh43:
	add	x1, x1, l_.str.25@PAGEOFF
	bl	_fprintf
	add	x21, x21, #1
	cmp	x21, #4
	b.ne	LBB0_27
; %bb.32:
Lloh44:
	adrp	x0, l_.str.12@PAGE
Lloh45:
	add	x0, x0, l_.str.12@PAGEOFF
	bl	_puts
	mov	x9, #0                          ; =0x0
	mov	w23, #1                         ; =0x1
	add	x26, sp, #1264
Lloh46:
	adrp	x27, _methods@PAGE
Lloh47:
	add	x27, x27, _methods@PAGEOFF
	mov	w25, #24                        ; =0x18
	add	x19, sp, #1204
	add	x20, sp, #1136
	add	x28, sp, #176
	adrp	x22, _random_state@PAGE
	b	LBB0_34
LBB0_33:                                ;   in Loop: Header=BB0_34 Depth=1
	ldr	x9, [sp, #88]                   ; 8-byte Folded Reload
	add	x9, x9, #1
	cmp	x9, #3
	b.eq	LBB0_70
LBB0_34:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_36 Depth 2
                                        ;       Child Loop BB0_39 Depth 3
                                        ;       Child Loop BB0_54 Depth 3
                                        ;         Child Loop BB0_56 Depth 4
                                        ;       Child Loop BB0_60 Depth 3
                                        ;         Child Loop BB0_62 Depth 4
                                        ;         Child Loop BB0_65 Depth 4
                                        ;       Child Loop BB0_68 Depth 3
Lloh48:
	adrp	x8, l___const.main.widths@PAGE
Lloh49:
	add	x8, x8, l___const.main.widths@PAGEOFF
	ldr	w8, [x8, x9, lsl #2]
                                        ; kill: def $w8 killed $w8 killed $x8 def $x8
	sub	w10, w8, #1
	str	w10, [sp, #108]                 ; 4-byte Folded Spill
	lsl	w11, w23, w10
	mov	w10, #-1                        ; =0xffffffff
	stp	xzr, x8, [sp, #160]             ; 16-byte Folded Spill
	lsl	w8, w10, w8
	cmp	x9, #2
	csinv	w8, w10, w8, eq
	stp	w8, w11, [sp, #152]             ; 8-byte Folded Spill
	str	x9, [sp, #88]                   ; 8-byte Folded Spill
	cmp	x9, #0
	mov	w8, #255                        ; =0xff
	mov	w9, #63                         ; =0x3f
	csel	w10, w9, w8, eq
	lsr	w8, w11, #1
	sub	w8, w8, #1
	stp	w8, w10, [sp, #100]             ; 8-byte Folded Spill
	b	LBB0_36
LBB0_35:                                ;   in Loop: Header=BB0_36 Depth=2
Lloh50:
	adrp	x8, ___stdoutp@GOTPAGE
Lloh51:
	ldr	x8, [x8, ___stdoutp@GOTPAGEOFF]
Lloh52:
	ldr	x0, [x8]
	bl	_fflush
	ldr	x8, [sp, #160]                  ; 8-byte Folded Reload
	add	x8, x8, #1
	str	x8, [sp, #160]                  ; 8-byte Folded Spill
	cmp	x8, #8
	adrp	x22, _random_state@PAGE
	mov	w23, #1                         ; =0x1
	add	x26, sp, #1264
	b.eq	LBB0_33
LBB0_36:                                ;   Parent Loop BB0_34 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB0_39 Depth 3
                                        ;       Child Loop BB0_54 Depth 3
                                        ;         Child Loop BB0_56 Depth 4
                                        ;       Child Loop BB0_60 Depth 3
                                        ;         Child Loop BB0_62 Depth 4
                                        ;         Child Loop BB0_65 Depth 4
                                        ;       Child Loop BB0_68 Depth 3
	mov	x21, #0                         ; =0x0
	b	LBB0_39
LBB0_37:                                ;   in Loop: Header=BB0_39 Depth=3
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	ldr	w9, [sp, #100]                  ; 4-byte Folded Reload
	and	w9, w9, w8
	ldr	w10, [sp, #156]                 ; 4-byte Folded Reload
	orr	w0, w9, w10
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	ldr	w10, [sp, #104]                 ; 4-byte Folded Reload
	udiv	w9, w8, w10
	msub	w9, w9, w10, w8
	add	w9, w0, w9
	str	x8, [x22, _random_state@PAGEOFF]
	add	w1, w9, #1
LBB0_38:                                ;   in Loop: Header=BB0_39 Depth=3
	add	x8, x26, x21
	stp	w0, w1, [x8]
	bl	_check_pair
	add	x21, x21, #8
	cmp	x21, #8, lsl #12                ; =32768
	b.eq	LBB0_52
LBB0_39:                                ;   Parent Loop BB0_34 Depth=1
                                        ;     Parent Loop BB0_36 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [x22, _random_state@PAGEOFF]
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	ldp	w11, w10, [sp, #152]            ; 8-byte Folded Reload
	and	w9, w11, w8
	orr	w0, w9, w10
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	str	x8, [x22, _random_state@PAGEOFF]
	and	w9, w11, w8
	orr	w1, w9, w10
	ldr	x9, [sp, #160]                  ; 8-byte Folded Reload
	cmp	w9, #3
	b.le	LBB0_43
; %bb.40:                               ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #5
	b.gt	LBB0_47
; %bb.41:                               ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #4
	b.eq	LBB0_49
; %bb.42:                               ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #5
	csel	w1, w23, w1, eq
	b	LBB0_38
LBB0_43:                                ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #1
	b.eq	LBB0_37
; %bb.44:                               ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #2
	b.eq	LBB0_51
; %bb.45:                               ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #3
	b.ne	LBB0_38
; %bb.46:                               ;   in Loop: Header=BB0_39 Depth=3
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	ldr	x11, [sp, #168]                 ; 8-byte Folded Reload
	udiv	w9, w8, w11
	msub	w9, w9, w11, w8
	lsl	w9, w23, w9
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	udiv	w10, w8, w11
	msub	w10, w10, w11, w8
	lsl	w10, w23, w10
	ldr	w12, [sp, #156]                 ; 4-byte Folded Reload
	orr	w9, w9, w12
	orr	w0, w9, w10
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	udiv	w9, w8, w11
	msub	w9, w9, w11, w8
	lsl	w9, w23, w9
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	str	x8, [x22, _random_state@PAGEOFF]
	udiv	w10, w8, w11
	msub	w8, w10, w11, w8
	lsl	w8, w23, w8
	orr	w9, w9, w12
	orr	w1, w9, w8
	b	LBB0_38
LBB0_47:                                ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #6
	b.eq	LBB0_50
; %bb.48:                               ;   in Loop: Header=BB0_39 Depth=3
	cmp	w9, #7
	ldr	w8, [sp, #156]                  ; 4-byte Folded Reload
	csel	w1, w8, w1, eq
	b	LBB0_38
LBB0_49:                                ;   in Loop: Header=BB0_39 Depth=3
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	ldr	w11, [sp, #108]                 ; 4-byte Folded Reload
	udiv	w9, w8, w11
	msub	w9, w9, w11, w8
	lsl	w9, w23, w9
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	udiv	w10, w8, w11
	msub	w10, w10, w11, w8
	lsl	w10, w23, w10
	orr	w9, w10, w9
	ldr	w12, [sp, #152]                 ; 4-byte Folded Reload
	eor	w0, w9, w12
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	udiv	w9, w8, w11
	msub	w9, w9, w11, w8
	lsl	w9, w23, w9
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	str	x8, [x22, _random_state@PAGEOFF]
	udiv	w10, w8, w11
	msub	w8, w10, w11, w8
	lsl	w8, w23, w8
	orr	w8, w8, w9
	eor	w1, w8, w12
	b	LBB0_38
LBB0_50:                                ;   in Loop: Header=BB0_39 Depth=3
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x9, x8, x8, lsl #17
	str	x9, [x22, _random_state@PAGEOFF]
	and	w8, w8, #0xfe
	orr	w1, w8, #0x1
	b	LBB0_38
LBB0_51:                                ;   in Loop: Header=BB0_39 Depth=3
	mov	x1, x0
	b	LBB0_38
LBB0_52:                                ;   in Loop: Header=BB0_36 Depth=2
	mov	x26, #0                         ; =0x0
	mov	w11, #0                         ; =0x0
	movi.2d	v0, #0000000000000000
	add	x8, sp, #925
	stur	q0, [x8, #255]
	str	q0, [sp, #1168]
	str	q0, [sp, #1152]
	str	q0, [sp, #1136]
	str	xzr, [sp, #288]
	stp	q0, q0, [sp, #256]
	stp	q0, q0, [sp, #224]
	stp	q0, q0, [sp, #192]
	str	q0, [sp, #176]
	b	LBB0_54
LBB0_53:                                ;   in Loop: Header=BB0_54 Depth=3
	add	x26, x26, #1
	cmp	x26, #15
	b.eq	LBB0_58
LBB0_54:                                ;   Parent Loop BB0_34 Depth=1
                                        ;     Parent Loop BB0_36 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_56 Depth 4
	madd	x8, x26, x25, x27
	ldr	w9, [x8, #16]
	ldr	x10, [sp, #168]                 ; 8-byte Folded Reload
	cmp	w10, w9
	b.hi	LBB0_53
; %bb.55:                               ;   in Loop: Header=BB0_54 Depth=3
	mov	x24, x11
	str	w26, [x19, w11, uxtw #2]
	ldr	x21, [x8, #8]
	mov	w8, #1                          ; =0x1
	add	x22, x28, x26, lsl #3
LBB0_56:                                ;   Parent Loop BB0_34 Depth=1
                                        ;     Parent Loop BB0_36 Depth=2
                                        ;       Parent Loop BB0_54 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	mov	x23, x8
	add	x1, sp, #1264
	mov	x0, x21
	mov	x2, x8
	mov	x3, x22
	bl	_sample
	mov	w9, #4816                       ; =0x12d0
	movk	w9, #19, lsl #16
	lsl	w8, w23, #1
	cmp	x0, x9
	b.lo	LBB0_56
; %bb.57:                               ;   in Loop: Header=BB0_54 Depth=3
	add	w11, w24, #1
	mov	w8, #19264                      ; =0x4b40
	movk	w8, #76, lsl #16
	umaddl	x8, w8, w23, x0
	sub	x8, x8, #1
	udiv	x9, x8, x0
	cmp	x0, x8
	csinc	w8, w9, wzr, ls
	str	w8, [x20, x26, lsl #2]
	b	LBB0_53
LBB0_58:                                ;   in Loop: Header=BB0_36 Depth=2
	mov	x22, #0                         ; =0x0
	sub	w8, w11, #1
	str	w11, [sp, #132]                 ; 4-byte Folded Spill
	mov	w9, w11
	stp	x9, x8, [sp, #136]              ; 16-byte Folded Spill
	add	x9, x19, w8, uxtw #2
	sub	x8, x8, #1
	stp	x8, x9, [sp, #112]              ; 16-byte Folded Spill
	b	LBB0_60
LBB0_59:                                ;   in Loop: Header=BB0_60 Depth=3
	add	x22, x22, #1
	cmp	x22, #7
	b.eq	LBB0_66
LBB0_60:                                ;   Parent Loop BB0_34 Depth=1
                                        ;     Parent Loop BB0_36 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB0_62 Depth 4
                                        ;         Child Loop BB0_65 Depth 4
	ldr	x8, [sp, #144]                  ; 8-byte Folded Reload
	cbz	w8, LBB0_64
; %bb.61:                               ;   in Loop: Header=BB0_60 Depth=3
	adrp	x15, _random_state@PAGE
	ldr	x8, [x15, _random_state@PAGEOFF]
	ldp	x9, x10, [sp, #112]             ; 16-byte Folded Reload
	ldr	w16, [sp, #132]                 ; 4-byte Folded Reload
	mov	x11, x16
LBB0_62:                                ;   Parent Loop BB0_34 Depth=1
                                        ;     Parent Loop BB0_36 Depth=2
                                        ;       Parent Loop BB0_60 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	eor	x8, x8, x8, lsl #13
	eor	x8, x8, x8, lsr #7
	eor	x8, x8, x8, lsl #17
	udiv	w12, w8, w11
	msub	w12, w12, w11, w8
	ldr	w13, [x10]
	ldr	w14, [x19, w12, uxtw #2]
	str	w14, [x10], #-4
	str	w13, [x19, w12, uxtw #2]
	sub	w11, w11, #1
	mov	x12, x9
	sub	x9, x9, #1
	cbnz	w12, LBB0_62
; %bb.63:                               ;   in Loop: Header=BB0_60 Depth=3
	str	x8, [x15, _random_state@PAGEOFF]
	cbz	w16, LBB0_59
LBB0_64:                                ;   in Loop: Header=BB0_60 Depth=3
	add	x26, sp, #1204
	ldr	x23, [sp, #136]                 ; 8-byte Folded Reload
LBB0_65:                                ;   Parent Loop BB0_34 Depth=1
                                        ;     Parent Loop BB0_36 Depth=2
                                        ;       Parent Loop BB0_60 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ldr	w24, [x26], #4
	umaddl	x8, w24, w25, x27
	ldr	x0, [x8, #8]
	ldr	w21, [x20, x24, lsl #2]
	add	x3, x28, x24, lsl #3
	add	x1, sp, #1264
	mov	x2, x21
	bl	_sample
	add	x10, sp, #296
	mov	w9, #56                         ; =0x38
	mov	x8, #4661225614328463360        ; =0x40b0000000000000
	ucvtf	d0, x0
	ucvtf	d1, w21
	fmov	d2, x8
	fmul	d1, d1, d2
	fdiv	d0, d0, d1
	umaddl	x8, w24, w9, x10
	str	d0, [x8, x22, lsl #3]
	subs	x23, x23, #1
	b.ne	LBB0_65
	b	LBB0_59
LBB0_66:                                ;   in Loop: Header=BB0_36 Depth=2
	mov	x22, #0                         ; =0x0
	add	x21, sp, #296
	mov	x23, x27
	b	LBB0_68
LBB0_67:                                ;   in Loop: Header=BB0_68 Depth=3
	add	x22, x22, #1
	add	x21, x21, #56
	add	x23, x23, #24
	cmp	x22, #15
	b.eq	LBB0_35
LBB0_68:                                ;   Parent Loop BB0_34 Depth=1
                                        ;     Parent Loop BB0_36 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	w26, [x20, x22, lsl #2]
	cbz	w26, LBB0_67
; %bb.69:                               ;   in Loop: Header=BB0_68 Depth=3
	mov	x0, x21
	mov	w1, #7                          ; =0x7
	mov	w2, #8                          ; =0x8
Lloh53:
	adrp	x3, _compare_double@PAGE
Lloh54:
	add	x3, x3, _compare_double@PAGEOFF
	bl	_qsort
Lloh55:
	adrp	x8, l___const.main.patterns@PAGE
Lloh56:
	add	x8, x8, l___const.main.patterns@PAGEOFF
	ldr	x9, [sp, #160]                  ; 8-byte Folded Reload
	ldr	x11, [x8, x9, lsl #3]
	ldr	x9, [x23]
	ldr	d0, [x21, #24]
	ldr	d1, [x21]
	ldr	d2, [x21, #48]
	ldr	x10, [x28, x22, lsl #3]
	str	x10, [sp, #72]
	stp	d1, d2, [sp, #56]
	str	d0, [sp, #48]
	mov	w10, #7                         ; =0x7
	stp	x26, x10, [sp, #32]
	mov	w10, #4096                      ; =0x1000
	stp	x9, x10, [sp, #16]
	ldr	x8, [sp, #168]                  ; 8-byte Folded Reload
	stp	x8, x11, [sp]
Lloh57:
	adrp	x0, l_.str.13@PAGE
Lloh58:
	add	x0, x0, l_.str.13@PAGEOFF
	bl	_printf
	b	LBB0_67
LBB0_70:
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
	adrp	x1, l_.str.14@PAGE
Lloh65:
	add	x1, x1, l_.str.14@PAGEOFF
	bl	_fprintf
	mov	w0, #0                          ; =0x0
	ldur	x8, [x29, #-96]
Lloh66:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh67:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh68:
	ldr	x9, [x9]
	cmp	x9, x8
	b.eq	LBB0_25
LBB0_71:
	bl	___stack_chk_fail
LBB0_72:
	bl	_main.cold.2
LBB0_73:
	bl	_main.cold.3
LBB0_74:
	bl	_main.cold.1
LBB0_75:
	bl	_abort
	.loh AdrpLdrGotLdr	Lloh2, Lloh3, Lloh4
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpLdrGotLdr	Lloh5, Lloh6, Lloh7
	.loh AdrpAdd	Lloh12, Lloh13
	.loh AdrpAdd	Lloh17, Lloh18
	.loh AdrpLdrGotLdr	Lloh14, Lloh15, Lloh16
	.loh AdrpAdd	Lloh19, Lloh20
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpLdrGotLdr	Lloh21, Lloh22, Lloh23
	.loh AdrpLdrGotLdr	Lloh26, Lloh27, Lloh28
	.loh AdrpAdd	Lloh31, Lloh32
	.loh AdrpAdd	Lloh29, Lloh30
	.loh AdrpAdd	Lloh42, Lloh43
	.loh AdrpAdd	Lloh40, Lloh41
	.loh AdrpAdd	Lloh38, Lloh39
	.loh AdrpLdrGotLdr	Lloh35, Lloh36, Lloh37
	.loh AdrpAdd	Lloh33, Lloh34
	.loh AdrpAdd	Lloh46, Lloh47
	.loh AdrpAdd	Lloh44, Lloh45
	.loh AdrpAdd	Lloh48, Lloh49
	.loh AdrpLdrGotLdr	Lloh50, Lloh51, Lloh52
	.loh AdrpAdd	Lloh57, Lloh58
	.loh AdrpAdd	Lloh55, Lloh56
	.loh AdrpAdd	Lloh53, Lloh54
	.loh AdrpLdrGotLdr	Lloh66, Lloh67, Lloh68
	.loh AdrpAdd	Lloh64, Lloh65
	.loh AdrpLdr	Lloh62, Lloh63
	.loh AdrpLdrGotLdr	Lloh59, Lloh60, Lloh61
	.loh AdrpLdrGot	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function sample
_sample:                                ; @sample
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
	mov	x19, x3
	mov	x20, x2
	mov	x22, x1
	mov	x21, x0
	mov	x1, sp
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB1_8
; %bb.1:
	ldp	x25, x23, [sp]
	mov	x24, #0                         ; =0x0
	cbz	w20, LBB1_6
; %bb.2:
	mov	w26, #0                         ; =0x0
	add	x22, x22, #4
LBB1_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_4 Depth 2
	mov	w27, #4096                      ; =0x1000
	mov	x28, x22
LBB1_4:                                 ;   Parent Loop BB1_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldp	w0, w1, [x28, #-4]
	blr	x21
	add	x24, x0, x24
	add	x28, x28, #8
	subs	x27, x27, #1
	b.ne	LBB1_4
; %bb.5:                                ;   in Loop: Header=BB1_3 Depth=1
	add	w26, w26, #1
	cmp	w26, w20
	b.ne	LBB1_3
LBB1_6:
	mov	x1, sp
	mov	w0, #6                          ; =0x6
	bl	_clock_gettime
	cbnz	w0, LBB1_8
; %bb.7:
	ldp	x8, x9, [sp]
	sub	x8, x8, x25
	mov	w10, #51712                     ; =0xca00
	movk	w10, #15258, lsl #16
	sub	x9, x9, x23
	madd	x0, x8, x10, x9
	adrp	x8, __MergedGlobals@PAGE
	ldr	x9, [x8, __MergedGlobals@PAGEOFF]
	eor	x9, x9, x24
	str	x9, [x8, __MergedGlobals@PAGEOFF]
	str	x24, [x19]
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB1_8:
	bl	_abort
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function compare_double
_compare_double:                        ; @compare_double
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
	.p2align	2                               ; -- Begin function initialize_table8
_initialize_table8:                     ; @initialize_table8
	.cfi_startproc
; %bb.0:
	mov	x8, #0                          ; =0x0
	mov	w9, #0                          ; =0x0
Lloh69:
	adrp	x10, __MergedGlobals@PAGE
Lloh70:
	add	x10, x10, __MergedGlobals@PAGEOFF
LBB3_1:                                 ; =>This Inner Loop Header: Depth=1
	add	w11, w8, w9
	add	x12, x10, x8
	strh	w9, [x12, #8]
	add	w9, w11, #1
	add	x8, x8, #2
	cmp	x8, #512
	b.ne	LBB3_1
; %bb.2:
	ret
	.loh AdrpAdd	Lloh69, Lloh70
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function initialize_table16
_initialize_table16:                    ; @initialize_table16
	.cfi_startproc
; %bb.0:
	mov	x8, #0                          ; =0x0
	mov	w9, #0                          ; =0x0
Lloh71:
	adrp	x10, _table16@PAGE
Lloh72:
	add	x10, x10, _table16@PAGEOFF
LBB4_1:                                 ; =>This Inner Loop Header: Depth=1
	add	w11, w8, w9
	str	w9, [x10], #4
	add	w9, w11, #1
	add	x8, x8, #2
	cmp	x8, #32, lsl #12                ; =131072
	b.ne	LBB4_1
; %bb.2:
	ret
	.loh AdrpAdd	Lloh71, Lloh72
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function initialize_quarter8
_initialize_quarter8:                   ; @initialize_quarter8
	.cfi_startproc
; %bb.0:
	mov	x9, #0                          ; =0x0
	mov	w8, #0                          ; =0x0
Lloh73:
	adrp	x10, __MergedGlobals@PAGE+520
	strh	wzr, [x10, __MergedGlobals@PAGEOFF+520]
Lloh74:
	adrp	x10, __MergedGlobals@PAGE
Lloh75:
	add	x10, x10, __MergedGlobals@PAGEOFF
LBB5_1:                                 ; =>This Inner Loop Header: Depth=1
	add	x11, x10, x9, lsl #1
	add	x12, x9, #1
	lsr	x9, x12, #1
	add	w8, w8, w9
	strh	w8, [x11, #522]
	mov	x9, x12
	cmp	x12, #511
	b.ne	LBB5_1
; %bb.2:
	ret
	.loh AdrpAdd	Lloh74, Lloh75
	.loh AdrpAdrp	Lloh73, Lloh74
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ; -- Begin function initialize_products8
lCPI6_0:
	.short	0                               ; 0x0
	.short	1                               ; 0x1
	.short	2                               ; 0x2
	.short	3                               ; 0x3
	.short	4                               ; 0x4
	.short	5                               ; 0x5
	.short	6                               ; 0x6
	.short	7                               ; 0x7
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	2
_initialize_products8:                  ; @initialize_products8
	.cfi_startproc
; %bb.0:
	mov	x8, #0                          ; =0x0
Lloh76:
	adrp	x9, _products8@PAGE+256
Lloh77:
	add	x9, x9, _products8@PAGEOFF+256
Lloh78:
	adrp	x10, lCPI6_0@PAGE
Lloh79:
	ldr	q0, [x10, lCPI6_0@PAGEOFF]
LBB6_1:                                 ; =>This Inner Loop Header: Depth=1
	lsl	w10, w8, #3
	dup.8h	v1, w10
	dup.8h	v2, w8
	mul.8h	v2, v2, v0
	add.8h	v3, v2, v1
	add.8h	v4, v3, v1
	add.8h	v5, v4, v1
	stp	q2, q3, [x9, #-256]
	stp	q4, q5, [x9, #-224]
	add.8h	v2, v5, v1
	add.8h	v3, v2, v1
	add.8h	v4, v3, v1
	add.8h	v5, v4, v1
	stp	q2, q3, [x9, #-192]
	add.8h	v2, v5, v1
	add.8h	v3, v2, v1
	add.8h	v6, v3, v1
	stp	q4, q5, [x9, #-160]
	add.8h	v4, v6, v1
	stp	q2, q3, [x9, #-128]
	add.8h	v2, v4, v1
	stp	q6, q4, [x9, #-96]
	add.8h	v3, v2, v1
	add.8h	v4, v3, v1
	add.8h	v5, v4, v1
	stp	q2, q3, [x9, #-64]
	stp	q4, q5, [x9, #-32]
	add.8h	v2, v5, v1
	add.8h	v3, v2, v1
	add.8h	v4, v3, v1
	add.8h	v5, v4, v1
	stp	q2, q3, [x9]
	add.8h	v2, v5, v1
	add.8h	v3, v2, v1
	add.8h	v6, v3, v1
	stp	q4, q5, [x9, #32]
	add.8h	v4, v6, v1
	stp	q2, q3, [x9, #64]
	add.8h	v2, v4, v1
	stp	q6, q4, [x9, #96]
	add.8h	v3, v2, v1
	add.8h	v4, v3, v1
	add.8h	v5, v4, v1
	stp	q2, q3, [x9, #128]
	stp	q4, q5, [x9, #160]
	add.8h	v2, v5, v1
	add.8h	v3, v2, v1
	add.8h	v4, v3, v1
	add.8h	v1, v4, v1
	stp	q2, q3, [x9, #192]
	stp	q4, q1, [x9, #224]
	add	x8, x8, #1
	add	x9, x9, #512
	cmp	x8, #256
	b.ne	LBB6_1
; %bb.2:
	ret
	.loh AdrpLdr	Lloh78, Lloh79
	.loh AdrpAdd	Lloh76, Lloh77
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function check_pair
_check_pair:                            ; @check_pair
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
	mov	x20, x1
	mov	x19, x0
	umull	x21, w1, w0
	bl	_native_mul
	cmp	x0, x21
	b.ne	LBB7_19
; %bb.1:
	mov	x0, x19
	mov	x1, x20
	bl	_shift_add
	cmp	x0, x21
	b.ne	LBB7_20
; %bb.2:
	mov	x0, x19
	mov	x1, x20
	bl	_sparse_multiply
	cmp	x0, x21
	b.ne	LBB7_21
; %bb.3:
	mov	x0, x19
	mov	x1, x20
	bl	_software_karatsuba
	cmp	x0, x21
	b.ne	LBB7_22
; %bb.4:
	mov	x0, x19
	mov	x1, x20
	bl	_square_plus_delta
	cmp	x0, x21
	b.ne	LBB7_23
; %bb.5:
	mov	x0, x19
	mov	x1, x20
	bl	_equal_aware_recursive
	cmp	x0, x21
	b.ne	LBB7_24
; %bb.6:
	mov	x0, x19
	mov	x1, x20
	bl	_midpoint_prefix
	cmp	x0, x21
	b.ne	LBB7_25
; %bb.7:
	mov	x0, x19
	mov	x1, x20
	bl	_midpoint_set_bits
	cmp	x0, x21
	b.ne	LBB7_26
; %bb.8:
	mov	x0, x19
	mov	x1, x20
	bl	_midpoint_recursive
	cmp	x0, x21
	b.ne	LBB7_27
; %bb.9:
	orr	w23, w19, w20
	cmp	w23, #255
	b.hi	LBB7_11
; %bb.10:
	mov	x0, x19
	mov	x1, x20
	bl	_midpoint_table8
	cmp	x0, x21
	b.ne	LBB7_28
LBB7_11:
	lsr	w22, w23, #16
	cbnz	w22, LBB7_13
; %bb.12:
	mov	x0, x19
	mov	x1, x20
	bl	_midpoint_table16
	cmp	x0, x21
	b.ne	LBB7_29
LBB7_13:
	cmp	w23, #255
	b.hi	LBB7_16
; %bb.14:
	mov	x0, x19
	mov	x1, x20
	bl	_quarter_table8
	cmp	x0, x21
	b.ne	LBB7_30
; %bb.15:
	mov	x0, x19
	mov	x1, x20
	bl	_full_product_table8
	cmp	x0, x21
	b.ne	LBB7_31
LBB7_16:
	cbnz	w22, LBB7_18
; %bb.17:
	mov	x0, x19
	mov	x1, x20
	bl	_equal_aware_table16
	cmp	x0, x21
	b.ne	LBB7_32
LBB7_18:
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB7_19:
Lloh80:
	adrp	x9, _methods@PAGE+24
Lloh81:
	add	x9, x9, _methods@PAGEOFF+24
	b	LBB7_33
LBB7_20:
Lloh82:
	adrp	x9, _methods@PAGE+48
Lloh83:
	add	x9, x9, _methods@PAGEOFF+48
	b	LBB7_33
LBB7_21:
Lloh84:
	adrp	x9, _methods@PAGE+72
Lloh85:
	add	x9, x9, _methods@PAGEOFF+72
	b	LBB7_33
LBB7_22:
Lloh86:
	adrp	x9, _methods@PAGE+96
Lloh87:
	add	x9, x9, _methods@PAGEOFF+96
	b	LBB7_33
LBB7_23:
Lloh88:
	adrp	x9, _methods@PAGE+120
Lloh89:
	add	x9, x9, _methods@PAGEOFF+120
	b	LBB7_33
LBB7_24:
Lloh90:
	adrp	x9, _methods@PAGE+144
Lloh91:
	add	x9, x9, _methods@PAGEOFF+144
	b	LBB7_33
LBB7_25:
Lloh92:
	adrp	x9, _methods@PAGE+168
Lloh93:
	add	x9, x9, _methods@PAGEOFF+168
	b	LBB7_33
LBB7_26:
Lloh94:
	adrp	x9, _methods@PAGE+192
Lloh95:
	add	x9, x9, _methods@PAGEOFF+192
	b	LBB7_33
LBB7_27:
Lloh96:
	adrp	x9, _methods@PAGE+216
Lloh97:
	add	x9, x9, _methods@PAGEOFF+216
	b	LBB7_33
LBB7_28:
Lloh98:
	adrp	x9, _methods@PAGE+240
Lloh99:
	add	x9, x9, _methods@PAGEOFF+240
	b	LBB7_33
LBB7_29:
Lloh100:
	adrp	x9, _methods@PAGE+264
Lloh101:
	add	x9, x9, _methods@PAGEOFF+264
	b	LBB7_33
LBB7_30:
Lloh102:
	adrp	x9, _methods@PAGE+288
Lloh103:
	add	x9, x9, _methods@PAGEOFF+288
	b	LBB7_33
LBB7_31:
Lloh104:
	adrp	x9, _methods@PAGE+312
Lloh105:
	add	x9, x9, _methods@PAGEOFF+312
	b	LBB7_33
LBB7_32:
Lloh106:
	adrp	x9, _methods@PAGE+336
Lloh107:
	add	x9, x9, _methods@PAGEOFF+336
LBB7_33:
Lloh108:
	adrp	x8, ___stderrp@GOTPAGE
Lloh109:
	ldr	x8, [x8, ___stderrp@GOTPAGEOFF]
Lloh110:
	ldr	x8, [x8]
	ldr	x9, [x9]
	stp	x0, x21, [sp, #24]
	stp	x19, x20, [sp, #8]
	str	x9, [sp]
Lloh111:
	adrp	x1, l_.str.20@PAGE
Lloh112:
	add	x1, x1, l_.str.20@PAGEOFF
	mov	x0, x8
	bl	_fprintf
	mov	w0, #2                          ; =0x2
	bl	_exit
	.loh AdrpAdd	Lloh80, Lloh81
	.loh AdrpAdd	Lloh82, Lloh83
	.loh AdrpAdd	Lloh84, Lloh85
	.loh AdrpAdd	Lloh86, Lloh87
	.loh AdrpAdd	Lloh88, Lloh89
	.loh AdrpAdd	Lloh90, Lloh91
	.loh AdrpAdd	Lloh92, Lloh93
	.loh AdrpAdd	Lloh94, Lloh95
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpAdd	Lloh98, Lloh99
	.loh AdrpAdd	Lloh100, Lloh101
	.loh AdrpAdd	Lloh102, Lloh103
	.loh AdrpAdd	Lloh104, Lloh105
	.loh AdrpAdd	Lloh106, Lloh107
	.loh AdrpAdd	Lloh111, Lloh112
	.loh AdrpLdrGotLdr	Lloh108, Lloh109, Lloh110
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function square_recursive
_square_recursive:                      ; @square_recursive
	.cfi_startproc
; %bb.0:
	cmp	w0, #255
	b.hi	LBB8_2
; %bb.1:
Lloh113:
	adrp	x8, __MergedGlobals@PAGE
Lloh114:
	add	x8, x8, __MergedGlobals@PAGEOFF
	add	x8, x8, w0, uxtw #1
	ldrh	w0, [x8, #8]
	ret
LBB8_2:
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
	bl	_square_recursive
	mov	x21, x0
	mov	x0, x19
	bl	_square_recursive
	mov	x19, x0
	mov	x0, x20
	bl	_square_recursive
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
	.loh AdrpAdd	Lloh113, Lloh114
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function call_floor
_call_floor:                            ; @call_floor
	.cfi_startproc
; %bb.0:
	mov	w8, w1
	add	x0, x8, w0, uxtw
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function native_mul
_native_mul:                            ; @native_mul
	.cfi_startproc
; %bb.0:
	umull	x0, w1, w0
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_add
_shift_add:                             ; @shift_add
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w9, w0, w1, lo
	cbz	w9, LBB11_4
; %bb.1:
	mov	x8, x0
	mov	x0, #0                          ; =0x0
	cmp	w8, w1
	csel	w8, w8, w1, hi
LBB11_2:                                ; =>This Inner Loop Header: Depth=1
	tst	w9, #0x1
	csel	x10, xzr, x8, eq
	add	x0, x10, x0
	lsl	x8, x8, #1
	lsr	w10, w9, #1
	cmp	w9, #1
	mov	x9, x10
	b.hi	LBB11_2
; %bb.3:
	ret
LBB11_4:
	mov	x0, #0                          ; =0x0
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function sparse_multiply
_sparse_multiply:                       ; @sparse_multiply
	.cfi_startproc
; %bb.0:
	fmov	s0, w0
	cnt.8b	v0, v0
	uaddlv.8b	h0, v0
	fmov	w10, s0
	fmov	s0, w1
	cnt.8b	v0, v0
	uaddlv.8b	h0, v0
	fmov	w11, s0
	cmp	w10, w11
	csel	w9, w0, w1, lo
	cbz	w9, LBB12_4
; %bb.1:
	mov	x8, x0
	mov	x0, #0                          ; =0x0
	cmp	w10, w11
	csel	w8, w1, w8, lo
LBB12_2:                                ; =>This Inner Loop Header: Depth=1
	rbit	w10, w9
	clz	w10, w10
	lsl	x10, x8, x10
	add	x0, x10, x0
	sub	w10, w9, #1
	ands	w9, w10, w9
	b.ne	LBB12_2
; %bb.3:
	ret
LBB12_4:
	mov	x0, #0                          ; =0x0
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function software_karatsuba
_software_karatsuba:                    ; @software_karatsuba
	.cfi_startproc
; %bb.0:
	mov	x8, #0                          ; =0x0
	cbz	w0, LBB13_5
; %bb.1:
	cbz	w1, LBB13_5
; %bb.2:
	cmp	w0, w1
	csel	w8, w0, w1, hi
	cmp	w8, #255
	b.hi	LBB13_4
; %bb.3:
	b	_midpoint_table8
LBB13_4:
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
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
	.cfi_offset w27, -88
	.cfi_offset w28, -96
	clz	w8, w8
	mov	w9, #32                         ; =0x20
	sub	w25, w9, w8
	lsr	w26, w25, #1
	mov	w8, #-1                         ; =0xffffffff
	lsl	w8, w8, w26
	lsr	w19, w0, w26
	bic	w20, w0, w8
	lsr	w21, w1, w26
	bic	w22, w1, w8
	sub	w27, w20, w19
	sub	w28, w22, w21
	mov	x0, x19
	mov	x1, x21
	bl	_software_karatsuba
	mov	x23, x0
	mov	x0, x20
	mov	x1, x22
	bl	_software_karatsuba
	mov	x24, x0
	subs	w8, w21, w22
	csel	w1, w8, w28, hi
	cset	w21, hs
	subs	w8, w19, w20
	csel	w0, w8, w27, hi
	cset	w19, lo
	bl	_software_karatsuba
	eor	w8, w19, w21
	cmp	w8, #0
	cneg	x8, x0, ne
	add	x9, x24, x23
	add	x8, x9, x8
	and	w9, w25, #0x3e
	lsl	x9, x23, x9
	lsl	x8, x8, x26
	add	x9, x24, x9
	add	x8, x9, x8
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
LBB13_5:
	mov	x0, x8
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function square_plus_delta
_square_plus_delta:                     ; @square_plus_delta
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
	cmp	w0, w1
	csel	w19, w0, w1, lo
	csel	w21, w0, w1, hi
	mov	x0, x19
	bl	_square_recursive
	mov	x20, x0
	sub	w1, w21, w19
	mov	x0, x19
	bl	_sparse_multiply
	add	x0, x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function equal_aware_recursive
_equal_aware_recursive:                 ; @equal_aware_recursive
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	b.ne	LBB15_2
; %bb.1:
	b	_square_recursive
LBB15_2:
	b	_software_karatsuba
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function midpoint_prefix
_midpoint_prefix:                       ; @midpoint_prefix
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w8, w0, w1, lo
	csel	w9, w0, w1, hi
	sub	w9, w9, w8
	lsr	w11, w9, #1
	mov	x10, #0                         ; =0x0
	adds	w12, w11, w8
	b.eq	LBB16_3
; %bb.1:
	mov	x13, #0                         ; =0x0
	clz	w14, w12
	eor	w14, w14, #0x1f
LBB16_2:                                ; =>This Inner Loop Header: Depth=1
	lsr	w15, w12, w14
	lsl	x16, x13, #2
	ands	w15, w15, #0x1
	csinc	x16, xzr, x16, eq
	add	x10, x16, x10, lsl #2
	orr	x13, x15, x13, lsl #1
	sub	w14, w14, #1
	cmn	w14, #1
	b.ne	LBB16_2
LBB16_3:
	cmp	w9, #2
	b.hs	LBB16_5
; %bb.4:
	mov	x12, #0                         ; =0x0
	sbfx	w9, w9, #0, #1
	and	w8, w9, w8
	add	x8, x10, x8
	sub	x0, x8, x12
	ret
LBB16_5:
	mov	x12, #0                         ; =0x0
	mov	x13, #0                         ; =0x0
	clz	w14, w11
	eor	w14, w14, #0x1f
LBB16_6:                                ; =>This Inner Loop Header: Depth=1
	lsr	w15, w11, w14
	lsl	x16, x13, #2
	ands	w15, w15, #0x1
	csinc	x16, xzr, x16, eq
	add	x12, x16, x12, lsl #2
	orr	x13, x15, x13, lsl #1
	sub	w14, w14, #1
	cmn	w14, #1
	b.ne	LBB16_6
; %bb.7:
	sbfx	w9, w9, #0, #1
	and	w8, w9, w8
	add	x8, x10, x8
	sub	x0, x8, x12
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function midpoint_set_bits
_midpoint_set_bits:                     ; @midpoint_set_bits
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w8, w0, w1, lo
	csel	w9, w0, w1, hi
	sub	w9, w9, w8
	lsr	w11, w9, #1
	mov	x10, #0                         ; =0x0
	adds	w12, w11, w8
	b.eq	LBB17_2
LBB17_1:                                ; =>This Inner Loop Header: Depth=1
	sub	w13, w12, #1
	ands	w13, w13, w12
	eor	w12, w13, w12
	rbit	w14, w12
	clz	w14, w14
	lsl	x12, x12, x14
	add	w14, w14, #1
	lsl	x14, x13, x14
	orr	x12, x14, x12
	add	x10, x12, x10
	mov	x12, x13
	b.ne	LBB17_1
LBB17_2:
	cmp	w9, #2
	b.hs	LBB17_4
; %bb.3:
	mov	x12, #0                         ; =0x0
	sbfx	w9, w9, #0, #1
	and	w8, w9, w8
	add	x8, x10, x8
	sub	x0, x8, x12
	ret
LBB17_4:
	mov	x12, #0                         ; =0x0
LBB17_5:                                ; =>This Inner Loop Header: Depth=1
	sub	w13, w11, #1
	ands	w13, w13, w11
	eor	w11, w13, w11
	rbit	w14, w11
	clz	w14, w14
	lsl	x11, x11, x14
	add	w14, w14, #1
	lsl	x14, x13, x14
	orr	x11, x14, x11
	add	x12, x11, x12
	mov	x11, x13
	b.ne	LBB17_5
; %bb.6:
	sbfx	w9, w9, #0, #1
	and	w8, w9, w8
	add	x8, x10, x8
	sub	x0, x8, x12
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function midpoint_recursive
_midpoint_recursive:                    ; @midpoint_recursive
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
	cmp	w0, w1
	csel	w21, w0, w1, lo
	csel	w8, w0, w1, hi
	sub	w22, w8, w21
	lsr	w19, w22, #1
	add	w0, w19, w21
	bl	_square_recursive
	mov	x20, x0
	mov	x0, x19
	bl	_square_recursive
	sbfx	w8, w22, #0, #1
	and	w8, w8, w21
	add	x8, x20, x8
	sub	x0, x8, x0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function midpoint_table8
_midpoint_table8:                       ; @midpoint_table8
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w8, w0, w1, lo
	csel	w9, w0, w1, hi
	sub	w9, w9, w8
	lsr	w10, w9, #1
Lloh115:
	adrp	x11, __MergedGlobals@PAGE+8
Lloh116:
	add	x11, x11, __MergedGlobals@PAGEOFF+8
	add	w12, w10, w8
	ldrh	w12, [x11, w12, uxtw #1]
	lsl	w10, w10, #1
	ldrh	w10, [x11, w10, uxtw]
	sbfx	w9, w9, #0, #1
	and	w8, w9, w8
	add	x8, x12, x8
	sub	x0, x8, x10
	ret
	.loh AdrpAdd	Lloh115, Lloh116
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function midpoint_table16
_midpoint_table16:                      ; @midpoint_table16
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	csel	w8, w0, w1, lo
	csel	w9, w0, w1, hi
	sub	w9, w9, w8
	lsr	w10, w9, #1
	add	w11, w10, w8
Lloh117:
	adrp	x12, _table16@PAGE
Lloh118:
	add	x12, x12, _table16@PAGEOFF
	ldr	w11, [x12, w11, uxtw #2]
	ldr	w10, [x12, w10, uxtw #2]
	sbfx	w9, w9, #0, #1
	and	w8, w9, w8
	add	x8, x11, x8
	sub	x0, x8, x10
	ret
	.loh AdrpAdd	Lloh117, Lloh118
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function quarter_table8
_quarter_table8:                        ; @quarter_table8
	.cfi_startproc
; %bb.0:
	sub	w8, w1, w0
	subs	w9, w0, w1
	csel	w8, w9, w8, hi
	add	w9, w1, w0
Lloh119:
	adrp	x10, __MergedGlobals@PAGE+520
Lloh120:
	add	x10, x10, __MergedGlobals@PAGEOFF+520
	ldrh	w9, [x10, w9, uxtw #1]
	ldrh	w8, [x10, w8, uxtw #1]
	sub	x0, x9, x8
	ret
	.loh AdrpAdd	Lloh119, Lloh120
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function full_product_table8
_full_product_table8:                   ; @full_product_table8
	.cfi_startproc
; %bb.0:
	mov	w8, w0
Lloh121:
	adrp	x9, _products8@PAGE
Lloh122:
	add	x9, x9, _products8@PAGEOFF
	add	x8, x9, x8, lsl #9
	ldrh	w0, [x8, w1, uxtw #1]
	ret
	.loh AdrpAdd	Lloh121, Lloh122
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function equal_aware_table16
_equal_aware_table16:                   ; @equal_aware_table16
	.cfi_startproc
; %bb.0:
	cmp	w0, w1
	b.ne	LBB23_2
; %bb.1:
Lloh123:
	adrp	x8, _table16@PAGE
Lloh124:
	add	x8, x8, _table16@PAGEOFF
	ldr	w0, [x8, w0, uxtw #2]
	ret
LBB23_2:
	b	_midpoint_table16
	.loh AdrpAdd	Lloh123, Lloh124
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.1
_main.cold.1:                           ; @main.cold.1
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh125:
	adrp	x0, l___func__.verify@PAGE
Lloh126:
	add	x0, x0, l___func__.verify@PAGEOFF
Lloh127:
	adrp	x1, l_.str.15@PAGE
Lloh128:
	add	x1, x1, l_.str.15@PAGEOFF
Lloh129:
	adrp	x3, l_.str.16@PAGE
Lloh130:
	add	x3, x3, l_.str.16@PAGEOFF
	mov	w2, #255                        ; =0xff
	bl	___assert_rtn
	.loh AdrpAdd	Lloh129, Lloh130
	.loh AdrpAdd	Lloh127, Lloh128
	.loh AdrpAdd	Lloh125, Lloh126
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.2
_main.cold.2:                           ; @main.cold.2
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh131:
	adrp	x0, l___func__.verify@PAGE
Lloh132:
	add	x0, x0, l___func__.verify@PAGEOFF
Lloh133:
	adrp	x1, l_.str.15@PAGE
Lloh134:
	add	x1, x1, l_.str.15@PAGEOFF
Lloh135:
	adrp	x3, l_.str.17@PAGE
Lloh136:
	add	x3, x3, l_.str.17@PAGEOFF
	mov	w2, #256                        ; =0x100
	bl	___assert_rtn
	.loh AdrpAdd	Lloh135, Lloh136
	.loh AdrpAdd	Lloh133, Lloh134
	.loh AdrpAdd	Lloh131, Lloh132
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function main.cold.3
_main.cold.3:                           ; @main.cold.3
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh137:
	adrp	x0, l___func__.verify@PAGE
Lloh138:
	add	x0, x0, l___func__.verify@PAGEOFF
Lloh139:
	adrp	x1, l_.str.15@PAGE
Lloh140:
	add	x1, x1, l_.str.15@PAGEOFF
Lloh141:
	adrp	x3, l_.str.18@PAGE
Lloh142:
	add	x3, x3, l_.str.18@PAGEOFF
	mov	w2, #257                        ; =0x101
	bl	___assert_rtn
	.loh AdrpAdd	Lloh141, Lloh142
	.loh AdrpAdd	Lloh139, Lloh140
	.loh AdrpAdd	Lloh137, Lloh138
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"compiler=%s; pointer_bits=%zu; pairs=%d; trials=%d; target_ns=%llu; seed=0x584255896d; all_tables_first_build_ns=%llu\n"

l_.str.1:                               ; @.str.1
	.asciz	"17.0.0 (clang-1700.0.13.5)"

l_.str.2:                               ; @.str.2
	.asciz	"--verify-only"

l_.str.3:                               ; @.str.3
	.asciz	"Usage: %s [--verify-only]\n"

	.section	__TEXT,__const
	.p2align	2, 0x0                          ; @__const.main.widths
l___const.main.widths:
	.long	8                               ; 0x8
	.long	16                              ; 0x10
	.long	32                              ; 0x20

	.section	__TEXT,__cstring,cstring_literals
l_.str.4:                               ; @.str.4
	.asciz	"random"

l_.str.5:                               ; @.str.5
	.asciz	"near"

l_.str.6:                               ; @.str.6
	.asciz	"equal"

l_.str.7:                               ; @.str.7
	.asciz	"sparse"

l_.str.8:                               ; @.str.8
	.asciz	"dense"

l_.str.9:                               ; @.str.9
	.asciz	"times_one"

l_.str.10:                              ; @.str.10
	.asciz	"times_byte"

l_.str.11:                              ; @.str.11
	.asciz	"times_power2"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @__const.main.patterns
l___const.main.patterns:
	.quad	l_.str.4
	.quad	l_.str.5
	.quad	l_.str.6
	.quad	l_.str.7
	.quad	l_.str.8
	.quad	l_.str.9
	.quad	l_.str.10
	.quad	l_.str.11

	.section	__TEXT,__cstring,cstring_literals
l_.str.12:                              ; @.str.12
	.asciz	"bits,pattern,method,pairs,repeats,trials,median_ns,min_ns,max_ns,checksum"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @methods
_methods:
	.quad	l_.str.26
	.quad	_call_floor
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.27
	.quad	_native_mul
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.28
	.quad	_shift_add
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.29
	.quad	_sparse_multiply
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.30
	.quad	_software_karatsuba
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.31
	.quad	_square_plus_delta
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.32
	.quad	_equal_aware_recursive
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.33
	.quad	_midpoint_prefix
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.34
	.quad	_midpoint_set_bits
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.35
	.quad	_midpoint_recursive
	.long	32                              ; 0x20
	.space	4
	.quad	l_.str.36
	.quad	_midpoint_table8
	.long	8                               ; 0x8
	.space	4
	.quad	l_.str.37
	.quad	_midpoint_table16
	.long	16                              ; 0x10
	.space	4
	.quad	l_.str.38
	.quad	_quarter_table8
	.long	8                               ; 0x8
	.space	4
	.quad	l_.str.39
	.quad	_full_product_table8
	.long	8                               ; 0x8
	.space	4
	.quad	l_.str.40
	.quad	_equal_aware_table16
	.long	16                              ; 0x10
	.space	4

	.section	__TEXT,__cstring,cstring_literals
l_.str.13:                              ; @.str.13
	.asciz	"%u,%s,%s,%u,%u,%u,%.6f,%.6f,%.6f,%llu\n"

l_.str.14:                              ; @.str.14
	.asciz	"observable_checksum=%llu\n"

.zerofill __DATA,__bss,_table16,262144,2 ; @table16
.zerofill __DATA,__bss,_products8,131072,1 ; @products8
	.section	__TEXT,__const
	.p2align	2, 0x0                          ; @__const.verify.cases
l___const.verify.cases:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.long	3                               ; 0x3
	.long	127                             ; 0x7f
	.long	128                             ; 0x80
	.long	255                             ; 0xff
	.long	256                             ; 0x100
	.long	257                             ; 0x101
	.long	65535                           ; 0xffff
	.long	65536                           ; 0x10000
	.long	2147483647                      ; 0x7fffffff
	.long	2147483648                      ; 0x80000000
	.long	4294967295                      ; 0xffffffff

	.section	__TEXT,__cstring,cstring_literals
l___func__.verify:                      ; @__func__.verify
	.asciz	"verify"

l_.str.15:                              ; @.str.15
	.asciz	"bench_small.c"

l_.str.16:                              ; @.str.16
	.asciz	"square_prefix(z) == expected"

l_.str.17:                              ; @.str.17
	.asciz	"square_set_bits(z) == expected"

l_.str.18:                              ; @.str.18
	.asciz	"square_recursive(z) == expected"

l_.str.19:                              ; @.str.19
	.asciz	"Verification passed: 65536 ordered eight-bit pairs, 100000 random 32-bit pairs, 196 boundary pairs, 65536 inputs per square.\n"

l_.str.20:                              ; @.str.20
	.asciz	"FAIL %s %u %u got %llu expected %llu\n"

l_.str.21:                              ; @.str.21
	.asciz	"square8"

l_.str.22:                              ; @.str.22
	.asciz	"square16"

l_.str.23:                              ; @.str.23
	.asciz	"quarter8"

l_.str.24:                              ; @.str.24
	.asciz	"product8"

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @__const.measure_table_builds.names
l___const.measure_table_builds.names:
	.quad	l_.str.21
	.quad	l_.str.22
	.quad	l_.str.23
	.quad	l_.str.24

	.section	__TEXT,__literal16,16byte_literals
	.p2align	2, 0x0                          ; @__const.measure_table_builds.bytes
l___const.measure_table_builds.bytes:
	.long	512                             ; 0x200
	.long	262144                          ; 0x40000
	.long	1024                            ; 0x400
	.long	131072                          ; 0x20000

	.section	__DATA,__const
	.p2align	3, 0x0                          ; @__const.measure_table_builds.builders
l___const.measure_table_builds.builders:
	.quad	_initialize_table8
	.quad	_initialize_table16
	.quad	_initialize_quarter8
	.quad	_initialize_products8

	.section	__TEXT,__cstring,cstring_literals
l_.str.25:                              ; @.str.25
	.asciz	"table_build name=%s bytes=%u repeats=%u trials=%u median_ns=%.3f min_ns=%.3f max_ns=%.3f warm_rebuild=true\n"

l_.str.26:                              ; @.str.26
	.asciz	"call_floor"

l_.str.27:                              ; @.str.27
	.asciz	"native"

l_.str.28:                              ; @.str.28
	.asciz	"shift_add"

l_.str.29:                              ; @.str.29
	.asciz	"sparse_multiply"

l_.str.30:                              ; @.str.30
	.asciz	"software_karatsuba"

l_.str.31:                              ; @.str.31
	.asciz	"square_plus_delta"

l_.str.32:                              ; @.str.32
	.asciz	"equal_aware_recursive"

l_.str.33:                              ; @.str.33
	.asciz	"midpoint_prefix"

l_.str.34:                              ; @.str.34
	.asciz	"midpoint_set_bits"

l_.str.35:                              ; @.str.35
	.asciz	"midpoint_recursive"

l_.str.36:                              ; @.str.36
	.asciz	"midpoint_table8"

l_.str.37:                              ; @.str.37
	.asciz	"midpoint_table16"

l_.str.38:                              ; @.str.38
	.asciz	"quarter_table8"

l_.str.39:                              ; @.str.39
	.asciz	"full_product_table8"

l_.str.40:                              ; @.str.40
	.asciz	"equal_aware_table16"

	.section	__DATA,__data
	.p2align	3, 0x0                          ; @random_state
_random_state:
	.quad	379070024045                    ; 0x584255896d

.zerofill __DATA,__bss,__MergedGlobals,1544,3 ; @_MergedGlobals
.subsections_via_symbols
