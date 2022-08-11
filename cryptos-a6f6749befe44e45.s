	.text
	.file	"cryptos.1d4fdd87-cgu.0"
	.section	".text._ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E,@function
_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E:
	subq	$72, %rsp
	cmpq	$31, %rsi
	ja	.LBB0_20
	leaq	.LJTI0_0(%rip), %rax
	movslq	(%rax,%rsi,4), %rcx
	addq	%rax, %rcx
	jmpq	*%rcx
.LBB0_2:
	addq	$16, %rdi
.LBB0_25:
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_3:
	addq	$32, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_4:
	addq	$48, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_5:
	addq	$64, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_6:
	addq	$80, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_7:
	addq	$96, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_8:
	addq	$112, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_9:
	addq	$144, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_10:
	addq	$256, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_11:
	addq	$304, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_12:
	addq	$320, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_20:
	leaq	-32(%rsi), %rax
	cmpq	$224, %rax
	jae	.LBB0_21
	shlq	$4, %rax
	addq	%rax, %rdi
	addq	$512, %rdi
	movq	%rdi, %rax
	addq	$72, %rsp
	retq
.LBB0_15:
	movq	$8, (%rsp)
	jmp	.LBB0_31
.LBB0_13:
	movq	$15, (%rsp)
	jmp	.LBB0_27
.LBB0_17:
	movq	$29, (%rsp)
	jmp	.LBB0_31
.LBB0_18:
	movq	$30, (%rsp)
	jmp	.LBB0_31
.LBB0_14:
	movq	$31, (%rsp)
	jmp	.LBB0_27
.LBB0_21:
	leaq	-21(%rsi), %rax
	cmpq	$8, %rax
	jae	.LBB0_22
	movq	%rsi, (%rsp)
.LBB0_27:
	movq	%rsp, %rax
	movq	%rax, 8(%rsp)
	movq	_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h00525618f8c671d5E@GOTPCREL(%rip), %rax
	movq	%rax, 16(%rsp)
	leaq	.L__unnamed_1(%rip), %rax
	jmp	.LBB0_28
.LBB0_16:
	movq	$17, (%rsp)
	jmp	.LBB0_31
.LBB0_19:
	movq	$18, (%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%rsp)
	movq	_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h00525618f8c671d5E@GOTPCREL(%rip), %rax
	movq	%rax, 16(%rsp)
	leaq	.L__unnamed_2(%rip), %rax
	jmp	.LBB0_28
.LBB0_22:
	leaq	-10(%rsi), %rax
	cmpq	$5, %rax
	jae	.LBB0_23
	movq	%rsi, (%rsp)
.LBB0_31:
	movq	%rsp, %rax
	movq	%rax, 8(%rsp)
	movq	_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h00525618f8c671d5E@GOTPCREL(%rip), %rax
	movq	%rax, 16(%rsp)
	leaq	.L__unnamed_3(%rip), %rax
.LBB0_28:
	movq	%rax, 24(%rsp)
	movq	$2, 32(%rsp)
.LBB0_29:
	movq	$0, 40(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	24(%rsp), %rdi
	movq	%rdx, %rsi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB0_23:
	movq	%rsi, (%rsp)
	movq	%rsp, %rax
	movq	%rax, 8(%rsp)
	movq	_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h00525618f8c671d5E@GOTPCREL(%rip), %rax
	movq	%rax, 16(%rsp)
	leaq	.L__unnamed_4(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$1, 32(%rsp)
	jmp	.LBB0_29
.Lfunc_end0:
	.size	_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E, .Lfunc_end0-_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E
	.section	".rodata._ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E","a",@progbits
	.p2align	2
.LJTI0_0:
	.long	.LBB0_25-.LJTI0_0
	.long	.LBB0_2-.LJTI0_0
	.long	.LBB0_3-.LJTI0_0
	.long	.LBB0_4-.LJTI0_0
	.long	.LBB0_5-.LJTI0_0
	.long	.LBB0_6-.LJTI0_0
	.long	.LBB0_7-.LJTI0_0
	.long	.LBB0_8-.LJTI0_0
	.long	.LBB0_15-.LJTI0_0
	.long	.LBB0_9-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_13-.LJTI0_0
	.long	.LBB0_10-.LJTI0_0
	.long	.LBB0_16-.LJTI0_0
	.long	.LBB0_19-.LJTI0_0
	.long	.LBB0_11-.LJTI0_0
	.long	.LBB0_12-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_20-.LJTI0_0
	.long	.LBB0_17-.LJTI0_0
	.long	.LBB0_18-.LJTI0_0
	.long	.LBB0_14-.LJTI0_0

	.section	".text._ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E,@function
_ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1928, %rsp
	movq	(%rdi), %r12
	movq	8(%rdi), %r15
	cmpq	%r15, %r12
	jae	.LBB1_1
	movq	%rdi, %rbx
	movq	16(%rdi), %r13
	movq	%r12, %r14
	shlq	$7, %r14
	movq	%r15, 8(%rsp)
	movq	%rdi, (%rsp)
	jmp	.LBB1_3
.LBB1_26:
	leaq	.L__unnamed_5(%rip), %rdx
	xorl	%ebp, %ebp
	movq	8(%rsp), %r15
	movq	(%rsp), %rbx
.LBB1_39:
	testq	%rbp, %rbp
	jne	.LBB1_42
.LBB1_40:
	subq	$-128, %r14
	cmpq	%r12, %r15
	je	.LBB1_41
.LBB1_3:
	movq	%r12, %rax
	addq	$1, %r12
	movq	%r12, (%rbx)
	movl	(%r13), %ecx
	btl	%eax, %ecx
	jae	.LBB1_40
	movq	%rax, 40(%rsp)
	movq	24(%rbx), %r15
	movl	40(%r15,%r14), %edx
	notl	%edx
	xorl	%eax, %eax
	testb	$3, %dl
	jne	.LBB1_15
	movl	36(%r15,%r14), %ecx
	movl	$1, %eax
	cmpl	$-351010560, %ecx
	jg	.LBB1_9
	cmpl	$-1771503359, %ecx
	je	.LBB1_13
	cmpl	$-1019477759, %ecx
	jne	.LBB1_15
	movl	$5, %eax
	jmp	.LBB1_14
.LBB1_9:
	cmpl	$-351010559, %ecx
	je	.LBB1_12
	cmpl	$257, %ecx
	jne	.LBB1_15
	movl	$2, %eax
	jmp	.LBB1_14
.LBB1_13:
	movl	$4, %eax
	jmp	.LBB1_14
.LBB1_12:
	movl	$3, %eax
.LBB1_14:
.LBB1_15:
	movl	%eax, 16(%rsp)
	movl	%ecx, 20(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	cmpq	$2, %rcx
	jbe	.LBB1_16
	leaq	40(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	_ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE(%rip), %rax
	movq	%rax, 120(%rsp)
	leaq	.L__unnamed_6(%rip), %rax
	movq	%rax, 1008(%rsp)
	movq	$2, 1016(%rsp)
	leaq	.L__unnamed_7(%rip), %rax
	movq	%rax, 1024(%rsp)
	movq	$2, 1032(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 1040(%rsp)
	movq	$2, 1048(%rsp)
	movl	$3, %esi
	leaq	1008(%rsp), %rdi
	leaq	.L__unnamed_8(%rip), %rdx
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movl	16(%rsp), %eax
.LBB1_16:
	addq	%r14, %r15
	cmpl	$2, %eax
	je	.LBB1_29
	cmpl	$3, %eax
	jne	.LBB1_18
	movq	40(%rsp), %rsi
	leaq	1008(%rsp), %rdi
	movq	%r15, %rdx
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface3new17h3957f64dc4fbe2f4E
	cmpl	$0, 1008(%rsp)
	je	.LBB1_21
	movl	1012(%rsp), %eax
	movl	%eax, 24(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.LBB1_26
	leaq	24(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	_ZN58_$LT$syscall..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h77d959c082dd1971E@GOTPCREL(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L__unnamed_9(%rip), %rax
	movq	%rax, 96(%rsp)
	movq	$1, 104(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 112(%rsp)
	movq	$1, 120(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	$1, 136(%rsp)
	movl	$1, %esi
	leaq	96(%rsp), %rdi
	leaq	.L__unnamed_11(%rip), %rdx
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	jmp	.LBB1_26
.LBB1_29:
	movq	40(%rsp), %rsi
	leaq	1008(%rsp), %rdi
	movq	%r15, %rdx
	callq	_ZN7cryptos4ahci4sata8SataDisk3new17hc64c7acabc403755E
	cmpl	$0, 1008(%rsp)
	je	.LBB1_33
	movl	1012(%rsp), %eax
	movl	%eax, 24(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	movq	8(%rsp), %r15
	movq	(%rsp), %rbx
	je	.LBB1_31
	leaq	24(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	_ZN58_$LT$syscall..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h77d959c082dd1971E@GOTPCREL(%rip), %rax
	movq	%rax, 56(%rsp)
	leaq	.L__unnamed_12(%rip), %rax
	movq	%rax, 96(%rsp)
	movq	$1, 104(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 112(%rsp)
	movq	$1, 120(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	$1, 136(%rsp)
	movl	$1, %esi
	leaq	96(%rsp), %rdi
	leaq	.L__unnamed_13(%rip), %rdx
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB1_31:
	leaq	.L__unnamed_14(%rip), %rdx
	xorl	%ebp, %ebp
	jmp	.LBB1_39
.LBB1_18:
	movq	8(%rsp), %r15
	movq	(%rsp), %rbx
	jmp	.LBB1_40
.LBB1_21:
	movl	$864, %edx
	leaq	96(%rsp), %rdi
	leaq	1016(%rsp), %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB1_22
	leaq	16(%rsp), %rax
	movq	%rax, 24(%rsp)
	leaq	_ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L__unnamed_15(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	$1, 88(%rsp)
	movl	$3, %esi
	leaq	48(%rsp), %rdi
	leaq	.L__unnamed_16(%rip), %rdx
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB1_22:
	movl	$864, %edi
	movl	$8, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	movq	8(%rsp), %r15
	movq	(%rsp), %rbx
	je	.LBB1_23
	movq	%rax, %rbp
	movl	$864, %edx
	movq	%rax, %rdi
	leaq	96(%rsp), %rsi
	callq	*memcpy@GOTPCREL(%rip)
	leaq	.L__unnamed_5(%rip), %rdx
	jmp	.LBB1_39
.LBB1_33:
	movl	$912, %edx
	leaq	96(%rsp), %rdi
	leaq	1016(%rsp), %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	movq	8(%rsp), %r15
	movq	(%rsp), %rbx
	jbe	.LBB1_34
	leaq	16(%rsp), %rax
	movq	%rax, 24(%rsp)
	leaq	_ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L__unnamed_15(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	$1, 88(%rsp)
	movl	$3, %esi
	leaq	48(%rsp), %rdi
	leaq	.L__unnamed_17(%rip), %rdx
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB1_34:
	movl	$912, %edi
	movl	$8, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB1_35
	movq	%rax, %rbp
	movl	$912, %edx
	movq	%rax, %rdi
	leaq	96(%rsp), %rsi
	callq	*memcpy@GOTPCREL(%rip)
	leaq	.L__unnamed_14(%rip), %rdx
	jmp	.LBB1_39
.LBB1_1:
	xorl	%ebp, %ebp
	jmp	.LBB1_42
.LBB1_41:
	xorl	%ebp, %ebp
.LBB1_42:
	movq	%rbp, %rax
	addq	$1928, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB1_23:
	movl	$864, %edi
	jmp	.LBB1_24
.LBB1_35:
	movl	$912, %edi
.LBB1_24:
	movl	$8, %esi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end1:
	.size	_ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E, .Lfunc_end1-_ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h248e261427e063f4E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h248e261427e063f4E,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h248e261427e063f4E:
	pushq	%rax
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip)
	cmpq	$1, %rax
	je	.LBB2_5
	cmpq	$2, %rax
	je	.LBB2_4
	cmpq	$3, %rax
	je	.LBB2_8
	movl	$1, %ecx
.LBB2_4:
	movq	%rcx, 8(%rdi)
	movq	%rax, 16(%rdi)
	movl	$1, %eax
	movq	%rax, (%rdi)
	popq	%rax
	retq
.LBB2_5:
	movq	(%rsi), %rdx
	movq	(%rdx), %rax
	movq	8(%rdx), %rcx
	movq	$0, 8(%rdx)
	testq	%rcx, %rcx
	je	.LBB2_9
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	movq	%rax, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip)
	movq	%rcx, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+24(%rip)
	movl	$2, %eax
	xchgq	%rax, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip)
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %rax
	movq	%rax, 8(%rdi)
	xorl	%eax, %eax
	movq	%rax, (%rdi)
	popq	%rax
	retq
.LBB2_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB2_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end2:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h248e261427e063f4E, .Lfunc_end2-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h248e261427e063f4E

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h3d2eca67641ff425E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h3d2eca67641ff425E,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h3d2eca67641ff425E:
	pushq	%r14
	pushq	%rbx
	subq	$136, %rsp
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E(%rip)
	movq	%rdi, %rbx
	cmpq	$1, %rax
	je	.LBB3_5
	cmpq	$2, %rax
	je	.LBB3_4
	cmpq	$3, %rax
	je	.LBB3_8
	movl	$1, %ecx
.LBB3_4:
	movq	%rcx, 8(%rbx)
	movq	%rax, 16(%rbx)
	movl	$1, %eax
	jmp	.LBB3_7
.LBB3_5:
	movq	(%rsi), %rax
	movq	(%rax), %rsi
	movq	8(%rax), %rdx
	movl	40(%rax), %ecx
	movl	$3, 40(%rax)
	cmpl	$3, %ecx
	je	.LBB3_9
	movq	32(%rax), %rdi
	movq	%rdi, 16(%rsp)
	movq	16(%rax), %r8
	movq	24(%rax), %rdi
	movq	%rdi, 8(%rsp)
	movq	%r8, (%rsp)
	movl	%ecx, 24(%rsp)
	movq	44(%rax), %rcx
	movq	52(%rax), %rdi
	movq	%rcx, 28(%rsp)
	movq	%rdi, 36(%rsp)
	movl	60(%rax), %eax
	movl	%eax, 44(%rsp)
	leaq	48(%rsp), %r14
	movq	%rsp, %rcx
	movq	%r14, %rdi
	callq	*_ZN6printk12LockedPrintk3new17h9d442781bccdf24eE@GOTPCREL(%rip)
	leaq	_ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E+8(%rip), %rax
	movl	$11, %ecx
	movq	%rax, %rdi
	movq	%r14, %rsi
	rep;movsq (%rsi), %es:(%rdi)
	movl	$2, %ecx
	xchgq	%rcx, _ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E(%rip)
	movq	%rax, 8(%rbx)
	xorl	%eax, %eax
.LBB3_7:
	movq	%rax, (%rbx)
	addq	$136, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB3_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	leaq	48(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB3_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end3:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h3d2eca67641ff425E, .Lfunc_end3-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h3d2eca67641ff425E

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h9f6ba84a70de7dc2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h9f6ba84a70de7dc2E,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h9f6ba84a70de7dc2E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip)
	movq	%rdi, %rbx
	cmpq	$1, %rax
	je	.LBB4_5
	cmpq	$2, %rax
	je	.LBB4_4
	cmpq	$3, %rax
	je	.LBB4_22
	movl	$1, %ecx
.LBB4_4:
	movq	%rcx, 8(%rbx)
	movq	%rax, 16(%rbx)
	movl	$1, %eax
	jmp	.LBB4_21
.LBB4_5:
	movq	(%rsi), %rax
	movq	8(%rax), %r15
	movq	16(%rax), %rsi
	movq	24(%rax), %r14
	cmpq	$0, (%rax)
	movq	$0, (%rax)
	je	.LBB4_23
	testq	%r15, %r15
	je	.LBB4_7
	testq	%r14, %r14
	movq	%rsi, 16(%rsp)
	je	.LBB4_9
	movl	$16, %ecx
	movq	%r14, %rax
	mulq	%rcx
	jo	.LBB4_24
	movq	%rax, %r12
	movq	%rax, %rbp
	notq	%rbp
	shrq	$63, %rbp
	testq	%rax, %rax
	js	.LBB4_24
	je	.LBB4_13
	movq	%r12, %rdi
	movq	%rbp, %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	movq	%rax, %r13
	testq	%r13, %r13
	jne	.LBB4_16
	jmp	.LBB4_25
.LBB4_7:
	xorl	%r13d, %r13d
	jmp	.LBB4_20
.LBB4_9:
	movl	$1, %r13d
	jmp	.LBB4_16
.LBB4_13:
	movq	%rbp, %r13
	testq	%r13, %r13
	je	.LBB4_25
.LBB4_16:
	movq	%r14, %rdx
	shlq	$4, %rdx
	movq	%r13, %rdi
	movq	%r15, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	16(%rsp), %rax
	testq	%rax, %rax
	je	.LBB4_20
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB4_20
	testq	%rax, %rax
	jle	.LBB4_20
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	movq	%r15, %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB4_20:
	movq	%r13, _ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+8(%rip)
	movq	%r14, _ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+16(%rip)
	movq	%r14, _ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+24(%rip)
	movl	$2, %eax
	xchgq	%rax, _ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip)
	leaq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+8(%rip), %rax
	movq	%rax, 8(%rbx)
	xorl	%eax, %eax
.LBB4_21:
	movq	%rax, (%rbx)
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB4_22:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB4_23:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB4_24:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB4_25:
	movq	%r12, %rdi
	movq	%rbp, %rsi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end4:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h9f6ba84a70de7dc2E, .Lfunc_end4-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h9f6ba84a70de7dc2E

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hac1979b172f7ec82E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hac1979b172f7ec82E,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hac1979b172f7ec82E:
	pushq	%rax
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip)
	cmpq	$1, %rax
	je	.LBB5_5
	cmpq	$2, %rax
	je	.LBB5_4
	cmpq	$3, %rax
	je	.LBB5_8
	movl	$1, %ecx
.LBB5_4:
	movq	%rcx, 8(%rdi)
	movq	%rax, 16(%rdi)
	movl	$1, %eax
	movq	%rax, (%rdi)
	popq	%rax
	retq
.LBB5_5:
	movq	(%rsi), %rdx
	movq	(%rdx), %rax
	movq	8(%rdx), %rcx
	movq	$0, (%rdx)
	testq	%rax, %rax
	je	.LBB5_9
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movq	%rax, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip)
	movq	%rcx, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+24(%rip)
	movl	$2, %eax
	xchgq	%rax, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip)
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %rax
	movq	%rax, 8(%rdi)
	xorl	%eax, %eax
	movq	%rax, (%rdi)
	popq	%rax
	retq
.LBB5_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB5_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end5:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hac1979b172f7ec82E, .Lfunc_end5-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hac1979b172f7ec82E

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hbf38609c5118b8a6E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hbf38609c5118b8a6E,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hbf38609c5118b8a6E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E(%rip)
	movq	%rdi, %rbx
	cmpq	$1, %rax
	je	.LBB6_5
	cmpq	$2, %rax
	je	.LBB6_4
	cmpq	$3, %rax
	je	.LBB6_19
	movl	$1, %ecx
.LBB6_4:
	movq	%rcx, 8(%rbx)
	movq	%rax, 16(%rbx)
	movl	$1, %eax
	jmp	.LBB6_18
.LBB6_5:
	movq	(%rsi), %rax
	movq	(%rax), %rcx
	movq	8(%rax), %rsi
	movq	16(%rax), %r14
	movq	$0, (%rax)
	testq	%rcx, %rcx
	je	.LBB6_20
	movabsq	$9223372036854775804, %r15
	testq	%r14, %r14
	movq	%rcx, 16(%rsp)
	movq	%rsi, 8(%rsp)
	je	.LBB6_7
	movl	$4, %ecx
	movq	%r14, %rax
	mulq	%rcx
	movq	%rax, %rbp
	seto	%cl
	cmpq	%r15, %rax
	seta	%al
	orb	%cl, %al
	cmpb	$1, %al
	je	.LBB6_21
	xorb	$1, %al
	movzbl	%al, %r12d
	shlq	$2, %r12
	testq	%rbp, %rbp
	je	.LBB6_10
	movq	%rbp, %rdi
	movq	%r12, %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	movq	%rax, %r13
	testq	%r13, %r13
	jne	.LBB6_13
	jmp	.LBB6_22
.LBB6_7:
	movl	$4, %r13d
	jmp	.LBB6_13
.LBB6_10:
	movq	%r12, %r13
	testq	%r13, %r13
	je	.LBB6_22
.LBB6_13:
	leaq	(,%r14,4), %rdx
	movq	%r13, %rdi
	movq	16(%rsp), %rbp
	movq	%rbp, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.LBB6_17
	movl	$4, %ecx
	mulq	%rcx
	jo	.LBB6_17
	leaq	(%r15,%rax), %rcx
	addq	$7, %rcx
	addq	$8, %r15
	cmpq	%r15, %rcx
	jb	.LBB6_17
	movl	$4, %edx
	movq	%rbp, %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB6_17:
	movq	%r13, _ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E+8(%rip)
	movq	%r14, _ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E+16(%rip)
	movq	%r14, _ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E+24(%rip)
	movl	$2, %eax
	xchgq	%rax, _ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E(%rip)
	leaq	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E+8(%rip), %rax
	movq	%rax, 8(%rbx)
	xorl	%eax, %eax
.LBB6_18:
	movq	%rax, (%rbx)
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB6_19:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB6_20:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB6_21:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB6_22:
	movq	%rbp, %rdi
	movq	%r12, %rsi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end6:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hbf38609c5118b8a6E, .Lfunc_end6-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hbf38609c5118b8a6E

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hc366a53cdf8b30edE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hc366a53cdf8b30edE,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hc366a53cdf8b30edE:
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip)
	movq	%rdi, %rbx
	cmpq	$1, %rax
	je	.LBB7_5
	cmpq	$2, %rax
	je	.LBB7_4
	cmpq	$3, %rax
	je	.LBB7_8
	movl	$1, %ecx
.LBB7_4:
	movq	%rcx, 8(%rbx)
	movq	%rax, 16(%rbx)
	movl	$1, %eax
	jmp	.LBB7_7
.LBB7_5:
	movq	(%rsi), %rsi
	movb	104(%rsi), %bpl
	movb	$3, 104(%rsi)
	cmpb	$3, %bpl
	je	.LBB7_9
	movl	105(%rsi), %eax
	movl	108(%rsi), %ecx
	movl	%ecx, 11(%rsp)
	movl	%eax, 8(%rsp)
	leaq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+8(%rip), %r14
	movl	$104, %edx
	movq	%r14, %rdi
	callq	*memmove@GOTPCREL(%rip)
	movb	%bpl, _ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+112(%rip)
	movl	8(%rsp), %eax
	movl	11(%rsp), %ecx
	movl	%eax, _ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+113(%rip)
	movl	%ecx, _ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+116(%rip)
	movl	$2, %eax
	xchgq	%rax, _ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip)
	movq	%r14, 8(%rbx)
	xorl	%eax, %eax
.LBB7_7:
	movq	%rax, (%rbx)
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB7_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB7_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end7:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hc366a53cdf8b30edE, .Lfunc_end7-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hc366a53cdf8b30edE

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hcfdebd20286fdea5E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hcfdebd20286fdea5E,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hcfdebd20286fdea5E:
	subq	$24, %rsp
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE(%rip)
	cmpq	$1, %rax
	je	.LBB8_5
	cmpq	$2, %rax
	je	.LBB8_4
	cmpq	$3, %rax
	je	.LBB8_8
	movl	$1, %ecx
.LBB8_4:
	movq	%rcx, 8(%rdi)
	movq	%rax, 16(%rdi)
	movl	$1, %eax
	movq	%rax, (%rdi)
	addq	$24, %rsp
	retq
.LBB8_5:
	movq	(%rsi), %rcx
	movq	(%rcx), %rax
	movq	$0, (%rcx)
	testq	%rax, %rax
	je	.LBB8_9
	movq	8(%rcx), %rdx
	movq	16(%rcx), %rcx
	movq	$0, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+8(%rip)
	movq	%rax, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+16(%rip)
	movq	%rdx, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+24(%rip)
	movq	%rcx, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+32(%rip)
	movl	$2, %eax
	xchgq	%rax, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE(%rip)
	leaq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+8(%rip), %rax
	movq	%rax, 8(%rdi)
	xorl	%eax, %eax
	movq	%rax, (%rdi)
	addq	$24, %rsp
	retq
.LBB8_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB8_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end8:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hcfdebd20286fdea5E, .Lfunc_end8-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hcfdebd20286fdea5E

	.section	".text.unlikely._ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17he31b3d769122797eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17he31b3d769122797eE,@function
_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17he31b3d769122797eE:
	pushq	%rax
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip)
	cmpq	$1, %rax
	je	.LBB9_5
	cmpq	$2, %rax
	je	.LBB9_4
	cmpq	$3, %rax
	je	.LBB9_8
	movl	$1, %ecx
.LBB9_4:
	movq	%rcx, 8(%rdi)
	movq	%rax, 16(%rdi)
	movl	$1, %eax
	movq	%rax, (%rdi)
	popq	%rax
	retq
.LBB9_5:
	movq	(%rsi), %rcx
	movq	8(%rcx), %rax
	cmpq	$0, (%rcx)
	movq	$0, (%rcx)
	je	.LBB9_9
	movq	%rax, _ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip)
	movl	$2, %eax
	xchgq	%rax, _ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip)
	leaq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movq	%rax, 8(%rdi)
	xorl	%eax, %eax
	movq	%rax, (%rdi)
	popq	%rax
	retq
.LBB9_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_20(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB9_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_22(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end9:
	.size	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17he31b3d769122797eE, .Lfunc_end9-_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17he31b3d769122797eE

	.section	.text._ZN3aml7Handler18handle_fatal_error17hfae004f06f039a51E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN3aml7Handler18handle_fatal_error17hfae004f06f039a51E,@function
_ZN3aml7Handler18handle_fatal_error17hfae004f06f039a51E:
	subq	$120, %rsp
	movb	%sil, 11(%rsp)
	movl	%edx, 12(%rsp)
	movq	%rcx, 16(%rsp)
	leaq	11(%rsp), %rax
	movq	%rax, 24(%rsp)
	leaq	_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h3704d5938c1ece84E(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 40(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17haf60b95d630b3bccE(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 56(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E(%rip), %rax
	movq	%rax, 64(%rsp)
	leaq	.L__unnamed_23(%rip), %rax
	movq	%rax, 72(%rsp)
	movq	$3, 80(%rsp)
	movq	$0, 88(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	$3, 112(%rsp)
	leaq	.L__unnamed_24(%rip), %rsi
	leaq	72(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end10:
	.size	_ZN3aml7Handler18handle_fatal_error17hfae004f06f039a51E, .Lfunc_end10-_ZN3aml7Handler18handle_fatal_error17hfae004f06f039a51E

	.section	".text._ZN41_$LT$bool$u20$as$u20$core..fmt..Debug$GT$3fmt17heff99ea20215d47eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN41_$LT$bool$u20$as$u20$core..fmt..Debug$GT$3fmt17heff99ea20215d47eE,@function
_ZN41_$LT$bool$u20$as$u20$core..fmt..Debug$GT$3fmt17heff99ea20215d47eE:
	jmpq	*_ZN43_$LT$bool$u20$as$u20$core..fmt..Display$GT$3fmt17h655d419d231e7e01E@GOTPCREL(%rip)
.Lfunc_end11:
	.size	_ZN41_$LT$bool$u20$as$u20$core..fmt..Debug$GT$3fmt17heff99ea20215d47eE, .Lfunc_end11-_ZN41_$LT$bool$u20$as$u20$core..fmt..Debug$GT$3fmt17heff99ea20215d47eE

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h09a8297dbb6045aaE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h09a8297dbb6045aaE,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h09a8297dbb6045aaE:
	movq	(%rdi), %rdi
	jmpq	*_ZN78_$LT$acpi..platform..interrupt..InterruptModel$u20$as$u20$core..fmt..Debug$GT$3fmt17h82ce4f75b091f182E@GOTPCREL(%rip)
.Lfunc_end12:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h09a8297dbb6045aaE, .Lfunc_end12-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h09a8297dbb6045aaE

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h19fb2e808af40e0aE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h19fb2e808af40e0aE,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h19fb2e808af40e0aE:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	(%rdi), %r14
	movq	%rsi, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_lower_hex17h0339d59f23a4819dE@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB13_1
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip)
.LBB13_1:
	movq	%rbx, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_upper_hex17hf3b7d753d743b63bE@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	testb	%al, %al
	je	.LBB13_4
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17hd79df3101ce76a87E@GOTPCREL(%rip)
.LBB13_4:
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h4512a67783026698E@GOTPCREL(%rip)
.Lfunc_end13:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h19fb2e808af40e0aE, .Lfunc_end13-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h19fb2e808af40e0aE

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h33eac4d4d6bf9555E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h33eac4d4d6bf9555E,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h33eac4d4d6bf9555E:
	subq	$88, %rsp
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, (%rsp)
	leaq	.L__unnamed_25(%rip), %rcx
	movq	%rcx, 8(%rsp)
	leaq	_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcefa6b78c281546cE(%rip), %rcx
	movq	%rcx, 16(%rsp)
	movq	%rsp, %rcx
	movq	%rcx, 24(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17h37bc6141694e846cE@GOTPCREL(%rip), %rcx
	movq	%rcx, 32(%rsp)
	leaq	.L__unnamed_26(%rip), %rcx
	movq	%rcx, 40(%rsp)
	movq	$3, 48(%rsp)
	leaq	.L__unnamed_27(%rip), %rcx
	movq	%rcx, 56(%rsp)
	movq	$2, 64(%rsp)
	leaq	8(%rsp), %rcx
	movq	%rcx, 72(%rsp)
	movq	$2, 80(%rsp)
	leaq	40(%rsp), %rsi
	movq	%rax, %rdi
	callq	*_ZN4core3fmt9Formatter9write_fmt17h33db2c95d107fcb5E@GOTPCREL(%rip)
	addq	$88, %rsp
	retq
.Lfunc_end14:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h33eac4d4d6bf9555E, .Lfunc_end14-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h33eac4d4d6bf9555E

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d0324e82f682a10E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d0324e82f682a10E,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d0324e82f682a10E:
	movq	%rsi, %rdx
	movq	(%rdi), %rax
	movq	8(%rdi), %rsi
	movq	%rax, %rdi
	jmpq	*_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17h237ca7479e920490E@GOTPCREL(%rip)
.Lfunc_end15:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d0324e82f682a10E, .Lfunc_end15-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d0324e82f682a10E

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7f90e13ca7477986E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7f90e13ca7477986E,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7f90e13ca7477986E:
	movq	(%rdi), %rdi
	jmpq	*_ZN71_$LT$bootloader..boot_info..TlsTemplate$u20$as$u20$core..fmt..Debug$GT$3fmt17h4b3e50573f77a375E@GOTPCREL(%rip)
.Lfunc_end16:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7f90e13ca7477986E, .Lfunc_end16-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7f90e13ca7477986E

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h97aa9e3a076b37b7E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h97aa9e3a076b37b7E,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h97aa9e3a076b37b7E:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	(%rdi), %r14
	movq	%rsi, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_lower_hex17h0339d59f23a4819dE@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB17_1
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u8$GT$3fmt17h515897263c47a231E@GOTPCREL(%rip)
.LBB17_1:
	movq	%rbx, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_upper_hex17hf3b7d753d743b63bE@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	testb	%al, %al
	je	.LBB17_4
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u8$GT$3fmt17h35ff77a156a51f04E@GOTPCREL(%rip)
.LBB17_4:
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h3e8602218822a220E@GOTPCREL(%rip)
.Lfunc_end17:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h97aa9e3a076b37b7E, .Lfunc_end17-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h97aa9e3a076b37b7E

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7256e89aecd4c85E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7256e89aecd4c85E,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7256e89aecd4c85E:
	movq	%rsi, %rdx
	movq	(%rdi), %rax
	movq	(%rax), %rdi
	movq	16(%rax), %rsi
	jmpq	*_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17h237ca7479e920490E@GOTPCREL(%rip)
.Lfunc_end18:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7256e89aecd4c85E, .Lfunc_end18-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7256e89aecd4c85E

	.section	".text._ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf18ad751ac441a4E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf18ad751ac441a4E,@function
_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf18ad751ac441a4E:
	movq	(%rdi), %rdi
	jmpq	*_ZN65_$LT$acpi..mcfg..PciConfigRegions$u20$as$u20$core..fmt..Debug$GT$3fmt17h6f3ab0fe474ddf24E@GOTPCREL(%rip)
.Lfunc_end19:
	.size	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf18ad751ac441a4E, .Lfunc_end19-_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf18ad751ac441a4E

	.section	".text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcefa6b78c281546cE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcefa6b78c281546cE,@function
_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcefa6b78c281546cE:
	movq	%rsi, %rdx
	movq	(%rdi), %rax
	movq	8(%rdi), %rsi
	movq	%rax, %rdi
	jmpq	*_ZN42_$LT$str$u20$as$u20$core..fmt..Display$GT$3fmt17h77c8c988aa75771bE@GOTPCREL(%rip)
.Lfunc_end20:
	.size	_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcefa6b78c281546cE, .Lfunc_end20-_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hcefa6b78c281546cE

	.section	".text._ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf19a80f055ce65c2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf19a80f055ce65c2E,@function
_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf19a80f055ce65c2E:
	movq	(%rdi), %rdi
	jmpq	*_ZN73_$LT$core..panic..panic_info..PanicInfo$u20$as$u20$core..fmt..Display$GT$3fmt17h77818aed9b166a3dE@GOTPCREL(%rip)
.Lfunc_end21:
	.size	_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf19a80f055ce65c2E, .Lfunc_end21-_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf19a80f055ce65c2E

	.section	".text._ZN4acpi19AcpiTables$LT$H$GT$11process_sdt17h0c6f431d55adb969E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4acpi19AcpiTables$LT$H$GT$11process_sdt17h0c6f431d55adb969E,@function
_ZN4acpi19AcpiTables$LT$H$GT$11process_sdt17h0c6f431d55adb969E:
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
	subq	$144, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %r14
	leaq	48(%rsp), %rdi
	movl	$36, %edx
	callq	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE
	movq	56(%rsp), %rax
	movq	(%rax), %rcx
	movq	8(%rax), %rdx
	movq	%rcx, 8(%rsp)
	movq	%rdx, 16(%rsp)
	movq	16(%rax), %rcx
	movq	%rcx, 24(%rsp)
	movq	24(%rax), %rcx
	movq	%rcx, 32(%rsp)
	movl	32(%rax), %eax
	movl	%eax, 40(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jbe	.LBB22_1
	movl	12(%rsp), %eax
	movl	%eax, 128(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 96(%rsp)
	movq	_ZN57_$LT$acpi..sdt..Signature$u20$as$u20$core..fmt..Debug$GT$3fmt17hc115831cf9277c54E@GOTPCREL(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	128(%rsp), %rax
	movq	%rax, 112(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17haf60b95d630b3bccE(%rip), %rax
	movq	%rax, 120(%rsp)
	leaq	.L__unnamed_28(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$2, 56(%rsp)
	movq	$0, 64(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	$2, 88(%rsp)
	leaq	.L__unnamed_29(%rip), %rdx
	leaq	48(%rsp), %rdi
	movl	$5, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB22_1:
	movb	8(%rsp), %al
	cmpb	$70, %al
	je	.LBB22_7
	cmpb	$83, %al
	jne	.LBB22_3
	cmpb	$83, 9(%rsp)
	jne	.LBB22_3
	cmpb	$68, 10(%rsp)
	jne	.LBB22_3
	cmpb	$84, 11(%rsp)
	jne	.LBB22_3
	movl	12(%rsp), %esi
	movq	%rbx, %rdi
	callq	*_ZN4acpi8AmlTable3new17h9b71125c9c38dd02E@GOTPCREL(%rip)
	movq	%rax, %rbx
	movl	%edx, %ebp
	movq	64(%r14), %rsi
	cmpq	56(%r14), %rsi
	jne	.LBB22_17
	leaq	48(%r14), %rdi
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hcdf995785f56f774E
	movq	64(%r14), %rsi
.LBB22_17:
	movq	48(%r14), %rax
	movq	%rsi, %rcx
	shlq	$4, %rcx
	movq	%rbx, (%rax,%rcx)
	movl	%ebp, 8(%rax,%rcx)
	addq	$1, %rsi
	movq	%rsi, 64(%r14)
	jmp	.LBB22_5
.LBB22_7:
	cmpb	$65, 9(%rsp)
	jne	.LBB22_3
	cmpb	$67, 10(%rsp)
	jne	.LBB22_3
	cmpb	$80, 11(%rsp)
	jne	.LBB22_3
	leaq	96(%rsp), %rdi
	movl	$276, %edx
	movq	%rbx, %rsi
	callq	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE
	movq	104(%rsp), %rbp
	movq	%rbp, %rdi
	callq	*_ZN4acpi4fadt4Fadt8validate17hb192557307068fafE@GOTPCREL(%rip)
	cmpb	$10, %al
	jne	.LBB22_11
	leaq	48(%rsp), %rdi
	movq	%rbp, %rsi
	callq	*_ZN4acpi4fadt4Fadt12dsdt_address17hcc7ccb55cbeb88bfE@GOTPCREL(%rip)
	cmpb	$0, 48(%rsp)
	je	.LBB22_18
	movl	49(%rsp), %ecx
	movzbl	53(%rsp), %eax
	shlq	$32, %rax
	orq	%rcx, %rax
.LBB22_11:
	movq	%rax, %rcx
	shrq	$8, %rcx
	jmp	.LBB22_6
.LBB22_3:
	movl	8(%rsp), %edx
	movl	12(%rsp), %eax
	movq	%rbx, 48(%rsp)
	movl	%eax, 56(%rsp)
	movb	$0, 60(%rsp)
	leaq	96(%rsp), %rdi
	leaq	48(%rsp), %rcx
	movq	%r14, %rsi
.LBB22_4:
	callq	_ZN5alloc11collections5btree3map25BTreeMap$LT$K$C$V$C$A$GT$6insert17hd7c4f8aca873a6f8E
.LBB22_5:
	movb	$10, %al
.LBB22_6:
	shlq	$8, %rcx
	movzbl	%al, %eax
	orq	%rcx, %rax
	addq	$144, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB22_18:
	movq	56(%rsp), %rbp
	leaq	48(%rsp), %rdi
	movl	$36, %edx
	movq	%rbp, %rsi
	callq	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE
	movq	56(%rsp), %rax
	movl	4(%rax), %esi
	movq	%rbp, %rdi
	callq	*_ZN4acpi8AmlTable3new17h9b71125c9c38dd02E@GOTPCREL(%rip)
	movq	$1, 24(%r14)
	movq	%rax, 32(%r14)
	movl	%edx, 40(%r14)
	movl	12(%rsp), %eax
	movq	%rbx, 48(%rsp)
	movl	%eax, 56(%rsp)
	movb	$1, 60(%rsp)
	leaq	128(%rsp), %rdi
	leaq	48(%rsp), %rcx
	movq	%r14, %rsi
	movl	$1346584902, %edx
	jmp	.LBB22_4
.Lfunc_end22:
	.size	_ZN4acpi19AcpiTables$LT$H$GT$11process_sdt17h0c6f431d55adb969E, .Lfunc_end22-_ZN4acpi19AcpiTables$LT$H$GT$11process_sdt17h0c6f431d55adb969E

	.section	".text._ZN4acpi19AcpiTables$LT$H$GT$7get_sdt17h7b6644ec31d1e378E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4acpi19AcpiTables$LT$H$GT$7get_sdt17h7b6644ec31d1e378E,@function
_ZN4acpi19AcpiTables$LT$H$GT$7get_sdt17h7b6644ec31d1e378E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdi, %r14
	movl	$1346584902, 12(%rsp)
	movq	8(%rsi), %r15
	testq	%r15, %r15
	je	.LBB23_9
	movq	(%rsi), %r9
	movl	$255, %r10d
.LBB23_2:
	movzwl	186(%r15), %r8d
	leaq	(,%r8,4), %r11
	negq	%r11
	movl	$188, %ebx
	movq	$-1, %rdx
	.p2align	4, 0x90
.LBB23_3:
	leaq	(%r11,%rbx), %rsi
	cmpq	$188, %rsi
	je	.LBB23_4
	movl	12(%rsp), %esi
	movl	(%r15,%rbx), %eax
	bswapl	%esi
	bswapl	%eax
	xorl	%ecx, %ecx
	xorl	%edi, %edi
	cmpl	%eax, %esi
	seta	%cl
	setb	%dil
	xorl	%esi, %esi
	cmpl	%edi, %ecx
	setne	%sil
	cmovsl	%r10d, %esi
	addq	$4, %rbx
	addq	$1, %rdx
	cmpb	$1, %sil
	je	.LBB23_3
	cmpb	$-1, %sil
	jne	.LBB23_10
	jmp	.LBB23_7
	.p2align	4, 0x90
.LBB23_4:
	movq	%r8, %rdx
.LBB23_7:
	subq	$1, %r9
	jb	.LBB23_9
	movq	232(%r15,%rdx,8), %r15
	jmp	.LBB23_2
.LBB23_10:
	movq	-760(%r15,%rbx,4), %rsi
	movl	-752(%r15,%rbx,4), %edx
	leaq	16(%rsp), %rdi
	callq	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE
	cmpb	$0, -748(%r15,%rbx,4)
	jne	.LBB23_11
	movq	24(%rsp), %rdi
	callq	*_ZN52_$LT$acpi..fadt..Fadt$u20$as$u20$acpi..AcpiTable$GT$6header17h313df7ffa5197ecaE@GOTPCREL(%rip)
	movq	%rax, %rdi
	movl	$1346584902, %esi
	callq	*_ZN4acpi3sdt9SdtHeader8validate17hbb9f2b352ae5ba92E@GOTPCREL(%rip)
	cmpb	$10, %al
	jne	.LBB23_13
.LBB23_11:
	movq	40(%rsp), %rax
	movq	%rax, 32(%r14)
	movq	32(%rsp), %rax
	movq	%rax, 24(%r14)
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rcx, 16(%r14)
	movq	%rax, 8(%r14)
	movb	$0, (%r14)
	jmp	.LBB23_14
.LBB23_9:
	movq	$0, 16(%r14)
	movb	$0, (%r14)
	jmp	.LBB23_14
.LBB23_13:
	movl	%eax, 1(%r14)
	shrq	$32, %rax
	movb	%al, 5(%r14)
	movb	$1, (%r14)
.LBB23_14:
	addq	$48, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end23:
	.size	_ZN4acpi19AcpiTables$LT$H$GT$7get_sdt17h7b6644ec31d1e378E, .Lfunc_end23-_ZN4acpi19AcpiTables$LT$H$GT$7get_sdt17h7b6644ec31d1e378E

	.section	".text._ZN4acpi19AcpiTables$LT$H$GT$9from_rsdt17h442b1f3c610c78d1E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4acpi19AcpiTables$LT$H$GT$9from_rsdt17h442b1f3c610c78d1E,@function
_ZN4acpi19AcpiTables$LT$H$GT$9from_rsdt17h442b1f3c610c78d1E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$120, %rsp
	movq	%rdx, %rbx
	movl	%esi, %ebp
	movq	%rdi, %r14
	movb	%bpl, 80(%rsp)
	movq	88(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$8, 56(%rsp)
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	leaq	88(%rsp), %rdi
	movl	$36, %edx
	movq	%rbx, %rsi
	callq	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE
	movq	96(%rsp), %rax
	movl	4(%rax), %edx
	leaq	88(%rsp), %rdi
	movq	%rbx, %rsi
	callq	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE
	movq	96(%rsp), %r12
	movq	%r12, %rdi
	testb	%bpl, %bpl
	je	.LBB24_5
	movl	$1413763928, %esi
	callq	*_ZN4acpi3sdt9SdtHeader8validate17hbb9f2b352ae5ba92E@GOTPCREL(%rip)
	cmpb	$10, %al
	jne	.LBB24_9
	movl	4(%r12), %ebp
	addq	$-36, %rbp
	shrq	$3, %rbp
	xorl	%ebx, %ebx
	leaq	8(%rsp), %r15
	.p2align	4, 0x90
.LBB24_3:
	cmpq	%rbx, %rbp
	je	.LBB24_47
	movq	36(%r12,%rbx,8), %rsi
	addq	$1, %rbx
	movq	%r15, %rdi
	callq	_ZN4acpi19AcpiTables$LT$H$GT$11process_sdt17h0c6f431d55adb969E
	cmpb	$10, %al
	je	.LBB24_3
	jmp	.LBB24_9
.LBB24_5:
	movl	$1413763922, %esi
	callq	*_ZN4acpi3sdt9SdtHeader8validate17hbb9f2b352ae5ba92E@GOTPCREL(%rip)
	cmpb	$10, %al
	jne	.LBB24_9
	movl	4(%r12), %ebp
	addq	$-36, %rbp
	shrq	$2, %rbp
	xorl	%ebx, %ebx
	leaq	8(%rsp), %r15
	.p2align	4, 0x90
.LBB24_7:
	cmpq	%rbx, %rbp
	je	.LBB24_47
	movl	36(%r12,%rbx,4), %esi
	addq	$1, %rbx
	movq	%r15, %rdi
	callq	_ZN4acpi19AcpiTables$LT$H$GT$11process_sdt17h0c6f431d55adb969E
	cmpb	$10, %al
	je	.LBB24_7
.LBB24_9:
	movl	%eax, 1(%r14)
	shrq	$32, %rax
	movb	%al, 5(%r14)
	movb	$1, (%r14)
	movq	16(%rsp), %rdi
	xorl	%r8d, %r8d
	movq	%rdi, %r12
	testq	%rdi, %rdi
	sete	%r8b
	je	.LBB24_11
	movq	24(%rsp), %r12
.LBB24_11:
	movq	8(%rsp), %rax
	addq	%r8, %r8
	movl	$232, %r13d
	movq	__rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB24_14
	.p2align	4, 0x90
.LBB24_12:
	addq	$1, %rbp
	movq	%rdi, %rcx
	movl	$0, %eax
	testq	%rdi, %rdi
	movq	%rcx, %rdi
	je	.LBB24_58
.LBB24_14:
	subq	$1, %r12
	jb	.LBB24_44
	testq	%r8, %r8
	je	.LBB24_19
	cmpq	$2, %r8
	je	.LBB24_64
	movzwl	186(%rdi), %ecx
	cmpq	%rcx, %rbp
	jae	.LBB24_27
.LBB24_18:
	movq	%rax, %rbx
	testq	%rbx, %rbx
	jne	.LBB24_34
	jmp	.LBB24_12
	.p2align	4, 0x90
.LBB24_19:
	movl	$1, %r8d
	testq	%rax, %rax
	je	.LBB24_26
	leaq	-1(%rax), %rcx
	movq	%rax, %rdx
	andq	$7, %rdx
	je	.LBB24_24
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB24_22:
	movq	232(%rdi), %rdi
	addq	$1, %rsi
	cmpq	%rsi, %rdx
	jne	.LBB24_22
	subq	%rsi, %rax
.LBB24_24:
	cmpq	$7, %rcx
	jb	.LBB24_26
	.p2align	4, 0x90
.LBB24_25:
	movq	232(%rdi), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rdi
	addq	$-8, %rax
	jne	.LBB24_25
.LBB24_26:
	xorl	%ebp, %ebp
	xorl	%eax, %eax
	movzwl	186(%rdi), %ecx
	cmpq	%rcx, %rbp
	jb	.LBB24_18
.LBB24_27:
	movq	%r8, (%rsp)
	.p2align	4, 0x90
.LBB24_28:
	movq	(%rdi), %r14
	testq	%r14, %r14
	je	.LBB24_30
	movzwl	184(%rdi), %ebp
	leaq	1(%rax), %rbx
	jmp	.LBB24_31
	.p2align	4, 0x90
.LBB24_30:
	xorl	%r14d, %r14d
.LBB24_31:
	testq	%rax, %rax
	movl	$328, %esi
	cmoveq	%r13, %rsi
	movl	$8, %edx
	callq	*%r15
	testq	%r14, %r14
	je	.LBB24_63
	movzwl	186(%r14), %ecx
	movq	%rbx, %rax
	movq	%r14, %rdi
	cmpq	%rcx, %rbp
	jae	.LBB24_28
	movq	%r14, %rdi
	movq	(%rsp), %r8
	testq	%rbx, %rbx
	je	.LBB24_12
.LBB24_34:
	movq	240(%rdi,%rbp,8), %rcx
	movq	%rbx, %rax
	addq	$-1, %rax
	je	.LBB24_42
	addq	$-2, %rbx
	movq	%rax, %rdx
	andq	$7, %rdx
	je	.LBB24_39
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB24_37:
	movq	232(%rcx), %rcx
	addq	$1, %rsi
	cmpq	%rsi, %rdx
	jne	.LBB24_37
	subq	%rsi, %rax
.LBB24_39:
	cmpq	$7, %rbx
	jb	.LBB24_42
	.p2align	4, 0x90
.LBB24_40:
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	addq	$-8, %rax
	jne	.LBB24_40
.LBB24_42:
	xorl	%ebp, %ebp
	movl	$0, %eax
	testq	%rdi, %rdi
	movq	%rcx, %rdi
	jne	.LBB24_14
	jmp	.LBB24_58
.LBB24_44:
	testq	%r8, %r8
	je	.LBB24_48
	cmpq	$1, %r8
	jne	.LBB24_58
	testq	%rdi, %rdi
	jne	.LBB24_56
	jmp	.LBB24_58
.LBB24_47:
	leaq	8(%r14), %rdi
	leaq	8(%rsp), %rsi
	movl	$10, %ecx
	rep;movsq (%rsi), %es:(%rdi)
	movb	$0, (%r14)
	jmp	.LBB24_62
.LBB24_48:
	testq	%rax, %rax
	je	.LBB24_55
	leaq	-1(%rax), %rcx
	movq	%rax, %rdx
	andq	$7, %rdx
	je	.LBB24_53
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB24_51:
	movq	232(%rdi), %rdi
	addq	$1, %rsi
	cmpq	%rsi, %rdx
	jne	.LBB24_51
	subq	%rsi, %rax
.LBB24_53:
	cmpq	$7, %rcx
	jb	.LBB24_55
	.p2align	4, 0x90
.LBB24_54:
	movq	232(%rdi), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rcx
	movq	232(%rcx), %rdi
	addq	$-8, %rax
	jne	.LBB24_54
.LBB24_55:
	xorl	%eax, %eax
.LBB24_56:
	movl	$232, %r14d
	.p2align	4, 0x90
.LBB24_57:
	movq	(%rdi), %rbp
	leaq	1(%rax), %rbx
	testq	%rax, %rax
	movl	$328, %esi
	cmoveq	%r14, %rsi
	movl	$8, %edx
	callq	*%r15
	movq	%rbp, %rdi
	movq	%rbx, %rax
	testq	%rbp, %rbp
	jne	.LBB24_57
.LBB24_58:
	movq	64(%rsp), %rax
	testq	%rax, %rax
	je	.LBB24_62
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB24_62
	movabsq	$-9223372036854775801, %rcx
	leaq	(%rax,%rcx), %rdx
	addq	$1, %rcx
	cmpq	%rcx, %rdx
	jb	.LBB24_62
	movq	56(%rsp), %rdi
	movl	$8, %edx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB24_62:
	addq	$120, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB24_63:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_30(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB24_64:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_31(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end24:
	.size	_ZN4acpi19AcpiTables$LT$H$GT$9from_rsdt17h442b1f3c610c78d1E, .Lfunc_end24-_ZN4acpi19AcpiTables$LT$H$GT$9from_rsdt17h442b1f3c610c78d1E

	.section	".text._ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h3704d5938c1ece84E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h3704d5938c1ece84E,@function
_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h3704d5938c1ece84E:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rsi, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_lower_hex17h0339d59f23a4819dE@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB25_1
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u8$GT$3fmt17h515897263c47a231E@GOTPCREL(%rip)
.LBB25_1:
	movq	%rbx, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_upper_hex17hf3b7d753d743b63bE@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	testb	%al, %al
	je	.LBB25_4
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u8$GT$3fmt17h35ff77a156a51f04E@GOTPCREL(%rip)
.LBB25_4:
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num3imp51_$LT$impl$u20$core..fmt..Display$u20$for$u20$u8$GT$3fmt17h3e8602218822a220E@GOTPCREL(%rip)
.Lfunc_end25:
	.size	_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h3704d5938c1ece84E, .Lfunc_end25-_ZN4core3fmt3num49_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u8$GT$3fmt17h3704d5938c1ece84E

	.section	".text._ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hc977587ed4082d5bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hc977587ed4082d5bE,@function
_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hc977587ed4082d5bE:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rsi, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_lower_hex17h0339d59f23a4819dE@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB26_1
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$i32$GT$3fmt17hf6fc1d1fe8ede26fE@GOTPCREL(%rip)
.LBB26_1:
	movq	%rbx, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_upper_hex17hf3b7d753d743b63bE@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	testb	%al, %al
	je	.LBB26_4
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$i32$GT$3fmt17h4f32caf933ee6310E@GOTPCREL(%rip)
.LBB26_4:
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17ha6712ef3bd5746f3E@GOTPCREL(%rip)
.Lfunc_end26:
	.size	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hc977587ed4082d5bE, .Lfunc_end26-_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hc977587ed4082d5bE

	.section	".text._ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17haf60b95d630b3bccE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17haf60b95d630b3bccE,@function
_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17haf60b95d630b3bccE:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rsi, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_lower_hex17h0339d59f23a4819dE@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB27_1
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip)
.LBB27_1:
	movq	%rbx, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_upper_hex17hf3b7d753d743b63bE@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	testb	%al, %al
	je	.LBB27_4
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u32$GT$3fmt17hd79df3101ce76a87E@GOTPCREL(%rip)
.LBB27_4:
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u32$GT$3fmt17h4512a67783026698E@GOTPCREL(%rip)
.Lfunc_end27:
	.size	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17haf60b95d630b3bccE, .Lfunc_end27-_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u32$GT$3fmt17haf60b95d630b3bccE

	.section	".text._ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E,@function
_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rsi, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_lower_hex17h0339d59f23a4819dE@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB28_1
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17h37bc6141694e846cE@GOTPCREL(%rip)
.LBB28_1:
	movq	%rbx, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_upper_hex17hf3b7d753d743b63bE@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	testb	%al, %al
	je	.LBB28_4
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$u64$GT$3fmt17h128409351072e1b6E@GOTPCREL(%rip)
.LBB28_4:
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u64$GT$3fmt17h6c15805e91d3bb01E@GOTPCREL(%rip)
.Lfunc_end28:
	.size	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E, .Lfunc_end28-_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E

	.section	".text._ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E,@function
_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	%rsi, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_lower_hex17h0339d59f23a4819dE@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB29_1
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h0338f6cb554ca680E@GOTPCREL(%rip)
.LBB29_1:
	movq	%rbx, %rdi
	callq	*_ZN4core3fmt9Formatter15debug_upper_hex17hf3b7d753d743b63bE@GOTPCREL(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	testb	%al, %al
	je	.LBB29_4
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..UpperHex$u20$for$u20$usize$GT$3fmt17h8e457bca16bc6126E@GOTPCREL(%rip)
.LBB29_4:
	popq	%rbx
	popq	%r14
	jmpq	*_ZN4core3fmt3num3imp54_$LT$impl$u20$core..fmt..Display$u20$for$u20$usize$GT$3fmt17h00525618f8c671d5E@GOTPCREL(%rip)
.Lfunc_end29:
	.size	_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E, .Lfunc_end29-_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E

	.section	".text._ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E,@function
_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdi, %rbx
	movq	8(%rdi), %rdx
	movq	16(%rdi), %rsi
	movq	_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip), %r12
	movq	%rsp, %r14
	movq	%r14, %rdi
	callq	*%r12
	movq	_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip), %r13
	movq	%rbx, %rdi
	callq	*%r13
	leaq	24(%rbx), %r15
	movq	32(%rbx), %rdx
	movq	40(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	48(%rbx), %r15
	movq	56(%rbx), %rdx
	movq	64(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	72(%rbx), %r15
	movq	80(%rbx), %rdx
	movq	88(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	96(%rbx), %r15
	movq	104(%rbx), %rdx
	movq	112(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	120(%rbx), %r15
	movq	128(%rbx), %rdx
	movq	136(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	144(%rbx), %r15
	movq	152(%rbx), %rdx
	movq	160(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	168(%rbx), %r15
	movq	176(%rbx), %rdx
	movq	184(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	192(%rbx), %r15
	movq	200(%rbx), %rdx
	movq	208(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	216(%rbx), %r15
	movq	224(%rbx), %rdx
	movq	232(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	240(%rbx), %r15
	movq	248(%rbx), %rdx
	movq	256(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	264(%rbx), %r15
	movq	272(%rbx), %rdx
	movq	280(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	288(%rbx), %r15
	movq	296(%rbx), %rdx
	movq	304(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	312(%rbx), %r15
	movq	320(%rbx), %rdx
	movq	328(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	336(%rbx), %r15
	movq	344(%rbx), %rdx
	movq	352(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	360(%rbx), %r15
	movq	368(%rbx), %rdx
	movq	376(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	384(%rbx), %r15
	movq	392(%rbx), %rdx
	movq	400(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	408(%rbx), %r15
	movq	416(%rbx), %rdx
	movq	424(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	432(%rbx), %r15
	movq	440(%rbx), %rdx
	movq	448(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	456(%rbx), %r15
	movq	464(%rbx), %rdx
	movq	472(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	480(%rbx), %r15
	movq	488(%rbx), %rdx
	movq	496(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	504(%rbx), %r15
	movq	512(%rbx), %rdx
	movq	520(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	528(%rbx), %r15
	movq	536(%rbx), %rdx
	movq	544(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	552(%rbx), %r15
	movq	560(%rbx), %rdx
	movq	568(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	576(%rbx), %r15
	movq	584(%rbx), %rdx
	movq	592(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	600(%rbx), %r15
	movq	608(%rbx), %rdx
	movq	616(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	624(%rbx), %r15
	movq	632(%rbx), %rdx
	movq	640(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	648(%rbx), %r15
	movq	656(%rbx), %rdx
	movq	664(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	672(%rbx), %r15
	movq	680(%rbx), %rdx
	movq	688(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	696(%rbx), %r15
	movq	704(%rbx), %rdx
	movq	712(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	720(%rbx), %r15
	movq	728(%rbx), %rdx
	movq	736(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	callq	*%r13
	leaq	744(%rbx), %r15
	movq	752(%rbx), %rdx
	movq	760(%rbx), %rsi
	movq	%r14, %rdi
	callq	*%r12
	movq	%r15, %rdi
	movq	%r13, %rax
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	jmpq	*%rax
.Lfunc_end30:
	.size	_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E, .Lfunc_end30-_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E

	.section	".text._ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E,@function
_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E:
	retq
.Lfunc_end31:
	.size	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E, .Lfunc_end31-_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E

	.section	".text._ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E,@function
_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E:
	movzbl	(%rdi), %eax
	addq	$-14, %rax
	cmpq	$4, %rax
	ja	.LBB32_9
	leaq	.LJTI32_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB32_5:
	movq	16(%rdi), %rax
	testq	%rax, %rax
	je	.LBB32_9
	movl	$5, %ecx
	mulq	%rcx
	jo	.LBB32_9
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	testq	%rax, %rax
	js	.LBB32_9
	je	.LBB32_9
	movq	8(%rdi), %rdi
	movq	%rax, %rsi
	jmpq	*__rust_dealloc@GOTPCREL(%rip)
.LBB32_9:
	retq
.Lfunc_end32:
	.size	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E, .Lfunc_end32-_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
	.section	".rodata._ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E","a",@progbits
	.p2align	2
.LJTI32_0:
	.long	.LBB32_5-.LJTI32_0
	.long	.LBB32_9-.LJTI32_0
	.long	.LBB32_5-.LJTI32_0
	.long	.LBB32_5-.LJTI32_0
	.long	.LBB32_5-.LJTI32_0

	.section	".text._ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E,@function
_ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movzbl	(%rdi), %eax
	addq	$-2, %rax
	cmpq	$9, %rax
	ja	.LBB33_2
	movq	%rdi, %r14
	leaq	.LJTI33_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB33_18:
	movq	8(%r14), %rax
	lock		subq	$1, (%rax)
	jne	.LBB33_2
	addq	$8, %r14
	#MEMBARRIER
	movq	%r14, %rdi
	popq	%rbx
	popq	%r14
	popq	%r15
	jmp	_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h1eed343e645936ceE
.LBB33_3:
	movq	16(%r14), %rsi
	testq	%rsi, %rsi
	jle	.LBB33_2
	movq	8(%r14), %rdi
	jmp	.LBB33_5
.LBB33_6:
	movq	24(%r14), %rdi
	testq	%rdi, %rdi
	je	.LBB33_2
	movq	32(%r14), %rax
	testq	%rax, %rax
	je	.LBB33_2
	movl	$5, %ecx
	mulq	%rcx
	jo	.LBB33_2
	testq	%rax, %rax
	jle	.LBB33_2
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	jmp	.LBB33_11
.LBB33_13:
	cmpq	$0, 8(%r14)
	je	.LBB33_14
	addq	$16, %r14
	movq	(%r14), %rax
	lock		subq	$1, (%rax)
	jne	.LBB33_2
	#MEMBARRIER
	movq	%r14, %rdi
	popq	%rbx
	popq	%r14
	popq	%r15
	jmp	_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h243c7559f836e74bE
.LBB33_20:
	movq	24(%r14), %rax
	testq	%rax, %rax
	je	.LBB33_23
	movq	8(%r14), %rdi
	shlq	$4, %rax
	leaq	(%rax,%rax,2), %rbx
	.p2align	4, 0x90
.LBB33_22:
	leaq	48(%rdi), %r15
	callq	_ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E
	movq	%r15, %rdi
	addq	$-48, %rbx
	jne	.LBB33_22
.LBB33_23:
	movq	16(%r14), %rax
	testq	%rax, %rax
	je	.LBB33_2
	movl	$48, %ecx
	mulq	%rcx
	jo	.LBB33_2
	movabsq	$-9223372036854775801, %rcx
	leaq	(%rax,%rcx), %rdx
	addq	$1, %rcx
	cmpq	%rcx, %rdx
	jb	.LBB33_2
	movq	8(%r14), %rdi
	movl	$8, %edx
.LBB33_11:
	movq	%rax, %rsi
	popq	%rbx
	popq	%r14
	popq	%r15
	jmpq	*__rust_dealloc@GOTPCREL(%rip)
.LBB33_14:
	movq	24(%r14), %rsi
	testq	%rsi, %rsi
	jle	.LBB33_2
	movq	16(%r14), %rdi
.LBB33_5:
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	popq	%rbx
	popq	%r14
	popq	%r15
	jmpq	*__rust_dealloc@GOTPCREL(%rip)
.LBB33_2:
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end33:
	.size	_ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E, .Lfunc_end33-_ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E
	.section	".rodata._ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E","a",@progbits
	.p2align	2
.LJTI33_0:
	.long	.LBB33_3-.LJTI33_0
	.long	.LBB33_6-.LJTI33_0
	.long	.LBB33_2-.LJTI33_0
	.long	.LBB33_2-.LJTI33_0
	.long	.LBB33_13-.LJTI33_0
	.long	.LBB33_18-.LJTI33_0
	.long	.LBB33_18-.LJTI33_0
	.long	.LBB33_2-.LJTI33_0
	.long	.LBB33_2-.LJTI33_0
	.long	.LBB33_20-.LJTI33_0

	.section	".text._ZN4core3ptr50drop_in_place$LT$cryptos..ahci..sata..SataDisk$GT$17h760db4982a32399cE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr50drop_in_place$LT$cryptos..ahci..sata..SataDisk$GT$17h760db4982a32399cE,@function
_ZN4core3ptr50drop_in_place$LT$cryptos..ahci..sata..SataDisk$GT$17h760db4982a32399cE:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rdi, %rbx
	leaq	72(%rdi), %r14
	movq	80(%rdi), %rdx
	movq	88(%rdi), %rsi
	movq	_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip), %r15
	leaq	8(%rsp), %rdi
	callq	*%r15
	movq	_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip), %r12
	movq	%r14, %rdi
	callq	*%r12
	leaq	96(%rbx), %rdi
	callq	_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E
	leaq	864(%rbx), %r14
	movq	872(%rbx), %rdx
	movq	880(%rbx), %rsi
	leaq	8(%rsp), %rdi
	callq	*%r15
	movq	%r14, %rdi
	callq	*%r12
	leaq	888(%rbx), %r14
	movq	896(%rbx), %rdx
	movq	904(%rbx), %rsi
	leaq	8(%rsp), %rdi
	callq	*%r15
	movq	%r14, %rdi
	movq	%r12, %rax
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	jmpq	*%rax
.Lfunc_end34:
	.size	_ZN4core3ptr50drop_in_place$LT$cryptos..ahci..sata..SataDisk$GT$17h760db4982a32399cE, .Lfunc_end34-_ZN4core3ptr50drop_in_place$LT$cryptos..ahci..sata..SataDisk$GT$17h760db4982a32399cE

	.section	".text._ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE,@function
_ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	cmpb	$2, 104(%rdi)
	je	.LBB35_16
	movq	%rdi, %rbx
	movabsq	$-9223372036854775805, %r14
	movq	16(%rdi), %rax
	testq	%rax, %rax
	je	.LBB35_5
	movl	$12, %ecx
	mulq	%rcx
	jo	.LBB35_5
	leaq	(%rax,%r14), %rcx
	leaq	1(%r14), %rdx
	cmpq	%rdx, %rcx
	jb	.LBB35_5
	movq	8(%rbx), %rdi
	movl	$4, %edx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB35_5:
	movq	40(%rbx), %rax
	testq	%rax, %rax
	je	.LBB35_9
	movl	$12, %ecx
	mulq	%rcx
	jo	.LBB35_9
	leaq	(%rax,%r14), %rcx
	leaq	1(%r14), %rdx
	cmpq	%rdx, %rcx
	jb	.LBB35_9
	movq	32(%rbx), %rdi
	movl	$4, %edx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB35_9:
	movq	64(%rbx), %rax
	testq	%rax, %rax
	je	.LBB35_13
	movl	$8, %ecx
	mulq	%rcx
	jo	.LBB35_13
	leaq	(%rax,%r14), %rcx
	leaq	1(%r14), %rdx
	cmpq	%rdx, %rcx
	jb	.LBB35_13
	movq	56(%rbx), %rdi
	movl	$4, %edx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB35_13:
	movq	88(%rbx), %rax
	testq	%rax, %rax
	je	.LBB35_16
	movl	$8, %ecx
	mulq	%rcx
	jo	.LBB35_16
	leaq	(%rax,%r14), %rcx
	addq	$1, %r14
	cmpq	%r14, %rcx
	jb	.LBB35_16
	movq	80(%rbx), %rdi
	movl	$4, %edx
	movq	%rax, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*__rust_dealloc@GOTPCREL(%rip)
.LBB35_16:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end35:
	.size	_ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE, .Lfunc_end35-_ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE

	.section	".text._ZN4core3ptr63drop_in_place$LT$cryptos..ahci..satapi..SataPacketInterface$GT$17hdd4b93432faaed4aE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr63drop_in_place$LT$cryptos..ahci..satapi..SataPacketInterface$GT$17hdd4b93432faaed4aE,@function
_ZN4core3ptr63drop_in_place$LT$cryptos..ahci..satapi..SataPacketInterface$GT$17hdd4b93432faaed4aE:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rdi, %rbx
	leaq	24(%rdi), %r14
	movq	32(%rdi), %rdx
	movq	40(%rdi), %rsi
	movq	_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip), %r15
	leaq	8(%rsp), %rdi
	callq	*%r15
	movq	_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip), %r12
	movq	%r14, %rdi
	callq	*%r12
	leaq	48(%rbx), %rdi
	callq	_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E
	leaq	816(%rbx), %r14
	movq	824(%rbx), %rdx
	movq	832(%rbx), %rsi
	leaq	8(%rsp), %rdi
	callq	*%r15
	movq	%r14, %rdi
	callq	*%r12
	leaq	840(%rbx), %r14
	movq	848(%rbx), %rdx
	movq	856(%rbx), %rsi
	leaq	8(%rsp), %rdi
	callq	*%r15
	movq	%r14, %rdi
	movq	%r12, %rax
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	jmpq	*%rax
.Lfunc_end36:
	.size	_ZN4core3ptr63drop_in_place$LT$cryptos..ahci..satapi..SataPacketInterface$GT$17hdd4b93432faaed4aE, .Lfunc_end36-_ZN4core3ptr63drop_in_place$LT$cryptos..ahci..satapi..SataPacketInterface$GT$17hdd4b93432faaed4aE

	.section	".text._ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE,@function
_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE:
	movq	%rdi, %rax
	movq	(%rdi), %rdi
	testq	%rdi, %rdi
	je	.LBB37_2
	movq	8(%rax), %rsi
	testq	%rsi, %rsi
	jle	.LBB37_2
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	jmpq	*__rust_dealloc@GOTPCREL(%rip)
.LBB37_2:
	retq
.Lfunc_end37:
	.size	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE, .Lfunc_end37-_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE

	.section	".text._ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE,@function
_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE:
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdi, %rbx
	movq	8(%rdi), %rdx
	movq	16(%rdi), %rsi
	movq	%rsp, %rdi
	callq	*_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip)
	movq	%rbx, %rdi
	addq	$16, %rsp
	popq	%rbx
	jmpq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.Lfunc_end38:
	.size	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE, .Lfunc_end38-_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE

	.section	".text._ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h55edd20dcc9dbabcE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h55edd20dcc9dbabcE,@function
_ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h55edd20dcc9dbabcE:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rdi, %rbx
	leaq	8(%rsp), %r14
	movq	%r14, %rdi
	callq	*_ZN4core3fmt9Formatter10debug_list17hdc38e9f66eb4aae4E@GOTPCREL(%rip)
	leaq	1(%rbx), %r13
	movq	%rbx, (%rsp)
	leaq	.L__unnamed_32(%rip), %rdx
	movq	_ZN4core3fmt8builders9DebugList5entry17h51768400aa72c3b1E@GOTPCREL(%rip), %r15
	movq	%rsp, %r12
	movq	%r14, %rdi
	movq	%r12, %rsi
	callq	*%r15
	leaq	2(%rbx), %rbp
	movq	%r13, (%rsp)
	movq	%r14, %rdi
	movq	%r12, %rsi
	leaq	.L__unnamed_32(%rip), %rdx
	callq	*%r15
	addq	$3, %rbx
	movq	%rbp, (%rsp)
	movq	%r14, %rdi
	movq	%r12, %rsi
	leaq	.L__unnamed_32(%rip), %rdx
	movq	%rdx, %rbp
	callq	*%r15
	movq	%rbx, (%rsp)
	movq	%r14, %rdi
	movq	%r12, %rsi
	movq	%rbp, %rdx
	callq	*%r15
	movq	%r14, %rdi
	callq	*_ZN4core3fmt8builders9DebugList6finish17he4f48ea1c5971431E@GOTPCREL(%rip)
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end39:
	.size	_ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h55edd20dcc9dbabcE, .Lfunc_end39-_ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h55edd20dcc9dbabcE

	.section	".text._ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE,@function
_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE:
	movq	%rsi, %rdx
	movq	(%rdi), %rax
	movq	16(%rdi), %rsi
	movq	%rax, %rdi
	jmpq	*_ZN40_$LT$str$u20$as$u20$core..fmt..Debug$GT$3fmt17h237ca7479e920490E@GOTPCREL(%rip)
.Lfunc_end40:
	.size	_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE, .Lfunc_end40-_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE

	.section	".text._ZN5alloc11collections5btree3map25BTreeMap$LT$K$C$V$C$A$GT$6insert17hd7c4f8aca873a6f8E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc11collections5btree3map25BTreeMap$LT$K$C$V$C$A$GT$6insert17hd7c4f8aca873a6f8E,@function
_ZN5alloc11collections5btree3map25BTreeMap$LT$K$C$V$C$A$GT$6insert17hd7c4f8aca873a6f8E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$232, %rsp
	movq	%rcx, %r15
	movl	%edx, %r12d
	movq	%rsi, %r11
	movq	%rdi, %r10
	movl	%edx, 16(%rsp)
	movq	8(%rsi), %r14
	testq	%r14, %r14
	je	.LBB41_1
	movq	(%r11), %r8
	movl	$255, %r9d
	movq	%r14, 136(%rsp)
	movq	%r8, 208(%rsp)
.LBB41_3:
	movzwl	186(%r14), %r13d
	leaq	(,%r13,4), %rsi
	negq	%rsi
	movl	$188, %edx
	movq	$-1, %rbp
	.p2align	4, 0x90
.LBB41_4:
	leaq	(%rsi,%rdx), %rdi
	cmpq	$188, %rdi
	je	.LBB41_5
	movl	16(%rsp), %edi
	movl	(%r14,%rdx), %ebx
	bswapl	%edi
	bswapl	%ebx
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	cmpl	%ebx, %edi
	seta	%cl
	setb	%al
	xorl	%edi, %edi
	cmpl	%eax, %ecx
	setne	%dil
	cmovsl	%r9d, %edi
	addq	$4, %rdx
	addq	$1, %rbp
	cmpb	$1, %dil
	je	.LBB41_4
	cmpb	$-1, %dil
	jne	.LBB41_72
	jmp	.LBB41_8
	.p2align	4, 0x90
.LBB41_5:
	movq	%r13, %rbp
.LBB41_8:
	subq	$1, %r8
	jb	.LBB41_10
	movq	232(%r14,%rbp,8), %r14
	jmp	.LBB41_3
.LBB41_72:
	movq	-760(%r14,%rdx,4), %rax
	movq	-752(%r14,%rdx,4), %rcx
	movq	%rcx, 8(%r10)
	movq	%rax, (%r10)
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rax, -760(%r14,%rdx,4)
	movq	%rcx, -752(%r14,%rdx,4)
	jmp	.LBB41_73
.LBB41_1:
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 184(%rsp)
	movq	%rax, 176(%rsp)
.LBB41_11:
	movq	%r11, %rbp
	movq	%r10, %rbx
	movl	$232, %edi
	movl	$8, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB41_12
	movq	$0, (%rax)
	movq	176(%rsp), %rcx
	movq	184(%rsp), %rdx
	movq	%rcx, 8(%rax)
	movq	%rdx, 16(%rax)
	movw	$1, 186(%rax)
	movl	%r12d, 188(%rax)
	movq	$0, (%rbp)
	movq	%rax, 8(%rbp)
	movq	$1, 16(%rbp)
	movb	$2, 12(%rbx)
.LBB41_73:
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB41_10:
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 184(%rsp)
	movq	%rax, 176(%rsp)
	testq	%r14, %r14
	je	.LBB41_11
	cmpw	$11, %r13w
	jae	.LBB41_16
	cmpq	%r13, %rbp
	jae	.LBB41_22
	leaq	1(%rbp), %rbx
	movq	%r13, %rax
	subq	%rbp, %rax
	movq	%rax, 136(%rsp)
	leaq	(,%rax,4), %rdx
	leaq	(%r14,%rbx,4), %rdi
	addq	$188, %rdi
	leaq	(%r14,%rbp,4), %rsi
	addq	$188, %rsi
	movq	%r10, 96(%rsp)
	movq	%r11, 88(%rsp)
	callq	*memmove@GOTPCREL(%rip)
	movl	%r12d, 188(%r14,%rbp,4)
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 24(%rsp)
	movq	%rax, 16(%rsp)
	movq	%rbp, %rax
	shlq	$4, %rax
	leaq	(%r14,%rax), %rsi
	addq	$8, %rsi
	shlq	$4, %rbx
	leaq	(%r14,%rbx), %rdi
	addq	$8, %rdi
	movq	136(%rsp), %rdx
	shlq	$4, %rdx
	callq	*memmove@GOTPCREL(%rip)
	movq	88(%rsp), %r11
	movq	96(%rsp), %r10
	jmp	.LBB41_24
.LBB41_16:
	movq	%r11, 88(%rsp)
	movq	%r10, 96(%rsp)
	leaq	16(%rsp), %rdi
	movq	%rbp, %rsi
	callq	*_ZN5alloc11collections5btree4node10splitpoint17ha15b89b0e69aa26cE@GOTPCREL(%rip)
	movq	16(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	24(%rsp), %rbx
	movq	32(%rsp), %rax
	movq	%rax, 40(%rsp)
	movl	$232, %edi
	movl	$8, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB41_12
	movq	%rax, %r13
	movq	%rbx, 112(%rsp)
	movq	$0, (%rax)
	movzwl	186(%r14), %eax
	movq	48(%rsp), %rdx
	movq	%rdx, %rbp
	notq	%rbp
	addq	%rax, %rbp
	movw	%bp, 186(%r13)
	movl	188(%r14,%rdx,4), %ecx
	movl	%ecx, 108(%rsp)
	movq	%rdx, %rcx
	shlq	$4, %rcx
	movq	8(%r14,%rcx), %rdx
	movq	%rdx, 56(%rsp)
	movl	16(%r14,%rcx), %edx
	movl	%edx, 64(%rsp)
	movb	20(%r14,%rcx), %dl
	movb	%dl, 11(%rsp)
	movb	23(%r14,%rcx), %dl
	movb	%dl, 122(%rsp)
	movzwl	21(%r14,%rcx), %ecx
	movw	%cx, 120(%rsp)
	cmpq	$12, %rbp
	jae	.LBB41_74
	movq	48(%rsp), %rcx
	leaq	1(%rcx), %rbx
	subq	%rbx, %rax
	cmpq	%rbp, %rax
	jne	.LBB41_75
	leaq	(%r14,%rbx,4), %rsi
	addq	$188, %rsi
	leaq	(,%rbp,4), %rdx
	leaq	188(%r13), %rdi
	callq	*memcpy@GOTPCREL(%rip)
	leaq	8(%r13), %rdi
	shlq	$4, %rbx
	leaq	(%r14,%rbx), %rsi
	addq	$8, %rsi
	shlq	$4, %rbp
	movq	%rbp, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	48(%rsp), %rax
	movw	%ax, 186(%r14)
	movq	56(%rsp), %rax
	movq	%rax, 20(%rsp)
	movl	64(%rsp), %eax
	movl	%eax, 28(%rsp)
	movb	122(%rsp), %al
	movb	%al, 8(%rsp)
	movzwl	120(%rsp), %eax
	movw	%ax, 6(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	16(%rsp), %rax
	cmpq	$0, 112(%rsp)
	movq	%r13, %rbp
	cmoveq	%r14, %rbp
	movq	%rax, 56(%rsp)
	movzwl	186(%rbp), %esi
	movq	40(%rsp), %rdx
	leaq	1(%rdx), %rbx
	cmpq	%rsi, %rbx
	jbe	.LBB41_25
	movl	%r12d, 188(%rbp,%rdx,4)
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 24(%rsp)
	movq	%rax, 16(%rsp)
	jmp	.LBB41_26
.LBB41_22:
	movl	%r12d, 188(%r14,%rbp,4)
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 24(%rsp)
	movq	%rax, 16(%rsp)
.LBB41_24:
	leal	1(%r13), %eax
	shlq	$4, %rbp
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rdx, 16(%r14,%rbp)
	movq	%rcx, 8(%r14,%rbp)
	movw	%ax, 186(%r14)
	jmp	.LBB41_27
.LBB41_25:
	movq	%rsi, %rax
	subq	%rdx, %rax
	movq	%rax, 112(%rsp)
	leaq	(,%rax,4), %rdx
	leaq	188(,%rbx,4), %rdi
	addq	%rbp, %rdi
	movq	40(%rsp), %rax
	movq	%rsi, 48(%rsp)
	leaq	188(,%rax,4), %rsi
	addq	%rbp, %rsi
	callq	*memmove@GOTPCREL(%rip)
	movq	40(%rsp), %rax
	movl	%r12d, 188(%rbp,%rax,4)
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 24(%rsp)
	movq	%rax, 16(%rsp)
	movq	40(%rsp), %rax
	shlq	$4, %rax
	leaq	(%rax,%rbp), %rsi
	addq	$8, %rsi
	shlq	$4, %rbx
	leaq	(%rbx,%rbp), %rdi
	addq	$8, %rdi
	movq	112(%rsp), %rdx
	shlq	$4, %rdx
	callq	*memmove@GOTPCREL(%rip)
	movq	48(%rsp), %rsi
	movq	40(%rsp), %rdx
.LBB41_26:
	movq	96(%rsp), %r10
	movq	88(%rsp), %r11
	addl	$1, %esi
	shlq	$4, %rdx
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rcx, 16(%rbp,%rdx)
	movq	%rax, 8(%rbp,%rdx)
	movw	%si, 186(%rbp)
	movq	56(%rsp), %rax
	movq	64(%rsp), %rcx
	movq	%rcx, 168(%rsp)
	movq	%rax, 160(%rsp)
	movzwl	6(%rsp), %eax
	movw	%ax, 12(%rsp)
	movb	8(%rsp), %al
	movb	%al, 14(%rsp)
	movb	11(%rsp), %r15b
	cmpb	$2, %r15b
	movl	108(%rsp), %ebp
	jne	.LBB41_28
.LBB41_27:
	addq	$1, 16(%r11)
	movb	$2, 12(%r10)
	jmp	.LBB41_73
.LBB41_28:
	movq	160(%rsp), %rax
	movq	168(%rsp), %rcx
	movq	%rax, 120(%rsp)
	movq	%rcx, 128(%rsp)
	movzwl	12(%rsp), %eax
	movw	%ax, 2(%rsp)
	movb	14(%rsp), %al
	movb	%al, 4(%rsp)
	movq	(%r14), %rax
	testq	%rax, %rax
	je	.LBB41_29
	xorl	%ecx, %ecx
	movq	%rcx, 152(%rsp)
	movl	%ebp, %esi
	movq	%r13, %rcx
	movl	%r15d, %edx
.LBB41_31:
	movzwl	184(%r14), %ebx
	movq	%rax, %r14
	movzwl	186(%rax), %ebp
	cmpq	$11, %rbp
	movq	%rcx, 112(%rsp)
	movb	%dl, 10(%rsp)
	jb	.LBB41_43
	movl	%esi, 148(%rsp)
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_ZN5alloc11collections5btree4node10splitpoint17ha15b89b0e69aa26cE@GOTPCREL(%rip)
	movq	16(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	24(%rsp), %rbp
	movq	32(%rsp), %rax
	movq	%rax, 48(%rsp)
	movzwl	186(%r14), %r15d
	movl	$328, %edi
	movl	$8, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB41_33
	movq	%rax, %rbx
	movq	$0, (%rbx)
	movzwl	186(%r14), %eax
	movq	40(%rsp), %rsi
	movq	%rsi, %r12
	notq	%r12
	addq	%rax, %r12
	movw	%r12w, 186(%rbx)
	movl	188(%r14,%rsi,4), %ecx
	movl	%ecx, 108(%rsp)
	movq	%rsi, %rcx
	shlq	$4, %rcx
	movq	8(%r14,%rcx), %rdx
	movq	%rdx, 56(%rsp)
	movl	16(%r14,%rcx), %edx
	movl	%edx, 64(%rsp)
	movb	20(%r14,%rcx), %dl
	movb	%dl, 11(%rsp)
	movb	23(%r14,%rcx), %dl
	movb	%dl, 8(%rsp)
	movzwl	21(%r14,%rcx), %ecx
	movw	%cx, 6(%rsp)
	cmpq	$12, %r12
	jae	.LBB41_76
	movq	%rbp, 200(%rsp)
	leaq	1(%rsi), %rbp
	subq	%rbp, %rax
	cmpq	%r12, %rax
	jne	.LBB41_75
	movq	%rbx, %r13
	leaq	(%r14,%rbp,4), %rsi
	addq	$188, %rsi
	leaq	(,%r12,4), %rdx
	leaq	188(%rbx), %rdi
	callq	*memcpy@GOTPCREL(%rip)
	leaq	8(%rbx), %rdi
	movq	%rbp, 192(%rsp)
	shlq	$4, %rbp
	leaq	(%r14,%rbp), %rsi
	addq	$8, %rsi
	shlq	$4, %r12
	movq	%r12, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	40(%rsp), %rdx
	movw	%dx, 186(%r14)
	movq	56(%rsp), %rax
	leaq	20(%rsp), %rcx
	movq	%rax, (%rcx)
	movl	64(%rsp), %eax
	movl	%eax, 8(%rcx)
	movzwl	6(%rsp), %eax
	movw	%ax, 12(%rsp)
	movb	8(%rsp), %al
	movb	%al, 14(%rsp)
	movzwl	186(%rbx), %ebp
	leaq	1(%rbp), %rdi
	cmpq	$12, %rbp
	jae	.LBB41_77
	subq	%rdx, %r15
	cmpq	%rdi, %r15
	jne	.LBB41_75
	addq	$1, 152(%rsp)
	leaq	232(%rbx), %rdi
	movq	192(%rsp), %rax
	leaq	(%r14,%rax,8), %rsi
	addq	$232, %rsi
	shlq	$3, %r15
	movq	%r15, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB41_39:
	movq	%rax, %rcx
	cmpq	%rbp, %rax
	adcq	$0, %rax
	movq	232(%r13,%rcx,8), %rdx
	movq	%r13, (%rdx)
	movw	%cx, 184(%rdx)
	cmpq	%rbp, %rcx
	jae	.LBB41_41
	cmpq	%rbp, %rax
	jbe	.LBB41_39
.LBB41_41:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rcx, 64(%rsp)
	movq	%rax, 56(%rsp)
	movzwl	12(%rsp), %eax
	movw	%ax, 84(%rsp)
	movb	14(%rsp), %al
	cmpq	$0, 200(%rsp)
	cmoveq	%r14, %rbx
	movb	%al, 86(%rsp)
	movzwl	186(%rbx), %r11d
	movq	48(%rsp), %r10
	leaq	1(%r10), %rbp
	cmpq	%r11, %rbp
	jbe	.LBB41_55
	movl	148(%rsp), %eax
	movl	%eax, 188(%rbx,%r10,4)
	leaq	124(%rsp), %rcx
	movq	(%rcx), %rax
	movq	%rax, 16(%rsp)
	movl	8(%rcx), %eax
	movl	%eax, 24(%rsp)
	movzwl	2(%rsp), %eax
	movw	%ax, 6(%rsp)
	movb	4(%rsp), %al
	movb	%al, 8(%rsp)
	jmp	.LBB41_56
.LBB41_55:
	movq	%r11, %r12
	subq	%r10, %r12
	leaq	(,%r12,4), %rdx
	leaq	(%rbx,%rbp,4), %rdi
	addq	$188, %rdi
	leaq	(%rbx,%r10,4), %rsi
	addq	$188, %rsi
	movq	memmove@GOTPCREL(%rip), %r15
	movq	%r11, 40(%rsp)
	callq	*%r15
	movq	48(%rsp), %rax
	movl	148(%rsp), %ecx
	movl	%ecx, 188(%rbx,%rax,4)
	leaq	124(%rsp), %rcx
	movq	(%rcx), %rax
	movq	%rax, 16(%rsp)
	movl	8(%rcx), %eax
	movl	%eax, 24(%rsp)
	movzwl	2(%rsp), %eax
	movw	%ax, 6(%rsp)
	movb	4(%rsp), %al
	movb	%al, 8(%rsp)
	movq	48(%rsp), %rax
	shlq	$4, %rax
	leaq	(%rbx,%rax), %rsi
	addq	$8, %rsi
	movq	%rbp, %rax
	shlq	$4, %rax
	leaq	(%rbx,%rax), %rdi
	addq	$8, %rdi
	shlq	$4, %r12
	movq	%r12, %rdx
	callq	*%r15
	movq	40(%rsp), %r11
	movq	48(%rsp), %r10
.LBB41_56:
	movq	96(%rsp), %r8
	movq	88(%rsp), %r9
	movb	10(%rsp), %dl
	leal	1(%r11), %esi
	movq	%r10, %rax
	shlq	$4, %rax
	movl	24(%rsp), %ecx
	movl	%ecx, 16(%rbx,%rax)
	movq	16(%rsp), %rcx
	movq	%rcx, 8(%rbx,%rax)
	movb	%dl, 20(%rbx,%rax)
	movzwl	6(%rsp), %ecx
	movw	%cx, 21(%rbx,%rax)
	movb	8(%rsp), %cl
	movb	%cl, 23(%rbx,%rax)
	leaq	2(%r11), %r12
	leaq	2(%r10), %rax
	cmpq	%r12, %rax
	jae	.LBB41_58
	movl	%esi, 40(%rsp)
	leaq	(%rbx,%rbp,8), %rsi
	addq	$232, %rsi
	leaq	(%rbx,%rax,8), %rdi
	addq	$232, %rdi
	movq	%r11, %rdx
	subq	%r10, %rdx
	shlq	$3, %rdx
	movq	%r11, %r15
	callq	*memmove@GOTPCREL(%rip)
	movl	40(%rsp), %esi
	movq	%r15, %r11
	movq	48(%rsp), %r10
	movq	88(%rsp), %r9
	movq	96(%rsp), %r8
.LBB41_58:
	movq	112(%rsp), %rax
	movq	%rax, 240(%rbx,%r10,8)
	movw	%si, 186(%rbx)
	cmpq	%r12, %rbp
	movb	11(%rsp), %r15b
	jae	.LBB41_65
	movl	%r11d, %eax
	subl	%r10d, %eax
	addl	$1, %eax
	subq	%r10, %r11
	andq	$3, %rax
	je	.LBB41_63
	leaq	(%rbx,%r10,8), %rdx
	addq	$240, %rdx
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB41_61:
	movq	(%rdx,%rcx,8), %rsi
	movq	%rbx, (%rsi)
	leal	(%rcx,%rbp), %edi
	movw	%di, 184(%rsi)
	addq	$1, %rcx
	cmpq	%rcx, %rax
	jne	.LBB41_61
	addq	%rcx, %rbp
.LBB41_63:
	cmpq	$3, %r11
	jb	.LBB41_65
	.p2align	4, 0x90
.LBB41_64:
	movq	232(%rbx,%rbp,8), %rax
	movq	%rbx, (%rax)
	movw	%bp, 184(%rax)
	movq	240(%rbx,%rbp,8), %rax
	movq	%rbx, (%rax)
	leal	1(%rbp), %ecx
	movw	%cx, 184(%rax)
	movq	248(%rbx,%rbp,8), %rax
	movq	%rbx, (%rax)
	leal	2(%rbp), %ecx
	movw	%cx, 184(%rax)
	movq	256(%rbx,%rbp,8), %rax
	movq	%rbx, (%rax)
	leal	3(%rbp), %ecx
	movw	%cx, 184(%rax)
	addq	$4, %rbp
	cmpq	%r12, %rbp
	jne	.LBB41_64
.LBB41_65:
	movq	56(%rsp), %rax
	movq	64(%rsp), %rcx
	movq	%rcx, 168(%rsp)
	movq	%rax, 160(%rsp)
	movzwl	84(%rsp), %eax
	movw	%ax, 80(%rsp)
	movb	86(%rsp), %al
	movb	%al, 82(%rsp)
	cmpb	$2, %r15b
	je	.LBB41_66
	movq	160(%rsp), %rax
	movq	168(%rsp), %rcx
	movq	%rcx, 128(%rsp)
	movq	%rax, 120(%rsp)
	movzwl	80(%rsp), %eax
	movw	%ax, 2(%rsp)
	movb	82(%rsp), %al
	movb	%al, 4(%rsp)
	movq	(%r14), %rax
	movl	108(%rsp), %ebp
	movl	%ebp, %esi
	movq	%r13, %rcx
	movl	%r15d, %edx
	testq	%rax, %rax
	jne	.LBB41_31
	jmp	.LBB41_68
.LBB41_29:
	xorl	%eax, %eax
	movq	%rax, 152(%rsp)
.LBB41_68:
	movq	120(%rsp), %rax
	movq	128(%rsp), %rcx
	movq	%rcx, 224(%rsp)
	movq	%rax, 216(%rsp)
	movzwl	2(%rsp), %edx
	movw	%dx, 76(%rsp)
	movb	4(%rsp), %dl
	movb	%dl, 78(%rsp)
	movq	%rcx, 24(%rsp)
	movq	%rax, 16(%rsp)
	movl	$328, %edi
	movl	$8, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB41_33
	movq	$0, (%rax)
	movw	$0, 186(%rax)
	movq	136(%rsp), %rcx
	movq	%rcx, 232(%rax)
	movq	%rax, (%rcx)
	movw	$0, 184(%rcx)
	movq	208(%rsp), %rdx
	leaq	1(%rdx), %rcx
	movq	88(%rsp), %rbx
	movq	%rcx, (%rbx)
	movq	%rax, 8(%rbx)
	cmpq	152(%rsp), %rdx
	movq	96(%rsp), %r8
	jne	.LBB41_78
	movzwl	186(%rax), %ecx
	cmpq	$10, %rcx
	ja	.LBB41_79
	leaq	20(%rsp), %rdx
	leal	1(%rcx), %esi
	movw	%si, 186(%rax)
	movl	%ebp, 188(%rax,%rcx,4)
	movq	%rcx, %rsi
	shlq	$4, %rsi
	movl	8(%rdx), %edi
	movl	%edi, 16(%rax,%rsi)
	movq	(%rdx), %rdx
	movq	%rdx, 8(%rax,%rsi)
	movb	%r15b, 20(%rax,%rsi)
	movzwl	76(%rsp), %edx
	movw	%dx, 21(%rax,%rsi)
	movb	78(%rsp), %dl
	movb	%dl, 23(%rax,%rsi)
	movq	%r13, 240(%rax,%rcx,8)
	addq	$1, %rcx
	movq	%rax, (%r13)
	movw	%cx, 184(%r13)
	addq	$1, 16(%rbx)
	movb	$2, 12(%r8)
	jmp	.LBB41_73
.LBB41_43:
	leal	1(%rbp), %r15d
	leaq	1(%rbx), %r13
	cmpw	%bx, %bp
	jbe	.LBB41_44
	movq	%rbp, %r12
	subq	%rbx, %r12
	leaq	(,%r12,4), %rdx
	leaq	(%r14,%r13,4), %rdi
	addq	$188, %rdi
	movl	%r15d, 136(%rsp)
	movl	%esi, %r15d
	leaq	(%r14,%rbx,4), %rsi
	addq	$188, %rsi
	callq	*memmove@GOTPCREL(%rip)
	movl	%r15d, 188(%r14,%rbx,4)
	movl	136(%rsp), %r15d
	leaq	124(%rsp), %rcx
	movq	(%rcx), %rax
	movq	%rax, 16(%rsp)
	movl	8(%rcx), %eax
	movl	%eax, 24(%rsp)
	movzwl	2(%rsp), %eax
	movw	%ax, 56(%rsp)
	movb	4(%rsp), %al
	movb	%al, 58(%rsp)
	movq	%rbx, %rax
	shlq	$4, %rax
	leaq	(%r14,%rax), %rsi
	addq	$8, %rsi
	movq	%r13, %rax
	shlq	$4, %rax
	leaq	(%r14,%rax), %rdi
	addq	$8, %rdi
	shlq	$4, %r12
	movq	%r12, %rdx
	callq	*memmove@GOTPCREL(%rip)
	movb	10(%rsp), %dl
	jmp	.LBB41_46
.LBB41_44:
	movl	%esi, 188(%r14,%rbx,4)
	leaq	124(%rsp), %rcx
	movq	(%rcx), %rax
	movq	%rax, 16(%rsp)
	movl	8(%rcx), %eax
	movl	%eax, 24(%rsp)
	movzwl	2(%rsp), %eax
	movw	%ax, 56(%rsp)
	movb	4(%rsp), %al
	movb	%al, 58(%rsp)
.LBB41_46:
	movq	%rbx, %rax
	shlq	$4, %rax
	leaq	2(%rbp), %r12
	movl	24(%rsp), %ecx
	movl	%ecx, 16(%r14,%rax)
	movq	16(%rsp), %rcx
	movq	%rcx, 8(%r14,%rax)
	movb	%dl, 20(%r14,%rax)
	movzwl	56(%rsp), %ecx
	movw	%cx, 21(%r14,%rax)
	movb	58(%rsp), %cl
	movb	%cl, 23(%r14,%rax)
	cmpw	%bx, %bp
	jbe	.LBB41_48
	leaq	(%r14,%r13,8), %rsi
	addq	$232, %rsi
	leaq	(%r14,%rbx,8), %rdi
	addq	$248, %rdi
	movq	%rbp, %rdx
	subq	%rbx, %rdx
	shlq	$3, %rdx
	callq	*memmove@GOTPCREL(%rip)
.LBB41_48:
	movq	112(%rsp), %rax
	movq	%rax, 240(%r14,%rbx,8)
	movw	%r15w, 186(%r14)
	cmpq	%r12, %r13
	movq	96(%rsp), %r8
	movq	88(%rsp), %r9
	jae	.LBB41_66
	movl	%ebp, %eax
	subl	%ebx, %eax
	addl	$1, %eax
	subq	%rbx, %rbp
	andq	$3, %rax
	je	.LBB41_53
	leaq	(%r14,%rbx,8), %rdx
	addq	$240, %rdx
	xorl	%ecx, %ecx
.LBB41_51:
	movq	(%rdx,%rcx,8), %rsi
	movq	%r14, (%rsi)
	leal	(%rcx,%r13), %edi
	movw	%di, 184(%rsi)
	addq	$1, %rcx
	cmpq	%rcx, %rax
	jne	.LBB41_51
	addq	%rcx, %r13
.LBB41_53:
	cmpq	$3, %rbp
	jb	.LBB41_66
.LBB41_54:
	movq	232(%r14,%r13,8), %rax
	movq	%r14, (%rax)
	movw	%r13w, 184(%rax)
	movq	240(%r14,%r13,8), %rax
	movq	%r14, (%rax)
	leal	1(%r13), %ecx
	movw	%cx, 184(%rax)
	movq	248(%r14,%r13,8), %rax
	movq	%r14, (%rax)
	leal	2(%r13), %ecx
	movw	%cx, 184(%rax)
	movq	256(%r14,%r13,8), %rax
	movq	%r14, (%rax)
	leal	3(%r13), %ecx
	movw	%cx, 184(%rax)
	addq	$4, %r13
	cmpq	%r12, %r13
	jne	.LBB41_54
.LBB41_66:
	addq	$1, 16(%r9)
	movb	$2, 12(%r8)
	jmp	.LBB41_73
.LBB41_12:
	movl	$232, %edi
	movl	$8, %esi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.LBB41_75:
	leaq	.L__unnamed_33(%rip), %rdi
	leaq	.L__unnamed_34(%rip), %rdx
	movl	$40, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB41_33:
	movl	$328, %edi
	movl	$8, %esi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.LBB41_76:
	leaq	.L__unnamed_35(%rip), %rdx
	movl	$11, %esi
	movq	%r12, %rdi
	callq	*_ZN4core5slice5index24slice_end_index_len_fail17hc406737a277ce85dE@GOTPCREL(%rip)
	ud2
.LBB41_77:
	leaq	.L__unnamed_36(%rip), %rdx
	movl	$12, %esi
	callq	*_ZN4core5slice5index24slice_end_index_len_fail17hc406737a277ce85dE@GOTPCREL(%rip)
	ud2
.LBB41_74:
	leaq	.L__unnamed_35(%rip), %rdx
	movl	$11, %esi
	movq	%rbp, %rdi
	callq	*_ZN4core5slice5index24slice_end_index_len_fail17hc406737a277ce85dE@GOTPCREL(%rip)
	ud2
.LBB41_78:
	leaq	.L__unnamed_37(%rip), %rdi
	leaq	.L__unnamed_38(%rip), %rdx
	movl	$48, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB41_79:
	leaq	.L__unnamed_39(%rip), %rdi
	leaq	.L__unnamed_40(%rip), %rdx
	movl	$32, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end41:
	.size	_ZN5alloc11collections5btree3map25BTreeMap$LT$K$C$V$C$A$GT$6insert17hd7c4f8aca873a6f8E, .Lfunc_end41-_ZN5alloc11collections5btree3map25BTreeMap$LT$K$C$V$C$A$GT$6insert17hd7c4f8aca873a6f8E

	.section	".text._ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h1eed343e645936ceE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h1eed343e645936ceE,@function
_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h1eed343e645936ceE:
	pushq	%rbx
	movq	(%rdi), %rbx
	movq	32(%rbx), %rsi
	testq	%rsi, %rsi
	jle	.LBB42_2
	movq	24(%rbx), %rdi
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB42_2:
	cmpq	$-1, %rbx
	je	.LBB42_4
	lock		subq	$1, 8(%rbx)
	jne	.LBB42_4
	#MEMBARRIER
	movl	$48, %esi
	movl	$8, %edx
	movq	%rbx, %rdi
	popq	%rbx
	jmpq	*__rust_dealloc@GOTPCREL(%rip)
.LBB42_4:
	popq	%rbx
	retq
.Lfunc_end42:
	.size	_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h1eed343e645936ceE, .Lfunc_end42-_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h1eed343e645936ceE

	.section	".text._ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h243c7559f836e74bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h243c7559f836e74bE,@function
_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h243c7559f836e74bE:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	(%rdi), %r14
	movq	8(%rdi), %rbx
	movq	16(%rbx), %rdi
	addq	$15, %rdi
	andq	$-16, %rdi
	addq	%r14, %rdi
	callq	*(%rbx)
	cmpq	$-1, %r14
	je	.LBB43_3
	lock		subq	$1, 8(%r14)
	jne	.LBB43_3
	#MEMBARRIER
	movq	16(%rbx), %rax
	cmpq	$9, %rax
	movl	$8, %edx
	cmovaeq	%rax, %rdx
	movq	8(%rbx), %rax
	addq	%rdx, %rax
	addq	$15, %rax
	movq	%rdx, %rsi
	negq	%rsi
	andq	%rax, %rsi
	je	.LBB43_3
	movq	%r14, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	jmpq	*__rust_dealloc@GOTPCREL(%rip)
.LBB43_3:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end43:
	.size	_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h243c7559f836e74bE, .Lfunc_end43-_ZN5alloc4sync12Arc$LT$T$GT$9drop_slow17h243c7559f836e74bE

	.section	".text._ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E,@function
_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdx, %rbx
	notq	%rbx
	shrq	$63, %rbx
	testq	%rdx, %rdx
	js	.LBB44_6
	movq	%rdx, %r12
	movq	%rsi, %r15
	movq	%rdi, %r14
	je	.LBB44_2
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	movq	%rax, %rdi
	testq	%rdi, %rdi
	je	.LBB44_7
.LBB44_5:
	movq	%rdi, (%r14)
	movq	%r12, 8(%r14)
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	%r12, 16(%r14)
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB44_2:
	movq	%rbx, %rdi
	testq	%rdi, %rdi
	jne	.LBB44_5
.LBB44_7:
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.LBB44_6:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.Lfunc_end44:
	.size	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E, .Lfunc_end44-_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E

	.section	.text._ZN5alloc6string6String4push17ha1195b5ba6724106E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc6string6String4push17ha1195b5ba6724106E,@function
_ZN5alloc6string6String4push17ha1195b5ba6724106E:
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	movl	%esi, %ebp
	movq	%rdi, %rbx
	cmpl	$128, %esi
	jae	.LBB45_1
	movq	16(%rbx), %rsi
	cmpq	8(%rbx), %rsi
	jne	.LBB45_6
	movq	%rbx, %rdi
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hf49364da04241748E
	movq	16(%rbx), %rsi
.LBB45_6:
	movq	(%rbx), %rax
	movb	%bpl, (%rax,%rsi)
	addq	$1, %rsi
	movq	%rsi, 16(%rbx)
	jmp	.LBB45_12
.LBB45_1:
	movl	$0, 12(%rsp)
	movl	%ebp, %eax
	cmpl	$2048, %ebp
	jae	.LBB45_2
	shrl	$6, %eax
	orb	$-64, %al
	movb	%al, 12(%rsp)
	andb	$63, %bpl
	orb	$-128, %bpl
	movb	%bpl, 13(%rsp)
	movl	$2, %r14d
	jmp	.LBB45_9
.LBB45_2:
	cmpl	$65536, %ebp
	jae	.LBB45_3
	shrl	$12, %eax
	orb	$-32, %al
	movb	%al, 12(%rsp)
	movl	%ebp, %eax
	shrl	$6, %eax
	andb	$63, %al
	orb	$-128, %al
	movb	%al, 13(%rsp)
	andb	$63, %bpl
	orb	$-128, %bpl
	movb	%bpl, 14(%rsp)
	movl	$3, %r14d
	jmp	.LBB45_9
.LBB45_3:
	shrl	$18, %eax
	andb	$7, %al
	orb	$-16, %al
	movb	%al, 12(%rsp)
	movl	%ebp, %eax
	shrl	$12, %eax
	andb	$63, %al
	orb	$-128, %al
	movb	%al, 13(%rsp)
	movl	%ebp, %eax
	shrl	$6, %eax
	andb	$63, %al
	orb	$-128, %al
	movb	%al, 14(%rsp)
	andb	$63, %bpl
	orb	$-128, %bpl
	movb	%bpl, 15(%rsp)
	movl	$4, %r14d
.LBB45_9:
	movq	8(%rbx), %rax
	movq	16(%rbx), %rbp
	subq	%rbp, %rax
	cmpq	%r14, %rax
	jb	.LBB45_10
.LBB45_11:
	movq	(%rbx), %rdi
	addq	%rbp, %rdi
	leaq	12(%rsp), %rsi
	movq	%r14, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	addq	%r14, %rbp
	movq	%rbp, 16(%rbx)
.LBB45_12:
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB45_10:
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17ha2fab7bef4ffaef5E
	movq	16(%rbx), %rbp
	jmp	.LBB45_11
.Lfunc_end45:
	.size	_ZN5alloc6string6String4push17ha1195b5ba6724106E, .Lfunc_end45-_ZN5alloc6string6String4push17ha1195b5ba6724106E

	.section	.text._ZN5alloc7raw_vec11finish_grow17he89659313f443575E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec11finish_grow17he89659313f443575E,@function
_ZN5alloc7raw_vec11finish_grow17he89659313f443575E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rdx, %rdx
	je	.LBB46_5
	movq	%rdx, %r15
	cmpq	$0, 16(%rcx)
	je	.LBB46_6
	movq	8(%rcx), %rsi
	testq	%rsi, %rsi
	je	.LBB46_6
	movq	(%rcx), %rdi
	movq	%r15, %rdx
	movq	%rbx, %rcx
	callq	*__rust_realloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB46_10
.LBB46_4:
	movq	%rbx, 8(%r14)
	movl	$1, %eax
	movq	%r15, %rbx
	jmp	.LBB46_11
.LBB46_6:
	testq	%rbx, %rbx
	je	.LBB46_7
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB46_4
.LBB46_10:
	movq	%rax, 8(%r14)
	xorl	%eax, %eax
	jmp	.LBB46_11
.LBB46_5:
	movq	%rbx, 8(%r14)
	movl	$1, %eax
	xorl	%ebx, %ebx
.LBB46_11:
	movq	%rbx, 16(%r14)
	movq	%rax, (%r14)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB46_7:
	movq	%r15, %rax
	testq	%rax, %rax
	jne	.LBB46_10
	jmp	.LBB46_4
.Lfunc_end46:
	.size	_ZN5alloc7raw_vec11finish_grow17he89659313f443575E, .Lfunc_end46-_ZN5alloc7raw_vec11finish_grow17he89659313f443575E

	.section	".text._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hcdf995785f56f774E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hcdf995785f56f774E,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hcdf995785f56f774E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$48, %rsp
	incq	%rsi
	je	.LBB47_9
	movq	%rdi, %r14
	movq	8(%rdi), %rdi
	leaq	(%rdi,%rdi), %rax
	cmpq	%rsi, %rax
	cmovaq	%rax, %rsi
	cmpq	$5, %rsi
	movl	$4, %r15d
	cmovaeq	%rsi, %r15
	movl	$16, %r8d
	movq	%r15, %rax
	mulq	%r8
	movq	%rax, %rsi
	seto	%al
	movabsq	$9223372036854775800, %r9
	xorl	%ebx, %ebx
	cmpq	%r9, %rsi
	setbe	%bl
	shlq	$3, %rbx
	xorl	%edx, %edx
	testb	%al, %al
	cmovneq	%rdx, %rbx
	testq	%rdi, %rdi
	je	.LBB47_3
	movq	%rdi, %rax
	mulq	%r8
	seto	%cl
	xorl	%edi, %edi
	cmpq	%r9, %rax
	setbe	%dil
	shlq	$3, %rdi
	xorl	%edx, %edx
	testb	%cl, %cl
	cmoveq	%rdi, %rdx
	movq	(%r14), %rcx
	movq	%rcx, 24(%rsp)
	movq	%rax, 32(%rsp)
.LBB47_3:
	movq	%rdx, 40(%rsp)
	movq	%rsp, %rdi
	leaq	24(%rsp), %rcx
	movq	%rbx, %rdx
	callq	_ZN5alloc7raw_vec11finish_grow17he89659313f443575E
	cmpq	$0, (%rsp)
	movq	8(%rsp), %rdi
	je	.LBB47_4
	movq	16(%rsp), %rsi
	movabsq	$-9223372036854775807, %rax
	cmpq	%rax, %rsi
	je	.LBB47_5
	testq	%rsi, %rsi
	jne	.LBB47_8
.LBB47_9:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB47_4:
	movq	%rdi, (%r14)
	movq	%r15, 8(%r14)
.LBB47_5:
	addq	$48, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB47_8:
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end47:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hcdf995785f56f774E, .Lfunc_end47-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hcdf995785f56f774E

	.section	".text._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hd04702c74329d1adE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hd04702c74329d1adE,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hd04702c74329d1adE:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$48, %rsp
	movq	%rsi, %r15
	incq	%r15
	je	.LBB48_9
	movq	%rdi, %r14
	movq	8(%rdi), %rdi
	leaq	(%rdi,%rdi), %rax
	cmpq	%r15, %rax
	cmovaq	%rax, %r15
	cmpq	$5, %r15
	movl	$4, %ecx
	cmovbq	%rcx, %r15
	movq	%r15, %rax
	mulq	%rcx
	movq	%rax, %rsi
	seto	%al
	movabsq	$9223372036854775804, %r8
	xorl	%ebx, %ebx
	cmpq	%r8, %rsi
	setbe	%bl
	shlq	$2, %rbx
	xorl	%edx, %edx
	testb	%al, %al
	cmovneq	%rdx, %rbx
	testq	%rdi, %rdi
	je	.LBB48_3
	movq	%rdi, %rax
	mulq	%rcx
	seto	%cl
	xorl	%edi, %edi
	cmpq	%r8, %rax
	setbe	%dil
	shlq	$2, %rdi
	xorl	%edx, %edx
	testb	%cl, %cl
	cmoveq	%rdi, %rdx
	movq	(%r14), %rcx
	movq	%rcx, 24(%rsp)
	movq	%rax, 32(%rsp)
.LBB48_3:
	movq	%rdx, 40(%rsp)
	movq	%rsp, %rdi
	leaq	24(%rsp), %rcx
	movq	%rbx, %rdx
	callq	_ZN5alloc7raw_vec11finish_grow17he89659313f443575E
	cmpq	$0, (%rsp)
	movq	8(%rsp), %rdi
	je	.LBB48_4
	movq	16(%rsp), %rsi
	movabsq	$-9223372036854775807, %rax
	cmpq	%rax, %rsi
	je	.LBB48_5
	testq	%rsi, %rsi
	jne	.LBB48_8
.LBB48_9:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB48_4:
	movq	%rdi, (%r14)
	movq	%r15, 8(%r14)
.LBB48_5:
	addq	$48, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB48_8:
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end48:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hd04702c74329d1adE, .Lfunc_end48-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hd04702c74329d1adE

	.section	".text._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hf49364da04241748E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hf49364da04241748E,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hf49364da04241748E:
	pushq	%r14
	pushq	%rbx
	subq	$56, %rsp
	incq	%rsi
	je	.LBB49_10
	movq	%rdi, %r14
	movq	8(%rdi), %rax
	leaq	(%rax,%rax), %rcx
	cmpq	%rsi, %rcx
	cmovaq	%rcx, %rsi
	cmpq	$9, %rsi
	movl	$8, %ebx
	cmovaeq	%rsi, %rbx
	movq	%rbx, %rdx
	notq	%rdx
	shrq	$63, %rdx
	testq	%rax, %rax
	je	.LBB49_2
	movq	(%r14), %rsi
	movq	%rax, %rcx
	notq	%rcx
	shrq	$63, %rcx
	movq	%rsi, 32(%rsp)
	movq	%rax, 40(%rsp)
	jmp	.LBB49_4
.LBB49_2:
	xorl	%ecx, %ecx
.LBB49_4:
	movq	%rcx, 48(%rsp)
	leaq	8(%rsp), %rdi
	leaq	32(%rsp), %rcx
	movq	%rbx, %rsi
	callq	_ZN5alloc7raw_vec11finish_grow17he89659313f443575E
	cmpq	$0, 8(%rsp)
	movq	16(%rsp), %rdi
	je	.LBB49_5
	movq	24(%rsp), %rsi
	movabsq	$-9223372036854775807, %rax
	cmpq	%rax, %rsi
	jne	.LBB49_8
	addq	$56, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB49_5:
	movq	%rdi, (%r14)
	movq	%rbx, 8(%r14)
	addq	$56, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB49_8:
	testq	%rsi, %rsi
	jne	.LBB49_9
.LBB49_10:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB49_9:
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end49:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hf49364da04241748E, .Lfunc_end49-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hf49364da04241748E

	.section	".text.unlikely._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17ha2fab7bef4ffaef5E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17ha2fab7bef4ffaef5E,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17ha2fab7bef4ffaef5E:
	pushq	%r14
	pushq	%rbx
	subq	$56, %rsp
	addq	%rdx, %rsi
	jb	.LBB50_10
	movq	%rdi, %r14
	movq	8(%rdi), %rax
	leaq	(%rax,%rax), %rcx
	cmpq	%rsi, %rcx
	cmovaq	%rcx, %rsi
	cmpq	$9, %rsi
	movl	$8, %ebx
	cmovaeq	%rsi, %rbx
	movq	%rbx, %rdx
	notq	%rdx
	shrq	$63, %rdx
	testq	%rax, %rax
	je	.LBB50_2
	movq	(%r14), %rsi
	movq	%rax, %rcx
	notq	%rcx
	shrq	$63, %rcx
	movq	%rsi, 32(%rsp)
	movq	%rax, 40(%rsp)
	jmp	.LBB50_4
.LBB50_2:
	xorl	%ecx, %ecx
.LBB50_4:
	movq	%rcx, 48(%rsp)
	leaq	8(%rsp), %rdi
	leaq	32(%rsp), %rcx
	movq	%rbx, %rsi
	callq	_ZN5alloc7raw_vec11finish_grow17he89659313f443575E
	cmpq	$0, 8(%rsp)
	movq	16(%rsp), %rdi
	je	.LBB50_5
	movq	24(%rsp), %rsi
	movabsq	$-9223372036854775807, %rax
	cmpq	%rax, %rsi
	jne	.LBB50_8
	addq	$56, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB50_5:
	movq	%rdi, (%r14)
	movq	%rbx, 8(%r14)
	addq	$56, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB50_8:
	testq	%rsi, %rsi
	jne	.LBB50_9
.LBB50_10:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB50_9:
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end50:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17ha2fab7bef4ffaef5E, .Lfunc_end50-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17ha2fab7bef4ffaef5E

	.section	".text.unlikely._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hedf5e4fa0b1129c6E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hedf5e4fa0b1129c6E,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hedf5e4fa0b1129c6E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$48, %rsp
	addq	%rdx, %rsi
	jb	.LBB51_9
	movq	%rdi, %r14
	movq	8(%rdi), %rdi
	leaq	(%rdi,%rdi), %rax
	cmpq	%rsi, %rax
	cmovaq	%rax, %rsi
	cmpq	$5, %rsi
	movl	$4, %r15d
	cmovaeq	%rsi, %r15
	movl	$16, %r8d
	movq	%r15, %rax
	mulq	%r8
	movq	%rax, %rsi
	seto	%al
	movabsq	$9223372036854775800, %r9
	xorl	%ebx, %ebx
	cmpq	%r9, %rsi
	setbe	%bl
	shlq	$3, %rbx
	xorl	%edx, %edx
	testb	%al, %al
	cmovneq	%rdx, %rbx
	testq	%rdi, %rdi
	je	.LBB51_3
	movq	%rdi, %rax
	mulq	%r8
	seto	%cl
	xorl	%edi, %edi
	cmpq	%r9, %rax
	setbe	%dil
	shlq	$3, %rdi
	xorl	%edx, %edx
	testb	%cl, %cl
	cmoveq	%rdi, %rdx
	movq	(%r14), %rcx
	movq	%rcx, 24(%rsp)
	movq	%rax, 32(%rsp)
.LBB51_3:
	movq	%rdx, 40(%rsp)
	movq	%rsp, %rdi
	leaq	24(%rsp), %rcx
	movq	%rbx, %rdx
	callq	_ZN5alloc7raw_vec11finish_grow17he89659313f443575E
	cmpq	$0, (%rsp)
	movq	8(%rsp), %rdi
	je	.LBB51_4
	movq	16(%rsp), %rsi
	movabsq	$-9223372036854775807, %rax
	cmpq	%rax, %rsi
	je	.LBB51_5
	testq	%rsi, %rsi
	jne	.LBB51_8
.LBB51_9:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB51_4:
	movq	%rdi, (%r14)
	movq	%r15, 8(%r14)
.LBB51_5:
	addq	$48, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB51_8:
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end51:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hedf5e4fa0b1129c6E, .Lfunc_end51-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hedf5e4fa0b1129c6E

	.section	".text._ZN62_$LT$x86_64..addr..VirtAddr$u20$as$u20$core..fmt..LowerHex$GT$3fmt17h1a6af04cb213da62E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN62_$LT$x86_64..addr..VirtAddr$u20$as$u20$core..fmt..LowerHex$GT$3fmt17h1a6af04cb213da62E,@function
_ZN62_$LT$x86_64..addr..VirtAddr$u20$as$u20$core..fmt..LowerHex$GT$3fmt17h1a6af04cb213da62E:
	jmpq	*_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17h37bc6141694e846cE@GOTPCREL(%rip)
.Lfunc_end52:
	.size	_ZN62_$LT$x86_64..addr..VirtAddr$u20$as$u20$core..fmt..LowerHex$GT$3fmt17h1a6af04cb213da62E, .Lfunc_end52-_ZN62_$LT$x86_64..addr..VirtAddr$u20$as$u20$core..fmt..LowerHex$GT$3fmt17h1a6af04cb213da62E

	.section	".text._ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h54c40caeb88a5c77E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h54c40caeb88a5c77E,@function
_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h54c40caeb88a5c77E:
	pushq	%rax
	movq	%rsi, %rax
	cmpq	$0, (%rdi)
	je	.LBB53_2
	movq	%rdi, (%rsp)
	leaq	.L__unnamed_41(%rip), %rsi
	leaq	.L__unnamed_42(%rip), %r8
	movq	%rsp, %rcx
	movl	$4, %edx
	movq	%rax, %rdi
	callq	*_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h27705bcf66387e64E@GOTPCREL(%rip)
	popq	%rcx
	retq
.LBB53_2:
	leaq	.L__unnamed_43(%rip), %rsi
	movl	$4, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.Lfunc_end53:
	.size	_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h54c40caeb88a5c77E, .Lfunc_end53-_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h54c40caeb88a5c77E

	.section	".text._ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE,@function
_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%r9, %rbx
	movq	%r8, %r15
	movq	%rcx, %r14
	movq	%rdx, %r13
	movq	%rsi, %rbp
	movq	%rdi, %r12
	shrq	$36, %rdx
	andl	$4088, %edx
	addq	8(%rsi), %rdx
	leaq	8(%rsp), %rdi
	movq	%r9, %rcx
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE
	cmpb	$0, 8(%rsp)
	jne	.LBB54_9
	movq	%r13, %rdx
	shrq	$27, %rdx
	andl	$4088, %edx
	addq	16(%rsp), %rdx
	leaq	8(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%rbx, %rcx
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE
	cmpb	$0, 8(%rsp)
	jne	.LBB54_9
	movq	%r13, %rax
	shrq	$21, %rax
	movq	16(%rsp), %rcx
	andl	$511, %eax
	leaq	(%rcx,%rax,8), %rdx
	leaq	8(%rsp), %rdi
	movq	%rbp, %rsi
	movq	%rbx, %rcx
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE
	cmpb	$0, 8(%rsp)
	je	.LBB54_3
.LBB54_9:
	xorl	%eax, %eax
	cmpb	$0, 9(%rsp)
	sete	%al
	movq	%rax, 8(%r12)
.LBB54_5:
	movl	$1, %eax
.LBB54_6:
	movq	%rax, (%r12)
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB54_3:
	movq	%r13, %rax
	shrq	$12, %rax
	movq	16(%rsp), %rcx
	andl	$511, %eax
	cmpq	$0, (%rcx,%rax,8)
	je	.LBB54_7
	movq	$2, 8(%r12)
	movq	%r14, 16(%r12)
	jmp	.LBB54_5
.LBB54_7:
	testl	$4095, %r14d
	jne	.LBB54_10
	orq	%r14, %r15
	movq	%r15, (%rcx,%rax,8)
	movq	%r13, 8(%r12)
	xorl	%eax, %eax
	jmp	.LBB54_6
.LBB54_10:
	leaq	.L__unnamed_44(%rip), %rdi
	leaq	.L__unnamed_45(%rip), %rdx
	movl	$49, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end54:
	.size	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE, .Lfunc_end54-_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE

	.section	".text._ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE,@function
_ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rdx, %r12
	movq	%rsi, %r14
	movq	%rdi, %r15
	movq	(%rdx), %rbx
	testq	%rbx, %rbx
	je	.LBB55_1
	movl	%ebx, %eax
	notl	%eax
	movq	%rbx, %rsi
	testb	$3, %al
	je	.LBB55_7
	movq	%rbx, %rsi
	jmp	.LBB55_6
.LBB55_1:
	leaq	8(%rsp), %rdi
	movq	%rcx, %rsi
	callq	_ZN158_$LT$cryptos..cralloc..frames..Falloc$u20$as$u20$x86_64..structures..paging..frame_alloc..FrameAllocator$LT$x86_64..structures..paging..page..Size4KiB$GT$$GT$14allocate_frame17h0f5bd85b586659d5E
	cmpl	$1, 8(%rsp)
	jne	.LBB55_15
	movq	16(%rsp), %rsi
	testl	$4095, %esi
	jne	.LBB55_3
.LBB55_6:
	orq	$3, %rsi
	movq	%rsi, (%r12)
.LBB55_7:
	testb	$1, %sil
	je	.LBB55_11
	testb	$-128, %sil
	jne	.LBB55_12
	movabsq	$4503599627366400, %rax
	andq	%rax, %rsi
	movq	%r14, %rdi
	callq	*_ZN162_$LT$x86_64..structures..paging..mapper..offset_page_table..PhysOffset$u20$as$u20$x86_64..structures..paging..mapper..mapped_page_table..PageTableFrameMapping$GT$16frame_to_pointer17h0c4cf150c899ac28E@GOTPCREL(%rip)
	movq	%rax, %r14
	testq	%rbx, %rbx
	jne	.LBB55_10
	movl	$4096, %edx
	movq	%r14, %rdi
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
.LBB55_10:
	movq	%r14, 8(%r15)
	movb	$0, (%r15)
	jmp	.LBB55_13
.LBB55_12:
	movw	$1, (%r15)
	jmp	.LBB55_13
.LBB55_15:
	movw	$257, (%r15)
.LBB55_13:
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.LBB55_11:
	leaq	.L__unnamed_46(%rip), %rdi
	leaq	.L__unnamed_47(%rip), %rdx
	movl	$36, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB55_3:
	leaq	.L__unnamed_44(%rip), %rdi
	leaq	.L__unnamed_45(%rip), %rdx
	movl	$49, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end55:
	.size	_ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE, .Lfunc_end55-_ZN6x86_6410structures6paging6mapper17mapped_page_table24PageTableWalker$LT$P$GT$17create_next_table17hac889b16ff9443dfE

	.section	.text._ZN6x86_644addr8VirtAddr3new17h1c485eaba4da328eE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN6x86_644addr8VirtAddr3new17h1c485eaba4da328eE,@function
_ZN6x86_644addr8VirtAddr3new17h1c485eaba4da328eE:
	movq	%rdi, %rax
	shrq	$47, %rax
	je	.LBB56_4
	cmpl	$131071, %eax
	je	.LBB56_4
	cmpl	$1, %eax
	jne	.LBB56_5
	shlq	$16, %rdi
	sarq	$16, %rdi
.LBB56_4:
	movq	%rdi, %rax
	retq
.LBB56_5:
	pushq	%rax
	movq	%rdi, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.Lfunc_end56:
	.size	_ZN6x86_644addr8VirtAddr3new17h1c485eaba4da328eE, .Lfunc_end56-_ZN6x86_644addr8VirtAddr3new17h1c485eaba4da328eE

	.section	".text._ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE,@function
_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE:
	pushq	%rax
	movq	%rsi, %rax
	movq	8(%rdi), %rcx
	cmpq	$0, (%rcx)
	je	.LBB57_2
	movq	%rcx, (%rsp)
	leaq	.L__unnamed_41(%rip), %rsi
	leaq	.L__unnamed_51(%rip), %r8
	movq	%rsp, %rcx
	movl	$4, %edx
	movq	%rax, %rdi
	callq	*_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h27705bcf66387e64E@GOTPCREL(%rip)
	popq	%rcx
	retq
.LBB57_2:
	leaq	.L__unnamed_43(%rip), %rsi
	movl	$4, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.Lfunc_end57:
	.size	_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE, .Lfunc_end57-_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE

	.section	".text._ZN77_$LT$bootloader..boot_info..Optional$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h6f03146962576cc2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN77_$LT$bootloader..boot_info..Optional$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h6f03146962576cc2E,@function
_ZN77_$LT$bootloader..boot_info..Optional$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h6f03146962576cc2E:
	pushq	%rax
	movq	%rsi, %rax
	cmpl	$0, (%rdi)
	je	.LBB58_1
	leaq	.L__unnamed_43(%rip), %rsi
	movl	$4, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.LBB58_1:
	addq	$8, %rdi
	movq	%rdi, (%rsp)
	leaq	.L__unnamed_41(%rip), %rsi
	leaq	.L__unnamed_52(%rip), %r8
	movq	%rsp, %rcx
	movl	$4, %edx
	movq	%rax, %rdi
	callq	*_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h27705bcf66387e64E@GOTPCREL(%rip)
	popq	%rcx
	retq
.Lfunc_end58:
	.size	_ZN77_$LT$bootloader..boot_info..Optional$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h6f03146962576cc2E, .Lfunc_end58-_ZN77_$LT$bootloader..boot_info..Optional$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h6f03146962576cc2E

	.section	".text._ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17h8640a7b4a81fcd67E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17h8640a7b4a81fcd67E,@function
_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17h8640a7b4a81fcd67E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdi, %rbx
	movl	$131072, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	leaq	8(%rsp), %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, 8(%rsp)
	je	.LBB59_1
	movl	12(%rsp), %eax
	movl	%eax, 4(%rbx)
	jmp	.LBB59_5
.LBB59_1:
	movq	16(%rsp), %r14
	movq	24(%rsp), %r15
	movq	%r14, 32(%rsp)
	movq	%r15, 40(%rsp)
	leaq	8(%rsp), %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, 8(%rsp)
	je	.LBB59_2
	movl	12(%rsp), %ebp
	leaq	32(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	movl	%ebp, 4(%rbx)
.LBB59_5:
	movl	$1, %ebp
.LBB59_6:
	movl	%ebp, (%rbx)
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB59_2:
	movq	16(%rsp), %r12
	xorl	%ebp, %ebp
	movq	%r12, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 8(%rbx)
	movq	%r15, 16(%rbx)
	movq	%r12, 24(%rbx)
	jmp	.LBB59_6
.Lfunc_end59:
	.size	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17h8640a7b4a81fcd67E, .Lfunc_end59-_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17h8640a7b4a81fcd67E

	.section	".text._ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E,@function
_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdi, %rbx
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	leaq	8(%rsp), %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, 8(%rsp)
	je	.LBB60_1
	movl	12(%rsp), %eax
	movl	%eax, 4(%rbx)
	jmp	.LBB60_5
.LBB60_1:
	movq	16(%rsp), %r14
	movq	24(%rsp), %r15
	movq	%r14, 32(%rsp)
	movq	%r15, 40(%rsp)
	leaq	8(%rsp), %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, 8(%rsp)
	je	.LBB60_2
	movl	12(%rsp), %ebp
	leaq	32(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	movl	%ebp, 4(%rbx)
.LBB60_5:
	movl	$1, %ebp
.LBB60_6:
	movl	%ebp, (%rbx)
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB60_2:
	movq	16(%rsp), %r12
	xorl	%ebp, %ebp
	movq	%r12, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 8(%rbx)
	movq	%r15, 16(%rbx)
	movq	%r12, 24(%rbx)
	jmp	.LBB60_6
.Lfunc_end60:
	.size	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E, .Lfunc_end60-_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E

	.section	".text._ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb9146c0bcac8e8edE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb9146c0bcac8e8edE,@function
_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb9146c0bcac8e8edE:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	%rdi, %rbx
	movl	$256, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	leaq	8(%rsp), %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, 8(%rsp)
	je	.LBB61_1
	movl	12(%rsp), %eax
	movl	%eax, 4(%rbx)
	jmp	.LBB61_5
.LBB61_1:
	movq	16(%rsp), %r14
	movq	24(%rsp), %r15
	movq	%r14, 32(%rsp)
	movq	%r15, 40(%rsp)
	leaq	8(%rsp), %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, 8(%rsp)
	je	.LBB61_2
	movl	12(%rsp), %ebp
	leaq	32(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	movl	%ebp, 4(%rbx)
.LBB61_5:
	movl	$1, %ebp
.LBB61_6:
	movl	%ebp, (%rbx)
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB61_2:
	movq	16(%rsp), %r12
	xorl	%ebp, %ebp
	movq	%r12, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 8(%rbx)
	movq	%r15, 16(%rbx)
	movq	%r12, 24(%rbx)
	jmp	.LBB61_6
.Lfunc_end61:
	.size	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb9146c0bcac8e8edE, .Lfunc_end61-_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb9146c0bcac8e8edE

	.section	".text._ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE,@function
_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE:
	jmpq	*_ZN86_$LT$x86_64..structures..idt..InterruptStackFrameValue$u20$as$u20$core..fmt..Debug$GT$3fmt17h53ce6653962ba566E@GOTPCREL(%rip)
.Lfunc_end62:
	.size	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE, .Lfunc_end62-_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE

	.section	".text._ZN92_$LT$x86_64..structures..paging..mapper..MapToError$LT$S$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5817cf5cab49b1a9E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN92_$LT$x86_64..structures..paging..mapper..MapToError$LT$S$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5817cf5cab49b1a9E,@function
_ZN92_$LT$x86_64..structures..paging..mapper..MapToError$LT$S$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5817cf5cab49b1a9E:
	pushq	%rax
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	testq	%rcx, %rcx
	je	.LBB63_3
	cmpl	$1, %ecx
	jne	.LBB63_5
	leaq	.L__unnamed_53(%rip), %rsi
	movl	$19, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.LBB63_3:
	leaq	.L__unnamed_54(%rip), %rsi
	movl	$21, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.LBB63_5:
	addq	$8, %rdi
	movq	%rdi, (%rsp)
	leaq	.L__unnamed_55(%rip), %rsi
	leaq	.L__unnamed_56(%rip), %r8
	movq	%rsp, %rcx
	movl	$17, %edx
	movq	%rax, %rdi
	callq	*_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h27705bcf66387e64E@GOTPCREL(%rip)
	popq	%rcx
	retq
.Lfunc_end63:
	.size	_ZN92_$LT$x86_64..structures..paging..mapper..MapToError$LT$S$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5817cf5cab49b1a9E, .Lfunc_end63-_ZN92_$LT$x86_64..structures..paging..mapper..MapToError$LT$S$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5817cf5cab49b1a9E

	.section	".text._ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE,@function
_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$80, %rsp
	movq	%rdx, %r14
	movq	%rsi, %r13
	movq	%rdi, %r15
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB64_10
	cmpq	$1, %rax
	je	.LBB64_8
	cmpq	$3, %rax
	je	.LBB64_3
	.p2align	4, 0x90
.LBB64_5:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB64_10
	cmpq	$3, %rax
	jne	.LBB64_5
	jmp	.LBB64_7
.LBB64_10:
	movq	%r13, %rax
	shrq	$52, %rax
	jne	.LBB64_59
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %r12
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB64_16
	cmpq	$1, %rax
	je	.LBB64_8
	cmpq	$3, %rax
	je	.LBB64_3
	.p2align	4, 0x90
.LBB64_14:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB64_16
	cmpq	$3, %rax
	jne	.LBB64_14
	jmp	.LBB64_7
.LBB64_16:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r13, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB64_20
	cmpl	$131071, %eax
	je	.LBB64_20
	cmpl	$1, %eax
	jne	.LBB64_25
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB64_20:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB64_27
	cmpq	$1, %rax
	je	.LBB64_60
	cmpq	$3, %rax
	je	.LBB64_3
	.p2align	4, 0x90
.LBB64_23:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB64_27
	cmpq	$3, %rax
	jne	.LBB64_23
	jmp	.LBB64_7
.LBB64_27:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB64_28:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB64_30
.LBB64_29:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB64_29
	jmp	.LBB64_28
.LBB64_30:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB64_35
	cmpq	$1, %rax
	je	.LBB64_60
	cmpq	$3, %rax
	je	.LBB64_3
	.p2align	4, 0x90
.LBB64_33:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB64_35
	cmpq	$3, %rax
	jne	.LBB64_33
	jmp	.LBB64_7
.LBB64_35:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r13, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB64_36:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB64_38
.LBB64_37:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB64_37
	jmp	.LBB64_36
.LBB64_38:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	56(%rsp), %rdi
	movl	$3, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 56(%rsp)
	movq	64(%rsp), %rax
	je	.LBB64_46
	cmpq	$1, %rax
	je	.LBB64_44
	cmpq	$2, %rax
	jne	.LBB64_58
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB64_47
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB64_43
.LBB64_46:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB64_47
.LBB64_44:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB64_47
	leaq	.L__unnamed_58(%rip), %rax
.LBB64_43:
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_60(%rip), %rdx
	leaq	8(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB64_47:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB64_52
	cmpq	$1, %rax
	je	.LBB64_8
	cmpq	$3, %rax
	je	.LBB64_3
	.p2align	4, 0x90
.LBB64_50:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB64_52
	cmpq	$3, %rax
	jne	.LBB64_50
.LBB64_7:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB64_52:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	addq	%r13, %rax
	je	.LBB64_53
	addq	%r13, %r12
	movq	%r12, %rcx
	shrq	$47, %rcx
	cmpq	$2, %rcx
	jb	.LBB64_57
	cmpl	$131071, %ecx
	jne	.LBB64_56
.LBB64_57:
	leaq	4095(%r14), %rcx
	andq	$-4096, %rcx
	movq	%r13, (%r15)
	movq	%rax, 8(%r15)
	movq	%r14, 16(%r15)
	movq	%rcx, 24(%r15)
	addq	$80, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.LBB64_3:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB64_8:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
	jmp	.LBB64_9
.LBB64_59:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB64_60:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_66(%rip), %rdx
	jmp	.LBB64_9
.LBB64_53:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_67(%rip), %rdx
.LBB64_9:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB64_25:
	movq	%rdx, 8(%rsp)
	jmp	.LBB64_26
.LBB64_58:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_66(%rip), %rsi
	leaq	8(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB64_56:
	movq	%r12, 8(%rsp)
.LBB64_26:
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.Lfunc_end64:
	.size	_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE, .Lfunc_end64-_ZN77_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$rsdp..handler..AcpiHandler$GT$19map_physical_region17h67725beb5ef6d25bE

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$7read_u817h1c5a0919e0f0e004E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$7read_u817h1c5a0919e0f0e004E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$7read_u817h1c5a0919e0f0e004E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB65_48
	movq	%rsi, %r14
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB65_11
	cmpq	$1, %rax
	je	.LBB65_9
	cmpq	$3, %rax
	je	.LBB65_4
	.p2align	4, 0x90
.LBB65_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB65_11
	cmpq	$3, %rax
	jne	.LBB65_6
	jmp	.LBB65_8
.LBB65_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB65_15
	cmpl	$131071, %eax
	je	.LBB65_15
	cmpl	$1, %eax
	jne	.LBB65_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB65_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB65_20
	cmpq	$1, %rax
	je	.LBB65_49
	cmpq	$3, %rax
	je	.LBB65_4
	.p2align	4, 0x90
.LBB65_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB65_20
	cmpq	$3, %rax
	jne	.LBB65_18
	jmp	.LBB65_8
.LBB65_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB65_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB65_23
.LBB65_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB65_22
	jmp	.LBB65_21
.LBB65_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB65_28
	cmpq	$1, %rax
	je	.LBB65_49
	cmpq	$3, %rax
	je	.LBB65_4
	.p2align	4, 0x90
.LBB65_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB65_28
	cmpq	$3, %rax
	jne	.LBB65_26
	jmp	.LBB65_8
.LBB65_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB65_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB65_31
.LBB65_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB65_30
	jmp	.LBB65_29
.LBB65_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB65_39
	cmpq	$1, %rax
	je	.LBB65_37
	cmpq	$2, %rax
	jne	.LBB65_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB65_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB65_36
.LBB65_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB65_40
.LBB65_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB65_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB65_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_69(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB65_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB65_45
	cmpq	$1, %rax
	je	.LBB65_9
	cmpq	$3, %rax
	je	.LBB65_4
	.p2align	4, 0x90
.LBB65_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB65_45
	cmpq	$3, %rax
	jne	.LBB65_43
.LBB65_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB65_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movb	(%rax,%r14), %al
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB65_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB65_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB65_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_70(%rip), %rdx
	jmp	.LBB65_10
.LBB65_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB65_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB65_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB65_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_70(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end65:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$7read_u817h1c5a0919e0f0e004E, .Lfunc_end65-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$7read_u817h1c5a0919e0f0e004E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u1617haa2e80c0b1f229f2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u1617haa2e80c0b1f229f2E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u1617haa2e80c0b1f229f2E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB66_48
	movq	%rsi, %r14
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB66_11
	cmpq	$1, %rax
	je	.LBB66_9
	cmpq	$3, %rax
	je	.LBB66_4
	.p2align	4, 0x90
.LBB66_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB66_11
	cmpq	$3, %rax
	jne	.LBB66_6
	jmp	.LBB66_8
.LBB66_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB66_15
	cmpl	$131071, %eax
	je	.LBB66_15
	cmpl	$1, %eax
	jne	.LBB66_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB66_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB66_20
	cmpq	$1, %rax
	je	.LBB66_49
	cmpq	$3, %rax
	je	.LBB66_4
	.p2align	4, 0x90
.LBB66_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB66_20
	cmpq	$3, %rax
	jne	.LBB66_18
	jmp	.LBB66_8
.LBB66_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB66_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB66_23
.LBB66_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB66_22
	jmp	.LBB66_21
.LBB66_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB66_28
	cmpq	$1, %rax
	je	.LBB66_49
	cmpq	$3, %rax
	je	.LBB66_4
	.p2align	4, 0x90
.LBB66_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB66_28
	cmpq	$3, %rax
	jne	.LBB66_26
	jmp	.LBB66_8
.LBB66_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB66_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB66_31
.LBB66_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB66_30
	jmp	.LBB66_29
.LBB66_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB66_39
	cmpq	$1, %rax
	je	.LBB66_37
	cmpq	$2, %rax
	jne	.LBB66_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB66_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB66_36
.LBB66_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB66_40
.LBB66_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB66_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB66_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_71(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB66_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB66_45
	cmpq	$1, %rax
	je	.LBB66_9
	cmpq	$3, %rax
	je	.LBB66_4
	.p2align	4, 0x90
.LBB66_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB66_45
	cmpq	$3, %rax
	jne	.LBB66_43
.LBB66_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB66_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movzwl	(%rax,%r14), %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB66_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB66_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB66_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_72(%rip), %rdx
	jmp	.LBB66_10
.LBB66_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB66_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB66_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB66_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_72(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end66:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u1617haa2e80c0b1f229f2E, .Lfunc_end66-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u1617haa2e80c0b1f229f2E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u3217h59a5b92a53c033f0E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u3217h59a5b92a53c033f0E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u3217h59a5b92a53c033f0E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB67_48
	movq	%rsi, %r14
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB67_11
	cmpq	$1, %rax
	je	.LBB67_9
	cmpq	$3, %rax
	je	.LBB67_4
	.p2align	4, 0x90
.LBB67_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB67_11
	cmpq	$3, %rax
	jne	.LBB67_6
	jmp	.LBB67_8
.LBB67_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB67_15
	cmpl	$131071, %eax
	je	.LBB67_15
	cmpl	$1, %eax
	jne	.LBB67_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB67_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB67_20
	cmpq	$1, %rax
	je	.LBB67_49
	cmpq	$3, %rax
	je	.LBB67_4
	.p2align	4, 0x90
.LBB67_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB67_20
	cmpq	$3, %rax
	jne	.LBB67_18
	jmp	.LBB67_8
.LBB67_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB67_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB67_23
.LBB67_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB67_22
	jmp	.LBB67_21
.LBB67_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB67_28
	cmpq	$1, %rax
	je	.LBB67_49
	cmpq	$3, %rax
	je	.LBB67_4
	.p2align	4, 0x90
.LBB67_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB67_28
	cmpq	$3, %rax
	jne	.LBB67_26
	jmp	.LBB67_8
.LBB67_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB67_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB67_31
.LBB67_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB67_30
	jmp	.LBB67_29
.LBB67_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB67_39
	cmpq	$1, %rax
	je	.LBB67_37
	cmpq	$2, %rax
	jne	.LBB67_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB67_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB67_36
.LBB67_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB67_40
.LBB67_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB67_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB67_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_73(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB67_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB67_45
	cmpq	$1, %rax
	je	.LBB67_9
	cmpq	$3, %rax
	je	.LBB67_4
	.p2align	4, 0x90
.LBB67_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB67_45
	cmpq	$3, %rax
	jne	.LBB67_43
.LBB67_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB67_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movl	(%rax,%r14), %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB67_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB67_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB67_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_74(%rip), %rdx
	jmp	.LBB67_10
.LBB67_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB67_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB67_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB67_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_74(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end67:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u3217h59a5b92a53c033f0E, .Lfunc_end67-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u3217h59a5b92a53c033f0E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u6417h970ff3ac5eba872aE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u6417h970ff3ac5eba872aE,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u6417h970ff3ac5eba872aE:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB68_48
	movq	%rsi, %r14
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB68_11
	cmpq	$1, %rax
	je	.LBB68_9
	cmpq	$3, %rax
	je	.LBB68_4
	.p2align	4, 0x90
.LBB68_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB68_11
	cmpq	$3, %rax
	jne	.LBB68_6
	jmp	.LBB68_8
.LBB68_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB68_15
	cmpl	$131071, %eax
	je	.LBB68_15
	cmpl	$1, %eax
	jne	.LBB68_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB68_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB68_20
	cmpq	$1, %rax
	je	.LBB68_49
	cmpq	$3, %rax
	je	.LBB68_4
	.p2align	4, 0x90
.LBB68_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB68_20
	cmpq	$3, %rax
	jne	.LBB68_18
	jmp	.LBB68_8
.LBB68_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB68_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB68_23
.LBB68_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB68_22
	jmp	.LBB68_21
.LBB68_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB68_28
	cmpq	$1, %rax
	je	.LBB68_49
	cmpq	$3, %rax
	je	.LBB68_4
	.p2align	4, 0x90
.LBB68_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB68_28
	cmpq	$3, %rax
	jne	.LBB68_26
	jmp	.LBB68_8
.LBB68_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB68_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB68_31
.LBB68_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB68_30
	jmp	.LBB68_29
.LBB68_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB68_39
	cmpq	$1, %rax
	je	.LBB68_37
	cmpq	$2, %rax
	jne	.LBB68_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB68_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB68_36
.LBB68_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB68_40
.LBB68_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB68_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB68_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_75(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB68_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB68_45
	cmpq	$1, %rax
	je	.LBB68_9
	cmpq	$3, %rax
	je	.LBB68_4
	.p2align	4, 0x90
.LBB68_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB68_45
	cmpq	$3, %rax
	jne	.LBB68_43
.LBB68_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB68_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movq	(%rax,%r14), %rax
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB68_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB68_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB68_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_76(%rip), %rdx
	jmp	.LBB68_10
.LBB68_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB68_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB68_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB68_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_76(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end68:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u6417h970ff3ac5eba872aE, .Lfunc_end68-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u6417h970ff3ac5eba872aE

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8write_u817hfde206ba5bcf3dc3E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8write_u817hfde206ba5bcf3dc3E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8write_u817hfde206ba5bcf3dc3E:
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
	subq	$80, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB69_48
	movl	%edx, %r14d
	movq	%rsi, %rbp
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB69_11
	cmpq	$1, %rax
	je	.LBB69_9
	cmpq	$3, %rax
	je	.LBB69_4
	.p2align	4, 0x90
.LBB69_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB69_11
	cmpq	$3, %rax
	jne	.LBB69_6
	jmp	.LBB69_8
.LBB69_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%rbp, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB69_15
	cmpl	$131071, %eax
	je	.LBB69_15
	cmpl	$1, %eax
	jne	.LBB69_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB69_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB69_20
	cmpq	$1, %rax
	je	.LBB69_49
	cmpq	$3, %rax
	je	.LBB69_4
	.p2align	4, 0x90
.LBB69_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB69_20
	cmpq	$3, %rax
	jne	.LBB69_18
	jmp	.LBB69_8
.LBB69_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB69_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB69_23
.LBB69_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB69_22
	jmp	.LBB69_21
.LBB69_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB69_28
	cmpq	$1, %rax
	je	.LBB69_49
	cmpq	$3, %rax
	je	.LBB69_4
	.p2align	4, 0x90
.LBB69_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB69_28
	cmpq	$3, %rax
	jne	.LBB69_26
	jmp	.LBB69_8
.LBB69_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rbp, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB69_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB69_31
.LBB69_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB69_30
	jmp	.LBB69_29
.LBB69_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	56(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 56(%rsp)
	movq	64(%rsp), %rax
	je	.LBB69_39
	cmpq	$1, %rax
	je	.LBB69_37
	cmpq	$2, %rax
	jne	.LBB69_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB69_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB69_36
.LBB69_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB69_40
.LBB69_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB69_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB69_36:
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_77(%rip), %rdx
	leaq	8(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB69_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB69_45
	cmpq	$1, %rax
	je	.LBB69_9
	cmpq	$3, %rax
	je	.LBB69_4
	.p2align	4, 0x90
.LBB69_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB69_45
	cmpq	$3, %rax
	jne	.LBB69_43
.LBB69_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB69_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movb	%r14b, (%rax,%rbp)
	addq	$80, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB69_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB69_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB69_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_78(%rip), %rdx
	jmp	.LBB69_10
.LBB69_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB69_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB69_46:
	movq	%rdx, 8(%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB69_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_78(%rip), %rsi
	leaq	8(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end69:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8write_u817hfde206ba5bcf3dc3E, .Lfunc_end69-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8write_u817hfde206ba5bcf3dc3E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u1617ha8f3fa2ddcbcce39E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u1617ha8f3fa2ddcbcce39E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u1617ha8f3fa2ddcbcce39E:
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
	subq	$80, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB70_48
	movl	%edx, %r14d
	movq	%rsi, %rbp
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB70_11
	cmpq	$1, %rax
	je	.LBB70_9
	cmpq	$3, %rax
	je	.LBB70_4
	.p2align	4, 0x90
.LBB70_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB70_11
	cmpq	$3, %rax
	jne	.LBB70_6
	jmp	.LBB70_8
.LBB70_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%rbp, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB70_15
	cmpl	$131071, %eax
	je	.LBB70_15
	cmpl	$1, %eax
	jne	.LBB70_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB70_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB70_20
	cmpq	$1, %rax
	je	.LBB70_49
	cmpq	$3, %rax
	je	.LBB70_4
	.p2align	4, 0x90
.LBB70_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB70_20
	cmpq	$3, %rax
	jne	.LBB70_18
	jmp	.LBB70_8
.LBB70_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB70_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB70_23
.LBB70_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB70_22
	jmp	.LBB70_21
.LBB70_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB70_28
	cmpq	$1, %rax
	je	.LBB70_49
	cmpq	$3, %rax
	je	.LBB70_4
	.p2align	4, 0x90
.LBB70_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB70_28
	cmpq	$3, %rax
	jne	.LBB70_26
	jmp	.LBB70_8
.LBB70_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rbp, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB70_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB70_31
.LBB70_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB70_30
	jmp	.LBB70_29
.LBB70_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	56(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 56(%rsp)
	movq	64(%rsp), %rax
	je	.LBB70_39
	cmpq	$1, %rax
	je	.LBB70_37
	cmpq	$2, %rax
	jne	.LBB70_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB70_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB70_36
.LBB70_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB70_40
.LBB70_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB70_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB70_36:
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_79(%rip), %rdx
	leaq	8(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB70_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB70_45
	cmpq	$1, %rax
	je	.LBB70_9
	cmpq	$3, %rax
	je	.LBB70_4
	.p2align	4, 0x90
.LBB70_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB70_45
	cmpq	$3, %rax
	jne	.LBB70_43
.LBB70_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB70_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movw	%r14w, (%rax,%rbp)
	addq	$80, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB70_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB70_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB70_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_80(%rip), %rdx
	jmp	.LBB70_10
.LBB70_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB70_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB70_46:
	movq	%rdx, 8(%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB70_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_80(%rip), %rsi
	leaq	8(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end70:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u1617ha8f3fa2ddcbcce39E, .Lfunc_end70-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u1617ha8f3fa2ddcbcce39E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u3217hae13c58c9a2a05b5E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u3217hae13c58c9a2a05b5E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u3217hae13c58c9a2a05b5E:
	pushq	%rbp
	pushq	%r14
	pushq	%rbx
	subq	$80, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB71_48
	movl	%edx, %r14d
	movq	%rsi, %rbp
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB71_11
	cmpq	$1, %rax
	je	.LBB71_9
	cmpq	$3, %rax
	je	.LBB71_4
	.p2align	4, 0x90
.LBB71_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB71_11
	cmpq	$3, %rax
	jne	.LBB71_6
	jmp	.LBB71_8
.LBB71_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%rbp, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB71_15
	cmpl	$131071, %eax
	je	.LBB71_15
	cmpl	$1, %eax
	jne	.LBB71_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB71_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB71_20
	cmpq	$1, %rax
	je	.LBB71_49
	cmpq	$3, %rax
	je	.LBB71_4
	.p2align	4, 0x90
.LBB71_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB71_20
	cmpq	$3, %rax
	jne	.LBB71_18
	jmp	.LBB71_8
.LBB71_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB71_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB71_23
.LBB71_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB71_22
	jmp	.LBB71_21
.LBB71_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB71_28
	cmpq	$1, %rax
	je	.LBB71_49
	cmpq	$3, %rax
	je	.LBB71_4
	.p2align	4, 0x90
.LBB71_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB71_28
	cmpq	$3, %rax
	jne	.LBB71_26
	jmp	.LBB71_8
.LBB71_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rbp, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB71_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB71_31
.LBB71_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB71_30
	jmp	.LBB71_29
.LBB71_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	56(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 56(%rsp)
	movq	64(%rsp), %rax
	je	.LBB71_39
	cmpq	$1, %rax
	je	.LBB71_37
	cmpq	$2, %rax
	jne	.LBB71_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB71_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB71_36
.LBB71_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB71_40
.LBB71_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB71_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB71_36:
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_81(%rip), %rdx
	leaq	8(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB71_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB71_45
	cmpq	$1, %rax
	je	.LBB71_9
	cmpq	$3, %rax
	je	.LBB71_4
	.p2align	4, 0x90
.LBB71_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB71_45
	cmpq	$3, %rax
	jne	.LBB71_43
.LBB71_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB71_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movl	%r14d, (%rax,%rbp)
	addq	$80, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB71_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB71_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB71_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_82(%rip), %rdx
	jmp	.LBB71_10
.LBB71_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB71_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB71_46:
	movq	%rdx, 8(%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB71_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_82(%rip), %rsi
	leaq	8(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end71:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u3217hae13c58c9a2a05b5E, .Lfunc_end71-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u3217hae13c58c9a2a05b5E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u6417h84f3c8d27ecc7834E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u6417h84f3c8d27ecc7834E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u6417h84f3c8d27ecc7834E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$80, %rsp
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB72_48
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB72_11
	cmpq	$1, %rax
	je	.LBB72_9
	cmpq	$3, %rax
	je	.LBB72_4
	.p2align	4, 0x90
.LBB72_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB72_11
	cmpq	$3, %rax
	jne	.LBB72_6
	jmp	.LBB72_8
.LBB72_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r15, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB72_15
	cmpl	$131071, %eax
	je	.LBB72_15
	cmpl	$1, %eax
	jne	.LBB72_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB72_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB72_20
	cmpq	$1, %rax
	je	.LBB72_49
	cmpq	$3, %rax
	je	.LBB72_4
	.p2align	4, 0x90
.LBB72_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB72_20
	cmpq	$3, %rax
	jne	.LBB72_18
	jmp	.LBB72_8
.LBB72_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB72_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB72_23
.LBB72_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB72_22
	jmp	.LBB72_21
.LBB72_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB72_28
	cmpq	$1, %rax
	je	.LBB72_49
	cmpq	$3, %rax
	je	.LBB72_4
	.p2align	4, 0x90
.LBB72_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB72_28
	cmpq	$3, %rax
	jne	.LBB72_26
	jmp	.LBB72_8
.LBB72_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r15, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB72_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB72_31
.LBB72_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB72_30
	jmp	.LBB72_29
.LBB72_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	56(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 56(%rsp)
	movq	64(%rsp), %rax
	je	.LBB72_39
	cmpq	$1, %rax
	je	.LBB72_37
	cmpq	$2, %rax
	jne	.LBB72_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB72_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB72_36
.LBB72_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB72_40
.LBB72_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB72_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB72_36:
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_83(%rip), %rdx
	leaq	8(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB72_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB72_45
	cmpq	$1, %rax
	je	.LBB72_9
	cmpq	$3, %rax
	je	.LBB72_4
	.p2align	4, 0x90
.LBB72_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB72_45
	cmpq	$3, %rax
	jne	.LBB72_43
.LBB72_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB72_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movq	%r14, (%rax,%r15)
	addq	$80, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB72_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB72_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB72_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_84(%rip), %rdx
	jmp	.LBB72_10
.LBB72_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB72_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB72_46:
	movq	%rdx, 8(%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB72_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_84(%rip), %rsi
	leaq	8(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end72:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u6417h84f3c8d27ecc7834E, .Lfunc_end72-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u6417h84f3c8d27ecc7834E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$10read_io_u817he891d122dd88baf1E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$10read_io_u817he891d122dd88baf1E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$10read_io_u817he891d122dd88baf1E:
	pushq	%rax
	movl	%esi, %edx
	#APP

	inb	%dx, %al

	#NO_APP
	popq	%rcx
	retq
.Lfunc_end73:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$10read_io_u817he891d122dd88baf1E, .Lfunc_end73-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$10read_io_u817he891d122dd88baf1E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u1617h1631af9c88ea5e2bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u1617h1631af9c88ea5e2bE,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u1617h1631af9c88ea5e2bE:
	pushq	%rax
	movl	%esi, %edx
	#APP

	inw	%dx, %ax

	#NO_APP
	popq	%rcx
	retq
.Lfunc_end74:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u1617h1631af9c88ea5e2bE, .Lfunc_end74-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u1617h1631af9c88ea5e2bE

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u3217h76d4a76581fc95bfE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u3217h76d4a76581fc95bfE,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u3217h76d4a76581fc95bfE:
	pushq	%rax
	movl	%esi, %edx
	#APP

	inl	%dx, %eax

	#NO_APP
	popq	%rcx
	retq
.Lfunc_end75:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u3217h76d4a76581fc95bfE, .Lfunc_end75-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u3217h76d4a76581fc95bfE

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11write_io_u817hde8550b94fffdb1dE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11write_io_u817hde8550b94fffdb1dE,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11write_io_u817hde8550b94fffdb1dE:
	pushq	%rax
	movl	%edx, %eax
	movl	%esi, %edx
	#APP

	outb	%al, %dx

	#NO_APP
	popq	%rax
	retq
.Lfunc_end76:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11write_io_u817hde8550b94fffdb1dE, .Lfunc_end76-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11write_io_u817hde8550b94fffdb1dE

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u1617h477a853211be2555E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u1617h477a853211be2555E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u1617h477a853211be2555E:
	pushq	%rax
	movl	%edx, %eax
	movl	%esi, %edx
	#APP

	outw	%ax, %dx

	#NO_APP
	popq	%rax
	retq
.Lfunc_end77:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u1617h477a853211be2555E, .Lfunc_end77-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u1617h477a853211be2555E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u3217hc94076676b810c02E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u3217hc94076676b810c02E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u3217hc94076676b810c02E:
	pushq	%rax
	movl	%edx, %eax
	movl	%esi, %edx
	#APP

	outl	%eax, %dx

	#NO_APP
	popq	%rax
	retq
.Lfunc_end78:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u3217hc94076676b810c02E, .Lfunc_end78-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u3217hc94076676b810c02E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_pci_u817had7477e863baba28E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_pci_u817had7477e863baba28E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_pci_u817had7477e863baba28E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	rolw	$8, %si
	shll	$8, %esi
	movzwl	%si, %r14d
	andl	$16711680, %esi
	movzwl	%r9w, %eax
	bswapq	%rax
	movzbl	%r8b, %edi
	shlq	$40, %rdi
	orq	%rax, %rdi
	movzbl	%cl, %eax
	shlq	$32, %rax
	orq	%rdi, %rax
	movzbl	%dl, %ecx
	shlq	$24, %rcx
	orq	%rax, %rcx
	orq	%rsi, %rcx
	orq	%rcx, %r14
	bswapq	%r14
	movq	%r14, %rax
	shrq	$52, %rax
	jne	.LBB79_48
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB79_11
	cmpq	$1, %rax
	je	.LBB79_9
	cmpq	$3, %rax
	je	.LBB79_4
	.p2align	4, 0x90
.LBB79_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB79_11
	cmpq	$3, %rax
	jne	.LBB79_6
	jmp	.LBB79_8
.LBB79_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB79_15
	cmpl	$131071, %eax
	je	.LBB79_15
	cmpl	$1, %eax
	jne	.LBB79_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB79_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB79_20
	cmpq	$1, %rax
	je	.LBB79_49
	cmpq	$3, %rax
	je	.LBB79_4
	.p2align	4, 0x90
.LBB79_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB79_20
	cmpq	$3, %rax
	jne	.LBB79_18
	jmp	.LBB79_8
.LBB79_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB79_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB79_23
.LBB79_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB79_22
	jmp	.LBB79_21
.LBB79_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB79_28
	cmpq	$1, %rax
	je	.LBB79_49
	cmpq	$3, %rax
	je	.LBB79_4
	.p2align	4, 0x90
.LBB79_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB79_28
	cmpq	$3, %rax
	jne	.LBB79_26
	jmp	.LBB79_8
.LBB79_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB79_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB79_31
.LBB79_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB79_30
	jmp	.LBB79_29
.LBB79_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB79_39
	cmpq	$1, %rax
	je	.LBB79_37
	cmpq	$2, %rax
	jne	.LBB79_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB79_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB79_36
.LBB79_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB79_40
.LBB79_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB79_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB79_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_85(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB79_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB79_45
	cmpq	$1, %rax
	je	.LBB79_9
	cmpq	$3, %rax
	je	.LBB79_4
	.p2align	4, 0x90
.LBB79_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB79_45
	cmpq	$3, %rax
	jne	.LBB79_43
.LBB79_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB79_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movb	(%rax,%r14), %al
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB79_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB79_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB79_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_86(%rip), %rdx
	jmp	.LBB79_10
.LBB79_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB79_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB79_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB79_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_86(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end79:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_pci_u817had7477e863baba28E, .Lfunc_end79-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_pci_u817had7477e863baba28E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u1617hcd931558e67a9d30E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u1617hcd931558e67a9d30E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u1617hcd931558e67a9d30E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	rolw	$8, %si
	shll	$8, %esi
	movzwl	%si, %r14d
	andl	$16711680, %esi
	movzwl	%r9w, %eax
	bswapq	%rax
	movzbl	%r8b, %edi
	shlq	$40, %rdi
	orq	%rax, %rdi
	movzbl	%cl, %eax
	shlq	$32, %rax
	orq	%rdi, %rax
	movzbl	%dl, %ecx
	shlq	$24, %rcx
	orq	%rax, %rcx
	orq	%rsi, %rcx
	orq	%rcx, %r14
	bswapq	%r14
	movq	%r14, %rax
	shrq	$52, %rax
	jne	.LBB80_48
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB80_11
	cmpq	$1, %rax
	je	.LBB80_9
	cmpq	$3, %rax
	je	.LBB80_4
	.p2align	4, 0x90
.LBB80_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB80_11
	cmpq	$3, %rax
	jne	.LBB80_6
	jmp	.LBB80_8
.LBB80_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB80_15
	cmpl	$131071, %eax
	je	.LBB80_15
	cmpl	$1, %eax
	jne	.LBB80_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB80_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB80_20
	cmpq	$1, %rax
	je	.LBB80_49
	cmpq	$3, %rax
	je	.LBB80_4
	.p2align	4, 0x90
.LBB80_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB80_20
	cmpq	$3, %rax
	jne	.LBB80_18
	jmp	.LBB80_8
.LBB80_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB80_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB80_23
.LBB80_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB80_22
	jmp	.LBB80_21
.LBB80_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB80_28
	cmpq	$1, %rax
	je	.LBB80_49
	cmpq	$3, %rax
	je	.LBB80_4
	.p2align	4, 0x90
.LBB80_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB80_28
	cmpq	$3, %rax
	jne	.LBB80_26
	jmp	.LBB80_8
.LBB80_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB80_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB80_31
.LBB80_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB80_30
	jmp	.LBB80_29
.LBB80_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB80_39
	cmpq	$1, %rax
	je	.LBB80_37
	cmpq	$2, %rax
	jne	.LBB80_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB80_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB80_36
.LBB80_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB80_40
.LBB80_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB80_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB80_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_87(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB80_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB80_45
	cmpq	$1, %rax
	je	.LBB80_9
	cmpq	$3, %rax
	je	.LBB80_4
	.p2align	4, 0x90
.LBB80_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB80_45
	cmpq	$3, %rax
	jne	.LBB80_43
.LBB80_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB80_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movzwl	(%rax,%r14), %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB80_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB80_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB80_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_88(%rip), %rdx
	jmp	.LBB80_10
.LBB80_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB80_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB80_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB80_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_88(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end80:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u1617hcd931558e67a9d30E, .Lfunc_end80-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u1617hcd931558e67a9d30E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u3217heb4807b9b56a97f0E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u3217heb4807b9b56a97f0E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u3217heb4807b9b56a97f0E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	rolw	$8, %si
	shll	$8, %esi
	movzwl	%si, %r14d
	andl	$16711680, %esi
	movzwl	%r9w, %eax
	bswapq	%rax
	movzbl	%r8b, %edi
	shlq	$40, %rdi
	orq	%rax, %rdi
	movzbl	%cl, %eax
	shlq	$32, %rax
	orq	%rdi, %rax
	movzbl	%dl, %ecx
	shlq	$24, %rcx
	orq	%rax, %rcx
	orq	%rsi, %rcx
	orq	%rcx, %r14
	bswapq	%r14
	movq	%r14, %rax
	shrq	$52, %rax
	jne	.LBB81_48
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB81_11
	cmpq	$1, %rax
	je	.LBB81_9
	cmpq	$3, %rax
	je	.LBB81_4
	.p2align	4, 0x90
.LBB81_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB81_11
	cmpq	$3, %rax
	jne	.LBB81_6
	jmp	.LBB81_8
.LBB81_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB81_15
	cmpl	$131071, %eax
	je	.LBB81_15
	cmpl	$1, %eax
	jne	.LBB81_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB81_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB81_20
	cmpq	$1, %rax
	je	.LBB81_49
	cmpq	$3, %rax
	je	.LBB81_4
	.p2align	4, 0x90
.LBB81_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB81_20
	cmpq	$3, %rax
	jne	.LBB81_18
	jmp	.LBB81_8
.LBB81_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB81_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB81_23
.LBB81_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB81_22
	jmp	.LBB81_21
.LBB81_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB81_28
	cmpq	$1, %rax
	je	.LBB81_49
	cmpq	$3, %rax
	je	.LBB81_4
	.p2align	4, 0x90
.LBB81_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB81_28
	cmpq	$3, %rax
	jne	.LBB81_26
	jmp	.LBB81_8
.LBB81_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB81_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB81_31
.LBB81_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB81_30
	jmp	.LBB81_29
.LBB81_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB81_39
	cmpq	$1, %rax
	je	.LBB81_37
	cmpq	$2, %rax
	jne	.LBB81_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB81_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB81_36
.LBB81_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB81_40
.LBB81_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB81_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB81_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_89(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB81_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB81_45
	cmpq	$1, %rax
	je	.LBB81_9
	cmpq	$3, %rax
	je	.LBB81_4
	.p2align	4, 0x90
.LBB81_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB81_45
	cmpq	$3, %rax
	jne	.LBB81_43
.LBB81_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB81_45:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movl	(%rax,%r14), %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB81_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB81_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB81_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_90(%rip), %rdx
	jmp	.LBB81_10
.LBB81_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB81_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB81_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB81_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_90(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end81:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u3217heb4807b9b56a97f0E, .Lfunc_end81-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u3217heb4807b9b56a97f0E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_pci_u817hfeeee468c1b36c6bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_pci_u817hfeeee468c1b36c6bE,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_pci_u817hfeeee468c1b36c6bE:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	rolw	$8, %si
	shll	$8, %esi
	movzwl	%si, %r14d
	andl	$16711680, %esi
	movzwl	%r9w, %eax
	bswapq	%rax
	movzbl	%r8b, %edi
	shlq	$40, %rdi
	orq	%rax, %rdi
	movzbl	%cl, %eax
	shlq	$32, %rax
	orq	%rdi, %rax
	movzbl	%dl, %ecx
	shlq	$24, %rcx
	orq	%rax, %rcx
	orq	%rsi, %rcx
	orq	%rcx, %r14
	bswapq	%r14
	movq	%r14, %rax
	shrq	$52, %rax
	jne	.LBB82_48
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB82_11
	cmpq	$1, %rax
	je	.LBB82_9
	cmpq	$3, %rax
	je	.LBB82_4
	.p2align	4, 0x90
.LBB82_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB82_11
	cmpq	$3, %rax
	jne	.LBB82_6
	jmp	.LBB82_8
.LBB82_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB82_15
	cmpl	$131071, %eax
	je	.LBB82_15
	cmpl	$1, %eax
	jne	.LBB82_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB82_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB82_20
	cmpq	$1, %rax
	je	.LBB82_49
	cmpq	$3, %rax
	je	.LBB82_4
	.p2align	4, 0x90
.LBB82_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB82_20
	cmpq	$3, %rax
	jne	.LBB82_18
	jmp	.LBB82_8
.LBB82_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB82_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB82_23
.LBB82_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB82_22
	jmp	.LBB82_21
.LBB82_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB82_28
	cmpq	$1, %rax
	je	.LBB82_49
	cmpq	$3, %rax
	je	.LBB82_4
	.p2align	4, 0x90
.LBB82_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB82_28
	cmpq	$3, %rax
	jne	.LBB82_26
	jmp	.LBB82_8
.LBB82_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB82_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB82_31
.LBB82_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB82_30
	jmp	.LBB82_29
.LBB82_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB82_39
	cmpq	$1, %rax
	je	.LBB82_37
	cmpq	$2, %rax
	jne	.LBB82_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB82_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB82_36
.LBB82_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB82_40
.LBB82_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB82_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB82_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_91(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB82_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB82_45
	cmpq	$1, %rax
	je	.LBB82_9
	cmpq	$3, %rax
	je	.LBB82_4
	.p2align	4, 0x90
.LBB82_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB82_45
	cmpq	$3, %rax
	jne	.LBB82_43
.LBB82_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB82_45:
	movb	96(%rsp), %al
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rcx
	movb	%al, (%rcx,%r14)
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB82_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB82_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB82_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_92(%rip), %rdx
	jmp	.LBB82_10
.LBB82_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB82_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB82_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB82_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_92(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end82:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_pci_u817hfeeee468c1b36c6bE, .Lfunc_end82-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_pci_u817hfeeee468c1b36c6bE

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u1617h87b2238581fade75E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u1617h87b2238581fade75E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u1617h87b2238581fade75E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	rolw	$8, %si
	shll	$8, %esi
	movzwl	%si, %r14d
	andl	$16711680, %esi
	movzwl	%r9w, %eax
	bswapq	%rax
	movzbl	%r8b, %edi
	shlq	$40, %rdi
	orq	%rax, %rdi
	movzbl	%cl, %eax
	shlq	$32, %rax
	orq	%rdi, %rax
	movzbl	%dl, %ecx
	shlq	$24, %rcx
	orq	%rax, %rcx
	orq	%rsi, %rcx
	orq	%rcx, %r14
	bswapq	%r14
	movq	%r14, %rax
	shrq	$52, %rax
	jne	.LBB83_48
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB83_11
	cmpq	$1, %rax
	je	.LBB83_9
	cmpq	$3, %rax
	je	.LBB83_4
	.p2align	4, 0x90
.LBB83_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB83_11
	cmpq	$3, %rax
	jne	.LBB83_6
	jmp	.LBB83_8
.LBB83_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB83_15
	cmpl	$131071, %eax
	je	.LBB83_15
	cmpl	$1, %eax
	jne	.LBB83_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB83_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB83_20
	cmpq	$1, %rax
	je	.LBB83_49
	cmpq	$3, %rax
	je	.LBB83_4
	.p2align	4, 0x90
.LBB83_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB83_20
	cmpq	$3, %rax
	jne	.LBB83_18
	jmp	.LBB83_8
.LBB83_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB83_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB83_23
.LBB83_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB83_22
	jmp	.LBB83_21
.LBB83_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB83_28
	cmpq	$1, %rax
	je	.LBB83_49
	cmpq	$3, %rax
	je	.LBB83_4
	.p2align	4, 0x90
.LBB83_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB83_28
	cmpq	$3, %rax
	jne	.LBB83_26
	jmp	.LBB83_8
.LBB83_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB83_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB83_31
.LBB83_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB83_30
	jmp	.LBB83_29
.LBB83_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB83_39
	cmpq	$1, %rax
	je	.LBB83_37
	cmpq	$2, %rax
	jne	.LBB83_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB83_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB83_36
.LBB83_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB83_40
.LBB83_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB83_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB83_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_93(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB83_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB83_45
	cmpq	$1, %rax
	je	.LBB83_9
	cmpq	$3, %rax
	je	.LBB83_4
	.p2align	4, 0x90
.LBB83_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB83_45
	cmpq	$3, %rax
	jne	.LBB83_43
.LBB83_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB83_45:
	movzwl	96(%rsp), %eax
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rcx
	movw	%ax, (%rcx,%r14)
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB83_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB83_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB83_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_94(%rip), %rdx
	jmp	.LBB83_10
.LBB83_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB83_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB83_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB83_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_94(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end83:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u1617h87b2238581fade75E, .Lfunc_end83-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u1617h87b2238581fade75E

	.section	".text._ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u3217h5b4d07c28c1b4838E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u3217h5b4d07c28c1b4838E,@function
_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u3217h5b4d07c28c1b4838E:
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
	rolw	$8, %si
	shll	$8, %esi
	movzwl	%si, %r14d
	andl	$16711680, %esi
	movzwl	%r9w, %eax
	bswapq	%rax
	movzbl	%r8b, %edi
	shlq	$40, %rdi
	orq	%rax, %rdi
	movzbl	%cl, %eax
	shlq	$32, %rax
	orq	%rdi, %rax
	movzbl	%dl, %ecx
	shlq	$24, %rcx
	orq	%rax, %rcx
	orq	%rsi, %rcx
	orq	%rcx, %r14
	bswapq	%r14
	movq	%r14, %rax
	shrq	$52, %rax
	jne	.LBB84_48
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB84_11
	cmpq	$1, %rax
	je	.LBB84_9
	cmpq	$3, %rax
	je	.LBB84_4
	.p2align	4, 0x90
.LBB84_6:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB84_11
	cmpq	$3, %rax
	jne	.LBB84_6
	jmp	.LBB84_8
.LBB84_11:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r14, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB84_15
	cmpl	$131071, %eax
	je	.LBB84_15
	cmpl	$1, %eax
	jne	.LBB84_46
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB84_15:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB84_20
	cmpq	$1, %rax
	je	.LBB84_49
	cmpq	$3, %rax
	je	.LBB84_4
	.p2align	4, 0x90
.LBB84_18:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB84_20
	cmpq	$3, %rax
	jne	.LBB84_18
	jmp	.LBB84_8
.LBB84_20:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB84_21:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB84_23
.LBB84_22:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB84_22
	jmp	.LBB84_21
.LBB84_23:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB84_28
	cmpq	$1, %rax
	je	.LBB84_49
	cmpq	$3, %rax
	je	.LBB84_4
	.p2align	4, 0x90
.LBB84_26:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB84_28
	cmpq	$3, %rax
	jne	.LBB84_26
	jmp	.LBB84_8
.LBB84_28:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r14, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB84_29:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB84_31
.LBB84_30:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB84_30
	jmp	.LBB84_29
.LBB84_31:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	48(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 48(%rsp)
	movq	56(%rsp), %rax
	je	.LBB84_39
	cmpq	$1, %rax
	je	.LBB84_37
	cmpq	$2, %rax
	jne	.LBB84_47
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB84_40
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB84_36
.LBB84_39:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB84_40
.LBB84_37:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB84_40
	leaq	.L__unnamed_58(%rip), %rax
.LBB84_36:
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_95(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB84_40:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB84_45
	cmpq	$1, %rax
	je	.LBB84_9
	cmpq	$3, %rax
	je	.LBB84_4
	.p2align	4, 0x90
.LBB84_43:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB84_45
	cmpq	$3, %rax
	jne	.LBB84_43
.LBB84_8:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB84_45:
	movl	96(%rsp), %eax
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rcx
	movl	%eax, (%rcx,%r14)
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	retq
.LBB84_4:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB84_48:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB84_49:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_96(%rip), %rdx
	jmp	.LBB84_10
.LBB84_9:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
.LBB84_10:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB84_46:
	movq	%rdx, (%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	movq	%rsp, %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB84_47:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_96(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end84:
	.size	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u3217h5b4d07c28c1b4838E, .Lfunc_end84-_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u3217h5b4d07c28c1b4838E

	.section	".text._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E,@function
_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E:
	movl	52(%rdi), %ecx
	orl	56(%rdi), %ecx
	movl	$1, %eax
	testb	$1, %cl
	jne	.LBB85_2
	xorl	%edx, %edx
	retq
.LBB85_2:
	testb	$2, %cl
	jne	.LBB85_4
	movl	$1, %edx
	retq
.LBB85_4:
	movl	$2, %edx
	testb	$4, %cl
	je	.LBB85_34
	movl	$3, %edx
	testb	$8, %cl
	je	.LBB85_34
	movl	$4, %edx
	testb	$16, %cl
	je	.LBB85_34
	movl	$5, %edx
	testb	$32, %cl
	je	.LBB85_34
	movl	$6, %edx
	testb	$64, %cl
	je	.LBB85_34
	movl	$7, %edx
	testb	$-128, %cl
	je	.LBB85_34
	movl	$8, %edx
	testl	$256, %ecx
	je	.LBB85_34
	movl	$9, %edx
	testl	$512, %ecx
	je	.LBB85_34
	movl	$10, %edx
	testl	$1024, %ecx
	je	.LBB85_34
	movl	$11, %edx
	testl	$2048, %ecx
	je	.LBB85_34
	movl	$12, %edx
	testl	$4096, %ecx
	je	.LBB85_34
	movl	$13, %edx
	testl	$8192, %ecx
	je	.LBB85_34
	movl	$14, %edx
	testl	$16384, %ecx
	je	.LBB85_34
	movl	$15, %edx
	testl	$32768, %ecx
	je	.LBB85_34
	movl	$16, %edx
	testl	$65536, %ecx
	je	.LBB85_34
	movl	$17, %edx
	testl	$131072, %ecx
	je	.LBB85_34
	movl	$18, %edx
	testl	$262144, %ecx
	je	.LBB85_34
	movl	$19, %edx
	testl	$524288, %ecx
	je	.LBB85_34
	movl	$20, %edx
	testl	$1048576, %ecx
	je	.LBB85_34
	movl	$21, %edx
	testl	$2097152, %ecx
	je	.LBB85_34
	movl	$22, %edx
	testl	$4194304, %ecx
	je	.LBB85_34
	movl	$23, %edx
	testl	$8388608, %ecx
	je	.LBB85_34
	movl	$24, %edx
	testl	$16777216, %ecx
	je	.LBB85_34
	movl	$25, %edx
	testl	$33554432, %ecx
	je	.LBB85_34
	movl	$26, %edx
	testl	$67108864, %ecx
	je	.LBB85_34
	movl	$27, %edx
	testl	$134217728, %ecx
	je	.LBB85_34
	movl	$28, %edx
	testl	$268435456, %ecx
	je	.LBB85_34
	movl	$29, %edx
	testl	$536870912, %ecx
	je	.LBB85_34
	movl	$30, %edx
	testl	$1073741824, %ecx
	je	.LBB85_34
	notl	%ecx
	movl	%ecx, %edx
	sarl	$31, %edx
	addl	$32, %edx
	shrl	$31, %ecx
	movl	%ecx, %eax
.LBB85_34:
	retq
.Lfunc_end85:
	.size	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E, .Lfunc_end85-_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E

	.section	".text._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4init17h541fe38d68d0bdbbE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4init17h541fe38d68d0bdbbE,@function
_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4init17h541fe38d68d0bdbbE:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	movq	%rcx, 16(%rsp)
	movq	%rdx, %rbx
	movq	%rsi, %r12
	movq	%rdi, %r15
	andl	$-2, 24(%rdi)
	.p2align	4, 0x90
.LBB86_1:
	movl	24(%r15), %eax
	notl	%eax
	testl	$49152, %eax
	je	.LBB86_1
	andl	$-17, 24(%r15)
	xorl	%ebp, %ebp
	movq	_ZN7syscall2io3dma7PhysBox7address17h801088c8bf5f7a85E@GOTPCREL(%rip), %r13
	.p2align	4, 0x90
.LBB86_3:
	movq	16(%r12), %r14
	movq	%rbx, %rdi
	callq	*%r13
	movq	%rax, 8(%r14,%rbp)
	movw	$0, 2(%r14,%rbp)
	addq	$32, %rbp
	addq	$24, %rbx
	cmpq	$1024, %rbp
	jne	.LBB86_3
	movq	%r12, %rdi
	callq	*%r13
	movl	%eax, (%r15)
	movq	%r12, %rdi
	callq	*%r13
	shrq	$32, %rax
	movl	%eax, 4(%r15)
	movq	16(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*%r13
	movl	%eax, 8(%r15)
	movq	%rbx, %rdi
	callq	*%r13
	shrq	$32, %rax
	movl	%eax, 12(%r15)
	movl	16(%r15), %eax
	movl	%eax, 16(%r15)
	movl	$23, 20(%r15)
	movl	48(%r15), %eax
	movl	%eax, 48(%r15)
	movl	44(%r15), %eax
	movl	%eax, 44(%r15)
	orl	$6, 24(%r15)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB86_6
	movl	24(%r15), %eax
	movl	%eax, 12(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 24(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L__unnamed_97(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$1, 48(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	$1, 80(%rsp)
	leaq	.L__unnamed_98(%rip), %rdx
	leaq	40(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB86_6:
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end86:
	.size	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4init17h541fe38d68d0bdbbE, .Lfunc_end86-_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4init17h541fe38d68d0bdbbE

	.section	".text._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E,@function
_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E:
	subq	$120, %rsp
	movl	%esi, %ecx
	movl	$1, %eax
	shll	%cl, %eax
	jmp	.LBB87_1
	.p2align	4, 0x90
.LBB87_3:
	testl	$2013265920, 16(%rdi)
	jne	.LBB87_4
.LBB87_1:
	movl	56(%rdi), %ecx
	notl	%ecx
	testl	%ecx, %eax
	je	.LBB87_3
	testl	$128, 32(%rdi)
	jne	.LBB87_3
.LBB87_4:
	andl	$-2, 24(%rdi)
	.p2align	4, 0x90
.LBB87_5:
	movl	24(%rdi), %eax
	notl	%eax
	testl	$49152, %eax
	je	.LBB87_5
	andl	$-17, 24(%rdi)
	movl	16(%rdi), %eax
	shrl	$27, %eax
	andl	$15, %eax
	cmpl	$9, %eax
	jae	.LBB87_9
	movl	$279, %ecx
	btl	%eax, %ecx
	jae	.LBB87_9
	leaq	.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E(%rip), %rcx
	movl	(%rcx,%rax,4), %eax
	addq	$120, %rsp
	retq
.LBB87_9:
	leaq	.L__unnamed_99(%rip), %rax
	movq	%rax, 72(%rsp)
	movq	$1, 80(%rsp)
	movq	$0, 88(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 104(%rsp)
	movq	$0, 112(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	_ZN59_$LT$core..fmt..Arguments$u20$as$u20$core..fmt..Display$GT$3fmt17h01f0c599a801d27aE@GOTPCREL(%rip), %rax
	movq	%rax, 16(%rsp)
	leaq	.L__unnamed_100(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$1, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	.L__unnamed_101(%rip), %rsi
	leaq	24(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end87:
	.size	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E, .Lfunc_end87-_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E

	.section	".text._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E,@function
_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$184, %rsp
	movq	%rdx, %r14
	movq	%rsi, %rbp
	movq	%rdi, %rbx
	movl	$512, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	leaq	24(%rsp), %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, 24(%rsp)
	jne	.LBB88_11
	movq	%rbp, 168(%rsp)
	movq	32(%rsp), %rbp
	movq	40(%rsp), %r13
	movq	%rbp, 144(%rsp)
	movq	%r13, 152(%rsp)
	leaq	24(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, 24(%rsp)
	jne	.LBB88_2
	movq	32(%rsp), %r15
	movl	$512, %edx
	movq	%r15, %rdi
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	%rbp, 72(%rsp)
	movq	%r13, 80(%rsp)
	movq	%r15, 88(%rsp)
	movq	%rbx, %rdi
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E
	cmpl	$1, %eax
	jne	.LBB88_159
	movl	%edx, %r12d
	movl	%edx, %edi
	cmpl	$31, %edx
	ja	.LBB88_161
	movq	%rdi, %r15
	shlq	$5, %r15
	movq	168(%rsp), %r13
	movb	$5, (%r13,%r15)
	leaq	(%rdi,%rdi,2), %rax
	movq	16(%r14,%rax,8), %rbp
	leaq	1(%rbp), %rdi
	movl	$1048703, %edx
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movb	$39, (%rbp)
	movw	$1, 2(%r13,%r15)
	leaq	72(%rsp), %rdi
	callq	*_ZN7syscall2io3dma7PhysBox7address17h801088c8bf5f7a85E@GOTPCREL(%rip)
	movq	%rax, 128(%rbp)
	movl	$513, 140(%rbp)
	movb	$-128, 1(%rbp)
	movb	$-20, 2(%rbp)
	movb	$0, 7(%rbp)
	movb	$1, 12(%rbp)
	movb	$0, 13(%rbp)
	.p2align	4, 0x90
.LBB88_6:
	movl	32(%rbx), %eax
	notl	%eax
	testb	$-120, %al
	je	.LBB88_6
	movl	$1, %eax
	movl	%r12d, %ecx
	shll	%cl, %eax
	orl	%eax, 56(%rbx)
	.p2align	4, 0x90
.LBB88_8:
	testl	$32768, 24(%rbx)
	jne	.LBB88_8
	orl	$17, 24(%rbx)
	movq	%rbx, %rdi
	movl	%r12d, %esi
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E
	cmpl	$5, %eax
	ja	.LBB88_17
	movl	%eax, %eax
	leaq	.LJTI88_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB88_18:
	movl	$1, %ebp
	movl	$15, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB88_19
	movq	%rax, %rbx
	movq	.L__unnamed_102+7(%rip), %rax
	movq	%rax, 7(%rbx)
	movq	.L__unnamed_102(%rip), %rax
	movq	%rax, (%rbx)
	.p2align	4, 0x90
.LBB88_22:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB88_22
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB88_26
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_26
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_26:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB88_27:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB88_27
	movl	$0, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB88_59
.LBB88_159:
	leaq	24(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	*_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip)
	leaq	72(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	xorl	%ebx, %ebx
	jmp	.LBB88_160
.LBB88_29:
	movl	$1, %ebp
	movl	$81, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB88_30
	movq	%rax, %rbx
	leaq	.L__unnamed_103(%rip), %rsi
	movl	$81, %edx
	movq	%rax, %rdi
	callq	*memcpy@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB88_32:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB88_32
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB88_36
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_36
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_36:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$81, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$81, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB88_37:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB88_37
	movl	$1, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB88_59
.LBB88_39:
	movl	$1, %ebp
	movl	$64, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB88_40
	movq	%rax, %rbx
	movq	.L__unnamed_104+56(%rip), %rax
	movq	%rax, 56(%rbx)
	movq	.L__unnamed_104+48(%rip), %rax
	movq	%rax, 48(%rbx)
	movq	.L__unnamed_104+40(%rip), %rax
	movq	%rax, 40(%rbx)
	movq	.L__unnamed_104+32(%rip), %rax
	movq	%rax, 32(%rbx)
	movq	.L__unnamed_104+24(%rip), %rax
	movq	%rax, 24(%rbx)
	movq	.L__unnamed_104+16(%rip), %rax
	movq	%rax, 16(%rbx)
	movq	.L__unnamed_104+8(%rip), %rax
	movq	%rax, 8(%rbx)
	movq	.L__unnamed_104(%rip), %rax
	movq	%rax, (%rbx)
	.p2align	4, 0x90
.LBB88_42:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB88_42
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB88_46
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_46
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_46:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$64, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$64, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB88_47:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB88_47
	movl	$2, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB88_59
.LBB88_49:
	movl	$1, %ebp
	movl	$65, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB88_50
	movq	%rax, %rbx
	leaq	.L__unnamed_105(%rip), %rsi
	movl	$65, %edx
	movq	%rax, %rdi
	callq	*memcpy@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB88_52:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB88_52
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB88_56
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_56
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_56:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$65, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$65, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB88_57:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB88_57
	movl	$3, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
.LBB88_59:
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	xorl	%ebx, %ebx
.LBB88_60:
	movq	80(%rsp), %rdx
	movq	88(%rsp), %rsi
	leaq	24(%rsp), %rdi
	callq	*_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip)
	leaq	72(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB88_160:
	movq	%rbx, %rax
	movq	%r14, %rdx
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB88_13:
	movabsq	$9223372036854775804, %rbx
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%rbx, %rax
	ja	.LBB88_15
	.p2align	4, 0x90
.LBB88_61:
	testb	$3, %al
	je	.LBB88_63
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%rbx, %rax
	jbe	.LBB88_61
.LBB88_15:
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jmp	.LBB88_16
.LBB88_63:
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rax
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	testq	%rax, %rax
	je	.LBB88_64
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB88_67:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB88_67
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB88_71
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_71
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_71:
	movq	$0, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	24(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jmp	.LBB88_64
	.p2align	4, 0x90
.LBB88_73:
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
.LBB88_64:
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	cmpq	%rbx, %rax
	ja	.LBB88_65
	testb	$3, %al
	jne	.LBB88_73
	movl	_ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip), %eax
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	cmpl	$5, %eax
	je	.LBB88_78
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB88_76:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB88_76
	movl	$5, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
.LBB88_78:
	movq	$1, (%rsp)
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
	movq	88(%rsp), %rax
	movzwl	20(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_80
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_80:
	andw	$255, %bx
	je	.LBB88_82
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_82:
	movq	88(%rsp), %rax
	movzwl	22(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_84
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_84:
	andw	$255, %bx
	je	.LBB88_86
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_86:
	movq	88(%rsp), %rax
	movzwl	24(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_88
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_88:
	andw	$255, %bx
	je	.LBB88_90
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_90:
	movq	88(%rsp), %rax
	movzwl	26(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_92
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_92:
	andw	$255, %bx
	je	.LBB88_94
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_94:
	movq	88(%rsp), %rax
	movzwl	28(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_96
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_96:
	andw	$255, %bx
	je	.LBB88_98
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_98:
	movq	88(%rsp), %rax
	movzwl	30(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_100
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_100:
	andw	$255, %bx
	je	.LBB88_102
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_102:
	movq	88(%rsp), %rax
	movzwl	32(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_104
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_104:
	andw	$255, %bx
	je	.LBB88_106
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_106:
	movq	88(%rsp), %rax
	movzwl	34(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_108
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_108:
	andw	$255, %bx
	je	.LBB88_110
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_110:
	movq	88(%rsp), %rax
	movzwl	36(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_112
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_112:
	andw	$255, %bx
	je	.LBB88_114
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_114:
	movq	88(%rsp), %rax
	movzwl	38(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_116
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_116:
	andw	$255, %bx
	je	.LBB88_118
	movzwl	%bx, %esi
	movq	%rsp, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_118:
	movq	$1, 112(%rsp)
	movq	$0, 120(%rsp)
	movq	$0, 128(%rsp)
	movq	88(%rsp), %rax
	movzwl	46(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_120
	movl	%ebx, %esi
	shrl	$8, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_120:
	andw	$255, %bx
	je	.LBB88_122
	movzwl	%bx, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_122:
	movq	88(%rsp), %rax
	movzwl	48(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_124
	movl	%ebx, %esi
	shrl	$8, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_124:
	andw	$255, %bx
	je	.LBB88_126
	movzwl	%bx, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_126:
	movq	88(%rsp), %rax
	movzwl	50(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_128
	movl	%ebx, %esi
	shrl	$8, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_128:
	andw	$255, %bx
	je	.LBB88_130
	movzwl	%bx, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_130:
	movq	88(%rsp), %rax
	movzwl	52(%rax), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_132
	movl	%ebx, %esi
	shrl	$8, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_132:
	andw	$255, %bx
	je	.LBB88_134
	movzwl	%bx, %esi
	leaq	112(%rsp), %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_134:
	movq	$1, 144(%rsp)
	movq	$0, 152(%rsp)
	movq	$0, 160(%rsp)
	xorl	%ebp, %ebp
	leaq	144(%rsp), %r15
	jmp	.LBB88_135
	.p2align	4, 0x90
.LBB88_139:
	addq	$1, %rbp
	cmpq	$20, %rbp
	je	.LBB88_140
.LBB88_135:
	movq	88(%rsp), %rax
	movzwl	54(%rax,%rbp,2), %ebx
	cmpl	$256, %ebx
	jb	.LBB88_137
	movl	%ebx, %esi
	shrl	$8, %esi
	movq	%r15, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
.LBB88_137:
	andw	$255, %bx
	je	.LBB88_139
	movzwl	%bx, %esi
	movq	%r15, %rdi
	callq	_ZN5alloc6string6String4push17ha1195b5ba6724106E
	jmp	.LBB88_139
.LBB88_140:
	movq	88(%rsp), %rcx
	movq	200(%rcx), %r14
	movl	$48, %eax
	testq	%r14, %r14
	jne	.LBB88_142
	movl	120(%rcx), %r14d
	movl	$28, %eax
.LBB88_142:
	movl	%eax, 140(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rbp
	movq	(%rbp), %rax
	cmpq	$3, %rax
	jae	.LBB88_143
	movq	(%rbp), %rax
	cmpq	$3, %rax
	jae	.LBB88_145
.LBB88_146:
	movq	(%rbp), %rax
	cmpq	$3, %rax
	jae	.LBB88_147
.LBB88_148:
	movq	(%rbp), %rax
	cmpq	$3, %rax
	jae	.LBB88_149
.LBB88_150:
	movq	(%rbp), %rax
	cmpq	$2, %rax
	ja	.LBB88_158
.LBB88_151:
	movq	152(%rsp), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_153
.LBB88_152:
	movq	144(%rsp), %rdi
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_153:
	movq	120(%rsp), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_155
	movq	112(%rsp), %rdi
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_155:
	movq	8(%rsp), %rsi
	testq	%rsi, %rsi
	jle	.LBB88_157
	movq	(%rsp), %rdi
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB88_157:
	shlq	$9, %r14
	movl	$1, %ebx
	jmp	.LBB88_60
.LBB88_143:
	movq	%rsp, %rax
	movq	%rax, 96(%rsp)
	leaq	_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	.L__unnamed_106(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$1, 32(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$1, 48(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	.L__unnamed_107(%rip), %rdx
	leaq	24(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	(%rbp), %rax
	cmpq	$3, %rax
	jb	.LBB88_146
.LBB88_145:
	leaq	112(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	.L__unnamed_108(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$1, 32(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$1, 48(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	.L__unnamed_109(%rip), %rdx
	leaq	24(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	(%rbp), %rax
	cmpq	$3, %rax
	jb	.LBB88_148
.LBB88_147:
	movq	%r15, 96(%rsp)
	leaq	_ZN58_$LT$alloc..string..String$u20$as$u20$core..fmt..Debug$GT$3fmt17h067f42abe0c5c24aE(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	.L__unnamed_110(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$1, 32(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$1, 48(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	.L__unnamed_111(%rip), %rdx
	leaq	24(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	(%rbp), %rax
	cmpq	$3, %rax
	jb	.LBB88_150
.LBB88_149:
	leaq	140(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$i32$GT$3fmt17hc977587ed4082d5bE(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	.L__unnamed_112(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$2, 32(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$1, 48(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	.L__unnamed_113(%rip), %rdx
	leaq	24(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	(%rbp), %rax
	cmpq	$2, %rax
	jbe	.LBB88_151
.LBB88_158:
	movq	%r14, %rax
	shrq	$11, %rax
	movq	%rax, 176(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 96(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	.L__unnamed_114(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$2, 32(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$1, 48(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	.L__unnamed_115(%rip), %rdx
	leaq	24(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	152(%rsp), %rsi
	testq	%rsi, %rsi
	jg	.LBB88_152
	jmp	.LBB88_153
.LBB88_161:
	leaq	.L__unnamed_116(%rip), %rdx
	movl	$32, %esi
	callq	*_ZN4core9panicking18panic_bounds_check17h7f6539b946f45151E@GOTPCREL(%rip)
	ud2
.LBB88_65:
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
.LBB88_16:
	leaq	.L__unnamed_117(%rip), %rdi
	leaq	.L__unnamed_118(%rip), %rdx
	movl	$44, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB88_11:
	movl	28(%rsp), %ebx
	jmp	.LBB88_12
.LBB88_2:
	movl	28(%rsp), %ebx
	leaq	144(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB88_12:
	movl	%ebx, 24(%rsp)
	leaq	.L__unnamed_119(%rip), %rdi
	leaq	.L__unnamed_120(%rip), %rcx
	leaq	.L__unnamed_121(%rip), %r8
	leaq	24(%rsp), %rdx
	movl	$43, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB88_17:
	leaq	.L__unnamed_122(%rip), %rdi
	leaq	.L__unnamed_123(%rip), %rdx
	movl	$40, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB88_19:
	movl	$15, %edi
	jmp	.LBB88_20
.LBB88_30:
	movl	$81, %edi
	jmp	.LBB88_20
.LBB88_40:
	movl	$64, %edi
	jmp	.LBB88_20
.LBB88_50:
	movl	$65, %edi
.LBB88_20:
	movl	$1, %esi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end88:
	.size	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E, .Lfunc_end88-_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E
	.section	".rodata._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E","a",@progbits
	.p2align	2
.LJTI88_0:
	.long	.LBB88_18-.LJTI88_0
	.long	.LBB88_29-.LJTI88_0
	.long	.LBB88_39-.LJTI88_0
	.long	.LBB88_49-.LJTI88_0
	.long	.LBB88_17-.LJTI88_0
	.long	.LBB88_13-.LJTI88_0

	.section	".text._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E,@function
_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%r9, %r12
	movq	%r8, 16(%rsp)
	movq	%rcx, %r14
	movl	%edx, %r13d
	movq	%rsi, %rbp
	movq	%rdi, %rbx
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E
	movl	%eax, %ecx
	movl	$4, %eax
	cmpl	$1, %ecx
	jne	.LBB89_8
	movl	%edx, %r15d
	movl	%edx, %edi
	cmpl	$31, %edx
	ja	.LBB89_10
	movq	%rbp, 8(%rsp)
	movq	%r12, (%rsp)
	movq	%rdi, %r12
	shlq	$5, %r12
	movb	$5, (%r14,%r12)
	leaq	(%rdi,%rdi,2), %rax
	movq	16(%rsp), %rcx
	movq	16(%rcx,%rax,8), %rbp
	leaq	1(%rbp), %rdi
	movl	$1048703, %edx
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movb	$39, (%rbp)
	orb	$32, (%r14,%r12)
	movw	$1, 2(%r14,%r12)
	movq	(%rsp), %rdi
	callq	*_ZN7syscall2io3dma7PhysBox7address17h801088c8bf5f7a85E@GOTPCREL(%rip)
	movq	%rax, 128(%rbp)
	addl	$-1, %r13d
	movl	%r13d, 140(%rbp)
	movb	$-128, 1(%rbp)
	movb	$0, 2(%rbp)
	movb	$0, 7(%rbp)
	movb	$0, 5(%rbp)
	movb	$0, 6(%rbp)
	movb	$1, 3(%rbp)
	movb	$0, 11(%rbp)
	movq	8(%rsp), %rcx
	movq	(%rcx), %rax
	movq	8(%rcx), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, 24(%rsp)
	movq	32(%rsp), %rax
	movq	%rax, 72(%rbp)
	movq	24(%rsp), %rax
	movq	%rax, 64(%rbp)
	.p2align	4, 0x90
.LBB89_3:
	movl	32(%rbx), %eax
	notl	%eax
	testb	$-120, %al
	je	.LBB89_3
	movl	$1, %eax
	movl	%r15d, %ecx
	shll	%cl, %eax
	orl	%eax, 56(%rbx)
	.p2align	4, 0x90
.LBB89_5:
	testl	$32768, 24(%rbx)
	jne	.LBB89_5
	orl	$17, 24(%rbx)
	movq	%rbx, %rdi
	movl	%r15d, %esi
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E
	movl	$47, %ecx
	btl	%eax, %ecx
	jae	.LBB89_9
	movl	%eax, %eax
	leaq	.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E(%rip), %rcx
	movl	(%rcx,%rax,4), %eax
.LBB89_8:
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB89_10:
	leaq	.L__unnamed_116(%rip), %rdx
	movl	$32, %esi
	callq	*_ZN4core9panicking18panic_bounds_check17h7f6539b946f45151E@GOTPCREL(%rip)
	ud2
.LBB89_9:
	leaq	.L__unnamed_122(%rip), %rdi
	leaq	.L__unnamed_124(%rip), %rdx
	movl	$40, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end89:
	.size	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E, .Lfunc_end89-_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E

	.section	.text._ZN7cryptos4ahci4sata8SataDisk3new17hc64c7acabc403755E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci4sata8SataDisk3new17hc64c7acabc403755E,@function
_ZN7cryptos4ahci4sata8SataDisk3new17hc64c7acabc403755E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1592, %rsp
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$1024, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	leaq	824(%rsp), %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, 824(%rsp)
	je	.LBB90_1
	movl	828(%rsp), %ebp
	jmp	.LBB90_7
.LBB90_1:
	movq	832(%rsp), %rbp
	movq	840(%rsp), %r13
	movq	%rbp, (%rsp)
	movq	%r13, 8(%rsp)
	leaq	824(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, 824(%rsp)
	je	.LBB90_3
	movl	828(%rsp), %ebp
	movq	%rsp, %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB90_7:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
.LBB90_119:
	addq	$1592, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB90_3:
	movq	832(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%r13, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%rbp, 696(%rsp)
	movq	%r13, 704(%rsp)
	movq	%r15, 712(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_4
	movl	4(%rsp), %ebp
	jmp	.LBB90_12
.LBB90_4:
	movq	%rbx, 816(%rsp)
	movq	%r14, %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r14
	movq	%rbp, 240(%rsp)
	movq	%r14, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_8
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB90_12:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
.LBB90_112:
	leaq	824(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	*_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip)
	leaq	696(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	jmp	.LBB90_119
.LBB90_8:
	movq	%r15, 40(%rsp)
	movq	%r13, 32(%rsp)
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%rbp, 48(%rsp)
	movq	%r14, 56(%rsp)
	movq	%r15, 64(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_9
	movl	4(%rsp), %ebp
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	jmp	.LBB90_17
.LBB90_9:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	je	.LBB90_13
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB90_17:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
	movq	56(%rsp), %rdx
	movq	64(%rsp), %rsi
	movq	%rsp, %rdi
	callq	*_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip)
	leaq	48(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	jmp	.LBB90_112
.LBB90_13:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 72(%rsp)
	movq	%rbp, 80(%rsp)
	movq	%r15, 88(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_14
	movl	4(%rsp), %ebp
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	jmp	.LBB90_24
.LBB90_14:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	je	.LBB90_18
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB90_24:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
	movq	80(%rsp), %rdx
	movq	88(%rsp), %rsi
	movq	_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip), %r14
	movq	%rsp, %rdi
	callq	*%r14
	movq	_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip), %rbp
.LBB90_25:
	leaq	72(%rsp), %rdi
	callq	*%rbp
	movq	56(%rsp), %rdx
	movq	64(%rsp), %rsi
	movq	%rsp, %rdi
	callq	*%r14
	leaq	48(%rsp), %rdi
	callq	*%rbp
	jmp	.LBB90_112
.LBB90_18:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 96(%rsp)
	movq	%rbp, 104(%rsp)
	movq	%r15, 112(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_19
	movl	4(%rsp), %ebp
	jmp	.LBB90_22
.LBB90_19:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_26
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB90_22:
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
	movq	104(%rsp), %rdx
	movq	112(%rsp), %rsi
	movq	_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip), %r14
	movq	%rsp, %rdi
	callq	*%r14
	movq	_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip), %rbp
	leaq	96(%rsp), %rdi
	callq	*%rbp
	movq	80(%rsp), %rdx
	movq	88(%rsp), %rsi
	movq	%rsp, %rdi
	callq	*%r14
	jmp	.LBB90_25
.LBB90_26:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 120(%rsp)
	movq	%rbp, 128(%rsp)
	movq	%r15, 136(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_27
	movl	4(%rsp), %ebp
	jmp	.LBB90_30
.LBB90_27:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB90_31
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB90_30:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
.LBB90_111:
	leaq	120(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	leaq	96(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	leaq	72(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	leaq	48(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	jmp	.LBB90_112
.LBB90_31:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 144(%rsp)
	movq	%rbp, 152(%rsp)
	movq	%r15, 160(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_33
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_110
.LBB90_33:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 168(%rsp)
	movq	%rcx, 176(%rsp)
	movq	%rdx, 184(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_35
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_109
.LBB90_35:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 192(%rsp)
	movq	%rcx, 200(%rsp)
	movq	%rdx, 208(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_37
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_108
.LBB90_37:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 216(%rsp)
	movq	%rcx, 224(%rsp)
	movq	%rdx, 232(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_39
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_107
.LBB90_39:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 264(%rsp)
	movq	%rcx, 272(%rsp)
	movq	%rdx, 280(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_41
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_106
.LBB90_41:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 288(%rsp)
	movq	%rcx, 296(%rsp)
	movq	%rdx, 304(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_43
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_105
.LBB90_43:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 312(%rsp)
	movq	%rcx, 320(%rsp)
	movq	%rdx, 328(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_45
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_104
.LBB90_45:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 336(%rsp)
	movq	%rcx, 344(%rsp)
	movq	%rdx, 352(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_47
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_103
.LBB90_47:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 360(%rsp)
	movq	%rcx, 368(%rsp)
	movq	%rdx, 376(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_49
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_102
.LBB90_49:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 384(%rsp)
	movq	%rcx, 392(%rsp)
	movq	%rdx, 400(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_51
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_101
.LBB90_51:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 408(%rsp)
	movq	%rcx, 416(%rsp)
	movq	%rdx, 424(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_53
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_100
.LBB90_53:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 432(%rsp)
	movq	%rcx, 440(%rsp)
	movq	%rdx, 448(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_55
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_99
.LBB90_55:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 456(%rsp)
	movq	%rcx, 464(%rsp)
	movq	%rdx, 472(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_57
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_98
.LBB90_57:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 480(%rsp)
	movq	%rcx, 488(%rsp)
	movq	%rdx, 496(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_59
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_97
.LBB90_59:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 504(%rsp)
	movq	%rcx, 512(%rsp)
	movq	%rdx, 520(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_61
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_96
.LBB90_61:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 528(%rsp)
	movq	%rcx, 536(%rsp)
	movq	%rdx, 544(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_63
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_95
.LBB90_63:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 552(%rsp)
	movq	%rcx, 560(%rsp)
	movq	%rdx, 568(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_65
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_94
.LBB90_65:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 576(%rsp)
	movq	%rcx, 584(%rsp)
	movq	%rdx, 592(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_67
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_93
.LBB90_67:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 600(%rsp)
	movq	%rcx, 608(%rsp)
	movq	%rdx, 616(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_69
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_92
.LBB90_69:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 624(%rsp)
	movq	%rcx, 632(%rsp)
	movq	%rdx, 640(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_71
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_91
.LBB90_71:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 648(%rsp)
	movq	%rcx, 656(%rsp)
	movq	%rdx, 664(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_73
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_90
.LBB90_73:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 672(%rsp)
	movq	%rcx, 680(%rsp)
	movq	%rdx, 688(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_75
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_89
.LBB90_75:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 720(%rsp)
	movq	%rcx, 728(%rsp)
	movq	%rdx, 736(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_77
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_88
.LBB90_77:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 744(%rsp)
	movq	%rcx, 752(%rsp)
	movq	%rdx, 760(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_79
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_87
.LBB90_79:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 768(%rsp)
	movq	%rcx, 776(%rsp)
	movq	%rdx, 784(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_81
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_86
.LBB90_81:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 792(%rsp)
	movq	%rcx, 800(%rsp)
	movq	%rdx, 808(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_83
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_85
.LBB90_83:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 240(%rsp)
	movq	%rcx, 248(%rsp)
	movq	%rdx, 256(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB90_113
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	leaq	240(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_85:
	leaq	792(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_86:
	leaq	768(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_87:
	leaq	744(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_88:
	leaq	720(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_89:
	leaq	672(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_90:
	leaq	648(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_91:
	leaq	624(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_92:
	leaq	600(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_93:
	leaq	576(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_94:
	leaq	552(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_95:
	leaq	528(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_96:
	leaq	504(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_97:
	leaq	480(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_98:
	leaq	456(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_99:
	leaq	432(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_100:
	leaq	408(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_101:
	leaq	384(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_102:
	leaq	360(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_103:
	leaq	336(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_104:
	leaq	312(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_105:
	leaq	288(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_106:
	leaq	264(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_107:
	leaq	216(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_108:
	leaq	192(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_109:
	leaq	168(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_110:
	leaq	144(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	jmp	.LBB90_111
.LBB90_113:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	48(%rsp), %rsi
	movq	56(%rsp), %rdi
	movq	%rsi, 824(%rsp)
	movq	%rdi, 832(%rsp)
	movq	64(%rsp), %rsi
	movq	%rsi, 840(%rsp)
	movq	72(%rsp), %rsi
	movq	80(%rsp), %rdi
	movq	%rsi, 848(%rsp)
	movq	%rdi, 856(%rsp)
	movq	88(%rsp), %rsi
	movq	%rsi, 864(%rsp)
	movq	112(%rsp), %rsi
	movq	%rsi, 888(%rsp)
	movq	96(%rsp), %rsi
	movq	104(%rsp), %rdi
	movq	%rdi, 880(%rsp)
	movq	%rsi, 872(%rsp)
	movq	136(%rsp), %rsi
	movq	%rsi, 912(%rsp)
	movq	120(%rsp), %rsi
	movq	128(%rsp), %rdi
	movq	%rdi, 904(%rsp)
	movq	%rsi, 896(%rsp)
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	movq	%rsi, 920(%rsp)
	movq	%rdi, 928(%rsp)
	movq	160(%rsp), %rsi
	movq	%rsi, 936(%rsp)
	movq	168(%rsp), %rsi
	movq	176(%rsp), %rdi
	movq	%rsi, 944(%rsp)
	movq	%rdi, 952(%rsp)
	movq	184(%rsp), %rsi
	movq	%rsi, 960(%rsp)
	movq	208(%rsp), %rsi
	movq	%rsi, 984(%rsp)
	movq	192(%rsp), %rsi
	movq	200(%rsp), %rdi
	movq	%rdi, 976(%rsp)
	movq	%rsi, 968(%rsp)
	movq	232(%rsp), %rsi
	movq	%rsi, 1008(%rsp)
	movq	216(%rsp), %rsi
	movq	224(%rsp), %rdi
	movq	%rdi, 1000(%rsp)
	movq	%rsi, 992(%rsp)
	movq	280(%rsp), %rsi
	movq	%rsi, 1032(%rsp)
	movq	264(%rsp), %rsi
	movq	272(%rsp), %rdi
	movq	%rdi, 1024(%rsp)
	movq	%rsi, 1016(%rsp)
	movq	304(%rsp), %rsi
	movq	%rsi, 1056(%rsp)
	movq	288(%rsp), %rsi
	movq	296(%rsp), %rdi
	movq	%rdi, 1048(%rsp)
	movq	%rsi, 1040(%rsp)
	movq	328(%rsp), %rsi
	movq	%rsi, 1080(%rsp)
	movq	312(%rsp), %rsi
	movq	320(%rsp), %rdi
	movq	%rdi, 1072(%rsp)
	movq	%rsi, 1064(%rsp)
	movq	352(%rsp), %rsi
	movq	%rsi, 1104(%rsp)
	movq	336(%rsp), %rsi
	movq	344(%rsp), %rdi
	movq	%rdi, 1096(%rsp)
	movq	%rsi, 1088(%rsp)
	movq	376(%rsp), %rsi
	movq	%rsi, 1128(%rsp)
	movq	360(%rsp), %rsi
	movq	368(%rsp), %rdi
	movq	%rdi, 1120(%rsp)
	movq	%rsi, 1112(%rsp)
	movq	400(%rsp), %rsi
	movq	%rsi, 1152(%rsp)
	movq	384(%rsp), %rsi
	movq	392(%rsp), %rdi
	movq	%rdi, 1144(%rsp)
	movq	%rsi, 1136(%rsp)
	movq	424(%rsp), %rsi
	movq	%rsi, 1176(%rsp)
	movq	408(%rsp), %rsi
	movq	416(%rsp), %rdi
	movq	%rdi, 1168(%rsp)
	movq	%rsi, 1160(%rsp)
	movq	448(%rsp), %rsi
	movq	%rsi, 1200(%rsp)
	movq	432(%rsp), %rsi
	movq	440(%rsp), %rdi
	movq	%rdi, 1192(%rsp)
	movq	%rsi, 1184(%rsp)
	movq	472(%rsp), %rsi
	movq	%rsi, 1224(%rsp)
	movq	456(%rsp), %rsi
	movq	464(%rsp), %rdi
	movq	%rdi, 1216(%rsp)
	movq	%rsi, 1208(%rsp)
	movq	496(%rsp), %rsi
	movq	%rsi, 1248(%rsp)
	movq	480(%rsp), %rsi
	movq	488(%rsp), %rdi
	movq	%rdi, 1240(%rsp)
	movq	%rsi, 1232(%rsp)
	movq	520(%rsp), %rsi
	movq	%rsi, 1272(%rsp)
	movq	504(%rsp), %rsi
	movq	512(%rsp), %rdi
	movq	%rdi, 1264(%rsp)
	movq	%rsi, 1256(%rsp)
	movq	544(%rsp), %rsi
	movq	%rsi, 1296(%rsp)
	movq	528(%rsp), %rsi
	movq	536(%rsp), %rdi
	movq	%rdi, 1288(%rsp)
	movq	%rsi, 1280(%rsp)
	movq	568(%rsp), %rsi
	movq	%rsi, 1320(%rsp)
	movq	552(%rsp), %rsi
	movq	560(%rsp), %rdi
	movq	%rdi, 1312(%rsp)
	movq	%rsi, 1304(%rsp)
	movq	592(%rsp), %rsi
	movq	%rsi, 1344(%rsp)
	movq	576(%rsp), %rsi
	movq	584(%rsp), %rdi
	movq	%rdi, 1336(%rsp)
	movq	%rsi, 1328(%rsp)
	movq	616(%rsp), %rsi
	movq	%rsi, 1368(%rsp)
	movq	600(%rsp), %rsi
	movq	608(%rsp), %rdi
	movq	%rdi, 1360(%rsp)
	movq	%rsi, 1352(%rsp)
	movq	640(%rsp), %rsi
	movq	%rsi, 1392(%rsp)
	movq	624(%rsp), %rsi
	movq	632(%rsp), %rdi
	movq	%rdi, 1384(%rsp)
	movq	%rsi, 1376(%rsp)
	movq	664(%rsp), %rsi
	movq	%rsi, 1416(%rsp)
	movq	648(%rsp), %rsi
	movq	656(%rsp), %rdi
	movq	%rdi, 1408(%rsp)
	movq	%rsi, 1400(%rsp)
	movq	688(%rsp), %rsi
	movq	%rsi, 1440(%rsp)
	movq	672(%rsp), %rsi
	movq	680(%rsp), %rdi
	movq	%rdi, 1432(%rsp)
	movq	%rsi, 1424(%rsp)
	movq	736(%rsp), %rsi
	movq	%rsi, 1464(%rsp)
	movq	720(%rsp), %rsi
	movq	728(%rsp), %rdi
	movq	%rdi, 1456(%rsp)
	movq	%rsi, 1448(%rsp)
	movq	760(%rsp), %rsi
	movq	%rsi, 1488(%rsp)
	movq	744(%rsp), %rsi
	movq	752(%rsp), %rdi
	movq	%rdi, 1480(%rsp)
	movq	%rsi, 1472(%rsp)
	movq	784(%rsp), %rsi
	movq	%rsi, 1512(%rsp)
	movq	768(%rsp), %rsi
	movq	776(%rsp), %rdi
	movq	%rdi, 1504(%rsp)
	movq	%rsi, 1496(%rsp)
	movq	808(%rsp), %rsi
	movq	%rsi, 1536(%rsp)
	movq	792(%rsp), %rsi
	movq	800(%rsp), %rdi
	movq	%rdi, 1528(%rsp)
	movq	%rsi, 1520(%rsp)
	movq	256(%rsp), %rsi
	movq	%rsi, 1560(%rsp)
	movq	240(%rsp), %rsi
	movq	248(%rsp), %rdi
	movq	%rdi, 1552(%rsp)
	movq	%rsi, 1544(%rsp)
	movq	%rax, 1568(%rsp)
	movq	%rcx, 1576(%rsp)
	movq	%rdx, 1584(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb9146c0bcac8e8edE
	cmpl	$0, (%rsp)
	je	.LBB90_116
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB90_115
.LBB90_116:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 240(%rsp)
	movq	%rcx, 248(%rsp)
	movq	%rdx, 256(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17h8640a7b4a81fcd67E
	cmpl	$0, (%rsp)
	je	.LBB90_118
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	leaq	240(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB90_115:
	leaq	824(%rsp), %rdi
	callq	_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E
	movq	704(%rsp), %r13
	movq	712(%rsp), %r15
	jmp	.LBB90_112
.LBB90_118:
	movq	8(%rsp), %r15
	movq	16(%rsp), %r13
	movq	24(%rsp), %rax
	movq	%rax, 32(%rsp)
	leaq	696(%rsp), %rsi
	leaq	824(%rsp), %r14
	leaq	240(%rsp), %rcx
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4init17h541fe38d68d0bdbbE
	movq	712(%rsp), %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E
	movq	%rdx, %rbp
	testq	%rax, %rax
	cmoveq	%rax, %rbp
	movq	696(%rsp), %rax
	movq	704(%rsp), %rcx
	movq	%rax, 80(%r12)
	movq	%rcx, 88(%r12)
	movq	712(%rsp), %rax
	movq	%rax, 96(%r12)
	leaq	104(%r12), %rdi
	movl	$768, %edx
	movq	%r14, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	240(%rsp), %rax
	movq	248(%rsp), %rcx
	movq	%rax, 872(%r12)
	movq	%rcx, 880(%r12)
	movq	256(%rsp), %rax
	movq	%rax, 888(%r12)
	movq	816(%rsp), %rax
	movq	%rax, 8(%r12)
	movq	%rbx, 16(%r12)
	movq	%rbp, 24(%r12)
	movq	$2, 56(%r12)
	movq	%r15, 896(%r12)
	movq	%r13, 904(%r12)
	movq	32(%rsp), %rax
	movq	%rax, 912(%r12)
	movl	$0, (%r12)
	jmp	.LBB90_119
.Lfunc_end90:
	.size	_ZN7cryptos4ahci4sata8SataDisk3new17hc64c7acabc403755E, .Lfunc_end90-_ZN7cryptos4ahci4sata8SataDisk3new17hc64c7acabc403755E

	.section	.text._ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E,@function
_ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$136, %rsp
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movq	%rdi, 24(%rsp)
	movq	(%rcx), %r12
	movq	8(%rcx), %r8
	movq	16(%rcx), %r13
	shrq	$9, %r13
	movq	24(%rsi), %rdi
	movq	32(%rsi), %rdx
	movq	40(%rsi), %rbp
	movq	48(%rsi), %rax
	movl	56(%rsi), %esi
	movl	60(%rbx), %ecx
	movq	64(%rbx), %r15
	movq	$2, 48(%rbx)
	cmpq	$2, %rax
	movq	%r8, 8(%rsp)
	jne	.LBB91_2
	xorl	%ebp, %ebp
	jmp	.LBB91_10
.LBB91_2:
	cmpq	%r8, %rdi
	jne	.LBB91_4
	cmpq	%rdx, %r13
	jne	.LBB91_4
	cmpq	$1, %rax
	jne	.LBB91_10
	movq	8(%rbx), %rdi
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E
	movl	%eax, %eax
	leaq	.LJTI91_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB91_44:
	movl	$1, %ebp
	movl	$15, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB91_45
	movq	%rax, %rbx
	movq	.L__unnamed_102+7(%rip), %rax
	movq	%rax, 7(%rbx)
	movq	.L__unnamed_102(%rip), %rax
	movq	%rax, (%rbx)
	.p2align	4, 0x90
.LBB91_48:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB91_48
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB91_52
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB91_52
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB91_52:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB91_53:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB91_53
	movl	$0, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB91_55
.LBB91_4:
	movq	%rax, 48(%rbx)
	movl	%ecx, 60(%rbx)
	jmp	.LBB91_41
.LBB91_66:
	movl	$1, %ebp
	movl	$64, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB91_67
	movq	%rax, %rbx
	movq	.L__unnamed_104+56(%rip), %rax
	movq	%rax, 56(%rbx)
	movq	.L__unnamed_104+48(%rip), %rax
	movq	%rax, 48(%rbx)
	movq	.L__unnamed_104+40(%rip), %rax
	movq	%rax, 40(%rbx)
	movq	.L__unnamed_104+32(%rip), %rax
	movq	%rax, 32(%rbx)
	movq	.L__unnamed_104+24(%rip), %rax
	movq	%rax, 24(%rbx)
	movq	.L__unnamed_104+16(%rip), %rax
	movq	%rax, 16(%rbx)
	movq	.L__unnamed_104+8(%rip), %rax
	movq	%rax, 8(%rbx)
	movq	.L__unnamed_104(%rip), %rax
	movq	%rax, (%rbx)
	.p2align	4, 0x90
.LBB91_69:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB91_69
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB91_73
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB91_73
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB91_73:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$64, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$64, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB91_74:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB91_74
	movl	$2, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB91_55
.LBB91_76:
	movl	$1, %ebp
	movl	$65, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB91_77
	movq	%rax, %rbx
	leaq	.L__unnamed_105(%rip), %rsi
	movl	$65, %edx
	movq	%rax, %rdi
	callq	*memcpy@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB91_79:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB91_79
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB91_83
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB91_83
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB91_83:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$65, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$65, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB91_84:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB91_84
	movl	$3, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB91_55
.LBB91_86:
	movl	$1, %ebp
	movl	$41, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB91_87
	movq	%rax, %rbx
	movb	.L__unnamed_125+40(%rip), %al
	movb	%al, 40(%rbx)
	movq	.L__unnamed_125+32(%rip), %rax
	movq	%rax, 32(%rbx)
	movq	.L__unnamed_125+24(%rip), %rax
	movq	%rax, 24(%rbx)
	movq	.L__unnamed_125+16(%rip), %rax
	movq	%rax, 16(%rbx)
	movq	.L__unnamed_125+8(%rip), %rax
	movq	%rax, 8(%rbx)
	movq	.L__unnamed_125(%rip), %rax
	movq	%rax, (%rbx)
	.p2align	4, 0x90
.LBB91_89:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB91_89
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB91_93
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB91_93
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB91_93:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$41, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$41, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB91_94:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB91_94
	movl	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB91_55
.LBB91_56:
	movl	$1, %ebp
	movl	$81, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB91_57
	movq	%rax, %rbx
	leaq	.L__unnamed_103(%rip), %rsi
	movl	$81, %edx
	movq	%rax, %rdi
	callq	*memcpy@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB91_59:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbp, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB91_59
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB91_63
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB91_63
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB91_63:
	movq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$81, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$81, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB91_64:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB91_64
	movl	$1, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
.LBB91_55:
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$5, %edi
	callq	*_ZN7syscall5error5Error3new17hf65ca5f5aa47022dE@GOTPCREL(%rip)
	movq	24(%rsp), %rcx
	movl	%eax, 4(%rcx)
	movl	$1, %eax
	jmp	.LBB91_43
.LBB91_7:
	testq	%r12, %r12
	jne	.LBB91_9
	movq	%rbp, %rsi
	shlq	$9, %rsi
	addq	8(%rsp), %rsi
	movq	904(%rbx), %rdi
	movq	%r15, %rdx
	shlq	$9, %rdx
	callq	*memmove@GOTPCREL(%rip)
.LBB91_9:
	addq	%r15, %rbp
	movq	8(%rsp), %r8
.LBB91_10:
	movq	%r13, %rax
	subq	%rbp, %rax
	jbe	.LBB91_11
	cmpq	$255, %rax
	movl	$255, %edx
	cmovbq	%rax, %rdx
	testq	%r12, %r12
	movq	%rbp, 16(%rsp)
	movq	%rdx, 112(%rsp)
	je	.LBB91_14
	movq	%rbp, %rsi
	shlq	$9, %rsi
	addq	%r8, %rsi
	movq	904(%rbx), %rdi
	shlq	$9, %rdx
	callq	*memmove@GOTPCREL(%rip)
	movq	112(%rsp), %rdx
	movq	16(%rsp), %rbp
	movq	8(%rsp), %r8
.LBB91_14:
	movq	8(%rbx), %r15
	addq	%rbp, %r14
	movq	%r14, 80(%rsp)
	movq	%rdx, 104(%rsp)
	movb	%r12b, 7(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %r14
	movq	(%r14), %rax
	cmpq	$5, %rax
	jae	.LBB91_15
	movq	(%r14), %rax
	cmpq	$5, %rax
	jae	.LBB91_17
.LBB91_18:
	movq	(%r14), %rax
	cmpq	$5, %rax
	jae	.LBB91_19
.LBB91_20:
	movq	(%r14), %rax
	cmpq	$4, %rax
	ja	.LBB91_96
.LBB91_21:
	movq	104(%rsp), %rax
	testq	%rax, %rax
	je	.LBB91_35
.LBB91_22:
	cmpq	$256, %rax
	jbe	.LBB91_23
	movq	(%r14), %rax
	testq	%rax, %rax
	je	.LBB91_38
	leaq	.L__unnamed_126(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 64(%rsp)
	movq	$0, 72(%rsp)
	leaq	.L__unnamed_127(%rip), %rdx
	jmp	.LBB91_37
.LBB91_11:
	shlq	$9, %rbp
	movq	24(%rsp), %rcx
	movq	$1, 8(%rcx)
	movq	%rbp, 16(%rcx)
	jmp	.LBB91_42
.LBB91_15:
	movq	%r15, 128(%rsp)
	leaq	128(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h0338f6cb554ca680E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_128(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	leaq	.L__unnamed_129(%rip), %rdx
	leaq	32(%rsp), %rdi
	movl	$5, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	16(%rsp), %rbp
	movq	8(%rsp), %r8
	movq	(%r14), %rax
	cmpq	$5, %rax
	jb	.LBB91_18
.LBB91_17:
	leaq	80(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17h37bc6141694e846cE@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_130(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	leaq	.L__unnamed_131(%rip), %rdx
	leaq	32(%rsp), %rdi
	movl	$5, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	16(%rsp), %rbp
	movq	8(%rsp), %r8
	movq	(%r14), %rax
	cmpq	$5, %rax
	jb	.LBB91_20
.LBB91_19:
	leaq	104(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_132(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	leaq	.L__unnamed_133(%rip), %rdx
	leaq	32(%rsp), %rdi
	movl	$5, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	16(%rsp), %rbp
	movq	8(%rsp), %r8
	movq	(%r14), %rax
	cmpq	$4, %rax
	jbe	.LBB91_21
.LBB91_96:
	leaq	7(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	_ZN41_$LT$bool$u20$as$u20$core..fmt..Debug$GT$3fmt17heff99ea20215d47eE(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_134(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	leaq	.L__unnamed_135(%rip), %rdx
	leaq	32(%rsp), %rdi
	movl	$5, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	16(%rsp), %rbp
	movq	8(%rsp), %r8
	movq	104(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB91_22
.LBB91_35:
	movq	(%r14), %rax
	testq	%rax, %rax
	je	.LBB91_38
	leaq	.L__unnamed_136(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 64(%rsp)
	movq	$0, 72(%rsp)
	leaq	.L__unnamed_137(%rip), %rdx
.LBB91_37:
	leaq	32(%rsp), %rdi
	movl	$1, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	16(%rsp), %rbp
	movq	8(%rsp), %r8
.LBB91_38:
.LBB91_39:
	xorl	%eax, %eax
.LBB91_40:
	movq	%r8, 24(%rbx)
	movq	%r13, 32(%rbx)
	movq	%rbp, 40(%rbx)
	movq	%rax, 48(%rbx)
	movl	%r14d, 56(%rbx)
	movq	112(%rsp), %rax
	movq	%rax, 64(%rbx)
.LBB91_41:
	movq	24(%rsp), %rcx
	movq	$0, 8(%rcx)
.LBB91_42:
	xorl	%eax, %eax
.LBB91_43:
	movl	%eax, (%rcx)
	addq	$136, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB91_23:
	movq	88(%rbx), %rbp
	movq	%r15, %rdi
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4slot17h6fef77646ce5e1a2E
	movl	%edx, %r14d
	cmpl	$1, %eax
	jne	.LBB91_24
	movl	%r14d, %edi
	cmpl	$31, %r14d
	ja	.LBB91_97
	movq	%rdi, %r12
	shlq	$5, %r12
	movb	$5, (%rbp,%r12)
	leaq	(%rdi,%rdi,2), %rax
	movq	%rbp, 120(%rsp)
	movq	112(%rbx,%rax,8), %rbp
	leaq	1(%rbp), %rdi
	movl	$1048703, %edx
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	120(%rsp), %rcx
	movb	$39, (%rbp)
	cmpb	$0, 7(%rsp)
	je	.LBB91_28
	leaq	(%rcx,%r12), %rax
	orb	$-64, (%rax)
.LBB91_28:
	movw	$1, 2(%rcx,%r12)
	leaq	888(%rbx), %rdi
	callq	*_ZN7syscall2io3dma7PhysBox7address17h801088c8bf5f7a85E@GOTPCREL(%rip)
	movq	%rax, 128(%rbp)
	movl	104(%rsp), %eax
	shll	$9, %eax
	orl	$1, %eax
	movl	%eax, 140(%rbp)
	movb	$-128, 1(%rbp)
	movb	7(%rsp), %al
	shlb	$4, %al
	orb	$37, %al
	movb	%al, 2(%rbp)
	movb	80(%rsp), %al
	movb	%al, 4(%rbp)
	movb	81(%rsp), %al
	movb	%al, 5(%rbp)
	movb	82(%rsp), %al
	movb	%al, 6(%rbp)
	movb	$64, 7(%rbp)
	movq	80(%rsp), %rax
	movq	%rax, %rcx
	shrq	$24, %rcx
	movb	%cl, 8(%rbp)
	cmpq	$33, %rax
	setae	9(%rbp)
	shrq	$40, %rax
	movb	%al, 10(%rbp)
	movq	104(%rsp), %rax
	movb	%al, 12(%rbp)
	movb	%ah, 13(%rbp)
	.p2align	4, 0x90
.LBB91_29:
	movl	32(%r15), %eax
	notl	%eax
	testb	$-120, %al
	je	.LBB91_29
	movl	$1, %eax
	movl	%r14d, %ecx
	shll	%cl, %eax
	orl	%eax, 56(%r15)
	movq	8(%rsp), %r8
	movq	16(%rsp), %rbp
	.p2align	4, 0x90
.LBB91_31:
	testl	$32768, 24(%r15)
	jne	.LBB91_31
	orl	$17, 24(%r15)
	movl	$1, %eax
	jmp	.LBB91_40
.LBB91_24:
	movq	8(%rsp), %r8
	movq	16(%rsp), %rbp
	jmp	.LBB91_39
.LBB91_97:
	leaq	.L__unnamed_116(%rip), %rdx
	movl	$32, %esi
	callq	*_ZN4core9panicking18panic_bounds_check17h7f6539b946f45151E@GOTPCREL(%rip)
	ud2
.LBB91_45:
	movl	$15, %edi
	jmp	.LBB91_46
.LBB91_67:
	movl	$64, %edi
	jmp	.LBB91_46
.LBB91_77:
	movl	$65, %edi
	jmp	.LBB91_46
.LBB91_87:
	movl	$41, %edi
	jmp	.LBB91_46
.LBB91_57:
	movl	$81, %edi
.LBB91_46:
	movl	$1, %esi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end91:
	.size	_ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E, .Lfunc_end91-_ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E
	.section	.rodata._ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E,"a",@progbits
	.p2align	2
.LJTI91_0:
	.long	.LBB91_44-.LJTI91_0
	.long	.LBB91_56-.LJTI91_0
	.long	.LBB91_66-.LJTI91_0
	.long	.LBB91_76-.LJTI91_0
	.long	.LBB91_86-.LJTI91_0
	.long	.LBB91_7-.LJTI91_0

	.section	".text._ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$2id17h3ac9995b8a0a165aE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$2id17h3ac9995b8a0a165aE,@function
_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$2id17h3ac9995b8a0a165aE:
	movq	(%rdi), %rax
	retq
.Lfunc_end92:
	.size	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$2id17h3ac9995b8a0a165aE, .Lfunc_end92-_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$2id17h3ac9995b8a0a165aE

	.section	".text._ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4size17hfa6520d0654e5028E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4size17hfa6520d0654e5028E,@function
_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4size17hfa6520d0654e5028E:
	movq	16(%rdi), %rax
	retq
.Lfunc_end93:
	.size	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4size17hfa6520d0654e5028E, .Lfunc_end93-_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4size17hfa6520d0654e5028E

	.section	".text._ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4read17h6c015b82e161daedE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4read17h6c015b82e161daedE,@function
_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4read17h6c015b82e161daedE:
	pushq	%rbx
	subq	$32, %rsp
	movq	%rdi, %rbx
	movq	%rcx, 16(%rsp)
	movq	%r8, 24(%rsp)
	movq	$0, 8(%rsp)
	leaq	8(%rsp), %rcx
	callq	_ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	retq
.Lfunc_end94:
	.size	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4read17h6c015b82e161daedE, .Lfunc_end94-_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4read17h6c015b82e161daedE

	.section	".text._ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$5write17hfcd4340d7caf4021E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$5write17hfcd4340d7caf4021E,@function
_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$5write17hfcd4340d7caf4021E:
	pushq	%rbx
	subq	$32, %rsp
	movq	%rdi, %rbx
	movq	%rcx, 16(%rsp)
	movq	%r8, 24(%rsp)
	movq	$1, 8(%rsp)
	leaq	8(%rsp), %rcx
	callq	_ZN7cryptos4ahci4sata8SataDisk7request17he133ff422d1cc618E
	movq	%rbx, %rax
	addq	$32, %rsp
	popq	%rbx
	retq
.Lfunc_end95:
	.size	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$5write17hfcd4340d7caf4021E, .Lfunc_end95-_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$5write17hfcd4340d7caf4021E

	.section	".text._ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17hfa72892bbaba06b2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17hfa72892bbaba06b2E,@function
_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17hfa72892bbaba06b2E:
	movabsq	$2199023255552, %rax
	retq
.Lfunc_end96:
	.size	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17hfa72892bbaba06b2E, .Lfunc_end96-_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17hfa72892bbaba06b2E

	.section	".text._ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h5b0b6a4c6f109bccE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h5b0b6a4c6f109bccE,@function
_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h5b0b6a4c6f109bccE:
	movq	8(%rdi), %rax
	movl	%esi, 16(%rax)
	retq
.Lfunc_end97:
	.size	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h5b0b6a4c6f109bccE, .Lfunc_end97-_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h5b0b6a4c6f109bccE

	.section	".text._ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hd7ece94927294c83E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hd7ece94927294c83E,@function
_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hd7ece94927294c83E:
	movq	8(%rdi), %rax
	movl	16(%rax), %eax
	retq
.Lfunc_end98:
	.size	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hd7ece94927294c83E, .Lfunc_end98-_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hd7ece94927294c83E

	.section	.text._ZN7cryptos4ahci6satapi19SataPacketInterface3new17h3957f64dc4fbe2f4E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci6satapi19SataPacketInterface3new17h3957f64dc4fbe2f4E,@function
_ZN7cryptos4ahci6satapi19SataPacketInterface3new17h3957f64dc4fbe2f4E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1592, %rsp
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movq	%rdi, %r12
	movl	$1024, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	leaq	824(%rsp), %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, 824(%rsp)
	je	.LBB99_1
	movl	828(%rsp), %ebp
	jmp	.LBB99_7
.LBB99_1:
	movq	832(%rsp), %rbp
	movq	840(%rsp), %r13
	movq	%rbp, (%rsp)
	movq	%r13, 8(%rsp)
	leaq	824(%rsp), %rdi
	movl	$1, %ecx
	movq	%rbp, %rsi
	movq	%r13, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, 824(%rsp)
	je	.LBB99_3
	movl	828(%rsp), %ebp
	movq	%rsp, %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB99_7:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
.LBB99_119:
	addq	$1592, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB99_3:
	movq	832(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%r13, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%rbp, 696(%rsp)
	movq	%r13, 704(%rsp)
	movq	%r15, 712(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_4
	movl	4(%rsp), %ebp
	jmp	.LBB99_12
.LBB99_4:
	movq	%rbx, 816(%rsp)
	movq	%r14, %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r14
	movq	%rbp, 240(%rsp)
	movq	%r14, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%rbp, %rsi
	movq	%r14, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_8
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB99_12:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
.LBB99_112:
	leaq	824(%rsp), %rdi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	*_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip)
	leaq	696(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	jmp	.LBB99_119
.LBB99_8:
	movq	%r15, 40(%rsp)
	movq	%r13, 32(%rsp)
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%rbp, 48(%rsp)
	movq	%r14, 56(%rsp)
	movq	%r15, 64(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_9
	movl	4(%rsp), %ebp
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	jmp	.LBB99_17
.LBB99_9:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	je	.LBB99_13
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB99_17:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
	movq	56(%rsp), %rdx
	movq	64(%rsp), %rsi
	movq	%rsp, %rdi
	callq	*_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip)
	leaq	48(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
	jmp	.LBB99_112
.LBB99_13:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 72(%rsp)
	movq	%rbp, 80(%rsp)
	movq	%r15, 88(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_14
	movl	4(%rsp), %ebp
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	jmp	.LBB99_24
.LBB99_14:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	je	.LBB99_18
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB99_24:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
	movq	80(%rsp), %rdx
	movq	88(%rsp), %rsi
	movq	_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip), %r14
	movq	%rsp, %rdi
	callq	*%r14
	movq	_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip), %rbp
.LBB99_25:
	leaq	72(%rsp), %rdi
	callq	*%rbp
	movq	56(%rsp), %rdx
	movq	64(%rsp), %rsi
	movq	%rsp, %rdi
	callq	*%r14
	leaq	48(%rsp), %rdi
	callq	*%rbp
	jmp	.LBB99_112
.LBB99_18:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 96(%rsp)
	movq	%rbp, 104(%rsp)
	movq	%r15, 112(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_19
	movl	4(%rsp), %ebp
	jmp	.LBB99_22
.LBB99_19:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_26
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB99_22:
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
	movq	104(%rsp), %rdx
	movq	112(%rsp), %rsi
	movq	_ZN7syscall4call6funmap17h31efb4e81bbafd7cE@GOTPCREL(%rip), %r14
	movq	%rsp, %rdi
	callq	*%r14
	movq	_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip), %rbp
	leaq	96(%rsp), %rdi
	callq	*%rbp
	movq	80(%rsp), %rdx
	movq	88(%rsp), %rsi
	movq	%rsp, %rdi
	callq	*%r14
	jmp	.LBB99_25
.LBB99_26:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 120(%rsp)
	movq	%rbp, 128(%rsp)
	movq	%r15, 136(%rsp)
	movl	$1048704, %edi
	callq	*_ZN7syscall2io3dma8round_up17ha412460a634485afE@GOTPCREL(%rip)
	movq	%rsp, %rdi
	movq	%rax, %rsi
	callq	*_ZN7syscall2io3dma7PhysBox3new17h8a0082b01e5da4a4E@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_27
	movl	4(%rsp), %ebp
	jmp	.LBB99_30
.LBB99_27:
	movq	8(%rsp), %r14
	movq	16(%rsp), %rbp
	movq	%r14, 240(%rsp)
	movq	%rbp, 248(%rsp)
	movq	%rsp, %rdi
	movl	$1, %ecx
	movq	%r14, %rsi
	movq	%rbp, %rdx
	callq	*_ZN7syscall4call7physmap17hc78d376be676025aE@GOTPCREL(%rip)
	cmpl	$0, (%rsp)
	je	.LBB99_31
	movl	4(%rsp), %ebp
	leaq	240(%rsp), %rdi
	callq	*_ZN67_$LT$syscall..io..dma..PhysBox$u20$as$u20$core..ops..drop..Drop$GT$4drop17hcb31aca3518df5daE@GOTPCREL(%rip)
.LBB99_30:
	movl	%ebp, 4(%r12)
	movl	$1, (%r12)
.LBB99_111:
	leaq	120(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	leaq	96(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	leaq	72(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	leaq	48(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	movq	32(%rsp), %r13
	movq	40(%rsp), %r15
	jmp	.LBB99_112
.LBB99_31:
	movq	8(%rsp), %r15
	movq	%r15, %rdi
	xorl	%esi, %esi
	movq	%rbp, %rdx
	callq	*memset@GOTPCREL(%rip)
	movq	%r14, 144(%rsp)
	movq	%rbp, 152(%rsp)
	movq	%r15, 160(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_33
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_110
.LBB99_33:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 168(%rsp)
	movq	%rcx, 176(%rsp)
	movq	%rdx, 184(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_35
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_109
.LBB99_35:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 192(%rsp)
	movq	%rcx, 200(%rsp)
	movq	%rdx, 208(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_37
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_108
.LBB99_37:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 216(%rsp)
	movq	%rcx, 224(%rsp)
	movq	%rdx, 232(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_39
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_107
.LBB99_39:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 264(%rsp)
	movq	%rcx, 272(%rsp)
	movq	%rdx, 280(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_41
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_106
.LBB99_41:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 288(%rsp)
	movq	%rcx, 296(%rsp)
	movq	%rdx, 304(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_43
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_105
.LBB99_43:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 312(%rsp)
	movq	%rcx, 320(%rsp)
	movq	%rdx, 328(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_45
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_104
.LBB99_45:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 336(%rsp)
	movq	%rcx, 344(%rsp)
	movq	%rdx, 352(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_47
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_103
.LBB99_47:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 360(%rsp)
	movq	%rcx, 368(%rsp)
	movq	%rdx, 376(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_49
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_102
.LBB99_49:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 384(%rsp)
	movq	%rcx, 392(%rsp)
	movq	%rdx, 400(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_51
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_101
.LBB99_51:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 408(%rsp)
	movq	%rcx, 416(%rsp)
	movq	%rdx, 424(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_53
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_100
.LBB99_53:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 432(%rsp)
	movq	%rcx, 440(%rsp)
	movq	%rdx, 448(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_55
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_99
.LBB99_55:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 456(%rsp)
	movq	%rcx, 464(%rsp)
	movq	%rdx, 472(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_57
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_98
.LBB99_57:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 480(%rsp)
	movq	%rcx, 488(%rsp)
	movq	%rdx, 496(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_59
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_97
.LBB99_59:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 504(%rsp)
	movq	%rcx, 512(%rsp)
	movq	%rdx, 520(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_61
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_96
.LBB99_61:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 528(%rsp)
	movq	%rcx, 536(%rsp)
	movq	%rdx, 544(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_63
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_95
.LBB99_63:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 552(%rsp)
	movq	%rcx, 560(%rsp)
	movq	%rdx, 568(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_65
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_94
.LBB99_65:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 576(%rsp)
	movq	%rcx, 584(%rsp)
	movq	%rdx, 592(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_67
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_93
.LBB99_67:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 600(%rsp)
	movq	%rcx, 608(%rsp)
	movq	%rdx, 616(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_69
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_92
.LBB99_69:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 624(%rsp)
	movq	%rcx, 632(%rsp)
	movq	%rdx, 640(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_71
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_91
.LBB99_71:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 648(%rsp)
	movq	%rcx, 656(%rsp)
	movq	%rdx, 664(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_73
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_90
.LBB99_73:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 672(%rsp)
	movq	%rcx, 680(%rsp)
	movq	%rdx, 688(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_75
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_89
.LBB99_75:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 720(%rsp)
	movq	%rcx, 728(%rsp)
	movq	%rdx, 736(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_77
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_88
.LBB99_77:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 744(%rsp)
	movq	%rcx, 752(%rsp)
	movq	%rdx, 760(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_79
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_87
.LBB99_79:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 768(%rsp)
	movq	%rcx, 776(%rsp)
	movq	%rdx, 784(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_81
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_86
.LBB99_81:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 792(%rsp)
	movq	%rcx, 800(%rsp)
	movq	%rdx, 808(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_83
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_85
.LBB99_83:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 240(%rsp)
	movq	%rcx, 248(%rsp)
	movq	%rdx, 256(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb43f5eff63cf9399E
	cmpl	$0, (%rsp)
	je	.LBB99_113
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	leaq	240(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_85:
	leaq	792(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_86:
	leaq	768(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_87:
	leaq	744(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_88:
	leaq	720(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_89:
	leaq	672(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_90:
	leaq	648(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_91:
	leaq	624(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_92:
	leaq	600(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_93:
	leaq	576(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_94:
	leaq	552(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_95:
	leaq	528(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_96:
	leaq	504(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_97:
	leaq	480(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_98:
	leaq	456(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_99:
	leaq	432(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_100:
	leaq	408(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_101:
	leaq	384(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_102:
	leaq	360(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_103:
	leaq	336(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_104:
	leaq	312(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_105:
	leaq	288(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_106:
	leaq	264(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_107:
	leaq	216(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_108:
	leaq	192(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_109:
	leaq	168(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_110:
	leaq	144(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
	jmp	.LBB99_111
.LBB99_113:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	48(%rsp), %rsi
	movq	56(%rsp), %rdi
	movq	%rsi, 824(%rsp)
	movq	%rdi, 832(%rsp)
	movq	64(%rsp), %rsi
	movq	%rsi, 840(%rsp)
	movq	72(%rsp), %rsi
	movq	80(%rsp), %rdi
	movq	%rsi, 848(%rsp)
	movq	%rdi, 856(%rsp)
	movq	88(%rsp), %rsi
	movq	%rsi, 864(%rsp)
	movq	112(%rsp), %rsi
	movq	%rsi, 888(%rsp)
	movq	96(%rsp), %rsi
	movq	104(%rsp), %rdi
	movq	%rdi, 880(%rsp)
	movq	%rsi, 872(%rsp)
	movq	136(%rsp), %rsi
	movq	%rsi, 912(%rsp)
	movq	120(%rsp), %rsi
	movq	128(%rsp), %rdi
	movq	%rdi, 904(%rsp)
	movq	%rsi, 896(%rsp)
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	movq	%rsi, 920(%rsp)
	movq	%rdi, 928(%rsp)
	movq	160(%rsp), %rsi
	movq	%rsi, 936(%rsp)
	movq	168(%rsp), %rsi
	movq	176(%rsp), %rdi
	movq	%rsi, 944(%rsp)
	movq	%rdi, 952(%rsp)
	movq	184(%rsp), %rsi
	movq	%rsi, 960(%rsp)
	movq	208(%rsp), %rsi
	movq	%rsi, 984(%rsp)
	movq	192(%rsp), %rsi
	movq	200(%rsp), %rdi
	movq	%rdi, 976(%rsp)
	movq	%rsi, 968(%rsp)
	movq	232(%rsp), %rsi
	movq	%rsi, 1008(%rsp)
	movq	216(%rsp), %rsi
	movq	224(%rsp), %rdi
	movq	%rdi, 1000(%rsp)
	movq	%rsi, 992(%rsp)
	movq	280(%rsp), %rsi
	movq	%rsi, 1032(%rsp)
	movq	264(%rsp), %rsi
	movq	272(%rsp), %rdi
	movq	%rdi, 1024(%rsp)
	movq	%rsi, 1016(%rsp)
	movq	304(%rsp), %rsi
	movq	%rsi, 1056(%rsp)
	movq	288(%rsp), %rsi
	movq	296(%rsp), %rdi
	movq	%rdi, 1048(%rsp)
	movq	%rsi, 1040(%rsp)
	movq	328(%rsp), %rsi
	movq	%rsi, 1080(%rsp)
	movq	312(%rsp), %rsi
	movq	320(%rsp), %rdi
	movq	%rdi, 1072(%rsp)
	movq	%rsi, 1064(%rsp)
	movq	352(%rsp), %rsi
	movq	%rsi, 1104(%rsp)
	movq	336(%rsp), %rsi
	movq	344(%rsp), %rdi
	movq	%rdi, 1096(%rsp)
	movq	%rsi, 1088(%rsp)
	movq	376(%rsp), %rsi
	movq	%rsi, 1128(%rsp)
	movq	360(%rsp), %rsi
	movq	368(%rsp), %rdi
	movq	%rdi, 1120(%rsp)
	movq	%rsi, 1112(%rsp)
	movq	400(%rsp), %rsi
	movq	%rsi, 1152(%rsp)
	movq	384(%rsp), %rsi
	movq	392(%rsp), %rdi
	movq	%rdi, 1144(%rsp)
	movq	%rsi, 1136(%rsp)
	movq	424(%rsp), %rsi
	movq	%rsi, 1176(%rsp)
	movq	408(%rsp), %rsi
	movq	416(%rsp), %rdi
	movq	%rdi, 1168(%rsp)
	movq	%rsi, 1160(%rsp)
	movq	448(%rsp), %rsi
	movq	%rsi, 1200(%rsp)
	movq	432(%rsp), %rsi
	movq	440(%rsp), %rdi
	movq	%rdi, 1192(%rsp)
	movq	%rsi, 1184(%rsp)
	movq	472(%rsp), %rsi
	movq	%rsi, 1224(%rsp)
	movq	456(%rsp), %rsi
	movq	464(%rsp), %rdi
	movq	%rdi, 1216(%rsp)
	movq	%rsi, 1208(%rsp)
	movq	496(%rsp), %rsi
	movq	%rsi, 1248(%rsp)
	movq	480(%rsp), %rsi
	movq	488(%rsp), %rdi
	movq	%rdi, 1240(%rsp)
	movq	%rsi, 1232(%rsp)
	movq	520(%rsp), %rsi
	movq	%rsi, 1272(%rsp)
	movq	504(%rsp), %rsi
	movq	512(%rsp), %rdi
	movq	%rdi, 1264(%rsp)
	movq	%rsi, 1256(%rsp)
	movq	544(%rsp), %rsi
	movq	%rsi, 1296(%rsp)
	movq	528(%rsp), %rsi
	movq	536(%rsp), %rdi
	movq	%rdi, 1288(%rsp)
	movq	%rsi, 1280(%rsp)
	movq	568(%rsp), %rsi
	movq	%rsi, 1320(%rsp)
	movq	552(%rsp), %rsi
	movq	560(%rsp), %rdi
	movq	%rdi, 1312(%rsp)
	movq	%rsi, 1304(%rsp)
	movq	592(%rsp), %rsi
	movq	%rsi, 1344(%rsp)
	movq	576(%rsp), %rsi
	movq	584(%rsp), %rdi
	movq	%rdi, 1336(%rsp)
	movq	%rsi, 1328(%rsp)
	movq	616(%rsp), %rsi
	movq	%rsi, 1368(%rsp)
	movq	600(%rsp), %rsi
	movq	608(%rsp), %rdi
	movq	%rdi, 1360(%rsp)
	movq	%rsi, 1352(%rsp)
	movq	640(%rsp), %rsi
	movq	%rsi, 1392(%rsp)
	movq	624(%rsp), %rsi
	movq	632(%rsp), %rdi
	movq	%rdi, 1384(%rsp)
	movq	%rsi, 1376(%rsp)
	movq	664(%rsp), %rsi
	movq	%rsi, 1416(%rsp)
	movq	648(%rsp), %rsi
	movq	656(%rsp), %rdi
	movq	%rdi, 1408(%rsp)
	movq	%rsi, 1400(%rsp)
	movq	688(%rsp), %rsi
	movq	%rsi, 1440(%rsp)
	movq	672(%rsp), %rsi
	movq	680(%rsp), %rdi
	movq	%rdi, 1432(%rsp)
	movq	%rsi, 1424(%rsp)
	movq	736(%rsp), %rsi
	movq	%rsi, 1464(%rsp)
	movq	720(%rsp), %rsi
	movq	728(%rsp), %rdi
	movq	%rdi, 1456(%rsp)
	movq	%rsi, 1448(%rsp)
	movq	760(%rsp), %rsi
	movq	%rsi, 1488(%rsp)
	movq	744(%rsp), %rsi
	movq	752(%rsp), %rdi
	movq	%rdi, 1480(%rsp)
	movq	%rsi, 1472(%rsp)
	movq	784(%rsp), %rsi
	movq	%rsi, 1512(%rsp)
	movq	768(%rsp), %rsi
	movq	776(%rsp), %rdi
	movq	%rdi, 1504(%rsp)
	movq	%rsi, 1496(%rsp)
	movq	808(%rsp), %rsi
	movq	%rsi, 1536(%rsp)
	movq	792(%rsp), %rsi
	movq	800(%rsp), %rdi
	movq	%rdi, 1528(%rsp)
	movq	%rsi, 1520(%rsp)
	movq	256(%rsp), %rsi
	movq	%rsi, 1560(%rsp)
	movq	240(%rsp), %rsi
	movq	248(%rsp), %rdi
	movq	%rdi, 1552(%rsp)
	movq	%rsi, 1544(%rsp)
	movq	%rax, 1568(%rsp)
	movq	%rcx, 1576(%rsp)
	movq	%rdx, 1584(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17hb9146c0bcac8e8edE
	cmpl	$0, (%rsp)
	je	.LBB99_116
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	jmp	.LBB99_115
.LBB99_116:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	%rax, 240(%rsp)
	movq	%rcx, 248(%rsp)
	movq	%rdx, 256(%rsp)
	movq	%rsp, %rdi
	callq	_ZN7syscall2io3dma12Dma$LT$T$GT$6zeroed17h8640a7b4a81fcd67E
	cmpl	$0, (%rsp)
	je	.LBB99_118
	movl	4(%rsp), %eax
	movl	%eax, 4(%r12)
	movl	$1, (%r12)
	leaq	240(%rsp), %rdi
	callq	_ZN4core3ptr75drop_in_place$LT$syscall..io..dma..Dma$LT$$u5b$u8$u3b$$u20$256$u5d$$GT$$GT$17hf114ca58377e687eE
.LBB99_115:
	leaq	824(%rsp), %rdi
	callq	_ZN4core3ptr112drop_in_place$LT$$u5b$syscall..io..dma..Dma$LT$cryptos..ahci..hba..structs..HbaCmdTable$GT$$u3b$$u20$32$u5d$$GT$17h06ee201b9a330397E
	movq	704(%rsp), %r13
	movq	712(%rsp), %r15
	jmp	.LBB99_112
.LBB99_118:
	movq	8(%rsp), %r15
	movq	16(%rsp), %r13
	movq	24(%rsp), %rax
	movq	%rax, 32(%rsp)
	leaq	696(%rsp), %rsi
	leaq	824(%rsp), %r14
	leaq	240(%rsp), %rcx
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$4init17h541fe38d68d0bdbbE
	movq	712(%rsp), %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$8identify17h6a03285e5230bfc2E
	movq	%rdx, %rbp
	testq	%rax, %rax
	cmoveq	%rax, %rbp
	movq	696(%rsp), %rax
	movq	704(%rsp), %rcx
	movq	%rax, 32(%r12)
	movq	%rcx, 40(%r12)
	movq	712(%rsp), %rax
	movq	%rax, 48(%r12)
	leaq	56(%r12), %rdi
	movl	$768, %edx
	movq	%r14, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	240(%rsp), %rax
	movq	248(%rsp), %rcx
	movq	%rax, 824(%r12)
	movq	%rcx, 832(%r12)
	movq	256(%rsp), %rax
	movq	%rax, 840(%r12)
	movq	816(%rsp), %rax
	movq	%rax, 8(%r12)
	movq	%rbx, 16(%r12)
	movq	%rbp, 24(%r12)
	movq	%r15, 848(%r12)
	movq	%r13, 856(%r12)
	movq	32(%rsp), %rax
	movq	%rax, 864(%r12)
	movl	$0, (%r12)
	jmp	.LBB99_119
.Lfunc_end99:
	.size	_ZN7cryptos4ahci6satapi19SataPacketInterface3new17h3957f64dc4fbe2f4E, .Lfunc_end99-_ZN7cryptos4ahci6satapi19SataPacketInterface3new17h3957f64dc4fbe2f4E

	.section	.text._ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E,@function
_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	$0, 8(%rsp)
	movq	$0, 1(%rsp)
	movb	$37, (%rsp)
	leaq	48(%rsi), %r8
	leaq	840(%rsi), %r9
	movq	8(%rsi), %rdi
	movq	40(%rsi), %rcx
	movq	%rsp, %rsi
	movl	$8, %edx
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E
	movl	%eax, %eax
	leaq	.LJTI100_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB100_3:
	movl	$1, %ebx
	movl	$15, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB100_4
	movq	%rax, %r15
	movq	.L__unnamed_102+7(%rip), %rax
	movq	%rax, 7(%r15)
	movq	.L__unnamed_102(%rip), %rax
	movq	%rax, (%r15)
	.p2align	4, 0x90
.LBB100_7:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB100_7
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB100_11
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB100_11
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB100_11:
	movq	%r15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %edx
	.p2align	4, 0x90
.LBB100_12:
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rdx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB100_12
	jmp	.LBB100_53
.LBB100_23:
	movl	$1, %ebx
	movl	$64, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB100_24
	movq	%rax, %r15
	movq	.L__unnamed_104+56(%rip), %rax
	movq	%rax, 56(%r15)
	movq	.L__unnamed_104+48(%rip), %rax
	movq	%rax, 48(%r15)
	movq	.L__unnamed_104+40(%rip), %rax
	movq	%rax, 40(%r15)
	movq	.L__unnamed_104+32(%rip), %rax
	movq	%rax, 32(%r15)
	movq	.L__unnamed_104+24(%rip), %rax
	movq	%rax, 24(%r15)
	movq	.L__unnamed_104+16(%rip), %rax
	movq	%rax, 16(%r15)
	movq	.L__unnamed_104+8(%rip), %rax
	movq	%rax, 8(%r15)
	movq	.L__unnamed_104(%rip), %rax
	movq	%rax, (%r15)
	.p2align	4, 0x90
.LBB100_26:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB100_26
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB100_30
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB100_30
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB100_30:
	movq	%r15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$64, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$64, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB100_31:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB100_31
	movl	$2, %ecx
	jmp	.LBB100_53
.LBB100_33:
	movl	$1, %ebx
	movl	$65, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB100_34
	movq	%rax, %r15
	leaq	.L__unnamed_105(%rip), %rsi
	movl	$65, %edx
	movq	%rax, %rdi
	callq	*memcpy@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB100_36:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB100_36
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB100_40
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB100_40
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB100_40:
	movq	%r15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$65, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$65, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB100_41:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB100_41
	movl	$3, %ecx
	jmp	.LBB100_53
.LBB100_43:
	movl	$1, %ebx
	movl	$41, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB100_44
	movq	%rax, %r15
	movb	.L__unnamed_125+40(%rip), %al
	movb	%al, 40(%r15)
	movq	.L__unnamed_125+32(%rip), %rax
	movq	%rax, 32(%r15)
	movq	.L__unnamed_125+24(%rip), %rax
	movq	%rax, 24(%r15)
	movq	.L__unnamed_125+16(%rip), %rax
	movq	%rax, 16(%r15)
	movq	.L__unnamed_125+8(%rip), %rax
	movq	%rax, 8(%r15)
	movq	.L__unnamed_125(%rip), %rax
	movq	%rax, (%r15)
	.p2align	4, 0x90
.LBB100_46:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB100_46
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB100_50
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB100_50
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB100_50:
	movq	%r15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$41, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$41, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB100_51:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB100_51
	movl	$4, %ecx
	jmp	.LBB100_53
.LBB100_13:
	movl	$1, %ebx
	movl	$81, %edi
	movl	$1, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB100_14
	movq	%rax, %r15
	leaq	.L__unnamed_103(%rip), %rsi
	movl	$81, %edx
	movq	%rax, %rdi
	callq	*memcpy@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB100_16:
	xorl	%eax, %eax
	lock		cmpxchgq	%rbx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB100_16
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	testq	%rdi, %rdi
	je	.LBB100_20
	movq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip), %rsi
	testq	%rsi, %rsi
	jle	.LBB100_20
	movq	%rsi, %rdx
	notq	%rdx
	shrq	$63, %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB100_20:
	movq	%r15, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	movq	$81, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	$81, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	.p2align	4, 0x90
.LBB100_21:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB100_21
	movl	$1, %ecx
.LBB100_53:
	movl	%ecx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$5, %edi
	callq	*_ZN7syscall5error5Error3new17hf65ca5f5aa47022dE@GOTPCREL(%rip)
	movl	%eax, 4(%r14)
	movl	$1, (%r14)
.LBB100_2:
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB100_1:
	movq	856(%rbx), %rax
	movl	(%rax), %ecx
	movl	4(%rax), %eax
	bswapl	%ecx
	addl	$1, %ecx
	bswapl	%eax
	movl	%ecx, 4(%r14)
	movl	%eax, 8(%r14)
	movl	$0, (%r14)
	jmp	.LBB100_2
.LBB100_4:
	movl	$15, %edi
	jmp	.LBB100_5
.LBB100_24:
	movl	$64, %edi
	jmp	.LBB100_5
.LBB100_34:
	movl	$65, %edi
	jmp	.LBB100_5
.LBB100_44:
	movl	$41, %edi
	jmp	.LBB100_5
.LBB100_14:
	movl	$81, %edi
.LBB100_5:
	movl	$1, %esi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end100:
	.size	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E, .Lfunc_end100-_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	.section	.rodata._ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E,"a",@progbits
	.p2align	2
.LJTI100_0:
	.long	.LBB100_3-.LJTI100_0
	.long	.LBB100_13-.LJTI100_0
	.long	.LBB100_23-.LJTI100_0
	.long	.LBB100_33-.LJTI100_0
	.long	.LBB100_43-.LJTI100_0
	.long	.LBB100_1-.LJTI100_0

	.section	".text._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$2id17h94f8cf6360dae590E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$2id17h94f8cf6360dae590E,@function
_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$2id17h94f8cf6360dae590E:
	movq	(%rdi), %rax
	retq
.Lfunc_end101:
	.size	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$2id17h94f8cf6360dae590E, .Lfunc_end101-_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$2id17h94f8cf6360dae590E

	.section	".text._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4size17hb58db37b873ace22E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4size17hb58db37b873ace22E,@function
_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4size17hb58db37b873ace22E:
	subq	$24, %rsp
	movq	%rdi, %rsi
	leaq	8(%rsp), %rdi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	movl	12(%rsp), %eax
	movl	16(%rsp), %ecx
	imulq	%rax, %rcx
	xorl	%eax, %eax
	cmpl	$0, 8(%rsp)
	cmoveq	%rcx, %rax
	addq	$24, %rsp
	retq
.Lfunc_end102:
	.size	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4size17hb58db37b873ace22E, .Lfunc_end102-_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4size17hb58db37b873ace22E

	.section	".text._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4read17h72502a8e09a7dc1dE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4read17h72502a8e09a7dc1dE,@function
_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4read17h72502a8e09a7dc1dE:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	movq	%r8, %rbp
	movq	%rcx, %r15
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r13
	movq	%rsp, %rdi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	xorl	%eax, %eax
	cmpl	$0, (%rsp)
	sete	%al
	movl	4(%rsp,%rax,4), %ecx
	jne	.LBB103_3
	testl	%ecx, %ecx
	je	.LBB103_78
	movl	%ebp, %eax
	xorl	%edx, %edx
	divl	%ecx
	movl	%eax, %ebp
	movq	%rsp, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	cmpl	$0, (%rsp)
	leaq	4(%rsp), %rax
	leaq	8(%rsp), %rcx
	cmoveq	%rcx, %rax
	movl	(%rax), %ecx
	je	.LBB103_6
.LBB103_3:
	movl	%ecx, 4(%r13)
.LBB103_4:
	movl	$1, (%r13)
.LBB103_5:
	movq	%r13, %rax
	addq	$104, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB103_6:
	movq	%rbx, 72(%rsp)
	testl	%ecx, %ecx
	je	.LBB103_79
	xorl	%r12d, %r12d
	movl	$131072, %eax
	xorl	%edx, %edx
	divl	%ecx
	movl	%eax, %ebx
	movq	%rsp, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	cmpl	$0, (%rsp)
	leaq	4(%rsp), %rax
	leaq	8(%rsp), %rcx
	cmoveq	%rcx, %rax
	movl	(%rax), %edx
	je	.LBB103_9
	movl	%edx, 4(%r13)
	jmp	.LBB103_4
.LBB103_9:
	movq	%r13, 24(%rsp)
	movq	%r15, 64(%rsp)
	imull	%ebx, %edx
	cmpl	%ebx, %ebp
	movq	%rbp, 56(%rsp)
	movl	%ebx, %ecx
	jae	.LBB103_17
.LBB103_10:
	cmpl	%r12d, %ebp
	jbe	.LBB103_27
	movq	72(%rsp), %rax
	addl	%r12d, %eax
	movq	$0, 37(%rsp)
	movq	$0, 44(%rsp)
	movb	$40, 36(%rsp)
	bswapl	%eax
	movl	%eax, 38(%rsp)
	rolw	$8, %cx
	movw	%cx, 43(%rsp)
	leaq	48(%r14), %r8
	leaq	840(%r14), %r9
	movq	8(%r14), %rdi
	movq	40(%r14), %rcx
	leaq	36(%rsp), %rsi
	movl	%edx, %ebp
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E
	movl	%eax, %eax
	leaq	.LJTI103_1(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB103_12:
	leaq	.L__unnamed_102(%rip), %rsi
	movq	%rsp, %rdi
	movl	$15, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB103_13:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_13
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_15:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_15
	movl	$0, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB103_74
.LBB103_17:
	leaq	48(%r14), %rax
	movq	%rax, 96(%rsp)
	leaq	840(%r14), %rax
	movq	%rax, 88(%rsp)
	movl	%edx, %eax
	movq	%rax, 80(%rsp)
	xorl	%r15d, %r15d
	movl	%ebp, %eax
	movl	%ecx, 52(%rsp)
.LBB103_18:
	movq	72(%rsp), %rcx
	addl	%r15d, %ecx
	leaq	37(%rsp), %rsi
	movq	$0, 7(%rsi)
	movq	$0, (%rsi)
	movb	$40, 36(%rsp)
	bswapl	%ecx
	rolw	$8, %ax
	movl	%ecx, 38(%rsp)
	movw	%ax, 43(%rsp)
	movq	8(%r14), %rdi
	movq	40(%r14), %rcx
	leaq	36(%rsp), %rsi
	movl	%edx, %ebx
	movq	96(%rsp), %r8
	movq	88(%rsp), %r9
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E
	cmpl	$5, %eax
	jne	.LBB103_22
	movq	856(%r14), %rbp
	movq	%rsp, %r13
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	xorl	%eax, %eax
	cmpl	$0, (%rsp)
	sete	%al
	movl	4(%rsp,%rax,4), %r12d
	jne	.LBB103_53
	movl	%r12d, %eax
	movl	%r15d, %edi
	imulq	%rax, %rdi
	addq	64(%rsp), %rdi
	movq	%rbp, %rsi
	movq	80(%rsp), %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	cmpl	$0, (%rsp)
	leaq	4(%rsp), %rax
	leaq	8(%rsp), %rcx
	cmoveq	%rcx, %rax
	movl	(%rax), %r12d
	jne	.LBB103_53
	addl	%r15d, %r12d
	movq	56(%rsp), %rbp
	movl	%ebp, %eax
	subl	%r12d, %eax
	movl	%r12d, %r15d
	movl	52(%rsp), %ecx
	cmpl	%ecx, %eax
	movl	%ebx, %edx
	jae	.LBB103_18
	jmp	.LBB103_10
.LBB103_22:
	movl	%eax, %eax
	leaq	.LJTI103_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB103_23:
	leaq	.L__unnamed_102(%rip), %rsi
	movq	%rsp, %rdi
	movl	$15, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_24:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_24
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %edx
.LBB103_26:
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rdx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_26
	jmp	.LBB103_51
.LBB103_27:
	movl	%r12d, %ebp
.LBB103_28:
	movq	24(%rsp), %r13
	movq	%r14, %rdi
	callq	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E
	movq	%rax, %rcx
	shrq	$32, %rcx
	testl	%eax, %eax
	je	.LBB103_30
	movl	%ecx, 4(%r13)
	jmp	.LBB103_4
.LBB103_53:
	movq	24(%rsp), %r13
	movl	%r12d, 4(%r13)
	jmp	.LBB103_4
.LBB103_30:
	imull	%ecx, %ebp
	movq	$1, 8(%r13)
	movq	%rbp, 16(%r13)
	movl	$0, (%r13)
	jmp	.LBB103_5
.LBB103_31:
	leaq	.L__unnamed_103(%rip), %rsi
	movq	%rsp, %rdi
	movl	$81, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_32:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_32
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB103_34:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_34
	movl	$1, %ecx
	jmp	.LBB103_51
.LBB103_36:
	leaq	.L__unnamed_104(%rip), %rsi
	movq	%rsp, %rdi
	movl	$64, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_37:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_37
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB103_39:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_39
	movl	$2, %ecx
	jmp	.LBB103_51
.LBB103_41:
	leaq	.L__unnamed_105(%rip), %rsi
	movq	%rsp, %rdi
	movl	$65, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_42:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_42
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB103_44:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_44
	movl	$3, %ecx
	jmp	.LBB103_51
.LBB103_46:
	leaq	.L__unnamed_125(%rip), %rsi
	movq	%rsp, %rdi
	movl	$41, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_47:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_47
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB103_49:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_49
	movl	$4, %ecx
.LBB103_51:
	movl	%ecx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$5, %edi
	callq	*_ZN7syscall5error5Error3new17hf65ca5f5aa47022dE@GOTPCREL(%rip)
	movl	%eax, %r12d
	movl	%eax, 4(%r13)
	jmp	.LBB103_4
.LBB103_54:
	leaq	.L__unnamed_103(%rip), %rsi
	movq	%rsp, %rdi
	movl	$81, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB103_55:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_55
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_57:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_57
	movl	$1, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB103_74
.LBB103_59:
	leaq	.L__unnamed_104(%rip), %rsi
	movq	%rsp, %rdi
	movl	$64, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB103_60:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_60
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_62:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_62
	movl	$2, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB103_74
.LBB103_64:
	leaq	.L__unnamed_105(%rip), %rsi
	movq	%rsp, %rdi
	movl	$65, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB103_65:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_65
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_67:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_67
	movl	$3, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB103_74
.LBB103_69:
	leaq	.L__unnamed_125(%rip), %rsi
	movq	%rsp, %rdi
	movl	$41, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB103_70:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB103_70
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB103_72:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB103_72
	movl	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
.LBB103_74:
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$5, %edi
	callq	*_ZN7syscall5error5Error3new17hf65ca5f5aa47022dE@GOTPCREL(%rip)
	movl	%eax, 4(%r13)
	jmp	.LBB103_4
.LBB103_75:
	movq	856(%r14), %rbx
	movq	%r14, %rdi
	callq	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E
	movq	%rax, %rcx
	shrq	$32, %rax
	testl	%ecx, %ecx
	je	.LBB103_77
	movq	24(%rsp), %r13
	movl	%eax, 4(%r13)
	jmp	.LBB103_4
.LBB103_77:
	movl	%r12d, %ecx
	imulq	%rcx, %rax
	movq	64(%rsp), %rdi
	addq	%rax, %rdi
	movl	%ebp, %edx
	movq	%rbx, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	56(%rsp), %rbp
	jmp	.LBB103_28
.LBB103_78:
	leaq	str.1(%rip), %rdi
	leaq	.L__unnamed_138(%rip), %rdx
	jmp	.LBB103_80
.LBB103_79:
	leaq	str.1(%rip), %rdi
	leaq	.L__unnamed_139(%rip), %rdx
.LBB103_80:
	movl	$25, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end103:
	.size	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4read17h72502a8e09a7dc1dE, .Lfunc_end103-_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4read17h72502a8e09a7dc1dE
	.section	".rodata._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4read17h72502a8e09a7dc1dE","a",@progbits
	.p2align	2
.LJTI103_0:
	.long	.LBB103_23-.LJTI103_0
	.long	.LBB103_31-.LJTI103_0
	.long	.LBB103_36-.LJTI103_0
	.long	.LBB103_41-.LJTI103_0
	.long	.LBB103_46-.LJTI103_0
.LJTI103_1:
	.long	.LBB103_12-.LJTI103_1
	.long	.LBB103_54-.LJTI103_1
	.long	.LBB103_59-.LJTI103_1
	.long	.LBB103_64-.LJTI103_1
	.long	.LBB103_69-.LJTI103_1
	.long	.LBB103_75-.LJTI103_1

	.section	".text._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$5write17h7254cb8ae50b8e13E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$5write17h7254cb8ae50b8e13E,@function
_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$5write17h7254cb8ae50b8e13E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	movq	%r8, %rbp
	movq	%rcx, %r15
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r13
	movq	%rsp, %rdi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	xorl	%eax, %eax
	cmpl	$0, (%rsp)
	sete	%al
	movl	4(%rsp,%rax,4), %ecx
	jne	.LBB104_3
	testl	%ecx, %ecx
	je	.LBB104_78
	movl	%ebp, %eax
	xorl	%edx, %edx
	divl	%ecx
	movl	%eax, %ebp
	movq	%rsp, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	cmpl	$0, (%rsp)
	leaq	4(%rsp), %rax
	leaq	8(%rsp), %rcx
	cmoveq	%rcx, %rax
	movl	(%rax), %ecx
	je	.LBB104_6
.LBB104_3:
	movl	%ecx, 4(%r13)
.LBB104_4:
	movl	$1, (%r13)
.LBB104_5:
	movq	%r13, %rax
	addq	$104, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB104_6:
	movq	%rbx, 72(%rsp)
	testl	%ecx, %ecx
	je	.LBB104_79
	xorl	%r12d, %r12d
	movl	$131072, %eax
	xorl	%edx, %edx
	divl	%ecx
	movl	%eax, %ebx
	movq	%rsp, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	cmpl	$0, (%rsp)
	leaq	4(%rsp), %rax
	leaq	8(%rsp), %rcx
	cmoveq	%rcx, %rax
	movl	(%rax), %edx
	je	.LBB104_9
	movl	%edx, 4(%r13)
	jmp	.LBB104_4
.LBB104_9:
	movq	%r13, 24(%rsp)
	movq	%r15, 64(%rsp)
	imull	%ebx, %edx
	cmpl	%ebx, %ebp
	movq	%rbp, 56(%rsp)
	movl	%ebx, %ecx
	jae	.LBB104_17
.LBB104_10:
	cmpl	%r12d, %ebp
	jbe	.LBB104_27
	movq	72(%rsp), %rax
	addl	%r12d, %eax
	movq	$0, 37(%rsp)
	movq	$0, 44(%rsp)
	movb	$42, 36(%rsp)
	bswapl	%eax
	movl	%eax, 38(%rsp)
	rolw	$8, %cx
	movw	%cx, 43(%rsp)
	leaq	48(%r14), %r8
	leaq	840(%r14), %r9
	movq	8(%r14), %rdi
	movq	40(%r14), %rcx
	leaq	36(%rsp), %rsi
	movl	%edx, %ebp
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E
	movl	%eax, %eax
	leaq	.LJTI104_1(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB104_12:
	leaq	.L__unnamed_102(%rip), %rsi
	movq	%rsp, %rdi
	movl	$15, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB104_13:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_13
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_15:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_15
	movl	$0, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB104_74
.LBB104_17:
	leaq	48(%r14), %rax
	movq	%rax, 96(%rsp)
	leaq	840(%r14), %rax
	movq	%rax, 88(%rsp)
	movl	%edx, %eax
	movq	%rax, 80(%rsp)
	xorl	%r15d, %r15d
	movl	%ebp, %eax
	movl	%ecx, 52(%rsp)
.LBB104_18:
	movq	72(%rsp), %rcx
	addl	%r15d, %ecx
	leaq	37(%rsp), %rsi
	movq	$0, 7(%rsi)
	movq	$0, (%rsi)
	movb	$42, 36(%rsp)
	bswapl	%ecx
	rolw	$8, %ax
	movl	%ecx, 38(%rsp)
	movw	%ax, 43(%rsp)
	movq	8(%r14), %rdi
	movq	40(%r14), %rcx
	leaq	36(%rsp), %rsi
	movl	%edx, %ebx
	movq	96(%rsp), %r8
	movq	88(%rsp), %r9
	callq	_ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E
	cmpl	$5, %eax
	jne	.LBB104_22
	movq	856(%r14), %rbp
	movq	%rsp, %r13
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	xorl	%eax, %eax
	cmpl	$0, (%rsp)
	sete	%al
	movl	4(%rsp,%rax,4), %r12d
	jne	.LBB104_53
	movl	%r12d, %eax
	movl	%r15d, %edi
	imulq	%rax, %rdi
	addq	64(%rsp), %rdi
	movq	%rbp, %rsi
	movq	80(%rsp), %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	cmpl	$0, (%rsp)
	leaq	4(%rsp), %rax
	leaq	8(%rsp), %rcx
	cmoveq	%rcx, %rax
	movl	(%rax), %r12d
	jne	.LBB104_53
	addl	%r15d, %r12d
	movq	56(%rsp), %rbp
	movl	%ebp, %eax
	subl	%r12d, %eax
	movl	%r12d, %r15d
	movl	52(%rsp), %ecx
	cmpl	%ecx, %eax
	movl	%ebx, %edx
	jae	.LBB104_18
	jmp	.LBB104_10
.LBB104_22:
	movl	%eax, %eax
	leaq	.LJTI104_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB104_23:
	leaq	.L__unnamed_102(%rip), %rsi
	movq	%rsp, %rdi
	movl	$15, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_24:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_24
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %edx
.LBB104_26:
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rdx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_26
	jmp	.LBB104_51
.LBB104_27:
	movl	%r12d, %ebp
.LBB104_28:
	movq	24(%rsp), %r13
	movq	%r14, %rdi
	callq	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E
	movq	%rax, %rcx
	shrq	$32, %rcx
	testl	%eax, %eax
	je	.LBB104_30
	movl	%ecx, 4(%r13)
	jmp	.LBB104_4
.LBB104_53:
	movq	24(%rsp), %r13
	movl	%r12d, 4(%r13)
	jmp	.LBB104_4
.LBB104_30:
	imull	%ecx, %ebp
	movq	$1, 8(%r13)
	movq	%rbp, 16(%r13)
	movl	$0, (%r13)
	jmp	.LBB104_5
.LBB104_31:
	leaq	.L__unnamed_103(%rip), %rsi
	movq	%rsp, %rdi
	movl	$81, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_32:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_32
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB104_34:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_34
	movl	$1, %ecx
	jmp	.LBB104_51
.LBB104_36:
	leaq	.L__unnamed_104(%rip), %rsi
	movq	%rsp, %rdi
	movl	$64, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_37:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_37
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB104_39:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_39
	movl	$2, %ecx
	jmp	.LBB104_51
.LBB104_41:
	leaq	.L__unnamed_105(%rip), %rsi
	movq	%rsp, %rdi
	movl	$65, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_42:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_42
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB104_44:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_44
	movl	$3, %ecx
	jmp	.LBB104_51
.LBB104_46:
	leaq	.L__unnamed_125(%rip), %rsi
	movq	%rsp, %rdi
	movl	$41, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_47:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_47
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
.LBB104_49:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_49
	movl	$4, %ecx
.LBB104_51:
	movl	%ecx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$5, %edi
	callq	*_ZN7syscall5error5Error3new17hf65ca5f5aa47022dE@GOTPCREL(%rip)
	movl	%eax, %r12d
	movl	%eax, 4(%r13)
	jmp	.LBB104_4
.LBB104_54:
	leaq	.L__unnamed_103(%rip), %rsi
	movq	%rsp, %rdi
	movl	$81, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB104_55:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_55
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_57:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_57
	movl	$1, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB104_74
.LBB104_59:
	leaq	.L__unnamed_104(%rip), %rsi
	movq	%rsp, %rdi
	movl	$64, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB104_60:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_60
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_62:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_62
	movl	$2, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB104_74
.LBB104_64:
	leaq	.L__unnamed_105(%rip), %rsi
	movq	%rsp, %rdi
	movl	$65, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB104_65:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_65
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_67:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_67
	movl	$3, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
	jmp	.LBB104_74
.LBB104_69:
	leaq	.L__unnamed_125(%rip), %rsi
	movq	%rsp, %rdi
	movl	$41, %edx
	callq	_ZN5alloc5slice64_$LT$impl$u20$alloc..borrow..ToOwned$u20$for$u20$$u5b$T$u5d$$GT$8to_owned17hb11109c7e333cbe1E
	movl	$1, %ecx
.LBB104_70:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jne	.LBB104_70
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rdi
	callq	_ZN4core3ptr70drop_in_place$LT$core..option..Option$LT$alloc..string..String$GT$$GT$17haca67a0a28a76eafE
	movq	16(%rsp), %rax
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+24(%rip)
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+16(%rip)
	movq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$1, %ecx
	movq	24(%rsp), %r13
.LBB104_72:
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	jne	.LBB104_72
	movl	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip)
.LBB104_74:
	lock		andq	$-4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$5, %edi
	callq	*_ZN7syscall5error5Error3new17hf65ca5f5aa47022dE@GOTPCREL(%rip)
	movl	%eax, 4(%r13)
	jmp	.LBB104_4
.LBB104_75:
	movq	856(%r14), %rbx
	movq	%r14, %rdi
	callq	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E
	movq	%rax, %rcx
	shrq	$32, %rax
	testl	%ecx, %ecx
	je	.LBB104_77
	movq	24(%rsp), %r13
	movl	%eax, 4(%r13)
	jmp	.LBB104_4
.LBB104_77:
	movl	%r12d, %ecx
	imulq	%rcx, %rax
	movq	64(%rsp), %rdi
	addq	%rax, %rdi
	movl	%ebp, %edx
	movq	%rbx, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	56(%rsp), %rbp
	jmp	.LBB104_28
.LBB104_78:
	leaq	str.1(%rip), %rdi
	leaq	.L__unnamed_140(%rip), %rdx
	jmp	.LBB104_80
.LBB104_79:
	leaq	str.1(%rip), %rdi
	leaq	.L__unnamed_141(%rip), %rdx
.LBB104_80:
	movl	$25, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end104:
	.size	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$5write17h7254cb8ae50b8e13E, .Lfunc_end104-_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$5write17h7254cb8ae50b8e13E
	.section	".rodata._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$5write17h7254cb8ae50b8e13E","a",@progbits
	.p2align	2
.LJTI104_0:
	.long	.LBB104_23-.LJTI104_0
	.long	.LBB104_31-.LJTI104_0
	.long	.LBB104_36-.LJTI104_0
	.long	.LBB104_41-.LJTI104_0
	.long	.LBB104_46-.LJTI104_0
.LJTI104_1:
	.long	.LBB104_12-.LJTI104_1
	.long	.LBB104_54-.LJTI104_1
	.long	.LBB104_59-.LJTI104_1
	.long	.LBB104_64-.LJTI104_1
	.long	.LBB104_69-.LJTI104_1
	.long	.LBB104_75-.LJTI104_1

	.section	".text._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E,@function
_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E:
	subq	$24, %rsp
	movq	%rdi, %rsi
	leaq	8(%rsp), %rdi
	callq	_ZN7cryptos4ahci6satapi19SataPacketInterface8read_cap17h862cde4f81849ef6E
	movl	8(%rsp), %ecx
	xorl	%eax, %eax
	testq	%rcx, %rcx
	sete	%al
	movl	12(%rsp,%rax,4), %eax
	shlq	$32, %rax
	orq	%rcx, %rax
	addq	$24, %rsp
	retq
.Lfunc_end105:
	.size	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E, .Lfunc_end105-_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E

	.section	".text._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h627f7b2a11f1eb6bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h627f7b2a11f1eb6bE,@function
_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h627f7b2a11f1eb6bE:
	movq	8(%rdi), %rax
	movl	%esi, 16(%rax)
	retq
.Lfunc_end106:
	.size	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h627f7b2a11f1eb6bE, .Lfunc_end106-_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h627f7b2a11f1eb6bE

	.section	".text._ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hbf3f2186a90ff66dE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hbf3f2186a90ff66dE,@function
_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hbf3f2186a90ff66dE:
	movq	8(%rdi), %rax
	movl	16(%rax), %eax
	retq
.Lfunc_end107:
	.size	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hbf3f2186a90ff66dE, .Lfunc_end107-_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hbf3f2186a90ff66dE

	.section	".text._ZN158_$LT$cryptos..cralloc..frames..Falloc$u20$as$u20$x86_64..structures..paging..frame_alloc..FrameAllocator$LT$x86_64..structures..paging..page..Size4KiB$GT$$GT$14allocate_frame17h0f5bd85b586659d5E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN158_$LT$cryptos..cralloc..frames..Falloc$u20$as$u20$x86_64..structures..paging..frame_alloc..FrameAllocator$LT$x86_64..structures..paging..page..Size4KiB$GT$$GT$14allocate_frame17h0f5bd85b586659d5E,@function
_ZN158_$LT$cryptos..cralloc..frames..Falloc$u20$as$u20$x86_64..structures..paging..frame_alloc..FrameAllocator$LT$x86_64..structures..paging..page..Size4KiB$GT$$GT$14allocate_frame17h0f5bd85b586659d5E:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	movq	(%rsi), %rdi
	callq	*_ZN80_$LT$bootloader..boot_info..MemoryRegions$u20$as$u20$core..ops..deref..Deref$GT$5deref17hc22198d550a683b6E@GOTPCREL(%rip)
	leaq	(%rdx,%rdx,2), %rcx
	leaq	(%rax,%rcx,8), %rdx
	movq	8(%r15), %r10
	movb	$2, %bl
	xorl	%r9d, %r9d
	xorl	%edi, %edi
.LBB108_1:
	cmpq	%r10, %rdi
	je	.LBB108_13
	addq	$1, %rdi
	testb	%bl, %bl
	je	.LBB108_8
.LBB108_4:
	cmpb	$2, %bl
	je	.LBB108_9
	jmp	.LBB108_5
	.p2align	4, 0x90
.LBB108_8:
	addq	$4095, %rsi
	jb	.LBB108_9
.LBB108_5:
	cmpq	%r8, %rsi
	jb	.LBB108_6
.LBB108_9:
	testq	%rax, %rax
	je	.LBB108_24
	.p2align	4, 0x90
.LBB108_10:
	cmpq	%rdx, %rax
	je	.LBB108_24
	leaq	24(%rax), %rcx
	cmpl	$0, 16(%rax)
	movq	%rcx, %rax
	jne	.LBB108_10
	movq	-24(%rcx), %rsi
	movq	-16(%rcx), %r8
	movb	$1, %bl
	movq	%rcx, %rax
	testb	%bl, %bl
	jne	.LBB108_4
	jmp	.LBB108_8
.LBB108_6:
	leaq	1(%rsi), %rcx
	xorl	%ebx, %ebx
	shrq	$52, %rsi
	movq	%rcx, %rsi
	je	.LBB108_1
.LBB108_7:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
	.p2align	4, 0x90
.LBB108_20:
	cmpq	%rdx, %rax
	je	.LBB108_23
	leaq	24(%rax), %rcx
	cmpl	$0, 16(%rax)
	movq	%rcx, %rax
	jne	.LBB108_20
	movq	-24(%rcx), %rsi
	movq	-16(%rcx), %r8
	movb	$1, %bl
	movq	%rcx, %rax
.LBB108_13:
	testb	%bl, %bl
	je	.LBB108_18
	cmpb	$2, %bl
	je	.LBB108_19
	jmp	.LBB108_15
.LBB108_18:
	addq	$4095, %rsi
	jb	.LBB108_19
.LBB108_15:
	cmpq	%r8, %rsi
	jb	.LBB108_16
.LBB108_19:
	testq	%rax, %rax
	jne	.LBB108_20
.LBB108_23:
	xorl	%r9d, %r9d
.LBB108_24:
	movq	%r9, (%r14)
	addq	$1, %r10
	movq	%r10, 8(%r15)
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.LBB108_16:
	movq	%rsi, %rax
	shrq	$52, %rax
	jne	.LBB108_7
	andq	$-4096, %rsi
	movq	%rsi, 8(%r14)
	movl	$1, %r9d
	jmp	.LBB108_24
.Lfunc_end108:
	.size	_ZN158_$LT$cryptos..cralloc..frames..Falloc$u20$as$u20$x86_64..structures..paging..frame_alloc..FrameAllocator$LT$x86_64..structures..paging..page..Size4KiB$GT$$GT$14allocate_frame17h0f5bd85b586659d5E, .Lfunc_end108-_ZN158_$LT$cryptos..cralloc..frames..Falloc$u20$as$u20$x86_64..structures..paging..frame_alloc..FrameAllocator$LT$x86_64..structures..paging..page..Size4KiB$GT$$GT$14allocate_frame17h0f5bd85b586659d5E

	.section	.text._ZN7cryptos10interrupts5timer17ha266d846786d7f80E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts5timer17ha266d846786d7f80E,@function
_ZN7cryptos10interrupts5timer17ha266d846786d7f80E:
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	cld
	lock		addq	$1, _ZN7cryptos10interrupts10TICK_COUNT17h3a5a3930a2c7f489E(%rip)
	movb	$1, %cl
	.p2align	4, 0x90
.LBB109_1:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	je	.LBB109_3
.LBB109_2:
	movzbl	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip), %eax
	testb	%al, %al
	jne	.LBB109_2
	jmp	.LBB109_1
.LBB109_3:
	cmpl	$2, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip)
	je	.LBB109_4
	leaq	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip), %rdi
	callq	*_ZN6x2apic5lapic9LocalApic16end_of_interrupt17h46ea2c2846374065E@GOTPCREL(%rip)
	movb	$0, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	popq	%rax
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	iretq
.LBB109_4:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_142(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end109:
	.size	_ZN7cryptos10interrupts5timer17ha266d846786d7f80E, .Lfunc_end109-_ZN7cryptos10interrupts5timer17ha266d846786d7f80E

	.section	.text._ZN7cryptos10interrupts8spurious17h3ca489531f11108dE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts8spurious17h3ca489531f11108dE,@function
_ZN7cryptos10interrupts8spurious17h3ca489531f11108dE:
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$48, %rsp
	cld
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB110_1
	leaq	.L__unnamed_143(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_144(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB110_1:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB110_2:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	je	.LBB110_4
.LBB110_3:
	movzbl	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip), %eax
	testb	%al, %al
	jne	.LBB110_3
	jmp	.LBB110_2
.LBB110_4:
	cmpl	$2, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip)
	je	.LBB110_7
	leaq	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip), %rdi
	callq	*_ZN6x2apic5lapic9LocalApic16end_of_interrupt17h46ea2c2846374065E@GOTPCREL(%rip)
	movb	$0, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	addq	$48, %rsp
	popq	%rax
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	iretq
.LBB110_7:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_145(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end110:
	.size	_ZN7cryptos10interrupts8spurious17h3ca489531f11108dE, .Lfunc_end110-_ZN7cryptos10interrupts8spurious17h3ca489531f11108dE

	.section	.text._ZN7cryptos10interrupts9lapic_err17h896d0c5d0cc01ae1E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts9lapic_err17h896d0c5d0cc01ae1E,@function
_ZN7cryptos10interrupts9lapic_err17h896d0c5d0cc01ae1E:
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$48, %rsp
	cld
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.LBB111_1
	leaq	.L__unnamed_146(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_147(%rip), %rdx
	movq	%rsp, %rdi
	movl	$1, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB111_1:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB111_2:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	je	.LBB111_4
.LBB111_3:
	movzbl	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip), %eax
	testb	%al, %al
	jne	.LBB111_3
	jmp	.LBB111_2
.LBB111_4:
	cmpl	$2, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip)
	je	.LBB111_7
	leaq	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip), %rdi
	callq	*_ZN6x2apic5lapic9LocalApic16end_of_interrupt17h46ea2c2846374065E@GOTPCREL(%rip)
	movb	$0, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	addq	$48, %rsp
	popq	%rax
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	iretq
.LBB111_7:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_148(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.Lfunc_end111:
	.size	_ZN7cryptos10interrupts9lapic_err17h896d0c5d0cc01ae1E, .Lfunc_end111-_ZN7cryptos10interrupts9lapic_err17h896d0c5d0cc01ae1E

	.section	.text._ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E,@function
_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rbx
	pushq	%rax
	subq	$80, %rsp
	cld
	movabsq	$9223372036854775804, %r14
	jmp	.LBB112_1
	.p2align	4, 0x90
.LBB112_7:
	movl	_ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+8(%rip), %eax
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	cmpl	$1, %eax
	je	.LBB112_8
.LBB112_1:
	movq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB112_8
	.p2align	4, 0x90
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_3
.LBB112_5:
	testb	$3, %al
	je	.LBB112_7
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	cmpq	%r14, %rax
	jbe	.LBB112_5
.LBB112_3:
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	jmp	.LBB112_4
	.p2align	4, 0x90
.LBB112_10:
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
.LBB112_8:
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_3
	testb	$3, %al
	jne	.LBB112_10
	movl	_ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+8(%rip), %ecx
	movl	_ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+12(%rip), %edx
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	movl	$1, %esi
	.p2align	4, 0x90
.LBB112_12:
	xorl	%eax, %eax
	lock		cmpxchgq	%rsi, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	jne	.LBB112_12
	movl	%ecx, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+8(%rip)
	movl	%edx, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+12(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	movq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB112_23
	cmpq	$1, %rax
	je	.LBB112_21
	cmpq	$3, %rax
	je	.LBB112_16
	.p2align	4, 0x90
.LBB112_18:
	movq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB112_23
	cmpq	$3, %rax
	jne	.LBB112_18
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	leaq	32(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
	.p2align	4, 0x90
.LBB112_23:
	movl	$1, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+8(%rip)
	jne	.LBB112_23
	movq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+32(%rip), %r15
	testq	%r15, %r15
	je	.LBB112_31
	movq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+16(%rip), %rbp
	shlq	$4, %r15
	addq	%rbp, %r15
	leaq	.LJTI112_0(%rip), %r12
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %r13
	jmp	.LBB112_26
	.p2align	4, 0x90
.LBB112_38:
	movq	(%rbp), %rdi
	movq	8(%rbp), %rcx
	movl	%eax, %esi
	callq	*72(%rcx)
	movq	%rbx, %rbp
	cmpq	%rbx, %r15
	je	.LBB112_31
.LBB112_26:
	movq	(%rbp), %rdi
	movq	8(%rbp), %rax
	callq	*64(%rax)
	movl	$4, %ecx
	lock		xaddq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	cmpq	%r14, %rcx
	ja	.LBB112_30
	leaq	16(%rbp), %rbx
	.p2align	4, 0x90
.LBB112_28:
	testb	$3, %cl
	je	.LBB112_34
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$4, %ecx
	lock		xaddq	%rcx, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	cmpq	%r14, %rcx
	jbe	.LBB112_28
	jmp	.LBB112_30
	.p2align	4, 0x90
.LBB112_34:
	movl	_ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip), %ecx
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	cmpl	$5, %ecx
	je	.LBB112_38
	.p2align	4, 0x90
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_30
.LBB112_36:
	testb	$3, %al
	je	.LBB112_40
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	cmpq	%r14, %rax
	jbe	.LBB112_36
	jmp	.LBB112_30
	.p2align	4, 0x90
.LBB112_40:
	movl	_ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E+8(%rip), %eax
	movslq	(%r12,%rax,4), %rax
	addq	%r12, %rax
	jmpq	*%rax
.LBB112_65:
	movq	(%r13), %rax
	testq	%rax, %rax
	je	.LBB112_49
	.p2align	4, 0x90
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_44
.LBB112_67:
	testb	$3, %al
	je	.LBB112_69
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	jbe	.LBB112_67
	jmp	.LBB112_44
.LBB112_60:
	movq	(%r13), %rax
	testq	%rax, %rax
	je	.LBB112_49
	.p2align	4, 0x90
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_44
.LBB112_62:
	testb	$3, %al
	je	.LBB112_64
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	jbe	.LBB112_62
	jmp	.LBB112_44
.LBB112_55:
	movq	(%r13), %rax
	testq	%rax, %rax
	je	.LBB112_49
	.p2align	4, 0x90
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_44
.LBB112_57:
	testb	$3, %al
	je	.LBB112_59
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	jbe	.LBB112_57
	jmp	.LBB112_44
.LBB112_50:
	movq	(%r13), %rax
	testq	%rax, %rax
	je	.LBB112_49
	.p2align	4, 0x90
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_44
.LBB112_52:
	testb	$3, %al
	je	.LBB112_54
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	jbe	.LBB112_52
	jmp	.LBB112_44
.LBB112_42:
	movq	(%r13), %rax
	testq	%rax, %rax
	je	.LBB112_49
	.p2align	4, 0x90
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	ja	.LBB112_44
.LBB112_45:
	testb	$3, %al
	je	.LBB112_47
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	movl	$4, %eax
	lock		xaddq	%rax, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	cmpq	%r14, %rax
	jbe	.LBB112_45
	jmp	.LBB112_44
.LBB112_69:
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip), %rax
	movq	%rax, (%rsp)
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 16(%rsp)
	leaq	_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	.L__unnamed_149(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	leaq	.L__unnamed_150(%rip), %rdx
	jmp	.LBB112_48
.LBB112_64:
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip), %rax
	movq	%rax, (%rsp)
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 16(%rsp)
	leaq	_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	.L__unnamed_149(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	leaq	.L__unnamed_151(%rip), %rdx
	jmp	.LBB112_48
.LBB112_59:
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip), %rax
	movq	%rax, (%rsp)
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 16(%rsp)
	leaq	_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	.L__unnamed_149(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	leaq	.L__unnamed_152(%rip), %rdx
	jmp	.LBB112_48
.LBB112_54:
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip), %rax
	movq	%rax, (%rsp)
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 16(%rsp)
	leaq	_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	.L__unnamed_149(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	leaq	.L__unnamed_153(%rip), %rdx
	jmp	.LBB112_48
.LBB112_47:
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip), %rax
	movq	%rax, (%rsp)
	leaq	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE+8(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	%rsp, %rax
	movq	%rax, 16(%rsp)
	leaq	_ZN75_$LT$spin..rwlock..RwLockReadGuard$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h92d09f4d542f247eE(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	.L__unnamed_149(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	$1, 72(%rsp)
	movl	$1, %esi
	leaq	32(%rsp), %rdi
	leaq	.L__unnamed_154(%rip), %rdx
	.p2align	4, 0x90
.LBB112_48:
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	(%rsp), %rax
	lock		subq	$4, (%rax)
.LBB112_49:
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
	movq	%rbx, %rbp
	cmpq	%rbx, %r15
	jne	.LBB112_26
.LBB112_31:
	lock		andq	$-4, _ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+8(%rip)
	movb	$1, %cl
	.p2align	4, 0x90
.LBB112_32:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	je	.LBB112_70
.LBB112_33:
	movzbl	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip), %eax
	testb	%al, %al
	jne	.LBB112_33
	jmp	.LBB112_32
.LBB112_70:
	cmpl	$2, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip)
	je	.LBB112_71
	leaq	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip), %rdi
	callq	*_ZN6x2apic5lapic9LocalApic16end_of_interrupt17h46ea2c2846374065E@GOTPCREL(%rip)
	movb	$0, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	addq	$80, %rsp
	popq	%rax
	popq	%rbx
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	iretq
.LBB112_30:
	lock		subq	$4, _ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E(%rip)
.LBB112_4:
	leaq	.L__unnamed_117(%rip), %rdi
	leaq	.L__unnamed_118(%rip), %rdx
	movl	$44, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB112_44:
	lock		subq	$4, _ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE(%rip)
	jmp	.LBB112_4
.LBB112_41:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_155(%rip), %rdx
	jmp	.LBB112_22
.LBB112_71:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_156(%rip), %rdx
	jmp	.LBB112_22
.LBB112_21:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_157(%rip), %rdx
.LBB112_22:
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB112_16:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	leaq	32(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.Lfunc_end112:
	.size	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E, .Lfunc_end112-_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E
	.section	.rodata._ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E,"a",@progbits
	.p2align	2
.LJTI112_0:
	.long	.LBB112_65-.LJTI112_0
	.long	.LBB112_60-.LJTI112_0
	.long	.LBB112_55-.LJTI112_0
	.long	.LBB112_50-.LJTI112_0
	.long	.LBB112_42-.LJTI112_0
	.long	.LBB112_41-.LJTI112_0

	.section	.text._ZN7cryptos10interrupts20bound_range_exceeded17hd3290ea832cb4869E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts20bound_range_exceeded17hd3290ea832cb4869E,@function
_ZN7cryptos10interrupts20bound_range_exceeded17hd3290ea832cb4869E:
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$64, %rsp
	cld
	leaq	136(%rsp), %rax
	movq	%rax, (%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 8(%rsp)
	leaq	.L__unnamed_158(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$1, 24(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	movq	%rsp, %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	.L__unnamed_159(%rip), %rsi
	leaq	16(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end113:
	.size	_ZN7cryptos10interrupts20bound_range_exceeded17hd3290ea832cb4869E, .Lfunc_end113-_ZN7cryptos10interrupts20bound_range_exceeded17hd3290ea832cb4869E

	.section	.text._ZN7cryptos10interrupts10invalid_op17h4915a7a0cce04ae0E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts10invalid_op17h4915a7a0cce04ae0E,@function
_ZN7cryptos10interrupts10invalid_op17h4915a7a0cce04ae0E:
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$96, %rsp
	cld
	movq	168(%rsp), %rax
	movl	-1(%rax), %eax
	bswapl	%eax
	movl	%eax, 12(%rsp)
	leaq	12(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	_ZN4core5array69_$LT$impl$u20$core..fmt..Debug$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$3fmt17h55edd20dcc9dbabcE(%rip), %rax
	movq	%rax, 24(%rsp)
	leaq	168(%rsp), %rax
	movq	%rax, 32(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 40(%rsp)
	leaq	.L__unnamed_160(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$2, 56(%rsp)
	leaq	.L__unnamed_161(%rip), %rax
	movq	%rax, 64(%rsp)
	movq	$2, 72(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 80(%rsp)
	movq	$2, 88(%rsp)
	leaq	.L__unnamed_162(%rip), %rsi
	leaq	48(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end114:
	.size	_ZN7cryptos10interrupts10invalid_op17h4915a7a0cce04ae0E, .Lfunc_end114-_ZN7cryptos10interrupts10invalid_op17h4915a7a0cce04ae0E

	.section	.text._ZN7cryptos10interrupts6navail17h6c40fefd72062ad0E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts6navail17h6c40fefd72062ad0E,@function
_ZN7cryptos10interrupts6navail17h6c40fefd72062ad0E:
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$64, %rsp
	cld
	leaq	136(%rsp), %rax
	movq	%rax, (%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 8(%rsp)
	leaq	.L__unnamed_163(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$1, 24(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	movq	%rsp, %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	.L__unnamed_164(%rip), %rsi
	leaq	16(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end115:
	.size	_ZN7cryptos10interrupts6navail17h6c40fefd72062ad0E, .Lfunc_end115-_ZN7cryptos10interrupts6navail17h6c40fefd72062ad0E

	.section	.text._ZN7cryptos10interrupts10breakpoint17h330af6ef4a811bedE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts10breakpoint17h330af6ef4a811bedE,@function
_ZN7cryptos10interrupts10breakpoint17h330af6ef4a811bedE:
	pushq	%r14
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rbx
	pushq	%rax
	subq	$48, %rsp
	cld
	leaq	136(%rsp), %r14
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rbx
	movq	(%rbx), %rax
	cmpq	$3, %rax
	jbe	.LBB116_1
	leaq	.L__unnamed_165(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_166(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB116_1:
	movq	(%r14), %rax
	cmpb	$-52, -1(%rax)
	jne	.LBB116_3
	.p2align	4, 0x90
.LBB116_2:
	jmp	.LBB116_2
.LBB116_3:
	movq	(%rbx), %rax
	cmpq	$3, %rax
	jbe	.LBB116_5
	leaq	.L__unnamed_167(%rip), %rax
	movq	%rax, (%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	.L__unnamed_168(%rip), %rdx
	movq	%rsp, %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB116_5:
	addq	$48, %rsp
	popq	%rax
	popq	%rbx
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	popq	%r14
	iretq
.Lfunc_end116:
	.size	_ZN7cryptos10interrupts10breakpoint17h330af6ef4a811bedE, .Lfunc_end116-_ZN7cryptos10interrupts10breakpoint17h330af6ef4a811bedE

	.section	.text._ZN7cryptos10interrupts12double_fault17h8e4873e22efc8641E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts12double_fault17h8e4873e22efc8641E,@function
_ZN7cryptos10interrupts12double_fault17h8e4873e22efc8641E:
	pushq	%rax
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$104, %rsp
	cld
	movq	192(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 24(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17h37bc6141694e846cE@GOTPCREL(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	192(%rsp), %rax
	movq	%rax, 40(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 48(%rsp)
	leaq	.L__unnamed_169(%rip), %rax
	movq	%rax, 56(%rsp)
	movq	$2, 64(%rsp)
	leaq	.L__unnamed_170(%rip), %rax
	movq	%rax, 72(%rsp)
	movq	$2, 80(%rsp)
	leaq	24(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	$2, 96(%rsp)
	leaq	.L__unnamed_171(%rip), %rsi
	leaq	56(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end117:
	.size	_ZN7cryptos10interrupts12double_fault17h8e4873e22efc8641E, .Lfunc_end117-_ZN7cryptos10interrupts12double_fault17h8e4873e22efc8641E

	.section	.text._ZN7cryptos10interrupts10page_fault17h14408972bb69c536E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts10page_fault17h14408972bb69c536E,@function
_ZN7cryptos10interrupts10page_fault17h14408972bb69c536E:
	pushq	%rax
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$120, %rsp
	cld
	#APP

	movq	%cr2, %rdi

	#NO_APP
	callq	_ZN6x86_644addr8VirtAddr3new17h1c485eaba4da328eE
	movq	%rax, 16(%rsp)
	leaq	16(%rsp), %rax
	movq	%rax, 72(%rsp)
	leaq	_ZN62_$LT$x86_64..addr..VirtAddr$u20$as$u20$core..fmt..LowerHex$GT$3fmt17h1a6af04cb213da62E(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	200(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN80_$LT$x86_64..structures..idt..PageFaultErrorCode$u20$as$u20$core..fmt..Debug$GT$3fmt17h31be2b6da4d7f72bE@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	208(%rsp), %rax
	movq	%rax, 104(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 112(%rsp)
	leaq	.L__unnamed_172(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$3, 32(%rsp)
	leaq	.L__unnamed_173(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$3, 48(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$3, 64(%rsp)
	leaq	.L__unnamed_174(%rip), %rsi
	leaq	24(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end118:
	.size	_ZN7cryptos10interrupts10page_fault17h14408972bb69c536E, .Lfunc_end118-_ZN7cryptos10interrupts10page_fault17h14408972bb69c536E

	.section	.text._ZN7cryptos10interrupts6sigfpe17h82499bbf9478eb0bE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts6sigfpe17h82499bbf9478eb0bE,@function
_ZN7cryptos10interrupts6sigfpe17h82499bbf9478eb0bE:
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$64, %rsp
	cld
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.LBB119_2
	leaq	136(%rsp), %rax
	movq	%rax, (%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 8(%rsp)
	leaq	.L__unnamed_175(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$1, 24(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	movq	%rsp, %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	.L__unnamed_176(%rip), %rdx
	leaq	16(%rsp), %rdi
	movl	$1, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB119_2:
	addq	$64, %rsp
	popq	%rax
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	iretq
.Lfunc_end119:
	.size	_ZN7cryptos10interrupts6sigfpe17h82499bbf9478eb0bE, .Lfunc_end119-_ZN7cryptos10interrupts6sigfpe17h82499bbf9478eb0bE

	.section	.text._ZN7cryptos10interrupts11invalid_tss17h3abe796b13aa3102E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts11invalid_tss17h3abe796b13aa3102E,@function
_ZN7cryptos10interrupts11invalid_tss17h3abe796b13aa3102E:
	pushq	%rax
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$88, %rsp
	cld
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.LBB120_2
	leaq	176(%rsp), %rax
	leaq	168(%rsp), %rcx
	movq	%rcx, 8(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E(%rip), %rcx
	movq	%rcx, 16(%rsp)
	movq	%rax, 24(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 32(%rsp)
	leaq	.L__unnamed_177(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$2, 48(%rsp)
	leaq	.L__unnamed_170(%rip), %rax
	movq	%rax, 56(%rsp)
	movq	$2, 64(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	$2, 80(%rsp)
	leaq	.L__unnamed_178(%rip), %rdx
	leaq	40(%rsp), %rdi
	movl	$1, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB120_2:
	addq	$88, %rsp
	popq	%rax
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	addq	$16, %rsp
	iretq
.Lfunc_end120:
	.size	_ZN7cryptos10interrupts11invalid_tss17h3abe796b13aa3102E, .Lfunc_end120-_ZN7cryptos10interrupts11invalid_tss17h3abe796b13aa3102E

	.section	.text._ZN7cryptos10interrupts6sigbus17h597adb0c8286a2c9E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts6sigbus17h597adb0c8286a2c9E,@function
_ZN7cryptos10interrupts6sigbus17h597adb0c8286a2c9E:
	pushq	%rax
	pushq	%r14
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rbx
	pushq	%rax
	subq	$152, %rsp
	cld
	movq	248(%rsp), %rdi
	callq	*_ZN6x86_6410structures3idt17SelectorErrorCode3new17h0b7080097ad6dc8cE@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB121_2
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_179(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB121_2:
	leaq	256(%rsp), %r14
	movq	%rdx, 24(%rsp)
	leaq	24(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_ZN6x86_6410structures3idt17SelectorErrorCode16descriptor_table17h8567fecda6328863E@GOTPCREL(%rip)
	movb	%al, 23(%rsp)
	movq	%rbx, %rdi
	callq	*_ZN6x86_6410structures3idt17SelectorErrorCode5index17h8a44a2f334028b19E@GOTPCREL(%rip)
	movq	%rax, 32(%rsp)
	leaq	248(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	23(%rsp), %rcx
	movq	%rcx, 104(%rsp)
	movq	_ZN77_$LT$x86_64..structures..idt..DescriptorTable$u20$as$u20$core..fmt..Debug$GT$3fmt17hdabcab8fa010d384E@GOTPCREL(%rip), %rcx
	movq	%rcx, 112(%rsp)
	leaq	32(%rsp), %rcx
	movq	%rcx, 120(%rsp)
	movq	%rax, 128(%rsp)
	movq	%r14, 136(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 144(%rsp)
	leaq	.L__unnamed_180(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$4, 48(%rsp)
	leaq	.L__unnamed_181(%rip), %rax
	movq	%rax, 56(%rsp)
	movq	$4, 64(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	$4, 80(%rsp)
	leaq	.L__unnamed_182(%rip), %rsi
	leaq	40(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end121:
	.size	_ZN7cryptos10interrupts6sigbus17h597adb0c8286a2c9E, .Lfunc_end121-_ZN7cryptos10interrupts6sigbus17h597adb0c8286a2c9E

	.section	.text._ZN7cryptos10interrupts7sigsegv17h8aa57eeff995121dE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts7sigsegv17h8aa57eeff995121dE,@function
_ZN7cryptos10interrupts7sigsegv17h8aa57eeff995121dE:
	pushq	%rax
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$104, %rsp
	cld
	movq	184(%rsp), %rcx
	leaq	192(%rsp), %rax
	testq	%rcx, %rcx
	je	.LBB122_3
	movq	%rcx, 64(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.LBB122_6
	leaq	64(%rsp), %rcx
	movq	%rcx, 72(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E(%rip), %rcx
	movq	%rcx, 80(%rsp)
	movq	%rax, 88(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_183(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$2, 24(%rsp)
	leaq	.L__unnamed_170(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$2, 40(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	$2, 56(%rsp)
	leaq	.L__unnamed_184(%rip), %rdx
	jmp	.LBB122_5
.LBB122_3:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.LBB122_6
	movq	%rax, 72(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	.L__unnamed_185(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$1, 24(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	.L__unnamed_186(%rip), %rdx
.LBB122_5:
	leaq	16(%rsp), %rdi
	movl	$1, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB122_6:
	addq	$104, %rsp
	popq	%rax
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	addq	$16, %rsp
	iretq
.Lfunc_end122:
	.size	_ZN7cryptos10interrupts7sigsegv17h8aa57eeff995121dE, .Lfunc_end122-_ZN7cryptos10interrupts7sigsegv17h8aa57eeff995121dE

	.section	.text._ZN7cryptos10interrupts18general_protection17h832b4df9a2f4e224E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos10interrupts18general_protection17h832b4df9a2f4e224E,@function
_ZN7cryptos10interrupts18general_protection17h832b4df9a2f4e224E:
	pushq	%rax
	pushq	%r11
	pushq	%r10
	pushq	%r9
	pushq	%r8
	pushq	%rdi
	pushq	%rsi
	pushq	%rdx
	pushq	%rcx
	pushq	%rax
	subq	$104, %rsp
	cld
	movq	184(%rsp), %rcx
	leaq	192(%rsp), %rax
	testq	%rcx, %rcx
	je	.LBB123_3
	movq	%rcx, 64(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.LBB123_6
	leaq	64(%rsp), %rcx
	movq	%rcx, 72(%rsp)
	leaq	_ZN4core3fmt3num50_$LT$impl$u20$core..fmt..Debug$u20$for$u20$u64$GT$3fmt17he291d34c2c59a912E(%rip), %rcx
	movq	%rcx, 80(%rsp)
	movq	%rax, 88(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_187(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$2, 24(%rsp)
	leaq	.L__unnamed_170(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$2, 40(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	$2, 56(%rsp)
	leaq	.L__unnamed_188(%rip), %rdx
	jmp	.LBB123_5
.LBB123_3:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	testq	%rcx, %rcx
	je	.LBB123_6
	movq	%rax, 72(%rsp)
	leaq	_ZN81_$LT$x86_64..structures..idt..InterruptStackFrame$u20$as$u20$core..fmt..Debug$GT$3fmt17he4a9832a746e91faE(%rip), %rax
	movq	%rax, 80(%rsp)
	leaq	.L__unnamed_189(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$1, 24(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$1, 40(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	leaq	.L__unnamed_190(%rip), %rdx
.LBB123_5:
	leaq	16(%rsp), %rdi
	movl	$1, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB123_6:
	addq	$104, %rsp
	popq	%rax
	popq	%rcx
	popq	%rdx
	popq	%rsi
	popq	%rdi
	popq	%r8
	popq	%r9
	popq	%r10
	popq	%r11
	addq	$16, %rsp
	iretq
.Lfunc_end123:
	.size	_ZN7cryptos10interrupts18general_protection17h832b4df9a2f4e224E, .Lfunc_end123-_ZN7cryptos10interrupts18general_protection17h832b4df9a2f4e224E

	.section	.text._ZN7cryptos8get_mcfg17hbfcae760a4136b45E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos8get_mcfg17hbfcae760a4136b45E,@function
_ZN7cryptos8get_mcfg17hbfcae760a4136b45E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %r14
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB124_9
	cmpq	$1, %rax
	je	.LBB124_8
	cmpq	$3, %rax
	je	.LBB124_3
	.p2align	4, 0x90
.LBB124_5:
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB124_9
	cmpq	$3, %rax
	jne	.LBB124_5
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB124_9:
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+8(%rip), %r15
	testq	%r15, %r15
	je	.LBB124_10
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+24(%rip), %rbx
	testq	%rbx, %rbx
	je	.LBB124_12
	movl	$16, %ecx
	movq	%rbx, %rax
	mulq	%rcx
	jo	.LBB124_21
	movq	%rax, %r12
	movq	%rax, %r13
	notq	%r13
	shrq	$63, %r13
	testq	%rax, %rax
	js	.LBB124_21
	je	.LBB124_16
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	movq	%rax, %rbp
	testq	%rbp, %rbp
	jne	.LBB124_19
	jmp	.LBB124_22
.LBB124_10:
	movq	$0, (%r14)
	jmp	.LBB124_20
.LBB124_12:
	movl	$1, %ebp
	jmp	.LBB124_19
.LBB124_16:
	movq	%r13, %rbp
	testq	%rbp, %rbp
	je	.LBB124_22
.LBB124_19:
	movq	%rbx, %rdx
	shlq	$4, %rdx
	movq	%rbp, %rdi
	movq	%r15, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	%rbp, (%r14)
	movq	%rbx, 8(%r14)
	movq	%rbx, 16(%r14)
.LBB124_20:
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB124_8:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_191(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB124_3:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	movq	%rsp, %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB124_21:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB124_22:
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.Lfunc_end124:
	.size	_ZN7cryptos8get_mcfg17hbfcae760a4136b45E, .Lfunc_end124-_ZN7cryptos8get_mcfg17hbfcae760a4136b45E

	.section	.text.rust_begin_unwind,"ax",@progbits
	.hidden	rust_begin_unwind
	.globl	rust_begin_unwind
	.p2align	4, 0x90
	.type	rust_begin_unwind,@function
rust_begin_unwind:
	subq	$72, %rsp
	movq	%rdi, (%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.LBB125_2
	movq	%rsp, %rax
	movq	%rax, 8(%rsp)
	leaq	_ZN44_$LT$$RF$T$u20$as$u20$core..fmt..Display$GT$3fmt17hf19a80f055ce65c2E(%rip), %rax
	movq	%rax, 16(%rsp)
	leaq	.L__unnamed_192(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	$1, 32(%rsp)
	movq	$0, 40(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 56(%rsp)
	movq	$1, 64(%rsp)
	leaq	.L__unnamed_193(%rip), %rdx
	leaq	24(%rsp), %rdi
	movl	$1, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB125_2:
	jmp	.LBB125_2
.Lfunc_end125:
	.size	rust_begin_unwind, .Lfunc_end125-rust_begin_unwind

	.section	.text._ZN7cryptos5maink17h58f915735fd959feE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN7cryptos5maink17h58f915735fd959feE,@function
_ZN7cryptos5maink17h58f915735fd959feE:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movl	$6744, %eax
	callq	__rust_probestack
	subq	%rax, %rsp
	cmpl	$0, 96(%rdi)
	jne	.LBB126_818
	movq	%rdi, %rbx
	movq	104(%rdi), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB126_5
	cmpl	$131071, %ecx
	je	.LBB126_5
	cmpl	$1, %ecx
	jne	.LBB126_807
	shlq	$16, %rax
	sarq	$16, %rax
.LBB126_5:
	movabsq	$4503599627370495, %rcx
	#APP

	movq	%cr3, %rdx

	#NO_APP
	addq	$-4095, %rcx
	andq	%rdx, %rcx
	addq	%rax, %rcx
	movq	%rcx, %rdx
	shrq	$47, %rdx
	je	.LBB126_9
	cmpl	$131071, %edx
	je	.LBB126_9
	cmpl	$1, %edx
	jne	.LBB126_843
	shlq	$16, %rcx
	sarq	$16, %rcx
.LBB126_9:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rdx
	cmpq	$2, %rdx
	je	.LBB126_17
	cmpq	$1, %rdx
	je	.LBB126_14
	cmpq	$3, %rdx
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_12:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_17
	cmpq	$3, %rax
	jne	.LBB126_12
	jmp	.LBB126_750
.LBB126_14:
	movq	%rax, 5032(%rsp)
	movq	%rcx, 5040(%rsp)
	leaq	5032(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	1440(%rsp), %rdi
	leaq	208(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h248e261427e063f4E
	cmpq	$0, 1440(%rsp)
	movq	1448(%rsp), %rax
	je	.LBB126_16
	testq	%rax, %rax
	jne	.LBB126_12
	jmp	.LBB126_861
.LBB126_16:
	testq	%rax, %rax
	je	.LBB126_12
.LBB126_17:
	leaq	8(%rbx), %rbp
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_25
	cmpq	$1, %rax
	je	.LBB126_22
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_20:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_25
	cmpq	$3, %rax
	jne	.LBB126_20
	jmp	.LBB126_750
.LBB126_22:
	movq	%rbp, 5032(%rsp)
	movq	$0, 5040(%rsp)
	leaq	5032(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	1440(%rsp), %rdi
	leaq	208(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hac1979b172f7ec82E
	cmpq	$0, 1440(%rsp)
	movq	1448(%rsp), %rax
	je	.LBB126_24
	testq	%rax, %rax
	jne	.LBB126_20
	jmp	.LBB126_861
.LBB126_24:
	testq	%rax, %rax
	je	.LBB126_20
.LBB126_25:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_30
	cmpq	$1, %rax
	je	.LBB126_845
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_28:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_30
	cmpq	$3, %rax
	jne	.LBB126_28
	jmp	.LBB126_750
.LBB126_30:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_31:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB126_33
.LBB126_32:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_32
	jmp	.LBB126_31
.LBB126_33:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_38
	cmpq	$1, %rax
	je	.LBB126_846
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_36:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_38
	cmpq	$3, %rax
	jne	.LBB126_36
	jmp	.LBB126_750
.LBB126_38:
	movq	%rbp, 24(%rsp)
	movq	%rbx, 200(%rsp)
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_39:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_41
.LBB126_40:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_40
	jmp	.LBB126_39
.LBB126_41:
	movabsq	$87960930222080, %rbp
	movq	%rbp, 5032(%rsp)
	leaq	16773120(%rbp), %rax
	movq	%rax, 208(%rsp)
	leaq	5032(%rsp), %r14
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %rbx
	leaq	1440(%rsp), %r12
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %r13
	leaq	208(%rsp), %r15
	.p2align	4, 0x90
.LBB126_42:
	cmpq	$-4096, %rbp
	jae	.LBB126_48
	leaq	4096(%rbp), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB126_47
	cmpl	$131071, %ecx
	je	.LBB126_47
	cmpl	$1, %ecx
	jne	.LBB126_807
	shlq	$16, %rax
	sarq	$16, %rax
.LBB126_47:
	movq	%r14, %rcx
	jmp	.LBB126_53
	.p2align	4, 0x90
.LBB126_48:
	subq	$4096, %rax
	jb	.LBB126_804
	movq	%rax, %rdx
	movq	%r15, %rcx
	shrq	$47, %rdx
	je	.LBB126_53
	cmpl	$131071, %edx
	je	.LBB126_53
	cmpl	$1, %edx
	jne	.LBB126_807
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%r15, %rcx
	.p2align	4, 0x90
.LBB126_53:
	shlq	$16, %rax
	sarq	$16, %rax
	andq	$-4096, %rax
	movq	%rax, (%rcx)
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	_ZN158_$LT$cryptos..cralloc..frames..Falloc$u20$as$u20$x86_64..structures..paging..frame_alloc..FrameAllocator$LT$x86_64..structures..paging..page..Size4KiB$GT$$GT$14allocate_frame17h0f5bd85b586659d5E
	cmpq	$0, 1440(%rsp)
	je	.LBB126_797
	movq	1448(%rsp), %rcx
	movl	$3, %r8d
	movq	%r12, %rdi
	movq	%r13, %rsi
	movq	%rbp, %rdx
	movq	%rbx, %r9
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	cmpq	$0, 1440(%rsp)
	movq	1448(%rsp), %rax
	jne	.LBB126_57
	#APP

	invlpg	(%rax)

	#NO_APP
	movq	5032(%rsp), %rbp
	movq	208(%rsp), %rax
	cmpq	%rax, %rbp
	jbe	.LBB126_42
	leaq	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE(%rip), %rdi
	movl	$16777216, %edx
	movabsq	$87960930222080, %rsi
	callq	*_ZN17slab_allocator_rs10LockedHeap4init17h90a1d588cb23756dE@GOTPCREL(%rip)
	jmp	.LBB126_58
.LBB126_57:
	cmpq	$3, %rax
	jne	.LBB126_844
.LBB126_58:
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	movq	200(%rsp), %rbp
	cmpl	$0, 96(%rbp)
	jne	.LBB126_819
	movq	104(%rbp), %rax
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rcx
	cmpq	$2, %rcx
	je	.LBB126_67
	cmpq	$1, %rcx
	je	.LBB126_64
	cmpq	$3, %rcx
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_62:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_67
	cmpq	$3, %rax
	jne	.LBB126_62
	jmp	.LBB126_750
.LBB126_64:
	movq	%rax, 5040(%rsp)
	movq	$1, 5032(%rsp)
	leaq	5032(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	1440(%rsp), %rdi
	leaq	208(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17he31b3d769122797eE
	cmpq	$0, 1440(%rsp)
	movq	1448(%rsp), %rax
	je	.LBB126_66
	testq	%rax, %rax
	jne	.LBB126_62
	jmp	.LBB126_861
.LBB126_66:
	testq	%rax, %rax
	je	.LBB126_62
.LBB126_67:
	cmpl	$0, 24(%rbp)
	jne	.LBB126_820
	leaq	32(%rbp), %rbx
	leaq	1288(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_ZN10bootloader9boot_info11FrameBuffer4info17h7e6f2905bbba9540E@GOTPCREL(%rip)
	movq	%rbx, %rdi
	callq	*_ZN10bootloader9boot_info11FrameBuffer10buffer_mut17he490adababc73522E@GOTPCREL(%rip)
	cmpl	$0, 120(%rbp)
	jne	.LBB126_821
	movq	128(%rbp), %r15
	movq	1328(%rsp), %rcx
	movq	%rcx, 5072(%rsp)
	movq	1320(%rsp), %rcx
	movq	%rcx, 5064(%rsp)
	movq	1312(%rsp), %rcx
	movq	%rcx, 5056(%rsp)
	movq	1304(%rsp), %rcx
	movq	%rcx, 5048(%rsp)
	movq	1288(%rsp), %rcx
	movq	1296(%rsp), %rsi
	movq	%rsi, 5040(%rsp)
	movq	%rcx, 5032(%rsp)
	movq	_ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E(%rip), %rcx
	cmpq	$2, %rcx
	je	.LBB126_74
	cmpq	$1, %rcx
	je	.LBB126_723
	cmpq	$3, %rcx
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_72:
	movq	_ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_74
	cmpq	$3, %rax
	jne	.LBB126_72
	jmp	.LBB126_750
.LBB126_74:
	leaq	_ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E+8(%rip), %rdi
.LBB126_75:
	leaq	.L__unnamed_194(%rip), %rsi
	callq	*_ZN3log10set_logger17h29fc02747f7a8182E@GOTPCREL(%rip)
	testb	%al, %al
	jne	.LBB126_822
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	$3, (%rax)
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB126_77
	leaq	.L__unnamed_195(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_196(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jae	.LBB126_82
.LBB126_78:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jb	.LBB126_79
.LBB126_83:
	movq	%r15, 208(%rsp)
	leaq	208(%rsp), %rax
	movq	%rax, 5032(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17h37bc6141694e846cE@GOTPCREL(%rip), %rax
	movq	%rax, 5040(%rsp)
	leaq	.L__unnamed_197(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	5032(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_198(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	ja	.LBB126_84
.LBB126_80:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	jne	.LBB126_87
	jmp	.LBB126_91
.LBB126_77:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jb	.LBB126_78
.LBB126_82:
	leaq	2(%rbp), %rax
	leaq	4(%rbp), %rcx
	movq	%rbp, 1440(%rsp)
	movq	_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$u16$GT$3fmt17h48de3566c42edeb4E@GOTPCREL(%rip), %rdx
	movq	%rdx, 1448(%rsp)
	movq	%rax, 1456(%rsp)
	movq	%rdx, 1464(%rsp)
	movq	%rcx, 1472(%rsp)
	movq	%rdx, 1480(%rsp)
	leaq	.L__unnamed_199(%rip), %rax
	movq	%rax, 5032(%rsp)
	movq	$4, 5040(%rsp)
	movq	$0, 5048(%rsp)
	movq	%r12, 5064(%rsp)
	movq	$3, 5072(%rsp)
	leaq	.L__unnamed_200(%rip), %rdx
	leaq	5032(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jae	.LBB126_83
.LBB126_79:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB126_80
.LBB126_84:
	movq	24(%rsp), %rdi
	callq	*_ZN80_$LT$bootloader..boot_info..MemoryRegions$u20$as$u20$core..ops..deref..Deref$GT$5deref17hc22198d550a683b6E@GOTPCREL(%rip)
	testq	%rdx, %rdx
	je	.LBB126_847
	testq	%rax, %rax
	je	.LBB126_847
	movq	%rax, 208(%rsp)
	leaq	208(%rsp), %rax
	movq	%rax, 5896(%rsp)
	leaq	5896(%rsp), %rax
	movq	%rax, 5032(%rsp)
	movq	_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h0338f6cb554ca680E@GOTPCREL(%rip), %rax
	movq	%rax, 5040(%rsp)
	leaq	.L__unnamed_201(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	5032(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_202(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_91
.LBB126_87:
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_89:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_91
	cmpq	$3, %rax
	jne	.LBB126_89
	jmp	.LBB126_750
.LBB126_91:
	movabsq	$4503599627370495, %rax
	cmpq	%rax, %r15
	ja	.LBB126_802
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rbp
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_97
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_95:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_97
	cmpq	$3, %rax
	jne	.LBB126_95
	jmp	.LBB126_750
.LBB126_97:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r15, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB126_101
	cmpl	$131071, %eax
	je	.LBB126_101
	cmpl	$1, %eax
	jne	.LBB126_841
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB126_101:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_106
	cmpq	$1, %rax
	je	.LBB126_813
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_104:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_106
	cmpq	$3, %rax
	jne	.LBB126_104
	jmp	.LBB126_750
.LBB126_106:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_107:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB126_109
.LBB126_108:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_108
	jmp	.LBB126_107
.LBB126_109:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_114
	cmpq	$1, %rax
	je	.LBB126_813
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_112:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_114
	cmpq	$3, %rax
	jne	.LBB126_112
	jmp	.LBB126_750
.LBB126_114:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r15, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB126_115:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_117
.LBB126_116:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_116
	jmp	.LBB126_115
.LBB126_117:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	5032(%rsp), %rdi
	movl	$3, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 5032(%rsp)
	movq	5040(%rsp), %rax
	je	.LBB126_122
	cmpq	$1, %rax
	je	.LBB126_123
	cmpq	$2, %rax
	jne	.LBB126_842
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_126
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_125
.LBB126_122:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB126_126
.LBB126_123:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_126
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_125:
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_60(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_126:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_131
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_129:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_131
	cmpq	$3, %rax
	jne	.LBB126_129
	jmp	.LBB126_750
.LBB126_131:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rbx
	addq	%r15, %rbx
	je	.LBB126_814
	addq	%r15, %rbp
	movq	%rbp, %rax
	shrq	$47, %rax
	cmpq	$2, %rax
	jb	.LBB126_134
	cmpl	$131071, %eax
	jne	.LBB126_817
.LBB126_134:
	movq	%rbx, %rdi
	callq	*_ZN4rsdp4Rsdp8validate17h3d81fecbbee879adE@GOTPCREL(%rip)
	cmpb	$4, %al
	jne	.LBB126_823
	movq	%rbx, %rdi
	callq	*_ZN4rsdp4Rsdp8revision17hceb4fdb2e0959b82E@GOTPCREL(%rip)
	testb	%al, %al
	je	.LBB126_137
	movl	%eax, %ebp
	movq	%rbx, %rdi
	callq	*_ZN4rsdp4Rsdp12xsdt_address17h2bb42ee0498521fdE@GOTPCREL(%rip)
	movzbl	%bpl, %esi
	leaq	1440(%rsp), %rdi
	movq	%rax, %rdx
	callq	_ZN4acpi19AcpiTables$LT$H$GT$9from_rsdt17h442b1f3c610c78d1E
	cmpb	$0, 1440(%rsp)
	je	.LBB126_138
	jmp	.LBB126_824
.LBB126_137:
	movq	%rbx, %rdi
	callq	*_ZN4rsdp4Rsdp12rsdt_address17h57c33b1bd584f53aE@GOTPCREL(%rip)
	movl	%eax, %edx
	leaq	1440(%rsp), %rdi
	xorl	%esi, %esi
	callq	_ZN4acpi19AcpiTables$LT$H$GT$9from_rsdt17h442b1f3c610c78d1E
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_824
.LBB126_138:
	leaq	1448(%rsp), %rsi
	leaq	1360(%rsp), %rdi
	movl	$10, %ecx
	rep;movsq (%rsi), %es:(%rdi)
	movl	$1195787085, 208(%rsp)
	movq	1368(%rsp), %r13
	testq	%r13, %r13
	je	.LBB126_203
	movq	1360(%rsp), %r9
	movl	$255, %r10d
.LBB126_140:
	movzwl	186(%r13), %r8d
	leaq	(,%r8,4), %rdi
	negq	%rdi
	movl	$188, %ebx
	movq	$-1, %rdx
	.p2align	4, 0x90
.LBB126_141:
	leaq	(%rdi,%rbx), %rsi
	cmpq	$188, %rsi
	je	.LBB126_144
	movl	208(%rsp), %esi
	movl	(%r13,%rbx), %ebp
	bswapl	%esi
	bswapl	%ebp
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	cmpl	%ebp, %esi
	seta	%al
	setb	%cl
	xorl	%esi, %esi
	cmpl	%ecx, %eax
	setne	%sil
	cmovsl	%r10d, %esi
	addq	$4, %rbx
	addq	$1, %rdx
	cmpb	$1, %sil
	je	.LBB126_141
	cmpb	$-1, %sil
	je	.LBB126_145
	jmp	.LBB126_147
	.p2align	4, 0x90
.LBB126_144:
	movq	%r8, %rdx
.LBB126_145:
	subq	$1, %r9
	jb	.LBB126_203
	movq	232(%r13,%rdx,8), %r13
	jmp	.LBB126_140
.LBB126_147:
	movq	-760(%r13,%rbx,4), %r15
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_152
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_150:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_152
	cmpq	$3, %rax
	jne	.LBB126_150
	jmp	.LBB126_750
.LBB126_152:
	movabsq	$4503599627370495, %rax
	cmpq	%rax, %r15
	ja	.LBB126_802
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %r12
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_158
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_156:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_158
	cmpq	$3, %rax
	jne	.LBB126_156
	jmp	.LBB126_750
.LBB126_158:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%r15, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB126_162
	cmpl	$131071, %eax
	je	.LBB126_162
	cmpl	$1, %eax
	jne	.LBB126_841
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB126_162:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_167
	cmpq	$1, %rax
	je	.LBB126_813
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_165:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_167
	cmpq	$3, %rax
	jne	.LBB126_165
	jmp	.LBB126_750
.LBB126_167:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_168:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB126_170
.LBB126_169:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_169
	jmp	.LBB126_168
.LBB126_170:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_175
	cmpq	$1, %rax
	je	.LBB126_813
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_173:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_175
	cmpq	$3, %rax
	jne	.LBB126_173
	jmp	.LBB126_750
.LBB126_175:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%r15, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %sil
	.p2align	4, 0x90
.LBB126_176:
	xorl	%eax, %eax
	lock		cmpxchgb	%sil, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_178
.LBB126_177:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_177
	jmp	.LBB126_176
.LBB126_178:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	5032(%rsp), %rdi
	movl	$3, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 5032(%rsp)
	movq	5040(%rsp), %rax
	je	.LBB126_183
	cmpq	$1, %rax
	je	.LBB126_184
	cmpq	$2, %rax
	jne	.LBB126_842
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_187
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_186
.LBB126_183:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB126_187
.LBB126_184:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_187
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_186:
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_60(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_187:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_192
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_190:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_192
	cmpq	$3, %rax
	jne	.LBB126_190
	jmp	.LBB126_750
.LBB126_192:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %r14
	addq	%r15, %r14
	je	.LBB126_814
	addq	%r15, %r12
	movq	%r12, %rax
	shrq	$47, %rax
	cmpq	$2, %rax
	jb	.LBB126_195
	cmpl	$131071, %eax
	jne	.LBB126_859
.LBB126_195:
	cmpb	$0, -748(%r13,%rbx,4)
	jne	.LBB126_197
	movq	%r14, %rdi
	callq	*_ZN52_$LT$acpi..mcfg..Mcfg$u20$as$u20$acpi..AcpiTable$GT$6header17h3698df2d50696e59E@GOTPCREL(%rip)
	movl	208(%rsp), %esi
	movq	%rax, %rdi
	callq	*_ZN4acpi3sdt9SdtHeader8validate17hbb9f2b352ae5ba92E@GOTPCREL(%rip)
	cmpb	$10, %al
	jne	.LBB126_203
.LBB126_197:
	movq	%r14, %rdi
	callq	*_ZN4acpi4mcfg4Mcfg7entries17h20ae44096bcf8ee4E@GOTPCREL(%rip)
	movq	%rax, %rbx
	movq	%rdx, %rbp
	shlq	$4, %rbp
	testq	%rdx, %rdx
	movq	%rdx, 80(%rsp)
	je	.LBB126_204
	js	.LBB126_852
	movq	%rbp, %r15
	notq	%r15
	shrq	$63, %r15
	movq	%rbp, %rdi
	movq	%r15, %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	movq	%rax, %r14
	testq	%rax, %rax
	je	.LBB126_853
	leaq	(%rbx,%rbp), %rax
	cmpq	%rax, %rbx
	je	.LBB126_205
.LBB126_201:
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB126_202:
	movq	(%rbx,%rax), %rcx
	movq	8(%rbx,%rax), %rdx
	movq	%rdx, 8(%r14,%rax)
	movq	%rcx, (%r14,%rax)
	addq	$1, %r13
	addq	$16, %rax
	cmpq	%rax, %rbp
	jne	.LBB126_202
	jmp	.LBB126_206
.LBB126_203:
	xorl	%r14d, %r14d
	jmp	.LBB126_206
.LBB126_204:
	movl	$1, %r14d
	leaq	(%rbx,%rbp), %rax
	cmpq	%rax, %rbx
	jne	.LBB126_201
.LBB126_205:
	xorl	%r13d, %r13d
.LBB126_206:
	leaq	1440(%rsp), %rdi
	leaq	1360(%rsp), %rsi
	callq	_ZN4acpi19AcpiTables$LT$H$GT$7get_sdt17h7b6644ec31d1e378E
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_816
	movq	1456(%rsp), %r12
	testq	%r12, %r12
	je	.LBB126_825
	movq	%r12, %rdi
	callq	*_ZN4acpi4fadt4Fadt13power_profile17hdd69bf2102ead2e2E@GOTPCREL(%rip)
	movl	$1128878145, 208(%rsp)
	movq	1368(%rsp), %r15
	testq	%r15, %r15
	je	.LBB126_253
	movq	1360(%rsp), %r9
	movl	$255, %r10d
.LBB126_210:
	movzwl	186(%r15), %r8d
	leaq	(,%r8,4), %rdi
	negq	%rdi
	movl	$188, %ebx
	movq	$-1, %rdx
	.p2align	4, 0x90
.LBB126_211:
	leaq	(%rdi,%rbx), %rsi
	cmpq	$188, %rsi
	je	.LBB126_214
	movl	208(%rsp), %esi
	movl	(%r15,%rbx), %ebp
	bswapl	%esi
	bswapl	%ebp
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	cmpl	%ebp, %esi
	seta	%al
	setb	%cl
	xorl	%esi, %esi
	cmpl	%ecx, %eax
	setne	%sil
	cmovsl	%r10d, %esi
	addq	$4, %rbx
	addq	$1, %rdx
	cmpb	$1, %sil
	je	.LBB126_211
	cmpb	$-1, %sil
	je	.LBB126_215
	jmp	.LBB126_217
	.p2align	4, 0x90
.LBB126_214:
	movq	%r8, %rdx
.LBB126_215:
	subq	$1, %r9
	jb	.LBB126_253
	movq	232(%r15,%rdx,8), %r15
	jmp	.LBB126_210
.LBB126_217:
	movq	-760(%r15,%rbx,4), %rbp
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_222
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_220:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_222
	cmpq	$3, %rax
	jne	.LBB126_220
	jmp	.LBB126_750
.LBB126_222:
	movabsq	$4503599627370495, %rax
	cmpq	%rax, %rbp
	ja	.LBB126_802
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rax
	movq	%rax, 24(%rsp)
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_228
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_226:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_228
	cmpq	$3, %rax
	jne	.LBB126_226
	jmp	.LBB126_750
.LBB126_228:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rdx
	addq	%rbp, %rdx
	movq	%rdx, %rax
	shrq	$47, %rax
	je	.LBB126_232
	cmpl	$131071, %eax
	je	.LBB126_232
	cmpl	$1, %eax
	jne	.LBB126_841
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB126_232:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_237
	cmpq	$1, %rax
	je	.LBB126_813
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_235:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_237
	cmpq	$3, %rax
	jne	.LBB126_235
	jmp	.LBB126_750
.LBB126_237:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_238:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB126_240
.LBB126_239:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_239
	jmp	.LBB126_238
.LBB126_240:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_245
	cmpq	$1, %rax
	je	.LBB126_813
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_243:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_245
	cmpq	$3, %rax
	jne	.LBB126_243
	jmp	.LBB126_750
.LBB126_245:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rbp, %rcx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %sil
	.p2align	4, 0x90
.LBB126_246:
	xorl	%eax, %eax
	lock		cmpxchgb	%sil, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_248
.LBB126_247:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_247
	jmp	.LBB126_246
.LBB126_248:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	5032(%rsp), %rdi
	movl	$3, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 5032(%rsp)
	movq	5040(%rsp), %rax
	je	.LBB126_254
	cmpq	$1, %rax
	je	.LBB126_255
	cmpq	$2, %rax
	jne	.LBB126_842
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_258
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_257
.LBB126_253:
	movb	$2, %bpl
	movb	$2, %r15b
	jmp	.LBB126_270
.LBB126_254:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB126_258
.LBB126_255:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_258
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_257:
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_60(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_258:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	movq	%r12, 168(%rsp)
	je	.LBB126_263
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_261:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_263
	cmpq	$3, %rax
	jne	.LBB126_261
	jmp	.LBB126_750
.LBB126_263:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %r12
	addq	%rbp, %r12
	je	.LBB126_814
	movq	24(%rsp), %rcx
	addq	%rbp, %rcx
	movq	%rcx, %rax
	shrq	$47, %rax
	cmpq	$2, %rax
	jb	.LBB126_266
	cmpl	$131071, %eax
	jne	.LBB126_843
.LBB126_266:
	cmpb	$0, -748(%r15,%rbx,4)
	jne	.LBB126_268
	movq	%r12, %rdi
	callq	*_ZN52_$LT$acpi..madt..Madt$u20$as$u20$acpi..AcpiTable$GT$6header17he8d59f3cb8802919E@GOTPCREL(%rip)
	movl	208(%rsp), %esi
	movq	%rax, %rdi
	callq	*_ZN4acpi3sdt9SdtHeader8validate17hbb9f2b352ae5ba92E@GOTPCREL(%rip)
	movq	%rax, %rbp
	cmpb	$10, %bpl
	jne	.LBB126_832
.LBB126_268:
	leaq	1440(%rsp), %rdi
	movq	%r12, %rsi
	callq	*_ZN4acpi4madt4Madt21parse_interrupt_model17h4de5f4aa67e0144aE@GOTPCREL(%rip)
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_816
	leaq	1448(%rsp), %rsi
	leaq	5034(%rsp), %rbx
	movq	memcpy@GOTPCREL(%rip), %r12
	movl	$104, %edx
	movq	%rbx, %rdi
	callq	*%r12
	movb	1552(%rsp), %bpl
	movl	1553(%rsp), %eax
	movl	%eax, 5896(%rsp)
	movl	1556(%rsp), %eax
	movl	%eax, 5899(%rsp)
	movq	1560(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	1568(%rsp), %rax
	movq	%rax, 24(%rsp)
	movb	1593(%rsp), %r15b
	leaq	208(%rsp), %rdi
	movl	$104, %edx
	movq	%rbx, %rsi
	callq	*%r12
	movq	168(%rsp), %r12
.LBB126_270:
	leaq	5032(%rsp), %rdi
	leaq	208(%rsp), %rsi
	movl	$13, %ecx
	rep;movsq (%rsi), %es:(%rdi)
	movb	%bpl, 5136(%rsp)
	movl	5896(%rsp), %eax
	movl	5899(%rsp), %ecx
	movl	%eax, 5137(%rsp)
	movl	%ecx, 5140(%rsp)
	leaq	1440(%rsp), %rdi
	movq	%r12, %rsi
	callq	*_ZN4acpi8platform7PmTimer3new17h3bed07052b89f0dbE@GOTPCREL(%rip)
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_826
	leaq	1442(%rsp), %rbx
	leaq	5032(%rsp), %rsi
	movq	memcpy@GOTPCREL(%rip), %rbp
	movl	$112, %edx
	movq	%rbx, %rdi
	callq	*%rbp
	leaq	6632(%rsp), %rdi
	movl	$112, %edx
	movq	%rbx, %rsi
	callq	*%rbp
	cmpb	$2, %r15b
	movq	24(%rsp), %rax
	je	.LBB126_276
	testq	%rax, %rax
	je	.LBB126_276
	movl	$12, %ecx
	mulq	%rcx
	jo	.LBB126_276
	movabsq	$-9223372036854775805, %rdx
	leaq	(%rax,%rdx), %rcx
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	jb	.LBB126_276
	movl	$4, %edx
	movq	160(%rsp), %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_276:
	leaq	5032(%rsp), %rdi
	leaq	6632(%rsp), %rsi
	movl	$14, %ecx
	rep;movsq (%rsi), %es:(%rdi)
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_280
	cmpq	$1, %rax
	je	.LBB126_725
	cmpq	$3, %rax
	je	.LBB126_793
	xorl	%ebx, %ebx
	jmp	.LBB126_281
.LBB126_280:
	leaq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+8(%rip), %rbx
.LBB126_281:
	leaq	5032(%rsp), %rdi
.LBB126_282:
	callq	_ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE
.LBB126_283:
	testq	%rbx, %rbx
	je	.LBB126_729
.LBB126_284:
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_288
	cmpq	$1, %rax
	je	.LBB126_731
	cmpq	$3, %rax
	je	.LBB126_793
	xorl	%ebx, %ebx
	movq	80(%rsp), %rax
	testq	%r14, %r14
	jne	.LBB126_289
	jmp	.LBB126_294
.LBB126_288:
	leaq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+8(%rip), %rbx
	movq	80(%rsp), %rax
	testq	%r14, %r14
	je	.LBB126_294
.LBB126_289:
	testq	%rax, %rax
	je	.LBB126_294
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_294
	testq	%rax, %rax
	jle	.LBB126_294
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	movq	%r14, %rdi
.LBB126_293:
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_294:
	testq	%rbx, %rbx
	je	.LBB126_739
.LBB126_295:
	leaq	.L__unnamed_203(%rip), %rdx
	leaq	5032(%rsp), %rdi
	movl	$1, %esi
	movl	$1, %ecx
	callq	*_ZN3aml10AmlContext3new17h86bbe3822d7e3046E@GOTPCREL(%rip)
	leaq	1440(%rsp), %rdi
	leaq	1360(%rsp), %rsi
	callq	_ZN4acpi19AcpiTables$LT$H$GT$7get_sdt17h7b6644ec31d1e378E
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_833
	movq	1456(%rsp), %rsi
	testq	%rsi, %rsi
	je	.LBB126_834
	leaq	1440(%rsp), %r13
	movq	%r13, %rdi
	callq	*_ZN4acpi4fadt4Fadt12dsdt_address17hcc7ccb55cbeb88bfE@GOTPCREL(%rip)
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_835
	movq	1448(%rsp), %rbx
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB126_300
	movq	%rbx, 5896(%rsp)
	leaq	5896(%rsp), %rax
	movq	%rax, 208(%rsp)
	movq	_ZN4core3fmt3num55_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$usize$GT$3fmt17h0338f6cb554ca680E@GOTPCREL(%rip), %rax
	movq	%rax, 216(%rsp)
	leaq	.L__unnamed_204(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	208(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_205(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_300:
	cmpq	$0, 1384(%rsp)
	je	.LBB126_836
	movl	1400(%rsp), %r14d
	movq	%rbx, %rax
	shrq	$47, %rax
	movq	%rbx, %rbp
	je	.LBB126_305
	movq	%rbx, %rbp
	cmpl	$131071, %eax
	je	.LBB126_305
	cmpl	$1, %eax
	jne	.LBB126_849
	movq	%rbx, %rbp
	shlq	$16, %rbp
	sarq	$16, %rbp
.LBB126_305:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_310
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_308:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_310
	cmpq	$3, %rax
	jne	.LBB126_308
	jmp	.LBB126_750
.LBB126_310:
	movabsq	$4503599627370495, %rax
	cmpq	%rax, %rbx
	ja	.LBB126_802
	shlq	$16, %rbp
	sarq	$16, %rbp
	andq	$-4096, %rbp
	addq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rbp
	movq	%rbp, %rax
	shrq	$47, %rax
	movq	%rbp, %rdx
	je	.LBB126_315
	movq	%rbp, %rdx
	cmpl	$131071, %eax
	je	.LBB126_315
	cmpl	$1, %eax
	jne	.LBB126_817
	movq	%rbp, %rdx
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB126_315:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_320
	cmpq	$1, %rax
	je	.LBB126_837
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_318:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_320
	cmpq	$3, %rax
	jne	.LBB126_318
	jmp	.LBB126_750
.LBB126_320:
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_321:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB126_323
.LBB126_322:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_322
	jmp	.LBB126_321
.LBB126_323:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_328
	cmpq	$1, %rax
	je	.LBB126_837
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_326:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_328
	cmpq	$3, %rax
	jne	.LBB126_326
	jmp	.LBB126_750
.LBB126_328:
	shlq	$16, %rdx
	sarq	$16, %rdx
	andq	$-4096, %rbx
	andq	$-4096, %rdx
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_329:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_331
.LBB126_330:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_330
	jmp	.LBB126_329
.LBB126_331:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	1336(%rsp), %rdi
	movl	$19, %r8d
	movq	%rbx, %rcx
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 1336(%rsp)
	movq	1344(%rsp), %rax
	je	.LBB126_336
	cmpq	$1, %rax
	je	.LBB126_337
	cmpq	$2, %rax
	jne	.LBB126_850
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_340
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_339
.LBB126_336:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB126_340
.LBB126_337:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_340
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_339:
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_206(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_340:
	leaq	32(%rsp), %rdi
	leaq	5032(%rsp), %rsi
	callq	*_ZN3aml10AmlContext18initialize_objects17hba61c8baac74fbcbE@GOTPCREL(%rip)
	cmpb	$46, 32(%rsp)
	jne	.LBB126_423
	addq	$36, %rbp
	leaq	88(%rsp), %rdi
	leaq	5032(%rsp), %rsi
	movq	%rbp, %rdx
	movq	%r14, %rcx
	callq	*_ZN3aml10AmlContext11parse_table17h1c8f69c41d08d83cE@GOTPCREL(%rip)
	cmpb	$46, 88(%rsp)
	jne	.LBB126_421
	leaq	.L__unnamed_207(%rip), %rsi
	leaq	1440(%rsp), %rdi
	movl	$5, %edx
	callq	*_ZN3aml9namespace7AmlName8from_str17h9ec69c715bd21ecbE@GOTPCREL(%rip)
	cmpq	$0, 1440(%rsp)
	jne	.LBB126_854
	movq	1464(%rsp), %rax
	movq	%rax, 5912(%rsp)
	movq	1448(%rsp), %rax
	movq	1456(%rsp), %rcx
	movq	%rcx, 5904(%rsp)
	movq	%rax, 5896(%rsp)
	movb	$1, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movb	$14, 1488(%rsp)
	movb	$14, 1536(%rsp)
	movb	$14, 1584(%rsp)
	movb	$14, 1632(%rsp)
	movb	$14, 1680(%rsp)
	movb	$14, 1728(%rsp)
	leaq	208(%rsp), %rdi
	leaq	5032(%rsp), %rsi
	leaq	5896(%rsp), %rdx
	leaq	1440(%rsp), %rcx
	callq	*_ZN3aml10AmlContext13invoke_method17h136e62947b7d1f6dE@GOTPCREL(%rip)
	cmpq	$0, 208(%rsp)
	leaq	216(%rsp), %rdi
	je	.LBB126_345
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
	movq	5904(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB126_346
	jmp	.LBB126_350
.LBB126_345:
	callq	_ZN4core3ptr41drop_in_place$LT$aml..value..AmlValue$GT$17h41dfa1a5d31d7fb8E
	movq	5904(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_350
.LBB126_346:
	movl	$5, %ecx
	mulq	%rcx
	jo	.LBB126_350
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	testq	%rax, %rax
	js	.LBB126_350
	je	.LBB126_350
	movq	5896(%rsp), %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_350:
	leaq	.L__unnamed_208(%rip), %rsi
	leaq	1440(%rsp), %rdi
	movl	$14, %edx
	callq	*_ZN3aml9namespace7AmlName8from_str17h9ec69c715bd21ecbE@GOTPCREL(%rip)
	cmpq	$0, 1440(%rsp)
	jne	.LBB126_855
	movq	1464(%rsp), %rax
	movq	%rax, 192(%rsp)
	movq	1448(%rsp), %rax
	movq	1456(%rsp), %rcx
	movq	%rcx, 184(%rsp)
	movq	%rax, 176(%rsp)
	leaq	5896(%rsp), %rdi
	leaq	176(%rsp), %rsi
	leaq	5032(%rsp), %rdx
	callq	*_ZN3aml11pci_routing15PciRoutingTable13from_prt_path17ha340b710ada6d16dE@GOTPCREL(%rip)
	cmpq	$0, 5896(%rsp)
	jne	.LBB126_414
	movq	5920(%rsp), %rax
	movq	%rax, 152(%rsp)
	movq	5904(%rsp), %rax
	movq	5912(%rsp), %rcx
	movq	%rcx, 144(%rsp)
	movq	%rax, 136(%rsp)
	leaq	208(%rsp), %rdi
	leaq	136(%rsp), %rsi
	leaq	5032(%rsp), %r9
	movl	$1, %edx
	movl	$6, %ecx
	xorl	%r8d, %r8d
	callq	*_ZN3aml11pci_routing15PciRoutingTable5route17hc54f8a2a0622659dE@GOTPCREL(%rip)
	cmpl	$0, 208(%rsp)
	jne	.LBB126_363
	movl	220(%rsp), %eax
	movl	%eax, 16(%rsp)
	movq	212(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB126_355
	leaq	8(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	_ZN65_$LT$aml..resource..IrqDescriptor$u20$as$u20$core..fmt..Debug$GT$3fmt17hc81a1e9125b6c3cdE@GOTPCREL(%rip), %rax
	movq	%rax, 72(%rsp)
	leaq	.L__unnamed_209(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_210(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_355:
	callq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E
	movq	%rax, %rbx
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_356:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, (%rbx)
	je	.LBB126_358
.LBB126_357:
	movzbl	(%rbx), %eax
	testb	%al, %al
	jne	.LBB126_357
	jmp	.LBB126_356
.LBB126_358:
	movq	%rbx, %rdi
	addq	$16, %rdi
	movl	8(%rsp), %esi
	addl	$32, %esi
	leaq	.L__unnamed_211(%rip), %rdx
	callq	_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E
	movq	%rax, %rbp
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB126_362
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rcx
	movq	%rcx, %rdx
	shrq	$47, %rdx
	cmpl	$131071, %edx
	je	.LBB126_362
	cmpl	$1, %edx
	jne	.LBB126_843
	shlq	$16, %rcx
	sarq	$16, %rcx
	movq	%rcx, %rax
.LBB126_362:
	movw	%ax, (%rbp)
	movq	%rax, %rcx
	shrq	$16, %rcx
	movw	%cx, 6(%rbp)
	shrq	$32, %rax
	movl	%eax, 8(%rbp)
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movw	%ax, 2(%rbp)
	orb	$-128, 5(%rbp)
	movb	$0, (%rbx)
	cmpl	$0, 208(%rsp)
	je	.LBB126_364
.LBB126_363:
	leaq	216(%rsp), %rdi
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
.LBB126_364:
	leaq	208(%rsp), %rdi
	leaq	136(%rsp), %rsi
	leaq	5032(%rsp), %r9
	movl	$1, %edx
	movl	$6, %ecx
	movl	$1, %r8d
	callq	*_ZN3aml11pci_routing15PciRoutingTable5route17hc54f8a2a0622659dE@GOTPCREL(%rip)
	cmpl	$0, 208(%rsp)
	jne	.LBB126_375
	movl	220(%rsp), %eax
	movl	%eax, 16(%rsp)
	movq	212(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB126_367
	leaq	8(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	_ZN65_$LT$aml..resource..IrqDescriptor$u20$as$u20$core..fmt..Debug$GT$3fmt17hc81a1e9125b6c3cdE@GOTPCREL(%rip), %rax
	movq	%rax, 72(%rsp)
	leaq	.L__unnamed_212(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_213(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_367:
	callq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E
	movq	%rax, %rbx
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_368:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, (%rbx)
	je	.LBB126_370
.LBB126_369:
	movzbl	(%rbx), %eax
	testb	%al, %al
	jne	.LBB126_369
	jmp	.LBB126_368
.LBB126_370:
	movq	%rbx, %rdi
	addq	$16, %rdi
	movl	8(%rsp), %esi
	addl	$32, %esi
	leaq	.L__unnamed_214(%rip), %rdx
	callq	_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E
	movq	%rax, %rbp
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB126_374
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rcx
	movq	%rcx, %rdx
	shrq	$47, %rdx
	cmpl	$131071, %edx
	je	.LBB126_374
	cmpl	$1, %edx
	jne	.LBB126_843
	shlq	$16, %rcx
	sarq	$16, %rcx
	movq	%rcx, %rax
.LBB126_374:
	movw	%ax, (%rbp)
	movq	%rax, %rcx
	shrq	$16, %rcx
	movw	%cx, 6(%rbp)
	shrq	$32, %rax
	movl	%eax, 8(%rbp)
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movw	%ax, 2(%rbp)
	orb	$-128, 5(%rbp)
	movb	$0, (%rbx)
	cmpl	$0, 208(%rsp)
	je	.LBB126_376
.LBB126_375:
	leaq	216(%rsp), %rdi
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
.LBB126_376:
	leaq	208(%rsp), %rdi
	leaq	136(%rsp), %rsi
	leaq	5032(%rsp), %r9
	movl	$1, %edx
	movl	$6, %ecx
	movl	$2, %r8d
	callq	*_ZN3aml11pci_routing15PciRoutingTable5route17hc54f8a2a0622659dE@GOTPCREL(%rip)
	cmpl	$0, 208(%rsp)
	jne	.LBB126_387
	movl	220(%rsp), %eax
	movl	%eax, 16(%rsp)
	movq	212(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB126_379
	leaq	8(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	_ZN65_$LT$aml..resource..IrqDescriptor$u20$as$u20$core..fmt..Debug$GT$3fmt17hc81a1e9125b6c3cdE@GOTPCREL(%rip), %rax
	movq	%rax, 72(%rsp)
	leaq	.L__unnamed_215(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_216(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_379:
	callq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E
	movq	%rax, %rbx
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_380:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, (%rbx)
	je	.LBB126_382
.LBB126_381:
	movzbl	(%rbx), %eax
	testb	%al, %al
	jne	.LBB126_381
	jmp	.LBB126_380
.LBB126_382:
	movq	%rbx, %rdi
	addq	$16, %rdi
	movl	8(%rsp), %esi
	addl	$32, %esi
	leaq	.L__unnamed_217(%rip), %rdx
	callq	_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E
	movq	%rax, %rbp
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB126_386
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rcx
	movq	%rcx, %rdx
	shrq	$47, %rdx
	cmpl	$131071, %edx
	je	.LBB126_386
	cmpl	$1, %edx
	jne	.LBB126_843
	shlq	$16, %rcx
	sarq	$16, %rcx
	movq	%rcx, %rax
.LBB126_386:
	movw	%ax, (%rbp)
	movq	%rax, %rcx
	shrq	$16, %rcx
	movw	%cx, 6(%rbp)
	shrq	$32, %rax
	movl	%eax, 8(%rbp)
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movw	%ax, 2(%rbp)
	orb	$-128, 5(%rbp)
	movb	$0, (%rbx)
	cmpl	$0, 208(%rsp)
	je	.LBB126_388
.LBB126_387:
	leaq	216(%rsp), %rdi
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
.LBB126_388:
	leaq	208(%rsp), %rdi
	leaq	136(%rsp), %rsi
	leaq	5032(%rsp), %r9
	movl	$1, %edx
	movl	$6, %ecx
	movl	$3, %r8d
	callq	*_ZN3aml11pci_routing15PciRoutingTable5route17hc54f8a2a0622659dE@GOTPCREL(%rip)
	cmpl	$0, 208(%rsp)
	jne	.LBB126_399
	movl	220(%rsp), %eax
	movl	%eax, 16(%rsp)
	movq	212(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB126_391
	leaq	8(%rsp), %rax
	movq	%rax, 64(%rsp)
	movq	_ZN65_$LT$aml..resource..IrqDescriptor$u20$as$u20$core..fmt..Debug$GT$3fmt17hc81a1e9125b6c3cdE@GOTPCREL(%rip), %rax
	movq	%rax, 72(%rsp)
	leaq	.L__unnamed_218(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_219(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_391:
	callq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E
	movq	%rax, %rbx
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_392:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, (%rbx)
	je	.LBB126_394
.LBB126_393:
	movzbl	(%rbx), %eax
	testb	%al, %al
	jne	.LBB126_393
	jmp	.LBB126_392
.LBB126_394:
	movq	%rbx, %rdi
	addq	$16, %rdi
	movl	8(%rsp), %esi
	addl	$32, %esi
	leaq	.L__unnamed_220(%rip), %rdx
	callq	_ZN109_$LT$x86_64..structures..idt..InterruptDescriptorTable$u20$as$u20$core..ops..index..IndexMut$LT$usize$GT$$GT$9index_mut17h1afbd5852dd01a90E
	movq	%rax, %rbp
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB126_398
	leaq	_ZN7cryptos10interrupts4ahci17h10f98ee84be380e8E(%rip), %rcx
	movq	%rcx, %rdx
	shrq	$47, %rdx
	cmpl	$131071, %edx
	je	.LBB126_398
	cmpl	$1, %edx
	jne	.LBB126_843
	shlq	$16, %rcx
	sarq	$16, %rcx
	movq	%rcx, %rax
.LBB126_398:
	movw	%ax, (%rbp)
	movq	%rax, %rcx
	shrq	$16, %rcx
	movw	%cx, 6(%rbp)
	shrq	$32, %rax
	movl	%eax, 8(%rbp)
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movw	%ax, 2(%rbp)
	orb	$-128, 5(%rbp)
	movb	$0, (%rbx)
	cmpl	$0, 208(%rsp)
	je	.LBB126_400
.LBB126_399:
	leaq	216(%rsp), %rdi
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
.LBB126_400:
	movq	152(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_409
	movq	136(%rsp), %rbx
	shlq	$3, %rax
	leaq	(%rax,%rax,4), %r14
	xorl	%ebp, %ebp
	movl	$5, %r15d
	movq	__rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB126_403
	.p2align	4, 0x90
.LBB126_402:
	addq	$40, %rbp
	cmpq	%rbp, %r14
	je	.LBB126_409
.LBB126_403:
	cmpl	$0, (%rbx,%rbp)
	je	.LBB126_402
	movq	16(%rbx,%rbp), %rax
	testq	%rax, %rax
	je	.LBB126_402
	mulq	%r15
	jo	.LBB126_402
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	testq	%rax, %rax
	js	.LBB126_402
	je	.LBB126_402
	movq	8(%rbx,%rbp), %rdi
	movq	%rax, %rsi
	callq	*%r12
	jmp	.LBB126_402
.LBB126_409:
	movq	144(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_413
	movl	$40, %ecx
	mulq	%rcx
	jo	.LBB126_413
	movabsq	$-9223372036854775805, %rdx
	leaq	5(%rdx), %rcx
	addq	%rax, %rdx
	addq	$4, %rdx
	cmpq	%rcx, %rdx
	jb	.LBB126_413
	movq	136(%rsp), %rdi
	movl	$8, %edx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_413:
	cmpq	$0, 5896(%rsp)
	je	.LBB126_415
.LBB126_414:
	leaq	5904(%rsp), %rdi
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
.LBB126_415:
	movq	184(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_420
	movl	$5, %ecx
	mulq	%rcx
	jo	.LBB126_420
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	testq	%rax, %rax
	js	.LBB126_420
	je	.LBB126_420
	movq	176(%rsp), %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_420:
	cmpb	$46, 88(%rsp)
	je	.LBB126_422
.LBB126_421:
	leaq	88(%rsp), %rdi
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
.LBB126_422:
	cmpb	$46, 32(%rsp)
	je	.LBB126_424
.LBB126_423:
	leaq	32(%rsp), %rdi
	callq	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
.LBB126_424:
	callq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E
	movq	%r13, %rdi
	movq	%rax, %rsi
	callq	*_ZN6x86_6410structures3gdt21GlobalDescriptorTable7pointer17h645f91ecb792cfdaE@GOTPCREL(%rip)
	#APP

	lgdtq	(%r13)

	#NO_APP
	callq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E
	movl	72(%rax), %edi
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7set_reg17hcb525cfe55c8a006E@GOTPCREL(%rip)
	callq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E
	movzwl	74(%rax), %edi
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..DS$GT$7set_reg17h5e665f739675bad6E@GOTPCREL(%rip)
	callq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E
	movl	76(%rax), %edi
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..ES$GT$7set_reg17h083b52356ba371e7E@GOTPCREL(%rip)
	callq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E
	movzwl	78(%rax), %edi
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..FS$GT$7set_reg17h4b0a436d9096f470E@GOTPCREL(%rip)
	callq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E
	movl	80(%rax), %edi
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..GS$GT$7set_reg17h904a9189aa2539dcE@GOTPCREL(%rip)
	callq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E
	movzwl	82(%rax), %eax
	#APP

	ltrw	%ax

	#NO_APP
	movq	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+4112(%rip), %rax
	testq	%rax, %rax
	jne	.LBB126_430
	movl	$1, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+4112(%rip)
	jne	.LBB126_430
	leaq	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+4112(%rip), %rax
	movq	%rax, 5896(%rsp)
	movb	$1, 5904(%rsp)
	callq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E
	movq	%rax, %rbx
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_427:
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, (%rbx)
	je	.LBB126_487
.LBB126_428:
	movzbl	(%rbx), %eax
	testb	%al, %al
	jne	.LBB126_428
	jmp	.LBB126_427
	.p2align	4, 0x90
.LBB126_429:
	movq	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+4112(%rip), %rax
.LBB126_430:
	cmpq	$1, %rax
	je	.LBB126_429
	cmpq	$2, %rax
	jne	.LBB126_791
.LBB126_432:
	leaq	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+16(%rip), %rsi
	movq	%r13, %rdi
	callq	*_ZN6x86_6410structures3idt24InterruptDescriptorTable7pointer17hb2f06b68aea1c2a8E@GOTPCREL(%rip)
	#APP

	lidtq	(%r13)

	#NO_APP
	movw	$32, %dx
	movb	$17, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$160, %dx
	movb	$17, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$128, %dx
	xorl	%eax, %eax
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$33, %dx
	movb	$-8, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$161, %dx
	movb	$-1, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$128, %dx
	xorl	%eax, %eax
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$33, %dx
	movb	$4, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$128, %dx
	xorl	%eax, %eax
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$161, %dx
	movb	$2, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$128, %dx
	xorl	%eax, %eax
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$33, %dx
	movb	$1, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$161, %dx
	movb	$1, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$128, %dx
	xorl	%eax, %eax
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$33, %dx
	movb	$-1, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movw	$161, %dx
	movb	$-1, %al
	#APP

	outb	%al, %dx

	#NO_APP
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_437
	cmpq	$1, %rax
	je	.LBB126_848
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_435:
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_437
	cmpq	$3, %rax
	jne	.LBB126_435
	jmp	.LBB126_750
.LBB126_437:
	cmpb	$2, _ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+112(%rip)
	je	.LBB126_815
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_443
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_441:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_443
	cmpq	$3, %rax
	jne	.LBB126_441
	jmp	.LBB126_750
.LBB126_443:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %r15
	movq	$8, 136(%rsp)
	movq	$0, 144(%rsp)
	movq	$0, 152(%rsp)
	movq	$4, 32(%rsp)
	movq	$0, 40(%rsp)
	movq	$0, 48(%rsp)
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+8(%rip), %rcx
	movabsq	$4503599627370495, %rax
	cmpq	%rax, %rcx
	ja	.LBB126_802
	leaq	(%rcx,%r15), %rbp
	movq	%rbp, %rax
	shrq	$47, %rax
	movq	%rbp, %rdx
	je	.LBB126_448
	movq	%rbp, %rdx
	cmpl	$131071, %eax
	je	.LBB126_448
	cmpl	$1, %eax
	jne	.LBB126_817
	movq	%rbp, %rdx
	shlq	$16, %rdx
	sarq	$16, %rdx
.LBB126_448:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_453
	cmpq	$1, %rax
	je	.LBB126_838
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_451:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rsi
	cmpq	$2, %rsi
	jb	.LBB126_453
	cmpq	$3, %rax
	jne	.LBB126_451
	jmp	.LBB126_750
.LBB126_453:
	movb	$1, %bl
	.p2align	4, 0x90
.LBB126_454:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB126_456
.LBB126_455:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_455
	jmp	.LBB126_454
.LBB126_456:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_461
	cmpq	$1, %rax
	je	.LBB126_838
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_459:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rsi
	cmpq	$2, %rsi
	jb	.LBB126_461
	cmpq	$3, %rax
	jne	.LBB126_459
	jmp	.LBB126_750
.LBB126_461:
	shlq	$16, %rdx
	sarq	$16, %rdx
	andq	$-4096, %rcx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB126_462:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_464
.LBB126_463:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_463
	jmp	.LBB126_462
.LBB126_464:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	88(%rsp), %rdi
	movl	$3, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 88(%rsp)
	movq	96(%rsp), %rax
	je	.LBB126_469
	cmpq	$1, %rax
	je	.LBB126_470
	cmpq	$2, %rax
	jne	.LBB126_851
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_473
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_472
.LBB126_469:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB126_473
.LBB126_470:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_473
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_472:
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_221(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_473:
	leaq	5896(%rsp), %r12
	movq	%r12, %rdi
	callq	*_ZN6x2apic5lapic7builder16LocalApicBuilder3new17hd14023d897d89b08E@GOTPCREL(%rip)
	movl	$254, %esi
	movq	%r12, %rdi
	callq	*_ZN6x2apic5lapic7builder16LocalApicBuilder12timer_vector17hd73ce2e939d823b4E@GOTPCREL(%rip)
	movl	$49, %esi
	movq	%rax, %rdi
	callq	*_ZN6x2apic5lapic7builder16LocalApicBuilder12error_vector17h1754dc23885d7fe1E@GOTPCREL(%rip)
	movl	$255, %esi
	movq	%rax, %rdi
	callq	*_ZN6x2apic5lapic7builder16LocalApicBuilder15spurious_vector17h05a990e1f557b22cE@GOTPCREL(%rip)
	movq	%rax, %rdi
	movq	%rbp, %rsi
	callq	*_ZN6x2apic5lapic7builder16LocalApicBuilder14set_xapic_base17h10e916497167c96aE@GOTPCREL(%rip)
	leaq	1440(%rsp), %rdi
	movq	%rax, %rsi
	callq	*_ZN6x2apic5lapic7builder16LocalApicBuilder5build17h080c34fb2399001fE@GOTPCREL(%rip)
	cmpq	$0, 1440(%rsp)
	jne	.LBB126_839
	leaq	1448(%rsp), %rsi
	leaq	208(%rsp), %rdi
	movl	$744, %edx
	callq	*memcpy@GOTPCREL(%rip)
	leaq	1440(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_ZN9raw_cpuid5CpuId3new17h3022a9cfaef0ff76E@GOTPCREL(%rip)
	leaq	8(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_ZN9raw_cpuid5CpuId26get_extended_topology_info17h88ae6d1b42a6bd46E@GOTPCREL(%rip)
	cmpb	$2, 20(%rsp)
	movq	%r15, 24(%rsp)
	jne	.LBB126_478
	leaq	208(%rsp), %rdi
	callq	*_ZN6x2apic5lapic9LocalApic2id17ha81411ed2eb0009bE@GOTPCREL(%rip)
	movl	%eax, %r14d
	movq	48(%rsp), %rbx
	cmpq	40(%rsp), %rbx
	jne	.LBB126_477
	leaq	32(%rsp), %rdi
	movq	%rbx, %rsi
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hd04702c74329d1adE
	movq	48(%rsp), %rbx
.LBB126_477:
	movq	32(%rsp), %rbp
	movl	%r14d, (%rbp,%rbx,4)
	addq	$1, %rbx
	movq	%rbx, 48(%rsp)
	movq	40(%rsp), %rax
	movq	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E(%rip), %rcx
	cmpq	$2, %rcx
	je	.LBB126_489
.LBB126_484:
	cmpq	$1, %rcx
	je	.LBB126_741
	cmpq	$3, %rcx
	je	.LBB126_793
	xorl	%ebx, %ebx
	testq	%rax, %rax
	jne	.LBB126_490
	jmp	.LBB126_494
.LBB126_478:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rcx, 72(%rsp)
	movq	%rax, 64(%rsp)
	leaq	5896(%rsp), %rdi
	leaq	64(%rsp), %rsi
	callq	*_ZN90_$LT$raw_cpuid..ExtendedTopologyIter$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he4d14528906a6b13E@GOTPCREL(%rip)
	cmpl	$0, 5896(%rsp)
	je	.LBB126_488
	leaq	5900(%rsp), %r15
	movq	48(%rsp), %rbx
	leaq	64(%rsp), %r14
	movq	_ZN90_$LT$raw_cpuid..ExtendedTopologyIter$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17he4d14528906a6b13E@GOTPCREL(%rip), %r13
	jmp	.LBB126_481
	.p2align	4, 0x90
.LBB126_480:
	movq	32(%rsp), %rbp
	movl	%r12d, (%rbp,%rbx,4)
	addq	$1, %rbx
	movq	%rbx, 48(%rsp)
	leaq	5896(%rsp), %rdi
	movq	%r14, %rsi
	callq	*%r13
	cmpl	$0, 5896(%rsp)
	je	.LBB126_483
.LBB126_481:
	movq	(%r15), %rax
	movq	8(%r15), %rcx
	movq	%rcx, 184(%rsp)
	movq	%rax, 176(%rsp)
	leaq	176(%rsp), %rdi
	callq	*_ZN9raw_cpuid21ExtendedTopologyLevel9x2apic_id17h81f4098d2bf00a51E@GOTPCREL(%rip)
	movl	%eax, %r12d
	cmpq	40(%rsp), %rbx
	jne	.LBB126_480
	leaq	32(%rsp), %rdi
	movq	%rbx, %rsi
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hd04702c74329d1adE
	movq	48(%rsp), %rbx
	jmp	.LBB126_480
.LBB126_483:
	movq	24(%rsp), %r15
	leaq	5896(%rsp), %r12
	movq	40(%rsp), %rax
	movq	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E(%rip), %rcx
	cmpq	$2, %rcx
	jne	.LBB126_484
.LBB126_489:
	leaq	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E+8(%rip), %rbx
	testq	%rax, %rax
	je	.LBB126_494
.LBB126_490:
	movl	$4, %ecx
	mulq	%rcx
	jo	.LBB126_494
	movabsq	$-9223372036854775805, %rdx
	leaq	(%rax,%rdx), %rcx
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	jb	.LBB126_494
	movl	$4, %edx
	movq	%rbp, %rdi
.LBB126_493:
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_494:
	testq	%rbx, %rbx
	je	.LBB126_748
.LBB126_495:
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+32(%rip), %rax
	testq	%rax, %rax
	je	.LBB126_528
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+16(%rip), %rbx
	leaq	(%rax,%rax,2), %rax
	leaq	(%rbx,%rax,4), %rax
	movq	%rax, 80(%rsp)
	movb	$1, %bpl
	jmp	.LBB126_499
	.p2align	4, 0x90
.LBB126_497:
	#APP

	invlpg	(%rax)

	#NO_APP
	movq	24(%rsp), %r15
.LBB126_498:
	addq	$12, %rbx
	cmpq	%rbx, 80(%rsp)
	je	.LBB126_528
.LBB126_499:
	movl	(%rbx), %r12d
	leaq	(%r15,%r12), %r13
	movq	%r13, %rdi
	callq	*_ZN6x2apic6ioapic6IoApic3new17h04f38be155d06adbE@GOTPCREL(%rip)
	movq	%rax, %r14
	movq	%rdx, %r15
	movq	152(%rsp), %rsi
	cmpq	144(%rsp), %rsi
	jne	.LBB126_501
	leaq	136(%rsp), %rdi
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$16reserve_for_push17hcdf995785f56f774E
	movq	152(%rsp), %rsi
.LBB126_501:
	movq	136(%rsp), %rax
	movq	%rsi, %rcx
	shlq	$4, %rcx
	movq	%r14, (%rax,%rcx)
	movq	%r15, 8(%rax,%rcx)
	addq	$1, %rsi
	movq	%rsi, 152(%rsp)
	movq	%r13, %rax
	shrq	$47, %rax
	je	.LBB126_505
	cmpl	$131071, %eax
	je	.LBB126_505
	cmpl	$1, %eax
	jne	.LBB126_805
	shlq	$16, %r13
	sarq	$16, %r13
.LBB126_505:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_511
	cmpq	$1, %rax
	je	.LBB126_796
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_508:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_511
	cmpq	$3, %rax
	jne	.LBB126_508
	jmp	.LBB126_750
	.p2align	4, 0x90
.LBB126_510:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_510
.LBB126_511:
	xorl	%eax, %eax
	lock		cmpxchgb	%bpl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	jne	.LBB126_510
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_517
	cmpq	$1, %rax
	je	.LBB126_796
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_515:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_517
	cmpq	$3, %rax
	jne	.LBB126_515
	jmp	.LBB126_750
	.p2align	4, 0x90
.LBB126_517:
	shlq	$16, %r13
	andl	$-4096, %r12d
	sarq	$16, %r13
	andq	$-4096, %r13
	.p2align	4, 0x90
.LBB126_518:
	xorl	%eax, %eax
	lock		cmpxchgb	%bpl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_520
.LBB126_519:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_519
	jmp	.LBB126_518
	.p2align	4, 0x90
.LBB126_520:
	movl	$3, %r8d
	leaq	5896(%rsp), %rdi
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	movq	%r13, %rdx
	movq	%r12, %rcx
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 5896(%rsp)
	movq	5904(%rsp), %rax
	je	.LBB126_497
	cmpq	$1, %rax
	movq	24(%rsp), %r15
	je	.LBB126_525
	cmpq	$2, %rax
	jne	.LBB126_806
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_498
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_527
	.p2align	4, 0x90
.LBB126_525:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_498
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_527:
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	movl	$4, %esi
	leaq	1440(%rsp), %rdi
	leaq	.L__unnamed_222(%rip), %rdx
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	jmp	.LBB126_498
.LBB126_528:
	movq	208(%rsp), %r15
	leaq	216(%rsp), %rsi
	leaq	1440(%rsp), %rdi
	movl	$736, %edx
	callq	*memcpy@GOTPCREL(%rip)
	cmpq	$2, %r15
	je	.LBB126_815
	movq	136(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	144(%rsp), %rax
	movq	%rax, 168(%rsp)
	movq	152(%rsp), %r12
	leaq	208(%rsp), %r14
	leaq	1440(%rsp), %rsi
	movl	$736, %edx
	movq	%r14, %rdi
	movq	memcpy@GOTPCREL(%rip), %rbx
	callq	*%rbx
	leaq	5896(%rsp), %rbp
	movl	$736, %edx
	movq	%rbp, %rdi
	movq	%r14, %rsi
	callq	*%rbx
	leaq	1440(%rsp), %rdi
	movl	$736, %edx
	movq	%rbp, %rsi
	callq	*%rbx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB126_530:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	je	.LBB126_532
.LBB126_531:
	movzbl	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip), %eax
	testb	%al, %al
	jne	.LBB126_531
	jmp	.LBB126_530
.LBB126_532:
	movq	%r15, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip)
	leaq	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+16(%rip), %rdi
	leaq	1440(%rsp), %rsi
	movl	$736, %edx
	callq	*memcpy@GOTPCREL(%rip)
	movb	$0, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	je	.LBB126_536
	movb	$1, %cl
	.p2align	4, 0x90
.LBB126_534:
	movzbl	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip), %eax
	testb	%al, %al
	jne	.LBB126_534
	xorl	%eax, %eax
	lock		cmpxchgb	%cl, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	jne	.LBB126_534
.LBB126_536:
	cmpl	$2, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip)
	je	.LBB126_840
	leaq	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip), %rdi
	callq	*_ZN6x2apic5lapic9LocalApic6enable17hb2bd84fce1f4d518E@GOTPCREL(%rip)
	movb	$0, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	testq	%r12, %r12
	je	.LBB126_547
	shlq	$4, %r12
	movq	160(%rsp), %rax
	addq	%rax, %r12
	movq	%r12, 80(%rsp)
	leaq	1440(%rsp), %rbp
	leaq	208(%rsp), %rbx
	movb	$1, %r12b
	movq	_ZN6x2apic6ioapic6IoApic10enable_irq17hcaf9af1f43e657b9E@GOTPCREL(%rip), %r13
	movq	%rax, %rdx
	.p2align	4, 0x90
.LBB126_539:
	movq	(%rdx), %rax
	testq	%rax, %rax
	je	.LBB126_547
	movq	8(%rdx), %rcx
	addq	$16, %rdx
	movq	%rdx, 24(%rsp)
	movq	%rax, 1440(%rsp)
	movq	%rcx, 1448(%rsp)
	movq	%rbp, %rdi
	movl	$32, %esi
	callq	*_ZN6x2apic6ioapic6IoApic4init17hb0d86145b1210dcfE@GOTPCREL(%rip)
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB126_541:
	movq	$0, 208(%rsp)
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	*_ZN6x2apic6ioapic9irq_entry21RedirectionTableEntry8set_mode17h74099e3b9c951d49E@GOTPCREL(%rip)
	movq	%rbx, %rdi
	movl	$40960, %esi
	callq	*_ZN6x2apic6ioapic9irq_entry21RedirectionTableEntry9set_flags17h2bc9aba8a581e6e7E@GOTPCREL(%rip)
	movzbl	%r14b, %r15d
	movq	%rbx, %rdi
	movl	%r15d, %esi
	callq	*_ZN6x2apic6ioapic9irq_entry21RedirectionTableEntry10set_vector17h5888a75287c02d5bE@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB126_542:
	xorl	%eax, %eax
	lock		cmpxchgb	%r12b, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	je	.LBB126_544
.LBB126_543:
	movzbl	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip), %eax
	testb	%al, %al
	jne	.LBB126_543
	jmp	.LBB126_542
	.p2align	4, 0x90
.LBB126_544:
	cmpl	$2, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip)
	je	.LBB126_790
	leal	1(%r15), %r14d
	leaq	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E+8(%rip), %rdi
	callq	*_ZN6x2apic5lapic9LocalApic2id17ha81411ed2eb0009bE@GOTPCREL(%rip)
	movq	%rbx, %rdi
	movl	%eax, %esi
	callq	*_ZN6x2apic6ioapic9irq_entry21RedirectionTableEntry8set_dest17h92a256f4b13172cdE@GOTPCREL(%rip)
	movb	$0, _ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E(%rip)
	movl	208(%rsp), %edx
	movl	212(%rsp), %ecx
	movq	%rbp, %rdi
	movl	%r15d, %esi
	callq	*_ZN6x2apic6ioapic6IoApic15set_table_entry17heb1c0dc5c2b49336E@GOTPCREL(%rip)
	movq	%rbp, %rdi
	movl	%r15d, %esi
	callq	*%r13
	cmpb	$-33, %r14b
	jne	.LBB126_541
	movq	24(%rsp), %rdx
	cmpq	80(%rsp), %rdx
	jne	.LBB126_539
.LBB126_547:
	movq	168(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_551
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_551
	movabsq	$-9223372036854775805, %rdx
	leaq	5(%rdx), %rcx
	addq	%rax, %rdx
	addq	$4, %rdx
	cmpq	%rcx, %rdx
	jb	.LBB126_551
	movl	$8, %edx
	movq	160(%rsp), %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_551:
	#APP

	sti

	#NO_APP
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	movq	200(%rsp), %rbx
	leaq	208(%rsp), %rbp
	jbe	.LBB126_559
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_558
	cmpq	$1, %rax
	je	.LBB126_858
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_555:
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_558
	cmpq	$3, %rax
	jne	.LBB126_555
	jmp	.LBB126_750
.LBB126_558:
	leaq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE+8(%rip), %rax
	movq	%rax, 5896(%rsp)
	leaq	5896(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h09a8297dbb6045aaE(%rip), %rax
	movq	%rax, 216(%rsp)
	leaq	.L__unnamed_223(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	movq	%rbp, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_224(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_559:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_561
	addq	$136, %rbx
	movq	%rbx, 208(%rsp)
	leaq	_ZN77_$LT$bootloader..boot_info..Optional$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h6f03146962576cc2E(%rip), %rax
	movq	%rax, 216(%rsp)
	leaq	.L__unnamed_225(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	movq	%rbp, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_226(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_561:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB126_567
	movq	%rbp, %rdi
	callq	_ZN7cryptos8get_mcfg17hbfcae760a4136b45E
	movq	%rbp, 5896(%rsp)
	leaq	_ZN66_$LT$core..option..Option$LT$T$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h54c40caeb88a5c77E(%rip), %rax
	movq	%rax, 5904(%rsp)
	leaq	.L__unnamed_227(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_228(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	5896(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_229(%rip), %rdx
	leaq	1440(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	208(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB126_567
	movq	216(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_567
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_567
	testq	%rax, %rax
	jle	.LBB126_567
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_567:
	xorl	%ebp, %ebp
	jmp	.LBB126_569
	.p2align	4, 0x90
.LBB126_568:
	movl	%r14d, %ebp
	cmpl	$16777215, %r14d
	je	.LBB126_722
.LBB126_569:
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_574
	cmpq	$1, %rax
	je	.LBB126_799
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_572:
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_574
	cmpq	$3, %rax
	jne	.LBB126_572
	jmp	.LBB126_750
	.p2align	4, 0x90
.LBB126_574:
	leal	1(%rbp), %r14d
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+8(%rip), %r15
	testq	%r15, %r15
	je	.LBB126_568
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E+24(%rip), %rbx
	testq	%rbx, %rbx
	movl	%r14d, 24(%rsp)
	je	.LBB126_580
	movq	%rbx, %rax
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_852
	movq	%rax, %r12
	movq	%rax, %r13
	notq	%r13
	shrq	$63, %r13
	testq	%rax, %rax
	js	.LBB126_852
	je	.LBB126_581
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	movq	%rax, %r14
	testq	%r14, %r14
	jne	.LBB126_582
	jmp	.LBB126_801
	.p2align	4, 0x90
.LBB126_580:
	movl	$1, %r14d
	jmp	.LBB126_582
.LBB126_581:
	movq	%r13, %r14
	testq	%r14, %r14
	je	.LBB126_801
.LBB126_582:
	movq	%rbx, %rdx
	shlq	$4, %rdx
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	*memcpy@GOTPCREL(%rip)
	movq	%r14, 1440(%rsp)
	movq	%rbx, 1448(%rsp)
	movq	%rbx, 1456(%rsp)
	bswapl	%ebp
	movl	%ebp, %edx
	shrl	$8, %edx
	movzbl	%bpl, %esi
	movl	%ebp, %ecx
	shrl	$16, %ecx
	shrl	$24, %ebp
	leaq	1440(%rsp), %rdi
	movl	%ebp, %r8d
	callq	*_ZN4acpi4mcfg16PciConfigRegions16physical_address17hc54e233e461a8a6dE@GOTPCREL(%rip)
	movq	%rax, %rbx
	movq	%rdx, %r13
	movq	1448(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_587
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_587
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	testq	%rax, %rax
	js	.LBB126_587
	je	.LBB126_587
	movq	1440(%rsp), %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB126_587:
	testq	%rbx, %rbx
	movl	24(%rsp), %r14d
	je	.LBB126_568
	movq	%r13, 64(%rsp)
	movq	%r13, %rcx
	movq	%r13, %rax
	shrq	$47, %rcx
	je	.LBB126_592
	cmpl	$131071, %ecx
	movb	$1, %dl
	je	.LBB126_593
	cmpl	$1, %ecx
	jne	.LBB126_805
	movq	%r13, %rax
	shlq	$16, %rax
	sarq	$16, %rax
	jmp	.LBB126_593
.LBB126_592:
	movb	$1, %dl
.LBB126_593:
	movabsq	$4503599627370495, %rcx
	cmpq	%rcx, %r13
	ja	.LBB126_802
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, %r15
	andq	$-4096, %r15
	shrq	$47, %rax
	cmpq	$2, %rax
	jb	.LBB126_596
	cmpl	$131071, %eax
	jne	.LBB126_811
.LBB126_596:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_602
	cmpq	$1, %rax
	je	.LBB126_803
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_599:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_602
	cmpq	$3, %rax
	jne	.LBB126_599
	jmp	.LBB126_750
	.p2align	4, 0x90
.LBB126_601:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_601
.LBB126_602:
	xorl	%eax, %eax
	lock		cmpxchgb	%dl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	jne	.LBB126_601
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_608
	cmpq	$1, %rax
	je	.LBB126_803
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_606:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_608
	cmpq	$3, %rax
	jne	.LBB126_606
	jmp	.LBB126_750
	.p2align	4, 0x90
.LBB126_608:
	andq	$-4096, %r13
	.p2align	4, 0x90
.LBB126_609:
	xorl	%eax, %eax
	lock		cmpxchgb	%dl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_611
.LBB126_610:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_610
	jmp	.LBB126_609
	.p2align	4, 0x90
.LBB126_611:
	movl	$19, %r8d
	leaq	176(%rsp), %rdi
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	movq	%r15, %rdx
	movq	%r13, %rcx
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 176(%rsp)
	movq	184(%rsp), %rax
	je	.LBB126_616
	cmpq	$1, %rax
	je	.LBB126_617
	cmpq	$2, %rax
	jne	.LBB126_812
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_620
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_619
.LBB126_616:
	#APP

	invlpg	(%rax)

	#NO_APP
	jmp	.LBB126_620
.LBB126_617:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_620
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_619:
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	movl	$4, %esi
	leaq	1440(%rsp), %rdi
	leaq	.L__unnamed_230(%rip), %rdx
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_620:
	movq	56(%r15), %r8
	movq	%r8, 5952(%rsp)
	movq	48(%r15), %rcx
	movq	%rcx, 5944(%rsp)
	movq	40(%r15), %rdx
	movq	%rdx, 5936(%rsp)
	movq	32(%r15), %rsi
	movq	%rsi, 5928(%rsp)
	movq	24(%r15), %rdi
	movq	%rdi, 5920(%rsp)
	movq	16(%r15), %rbp
	movq	%rbp, 5912(%rsp)
	movq	(%r15), %rbx
	movq	8(%r15), %rax
	movq	%rax, 5904(%rsp)
	movq	%rbx, 5896(%rsp)
	movq	%r8, 264(%rsp)
	movq	%rcx, 256(%rsp)
	movq	%rdx, 248(%rsp)
	movq	%rsi, 240(%rsp)
	movq	%rdi, 232(%rsp)
	movq	%rbp, 224(%rsp)
	movq	%rax, 216(%rsp)
	movq	%rbx, 208(%rsp)
	leaq	1440(%rsp), %rdi
	leaq	208(%rsp), %rsi
	callq	*_ZN92_$LT$pcics..header..Header$u20$as$u20$core..convert..From$LT$$u5b$u8$u3b$$u20$_$u5d$$GT$$GT$4from17hf8dc6256c9d69163E@GOTPCREL(%rip)
	cmpb	$1, 1624(%rsp)
	jne	.LBB126_622
	cmpb	$6, 1623(%rsp)
	je	.LBB126_623
.LBB126_622:
	movl	%r14d, %ebp
	cmpl	$16777215, %r14d
	jb	.LBB126_569
	jmp	.LBB126_722
.LBB126_623:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	leaq	88(%rsp), %rbx
	jb	.LBB126_624
	leaq	1592(%rsp), %rax
	leaq	1594(%rsp), %rcx
	movq	%rax, 208(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u16$GT$3fmt17hc0921f21ca7ec075E@GOTPCREL(%rip), %rax
	movq	%rax, 216(%rsp)
	movq	%rcx, 224(%rsp)
	movq	%rax, 232(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 240(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u64$GT$3fmt17h37bc6141694e846cE@GOTPCREL(%rip), %rax
	movq	%rax, 248(%rsp)
	leaq	.L__unnamed_231(%rip), %rax
	movq	%rax, 88(%rsp)
	movq	$3, 96(%rsp)
	leaq	.L__unnamed_232(%rip), %rax
	movq	%rax, 104(%rsp)
	movq	$3, 112(%rsp)
	leaq	208(%rsp), %rax
	movq	%rax, 120(%rsp)
	movq	$3, 128(%rsp)
	leaq	.L__unnamed_233(%rip), %rdx
	leaq	88(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jae	.LBB126_628
.LBB126_625:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB126_626
.LBB126_629:
	leaq	1633(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN64_$LT$pcics..header..InterruptPin$u20$as$u20$core..fmt..Debug$GT$3fmt17h49acae32efab3125E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_234(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_235(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_722
	jmp	.LBB126_630
.LBB126_624:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jb	.LBB126_625
.LBB126_628:
	leaq	1622(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN73_$LT$pcics..header..class_code..ClassCode$u20$as$u20$core..fmt..Debug$GT$3fmt17h0693728da9c73695E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_236(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_228(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_237(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	ja	.LBB126_629
.LBB126_626:
	cmpb	$0, 1440(%rsp)
	jne	.LBB126_722
.LBB126_630:
	movl	1464(%rsp), %ecx
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_635
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_633:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rdx
	cmpq	$2, %rdx
	jb	.LBB126_635
	cmpq	$3, %rax
	jne	.LBB126_633
	jmp	.LBB126_750
.LBB126_487:
	movq	16(%rbx), %rax
	movq	%rax, 24(%rsp)
	movq	24(%rbx), %rax
	movq	%rax, 80(%rsp)
	movq	32(%rbx), %rax
	movq	%rax, 168(%rsp)
	movq	40(%rbx), %rax
	movq	%rax, 160(%rsp)
	movq	48(%rbx), %rax
	movq	%rax, 1280(%rsp)
	movq	56(%rbx), %rax
	movq	%rax, 1272(%rsp)
	movq	64(%rbx), %rax
	movq	%rax, 1264(%rsp)
	movq	72(%rbx), %rax
	movq	%rax, 1256(%rsp)
	movq	80(%rbx), %rax
	movq	%rax, 1248(%rsp)
	movq	88(%rbx), %rax
	movq	%rax, 1240(%rsp)
	movq	96(%rbx), %rax
	movq	%rax, 1232(%rsp)
	movq	104(%rbx), %rax
	movq	%rax, 1224(%rsp)
	movq	112(%rbx), %rax
	movq	%rax, 1216(%rsp)
	movq	120(%rbx), %rax
	movq	%rax, 1208(%rsp)
	movl	$16, %ecx
	movq	128(%rbx), %r15
	movq	136(%rbx), %r13
	movq	144(%rbx), %rax
	movq	%rax, 952(%rsp)
	movq	152(%rbx), %rax
	movq	%rax, 960(%rsp)
	movq	160(%rbx), %rax
	movq	%rax, 968(%rsp)
	movq	168(%rbx), %rax
	movq	%rax, 976(%rsp)
	movq	176(%rbx), %rax
	movq	%rax, 984(%rsp)
	movq	184(%rbx), %rax
	movq	%rax, 992(%rsp)
	movq	192(%rbx), %rax
	movq	%rax, 1000(%rsp)
	movq	200(%rbx), %rax
	movq	%rax, 1008(%rsp)
	movq	208(%rbx), %rax
	movq	%rax, 1016(%rsp)
	movq	216(%rbx), %rax
	movq	%rax, 1024(%rsp)
	movq	224(%rbx), %rax
	movq	%rax, 1032(%rsp)
	movq	232(%rbx), %rax
	movq	%rax, 1040(%rsp)
	movq	240(%rbx), %rax
	movq	%rax, 1056(%rsp)
	movq	248(%rbx), %rax
	movq	%rax, 1072(%rsp)
	movq	256(%rbx), %rax
	movq	%rax, 1088(%rsp)
	movq	264(%rbx), %rax
	movq	%rax, 1104(%rsp)
	movq	272(%rbx), %rax
	movq	%rax, 1120(%rsp)
	movq	280(%rbx), %rax
	movq	%rax, 1136(%rsp)
	movq	288(%rbx), %rax
	movq	%rax, 1144(%rsp)
	movq	296(%rbx), %rax
	movq	%rax, 1152(%rsp)
	movq	304(%rbx), %rax
	movq	%rax, 1160(%rsp)
	movq	312(%rbx), %rax
	movq	%rax, 1168(%rsp)
	movq	320(%rbx), %rax
	movq	%rax, 1176(%rsp)
	movq	328(%rbx), %rax
	movq	%rax, 1184(%rsp)
	movq	336(%rbx), %rax
	movq	%rax, 1192(%rsp)
	movq	344(%rbx), %rax
	movq	%rax, 1200(%rsp)
	leaq	352(%rbx), %rsi
	leaq	208(%rsp), %r14
	movq	%r14, %rdi
	rep;movsq (%rsi), %es:(%rdi)
	movq	%rbx, %rsi
	addq	$528, %rsi
	movq	480(%rbx), %rax
	movq	%rax, 1048(%rsp)
	movq	488(%rbx), %rax
	movq	%rax, 1064(%rsp)
	movq	496(%rbx), %rax
	movq	%rax, 1080(%rsp)
	movq	504(%rbx), %rax
	movq	%rax, 1096(%rsp)
	movq	512(%rbx), %rax
	movq	%rax, 1112(%rsp)
	movq	520(%rbx), %rax
	movq	%rax, 1128(%rsp)
	leaq	1440(%rsp), %rbp
	movl	$3584, %edx
	movq	%rbp, %rdi
	movq	memcpy@GOTPCREL(%rip), %r12
	callq	*%r12
	movb	$0, (%rbx)
	leaq	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+352(%rip), %rdi
	movl	$16, %ecx
	movq	%r14, %rsi
	rep;movsq (%rsi), %es:(%rdi)
	leaq	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+528(%rip), %rdi
	movl	$3584, %edx
	movq	%rbp, %rsi
	callq	*%r12
	movb	$1, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E(%rip)
	movq	1440(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+1(%rip)
	movq	1447(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+8(%rip)
	movq	24(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+16(%rip)
	movq	80(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+24(%rip)
	movq	168(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+32(%rip)
	movq	160(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+40(%rip)
	movq	1280(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+48(%rip)
	movq	1272(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+56(%rip)
	movq	1264(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+64(%rip)
	movq	1256(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+72(%rip)
	movq	1248(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+80(%rip)
	movq	1240(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+88(%rip)
	movq	1232(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+96(%rip)
	movq	1224(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+104(%rip)
	movq	1216(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+112(%rip)
	movq	1208(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+120(%rip)
	movq	%r15, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+128(%rip)
	movq	%r13, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+136(%rip)
	movq	952(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+144(%rip)
	movq	960(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+152(%rip)
	movq	968(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+160(%rip)
	movq	976(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+168(%rip)
	movq	984(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+176(%rip)
	movq	992(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+184(%rip)
	movq	1000(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+192(%rip)
	movq	1008(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+200(%rip)
	movq	1016(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+208(%rip)
	movq	1024(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+216(%rip)
	movq	1032(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+224(%rip)
	movq	1040(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+232(%rip)
	movq	1056(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+240(%rip)
	movq	1072(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+248(%rip)
	movq	1088(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+256(%rip)
	movq	1104(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+264(%rip)
	movq	1120(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+272(%rip)
	movq	1136(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+280(%rip)
	movq	1144(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+288(%rip)
	movq	1152(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+296(%rip)
	movq	1160(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+304(%rip)
	movq	1168(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+312(%rip)
	movq	1176(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+320(%rip)
	movq	1184(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+328(%rip)
	movq	1192(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+336(%rip)
	movq	1200(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+344(%rip)
	movq	1048(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+480(%rip)
	movq	1064(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+488(%rip)
	movq	1080(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+496(%rip)
	movq	1096(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+504(%rip)
	movq	1112(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+512(%rip)
	movq	1128(%rsp), %rax
	movq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+520(%rip)
	movb	$0, 5904(%rsp)
	movl	$2, %eax
	xchgq	%rax, _ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E+4112(%rip)
	leaq	5896(%rsp), %rdi
	callq	*_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17hb6d03ae45e193650E@GOTPCREL(%rip)
	leaq	1440(%rsp), %r13
	jmp	.LBB126_432
.LBB126_488:
	movq	32(%rsp), %rbp
	movq	48(%rsp), %rbx
	movq	40(%rsp), %rax
	movq	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E(%rip), %rcx
	cmpq	$2, %rcx
	jne	.LBB126_484
	jmp	.LBB126_489
.LBB126_635:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rbp
	addq	%rcx, %rbp
	movq	%rbp, %rax
	shrq	$47, %rax
	je	.LBB126_639
	cmpl	$131071, %eax
	je	.LBB126_639
	cmpl	$1, %eax
	jne	.LBB126_865
	shlq	$16, %rbp
	sarq	$16, %rbp
.LBB126_639:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_644
	cmpq	$1, %rax
	je	.LBB126_808
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_642:
	movq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E(%rip), %rax
	leaq	-1(%rax), %rdx
	cmpq	$2, %rdx
	jb	.LBB126_644
	cmpq	$3, %rax
	jne	.LBB126_642
	jmp	.LBB126_750
.LBB126_644:
	shlq	$16, %rbp
	sarq	$16, %rbp
	andq	$-4096, %rbp
	addq	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E+8(%rip), %rbp
	movq	%rbp, %rax
	shrq	$47, %rax
	movq	%rbp, %rdx
	je	.LBB126_647
	movq	%rbp, %rdx
	cmpl	$1, %eax
	je	.LBB126_648
	cmpl	$131071, %eax
	jne	.LBB126_865
.LBB126_647:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	jne	.LBB126_649
	jmp	.LBB126_653
.LBB126_648:
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_653
.LBB126_649:
	cmpq	$1, %rax
	je	.LBB126_863
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_651:
	movq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE(%rip), %rax
	leaq	-1(%rax), %rsi
	cmpq	$2, %rsi
	jb	.LBB126_653
	cmpq	$3, %rax
	jne	.LBB126_651
	jmp	.LBB126_750
.LBB126_653:
	movb	$1, %bl
	.p2align	4, 0x90
.LBB126_654:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	je	.LBB126_656
.LBB126_655:
	movzbl	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_655
	jmp	.LBB126_654
.LBB126_656:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_661
	cmpq	$1, %rax
	je	.LBB126_863
	cmpq	$3, %rax
	je	.LBB126_793
	.p2align	4, 0x90
.LBB126_659:
	movq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E(%rip), %rax
	leaq	-1(%rax), %rsi
	cmpq	$2, %rsi
	jb	.LBB126_661
	cmpq	$3, %rax
	jne	.LBB126_659
	jmp	.LBB126_750
.LBB126_661:
	shlq	$16, %rdx
	andl	$-4096, %ecx
	sarq	$16, %rdx
	andq	$-4096, %rdx
	movb	$1, %bl
	.p2align	4, 0x90
.LBB126_662:
	xorl	%eax, %eax
	lock		cmpxchgb	%bl, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	je	.LBB126_664
.LBB126_663:
	movzbl	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip), %eax
	testb	%al, %al
	jne	.LBB126_663
	jmp	.LBB126_662
.LBB126_664:
	leaq	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+16(%rip), %rsi
	leaq	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+16(%rip), %r9
	leaq	136(%rsp), %rdi
	movl	$19, %r8d
	callq	_ZN6x86_6410structures6paging6mapper17mapped_page_table24MappedPageTable$LT$P$GT$11map_to_4kib17h28d4c785a8b5cfdcE
	movb	$0, _ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E+8(%rip)
	movb	$0, _ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE+8(%rip)
	cmpq	$0, 136(%rsp)
	movq	144(%rsp), %rax
	je	.LBB126_669
	cmpq	$1, %rax
	leaq	88(%rsp), %rbx
	je	.LBB126_670
	cmpq	$2, %rax
	jne	.LBB126_868
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_673
	leaq	.L__unnamed_57(%rip), %rax
	jmp	.LBB126_672
.LBB126_669:
	#APP

	invlpg	(%rax)

	#NO_APP
	leaq	88(%rsp), %rbx
	jmp	.LBB126_673
.LBB126_670:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_673
	leaq	.L__unnamed_58(%rip), %rax
.LBB126_672:
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	movq	$0, 224(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 240(%rsp)
	movq	$0, 248(%rsp)
	leaq	.L__unnamed_238(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_673:
	movl	$-2147483646, 4(%rbp)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_674
	leaq	.L__unnamed_239(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	movq	$0, 224(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 240(%rsp)
	movq	$0, 248(%rsp)
	leaq	.L__unnamed_240(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jae	.LBB126_698
.LBB126_675:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_676
.LBB126_699:
	movl	4(%rbp), %eax
	movl	%eax, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_241(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_242(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	ja	.LBB126_677
	jmp	.LBB126_678
.LBB126_674:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_675
.LBB126_698:
	movl	(%rbp), %eax
	movl	%eax, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_243(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_244(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jae	.LBB126_699
.LBB126_676:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB126_678
.LBB126_677:
	movl	8(%rbp), %eax
	movl	%eax, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_245(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_246(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_678:
	movl	8(%rbp), %ecx
	movl	$1, %edx
	.p2align	4, 0x90
.LBB126_679:
	xorl	%eax, %eax
	lock		cmpxchgq	%rdx, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	jne	.LBB126_679
	movl	$1, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+8(%rip)
	movl	%ecx, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+12(%rip)
	lock		andq	$-4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB126_681
	movl	12(%rbp), %eax
	movl	%eax, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_247(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_248(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jae	.LBB126_701
.LBB126_682:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_683
.LBB126_702:
	movl	36(%rbp), %eax
	movl	%eax, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_249(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_250(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	ja	.LBB126_684
	jmp	.LBB126_685
.LBB126_681:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jb	.LBB126_682
.LBB126_701:
	movl	16(%rbp), %eax
	movl	%eax, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_251(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_252(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$4, %rax
	jae	.LBB126_702
.LBB126_683:
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	jbe	.LBB126_685
.LBB126_684:
	movl	40(%rbp), %eax
	movl	%eax, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_ZN4core3fmt3num53_$LT$impl$u20$core..fmt..LowerHex$u20$for$u20$u32$GT$3fmt17hc753e452ed3648b1E@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_253(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%rbx, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_254(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$4, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_685:
	movl	$4, %ecx
	lock		xaddq	%rcx, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	movabsq	$-9223372036854775805, %rax
	addq	$-7, %rax
	cmpq	%rax, %rcx
	ja	.LBB126_688
	.p2align	4, 0x90
.LBB126_686:
	testb	$3, %cl
	je	.LBB126_689
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	movl	$4, %ecx
	lock		xaddq	%rcx, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	cmpq	%rax, %rcx
	jbe	.LBB126_686
.LBB126_688:
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	leaq	.L__unnamed_117(%rip), %rdi
	leaq	.L__unnamed_118(%rip), %rdx
	movl	$44, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_689:
	cmpl	$0, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+8(%rip)
	je	.LBB126_864
	movl	_ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE+12(%rip), %eax
	movl	%eax, 8(%rbp)
	lock		subq	$4, _ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE(%rip)
	movl	12(%rbp), %eax
	movl	%eax, 8(%rsp)
	addq	$256, %rbp
	movq	$0, 88(%rsp)
	movq	$32, 96(%rsp)
	leaq	8(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	%rbp, 112(%rsp)
	leaq	88(%rsp), %r12
	movq	%r12, %rdi
	callq	_ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E
	testq	%rax, %rax
	je	.LBB126_704
	movq	%rax, %rbx
	movq	%rdx, %rbp
	movl	$64, %edi
	movl	$8, %esi
	callq	*__rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB126_866
	movq	%rax, %r15
	movq	%rbx, (%rax)
	movq	%rbp, 8(%rax)
	movq	%rax, 32(%rsp)
	movq	$4, 40(%rsp)
	movq	$1, 48(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 232(%rsp)
	movq	104(%rsp), %rax
	movq	%rax, 224(%rsp)
	movq	88(%rsp), %rax
	movq	96(%rsp), %rcx
	movq	%rcx, 216(%rsp)
	movq	%rax, 208(%rsp)
	leaq	208(%rsp), %rdi
	callq	_ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E
	testq	%rax, %rax
	je	.LBB126_751
	movq	%rax, %rbp
	movq	%rdx, %rbx
	movl	$4, %esi
	movl	$2, %r14d
	movl	$24, %r12d
	leaq	208(%rsp), %r13
	leaq	-1(%r14), %rax
	cmpq	%rsi, %rax
	jne	.LBB126_694
	jmp	.LBB126_696
	.p2align	4, 0x90
.LBB126_695:
	movq	%rax, %rbp
	movq	%rdx, %rbx
	movq	40(%rsp), %rsi
	addq	$1, %r14
	addq	$16, %r12
	leaq	-1(%r14), %rax
	cmpq	%rsi, %rax
	jne	.LBB126_694
.LBB126_696:
	movl	$1, %edx
	leaq	32(%rsp), %rdi
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$7reserve21do_reserve_and_handle17hedf5e4fa0b1129c6E
	movq	32(%rsp), %r15
	.p2align	4, 0x90
.LBB126_694:
	movq	%rbp, -8(%r15,%r12)
	movq	%rbx, (%r15,%r12)
	movq	%r14, 48(%rsp)
	movq	%r13, %rdi
	callq	_ZN115_$LT$core..iter..adapters..filter_map..FilterMap$LT$I$C$F$GT$$u20$as$u20$core..iter..traits..iterator..Iterator$GT$4next17hb0e4845123b36466E
	testq	%rax, %rax
	jne	.LBB126_695
	movq	32(%rsp), %r15
	movq	40(%rsp), %rbp
	leaq	88(%rsp), %r12
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB126_706
.LBB126_705:
	movq	%r14, 32(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 88(%rsp)
	leaq	_ZN4core3fmt3num52_$LT$impl$u20$core..fmt..Debug$u20$for$u20$usize$GT$3fmt17hf75de25df93ce533E(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.L__unnamed_255(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$2, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	movq	%r12, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_256(%rip), %rdx
	leaq	208(%rsp), %rdi
	movl	$3, %esi
	xorl	%ecx, %ecx
	callq	*_ZN3log17__private_api_log17h1823a2a1b133fdf1E@GOTPCREL(%rip)
.LBB126_706:
	movq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE(%rip), %rax
	cmpq	$2, %rax
	je	.LBB126_710
	cmpq	$1, %rax
	je	.LBB126_766
	cmpq	$3, %rax
	je	.LBB126_793
	xorl	%r12d, %r12d
	jmp	.LBB126_711
.LBB126_710:
	leaq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE+8(%rip), %r12
.LBB126_711:
	testq	%r14, %r14
	je	.LBB126_716
	shlq	$4, %r14
	addq	%r15, %r14
	movq	%r15, %rbx
	jmp	.LBB126_714
	.p2align	4, 0x90
.LBB126_713:
	addq	$16, %rbx
	cmpq	%r14, %rbx
	je	.LBB126_716
.LBB126_714:
	movq	(%rbx), %rdi
	movq	8(%rbx), %rax
	callq	*(%rax)
	movq	8(%rbx), %rax
	movq	8(%rax), %rsi
	testq	%rsi, %rsi
	je	.LBB126_713
	movq	16(%rax), %rdx
	movq	(%rbx), %rdi
	callq	*__rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB126_713
.LBB126_716:
	testq	%rbp, %rbp
	je	.LBB126_721
	movl	$16, %ecx
	movq	%rbp, %rax
	mulq	%rcx
	jo	.LBB126_721
	movabsq	$-9223372036854775805, %rdx
	leaq	(%rdx,%rax), %rcx
	addq	$4, %rcx
	addq	$5, %rdx
	cmpq	%rdx, %rcx
	jb	.LBB126_721
	movl	$8, %edx
	movq	%r15, %rdi
.LBB126_720:
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_721:
	testq	%r12, %r12
	je	.LBB126_778
	.p2align	4, 0x90
.LBB126_722:
	#APP

	hlt

	#NO_APP
	jmp	.LBB126_722
.LBB126_704:
	movl	$8, %r15d
	xorl	%r14d, %r14d
	xorl	%ebp, %ebp
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	jbe	.LBB126_706
	jmp	.LBB126_705
.LBB126_723:
	movq	%rax, 1440(%rsp)
	movq	%rdx, 1448(%rsp)
	movq	5032(%rsp), %rax
	movq	5040(%rsp), %rcx
	movq	%rax, 1456(%rsp)
	movq	%rcx, 1464(%rsp)
	movq	5048(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	5056(%rsp), %rax
	movq	%rax, 1480(%rsp)
	movq	5064(%rsp), %rax
	movq	%rax, 1488(%rsp)
	movq	5072(%rsp), %rax
	movq	%rax, 1496(%rsp)
	movq	%r12, 5896(%rsp)
	leaq	208(%rsp), %rdi
	leaq	5896(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h3d2eca67641ff425E
	cmpq	$0, 208(%rsp)
	movq	216(%rsp), %rdi
	je	.LBB126_752
	testq	%rdi, %rdi
	jne	.LBB126_72
	jmp	.LBB126_861
.LBB126_725:
	leaq	5032(%rsp), %rsi
	movl	$14, %ecx
	leaq	1440(%rsp), %rax
	movq	%rax, %rdi
	rep;movsq (%rsi), %es:(%rdi)
	movq	%rax, 5896(%rsp)
	leaq	208(%rsp), %rdi
	leaq	5896(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hc366a53cdf8b30edE
	cmpq	$0, 208(%rsp)
	movq	216(%rsp), %rbx
	je	.LBB126_753
	testq	%rbx, %rbx
	je	.LBB126_861
	cmpb	$3, 1544(%rsp)
	je	.LBB126_729
	leaq	1440(%rsp), %rdi
	callq	_ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE
	.p2align	4, 0x90
.LBB126_729:
	movq	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_284
	cmpq	$3, %rax
	jne	.LBB126_729
	jmp	.LBB126_750
.LBB126_731:
	movq	%r14, 1448(%rsp)
	movq	80(%rsp), %rax
	movq	%rax, 1456(%rsp)
	movq	%r13, 1464(%rsp)
	movq	$1, 1440(%rsp)
	leaq	1440(%rsp), %rax
	movq	%rax, 208(%rsp)
	leaq	5032(%rsp), %rdi
	leaq	208(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17h9f6ba84a70de7dc2E
	cmpq	$0, 5032(%rsp)
	movq	5040(%rsp), %rbx
	je	.LBB126_755
	testq	%rbx, %rbx
	je	.LBB126_861
	cmpq	$0, 1440(%rsp)
	je	.LBB126_739
	movq	1448(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB126_739
	movq	1456(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_739
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_739
	testq	%rax, %rax
	jle	.LBB126_739
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB126_739:
	movq	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_295
	cmpq	$3, %rax
	jne	.LBB126_739
	jmp	.LBB126_750
.LBB126_741:
	movq	%rbp, 5896(%rsp)
	movq	%rax, 5904(%rsp)
	movq	%rbx, 5912(%rsp)
	movq	%r12, 176(%rsp)
	leaq	1440(%rsp), %rdi
	leaq	176(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hbf38609c5118b8a6E
	cmpq	$0, 1440(%rsp)
	movq	1448(%rsp), %rbx
	je	.LBB126_761
	testq	%rbx, %rbx
	je	.LBB126_861
	movq	5896(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB126_748
	movq	5904(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_748
	movl	$4, %ecx
	mulq	%rcx
	jo	.LBB126_748
	movabsq	$-9223372036854775805, %rdx
	leaq	(%rax,%rdx), %rcx
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	jb	.LBB126_748
	movl	$4, %edx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB126_748:
	movq	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_495
	cmpq	$3, %rax
	jne	.LBB126_748
.LBB126_750:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_61(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB126_751:
	movl	$4, %ebp
	movl	$1, %r14d
	movq	_ZN3log20MAX_LOG_LEVEL_FILTER17h5d36032a41fa4e85E@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	cmpq	$2, %rax
	ja	.LBB126_705
	jmp	.LBB126_706
.LBB126_752:
	testq	%rdi, %rdi
	jne	.LBB126_75
	jmp	.LBB126_72
.LBB126_753:
	cmpb	$3, 1544(%rsp)
	je	.LBB126_283
	leaq	1440(%rsp), %rdi
	jmp	.LBB126_282
.LBB126_755:
	cmpq	$0, 1440(%rsp)
	je	.LBB126_294
	movq	1448(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB126_294
	movq	1456(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_294
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_294
	testq	%rax, %rax
	jle	.LBB126_294
	movq	%rax, %rdx
	notq	%rdx
	shrq	$63, %rdx
	jmp	.LBB126_293
.LBB126_761:
	movq	5896(%rsp), %rdi
	testq	%rdi, %rdi
	je	.LBB126_494
	movq	5904(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_494
	movl	$4, %ecx
	mulq	%rcx
	jo	.LBB126_494
	movabsq	$-9223372036854775805, %rdx
	leaq	(%rax,%rdx), %rcx
	addq	$1, %rdx
	cmpq	%rdx, %rcx
	jb	.LBB126_494
	movl	$4, %edx
	jmp	.LBB126_493
.LBB126_766:
	movq	%r15, 88(%rsp)
	movq	%rbp, 96(%rsp)
	movq	%r14, 104(%rsp)
	movq	%r12, 32(%rsp)
	leaq	208(%rsp), %rdi
	leaq	32(%rsp), %rsi
	callq	_ZN12conquer_once4cell21OnceCell$LT$T$C$B$GT$14try_init_inner17hcfdebd20286fdea5E
	cmpq	$0, 208(%rsp)
	movq	216(%rsp), %r12
	je	.LBB126_780
	testq	%r12, %r12
	je	.LBB126_861
	movq	88(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB126_778
	movq	104(%rsp), %rbp
	testq	%rbp, %rbp
	je	.LBB126_774
	shlq	$4, %rbp
	addq	%rbx, %rbp
	jmp	.LBB126_772
.LBB126_771:
	addq	$16, %rbx
	cmpq	%rbp, %rbx
	je	.LBB126_774
.LBB126_772:
	movq	(%rbx), %rdi
	movq	8(%rbx), %rax
	callq	*(%rax)
	movq	8(%rbx), %rax
	movq	8(%rax), %rsi
	testq	%rsi, %rsi
	je	.LBB126_771
	movq	16(%rax), %rdx
	movq	(%rbx), %rdi
	callq	*__rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB126_771
.LBB126_774:
	movq	96(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_778
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_778
	movabsq	$-9223372036854775805, %rdx
	leaq	(%rdx,%rax), %rcx
	addq	$4, %rcx
	addq	$5, %rdx
	cmpq	%rdx, %rcx
	jb	.LBB126_778
	movq	88(%rsp), %rdi
	movl	$8, %edx
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
	.p2align	4, 0x90
.LBB126_778:
	movq	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE(%rip), %rax
	leaq	-1(%rax), %rcx
	cmpq	$2, %rcx
	jb	.LBB126_722
	cmpq	$3, %rax
	jne	.LBB126_778
	jmp	.LBB126_750
.LBB126_780:
	movq	88(%rsp), %rbp
	testq	%rbp, %rbp
	je	.LBB126_721
	movq	104(%rsp), %r14
	testq	%r14, %r14
	je	.LBB126_786
	shlq	$4, %r14
	addq	%rbp, %r14
	jmp	.LBB126_784
.LBB126_783:
	addq	$16, %rbp
	cmpq	%r14, %rbp
	je	.LBB126_786
.LBB126_784:
	movq	(%rbp), %rdi
	movq	8(%rbp), %rax
	callq	*(%rax)
	movq	8(%rbp), %rax
	movq	8(%rax), %rsi
	testq	%rsi, %rsi
	je	.LBB126_783
	movq	16(%rax), %rdx
	movq	(%rbp), %rdi
	callq	*__rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB126_783
.LBB126_786:
	movq	96(%rsp), %rax
	testq	%rax, %rax
	je	.LBB126_721
	movl	$16, %ecx
	mulq	%rcx
	jo	.LBB126_721
	movabsq	$-9223372036854775805, %rdx
	leaq	(%rdx,%rax), %rcx
	addq	$4, %rcx
	addq	$5, %rdx
	cmpq	%rdx, %rcx
	jb	.LBB126_721
	movq	88(%rsp), %rdi
	movl	$8, %edx
	jmp	.LBB126_720
.LBB126_790:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_257(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_793:
	leaq	.L__unnamed_18(%rip), %rdi
	leaq	.L__unnamed_19(%rip), %rcx
	leaq	.L__unnamed_62(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$36, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB126_791:
	testq	%rax, %rax
	jne	.LBB126_794
	leaq	.L__unnamed_122(%rip), %rdi
	leaq	.L__unnamed_258(%rip), %rdx
	movl	$40, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_794:
	leaq	.L__unnamed_259(%rip), %rdi
	leaq	.L__unnamed_260(%rip), %rdx
	movl	$17, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_796:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_261(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_797:
	xorl	%eax, %eax
.LBB126_798:
	movq	%rax, 208(%rsp)
	movq	%rcx, 216(%rsp)
	leaq	208(%rsp), %rax
	movq	%rax, 5032(%rsp)
	leaq	_ZN92_$LT$x86_64..structures..paging..mapper..MapToError$LT$S$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h5817cf5cab49b1a9E(%rip), %rax
	movq	%rax, 5040(%rsp)
	leaq	.L__unnamed_262(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 1456(%rsp)
	movq	$1, 1464(%rsp)
	leaq	5032(%rsp), %rax
	movq	%rax, 1472(%rsp)
	movq	$1, 1480(%rsp)
	leaq	.L__unnamed_263(%rip), %rsi
	leaq	1440(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB126_802:
	leaq	.L__unnamed_64(%rip), %rdi
	leaq	.L__unnamed_65(%rip), %rdx
	movl	$67, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_799:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_191(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_805:
	movq	%r13, 1440(%rsp)
	jmp	.LBB126_860
.LBB126_852:
	callq	*_ZN5alloc7raw_vec17capacity_overflow17ha57dcee9ca9483b5E@GOTPCREL(%rip)
	ud2
.LBB126_801:
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.LBB126_803:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_264(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_804:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_265(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_806:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_261(%rip), %rsi
	leaq	1440(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB126_807:
	movq	%rax, 1440(%rsp)
	jmp	.LBB126_860
.LBB126_808:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_63(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_811:
	movq	%r15, 1440(%rsp)
	jmp	.LBB126_860
.LBB126_812:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_264(%rip), %rsi
	leaq	1440(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB126_813:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_66(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_814:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_67(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_815:
	leaq	.L__unnamed_266(%rip), %rdi
	leaq	.L__unnamed_267(%rip), %rdx
	movl	$29, %esi
	callq	*_ZN4core6option13expect_failed17hc2b566b983cafff9E@GOTPCREL(%rip)
	ud2
.LBB126_816:
	movl	1441(%rsp), %eax
	movzbl	1445(%rsp), %ebp
	shlq	$32, %rbp
	orq	%rax, %rbp
	jmp	.LBB126_832
.LBB126_817:
	movq	%rbp, 1440(%rsp)
	jmp	.LBB126_860
.LBB126_818:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_268(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_819:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_269(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_820:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_270(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_821:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_271(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_822:
	leaq	.L__unnamed_272(%rip), %rdi
	leaq	.L__unnamed_273(%rip), %rcx
	leaq	.L__unnamed_274(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$28, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB126_823:
	movzbl	%al, %eax
	shlq	$8, %rax
	movl	%eax, 1441(%rsp)
	movb	$0, 1445(%rsp)
	movb	$1, 1440(%rsp)
.LBB126_824:
	movb	1445(%rsp), %al
	movb	%al, 5036(%rsp)
	movl	1441(%rsp), %eax
	movl	%eax, 5032(%rsp)
	leaq	.L__unnamed_119(%rip), %rdi
	leaq	.L__unnamed_275(%rip), %rcx
	leaq	.L__unnamed_276(%rip), %r8
	leaq	5032(%rsp), %rdx
	jmp	.LBB126_857
.LBB126_825:
	movabsq	$344725734917, %rbp
	jmp	.LBB126_832
.LBB126_826:
	movl	1441(%rsp), %ebp
	movzbl	1445(%rsp), %ebx
	shlq	$32, %rbx
	cmpb	$2, %r15b
	je	.LBB126_831
	cmpq	$0, 24(%rsp)
	je	.LBB126_831
	movl	$12, %ecx
	movq	24(%rsp), %rax
	mulq	%rcx
	jo	.LBB126_831
	movabsq	$-9223372036854775805, %rcx
	leaq	(%rax,%rcx), %rdx
	addq	$1, %rcx
	cmpq	%rcx, %rdx
	jb	.LBB126_831
	movl	$4, %edx
	movq	160(%rsp), %rdi
	movq	%rax, %rsi
	callq	*__rust_dealloc@GOTPCREL(%rip)
.LBB126_831:
	orq	%rbx, %rbp
	leaq	5032(%rsp), %rdi
	callq	_ZN4core3ptr62drop_in_place$LT$acpi..platform..interrupt..InterruptModel$GT$17hdec68041327d441eE
.LBB126_832:
	movl	%ebp, 1440(%rsp)
	shrq	$32, %rbp
	movb	%bpl, 1444(%rsp)
	leaq	.L__unnamed_119(%rip), %rdi
	leaq	.L__unnamed_275(%rip), %rcx
	leaq	.L__unnamed_277(%rip), %r8
	leaq	1440(%rsp), %rdx
	jmp	.LBB126_857
.LBB126_833:
	movb	1445(%rsp), %al
	movb	%al, 212(%rsp)
	movl	1441(%rsp), %eax
	movl	%eax, 208(%rsp)
	leaq	.L__unnamed_119(%rip), %rdi
	leaq	.L__unnamed_275(%rip), %rcx
	leaq	.L__unnamed_278(%rip), %r8
	jmp	.LBB126_856
.LBB126_834:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_278(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_835:
	movb	1445(%rsp), %al
	movb	%al, 212(%rsp)
	movl	1441(%rsp), %eax
	movl	%eax, 208(%rsp)
	leaq	.L__unnamed_119(%rip), %rdi
	leaq	.L__unnamed_275(%rip), %rcx
	leaq	.L__unnamed_279(%rip), %r8
	jmp	.LBB126_856
.LBB126_836:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_280(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_837:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_281(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_838:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_282(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_839:
	movq	1448(%rsp), %rax
	movq	1456(%rsp), %rcx
	movq	%rax, 64(%rsp)
	movq	%rcx, 72(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, 176(%rsp)
	leaq	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h5d0324e82f682a10E(%rip), %rax
	movq	%rax, 184(%rsp)
	leaq	.L__unnamed_283(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	leaq	.L__unnamed_10(%rip), %rax
	movq	%rax, 224(%rsp)
	movq	$1, 232(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 240(%rsp)
	movq	$1, 248(%rsp)
	leaq	.L__unnamed_284(%rip), %rsi
	leaq	208(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB126_840:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_285(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_841:
	movq	%rdx, 1440(%rsp)
	jmp	.LBB126_860
.LBB126_842:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_66(%rip), %rsi
	leaq	1440(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB126_843:
	movq	%rcx, 1440(%rsp)
	jmp	.LBB126_860
.LBB126_844:
	movq	1456(%rsp), %rcx
	jmp	.LBB126_798
.LBB126_845:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_286(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_846:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_287(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_847:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_288(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_848:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_289(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_849:
	movq	%rbx, 1440(%rsp)
	jmp	.LBB126_860
.LBB126_850:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_281(%rip), %rsi
	leaq	1440(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB126_851:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 1440(%rsp)
	movq	$1, 1448(%rsp)
	movq	$0, 1456(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 1472(%rsp)
	movq	$0, 1480(%rsp)
	leaq	.L__unnamed_282(%rip), %rsi
	leaq	1440(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.LBB126_853:
	movq	%rbp, %rdi
	movq	%r15, %rsi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.LBB126_854:
	movq	1472(%rsp), %rax
	movq	%rax, 232(%rsp)
	movq	1464(%rsp), %rax
	movq	%rax, 224(%rsp)
	movq	1448(%rsp), %rax
	movq	1456(%rsp), %rcx
	movq	%rcx, 216(%rsp)
	movq	%rax, 208(%rsp)
	leaq	.L__unnamed_119(%rip), %rdi
	leaq	.L__unnamed_290(%rip), %rcx
	leaq	.L__unnamed_291(%rip), %r8
	jmp	.LBB126_856
.LBB126_855:
	movq	1472(%rsp), %rax
	movq	%rax, 232(%rsp)
	movq	1464(%rsp), %rax
	movq	%rax, 224(%rsp)
	movq	1448(%rsp), %rax
	movq	1456(%rsp), %rcx
	movq	%rcx, 216(%rsp)
	movq	%rax, 208(%rsp)
	leaq	.L__unnamed_119(%rip), %rdi
	leaq	.L__unnamed_290(%rip), %rcx
	leaq	.L__unnamed_292(%rip), %r8
.LBB126_856:
	leaq	208(%rsp), %rdx
.LBB126_857:
	movl	$43, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB126_858:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_293(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_859:
	movq	%r12, 1440(%rsp)
.LBB126_860:
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	1440(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB126_861:
	leaq	.L__unnamed_122(%rip), %rdi
	leaq	.L__unnamed_294(%rip), %rdx
	movl	$40, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_863:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_295(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_864:
	leaq	.L__unnamed_21(%rip), %rdi
	leaq	.L__unnamed_296(%rip), %rdx
	movl	$43, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB126_865:
	movq	%rbp, 208(%rsp)
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	208(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.LBB126_866:
	movl	$64, %edi
	movl	$8, %esi
	callq	*_ZN5alloc5alloc18handle_alloc_error17hb40f3d1f459526b3E@GOTPCREL(%rip)
	ud2
.LBB126_868:
	leaq	.L__unnamed_68(%rip), %rax
	movq	%rax, 208(%rsp)
	movq	$1, 216(%rsp)
	movq	$0, 224(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 240(%rsp)
	movq	$0, 248(%rsp)
	leaq	.L__unnamed_295(%rip), %rsi
	leaq	208(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end126:
	.size	_ZN7cryptos5maink17h58f915735fd959feE, .Lfunc_end126-_ZN7cryptos5maink17h58f915735fd959feE

	.section	.text.rust_oom,"ax",@progbits
	.hidden	rust_oom
	.globl	rust_oom
	.p2align	4, 0x90
	.type	rust_oom,@function
rust_oom:
	subq	$56, %rsp
	leaq	.L__unnamed_297(%rip), %rax
	movq	%rax, 8(%rsp)
	movq	$1, 16(%rsp)
	movq	$0, 24(%rsp)
	leaq	.L__unnamed_59(%rip), %rax
	movq	%rax, 40(%rsp)
	movq	$0, 48(%rsp)
	leaq	.L__unnamed_298(%rip), %rsi
	leaq	8(%rsp), %rdi
	callq	*_ZN4core9panicking9panic_fmt17h82cd813eb3d4491dE@GOTPCREL(%rip)
	ud2
.Lfunc_end127:
	.size	rust_oom, .Lfunc_end127-rust_oom

	.section	".text._ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE,@function
_ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE:
	pushq	%rax
	movq	%rsi, %rax
	movl	(%rdi), %ecx
	leaq	.LJTI128_0(%rip), %rdx
	movslq	(%rdx,%rcx,4), %rcx
	addq	%rdx, %rcx
	jmpq	*%rcx
.LBB128_1:
	leaq	.L__unnamed_43(%rip), %rsi
	movl	$4, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.LBB128_3:
	addq	$4, %rdi
	movq	%rdi, (%rsp)
	leaq	.L__unnamed_299(%rip), %rsi
	leaq	.L__unnamed_300(%rip), %r8
	movq	%rsp, %rcx
	movl	$7, %edx
	movq	%rax, %rdi
	callq	*_ZN4core3fmt9Formatter25debug_tuple_field1_finish17h27705bcf66387e64E@GOTPCREL(%rip)
	popq	%rcx
	retq
.LBB128_4:
	leaq	.L__unnamed_301(%rip), %rsi
	movl	$9, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.LBB128_5:
	leaq	.L__unnamed_302(%rip), %rsi
	movl	$19, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.LBB128_6:
	leaq	.L__unnamed_303(%rip), %rsi
	movl	$14, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.LBB128_7:
	leaq	.L__unnamed_304(%rip), %rsi
	movl	$25, %edx
	movq	%rax, %rdi
	popq	%rax
	jmpq	*_ZN4core3fmt9Formatter9write_str17h5ac3623957f0f394E@GOTPCREL(%rip)
.Lfunc_end128:
	.size	_ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE, .Lfunc_end128-_ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE
	.section	".rodata._ZN77_$LT$cryptos..ahci..hba..structs..HbaPortKind$u20$as$u20$core..fmt..Debug$GT$3fmt17h6af33d78d70b8a4fE","a",@progbits
	.p2align	2
.LJTI128_0:
	.long	.LBB128_1-.LJTI128_0
	.long	.LBB128_3-.LJTI128_0
	.long	.LBB128_4-.LJTI128_0
	.long	.LBB128_5-.LJTI128_0
	.long	.LBB128_6-.LJTI128_0
	.long	.LBB128_7-.LJTI128_0

	.section	.text.__rg_alloc,"ax",@progbits
	.hidden	__rg_alloc
	.globl	__rg_alloc
	.p2align	4, 0x90
	.type	__rg_alloc,@function
__rg_alloc:
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	leaq	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE(%rip), %rdi
	jmpq	*_ZN82_$LT$slab_allocator_rs..LockedHeap$u20$as$u20$core..alloc..global..GlobalAlloc$GT$5alloc17hfa6414708fb06c47E@GOTPCREL(%rip)
.Lfunc_end129:
	.size	__rg_alloc, .Lfunc_end129-__rg_alloc

	.section	.text.__rg_dealloc,"ax",@progbits
	.hidden	__rg_dealloc
	.globl	__rg_dealloc
	.p2align	4, 0x90
	.type	__rg_dealloc,@function
__rg_dealloc:
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	leaq	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE(%rip), %rdi
	jmpq	*_ZN82_$LT$slab_allocator_rs..LockedHeap$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17h879d8874dc8a3e2bE@GOTPCREL(%rip)
.Lfunc_end130:
	.size	__rg_dealloc, .Lfunc_end130-__rg_dealloc

	.section	.text.__rg_realloc,"ax",@progbits
	.hidden	__rg_realloc
	.globl	__rg_realloc
	.p2align	4, 0x90
	.type	__rg_realloc,@function
__rg_realloc:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %rbx
	movq	%rdx, %r14
	movq	%rsi, %r12
	movq	%rdi, %r15
	leaq	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE(%rip), %rdi
	movq	%rcx, %rsi
	callq	*_ZN82_$LT$slab_allocator_rs..LockedHeap$u20$as$u20$core..alloc..global..GlobalAlloc$GT$5alloc17hfa6414708fb06c47E@GOTPCREL(%rip)
	movq	%rax, %r13
	testq	%rax, %rax
	je	.LBB131_2
	cmpq	%rbx, %r12
	cmovbeq	%r12, %rbx
	movq	%r13, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	leaq	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE(%rip), %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	movq	%r14, %rcx
	callq	*_ZN82_$LT$slab_allocator_rs..LockedHeap$u20$as$u20$core..alloc..global..GlobalAlloc$GT$7dealloc17h879d8874dc8a3e2bE@GOTPCREL(%rip)
.LBB131_2:
	movq	%r13, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end131:
	.size	__rg_realloc, .Lfunc_end131-__rg_realloc

	.section	.text.__rg_alloc_zeroed,"ax",@progbits
	.hidden	__rg_alloc_zeroed
	.globl	__rg_alloc_zeroed
	.p2align	4, 0x90
	.type	__rg_alloc_zeroed,@function
__rg_alloc_zeroed:
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rdx
	movq	%rdi, %r14
	leaq	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE(%rip), %rdi
	movq	%r14, %rsi
	callq	*_ZN82_$LT$slab_allocator_rs..LockedHeap$u20$as$u20$core..alloc..global..GlobalAlloc$GT$5alloc17hfa6414708fb06c47E@GOTPCREL(%rip)
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.LBB132_2
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	*memset@GOTPCREL(%rip)
.LBB132_2:
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end132:
	.size	__rg_alloc_zeroed, .Lfunc_end132-__rg_alloc_zeroed

	.section	".text._ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E,@function
_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E:
	subq	$120, %rsp
	movq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E(%rip), %rax
	testq	%rax, %rax
	jne	.LBB133_27
	movl	$1, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E(%rip)
	jne	.LBB133_27
	leaq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E(%rip), %rax
	movq	%rax, 16(%rsp)
	movb	$1, 24(%rsp)
	movq	$0, 88(%rsp)
	movq	$0, 80(%rsp)
	movq	$0, 32(%rsp)
	movabsq	$49428545226735615, %rax
	movq	%rax, 40(%rsp)
	movabsq	$58426948388454399, %rax
	movq	%rax, 48(%rsp)
	movq	%rax, 56(%rsp)
	movq	%rax, 64(%rsp)
	movq	%rax, 72(%rsp)
	movq	$6, 96(%rsp)
	movq	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE(%rip), %rax
	testq	%rax, %rax
	jne	.LBB133_19
	movl	$1, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE(%rip)
	jne	.LBB133_19
	leaq	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE(%rip), %rax
	movq	%rax, 104(%rsp)
	leaq	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref23__static_ref_initialize5STACK17h7a2ac005a7d2dfb0E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB133_8
	leaq	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref23__static_ref_initialize5STACK17h7a2ac005a7d2dfb0E(%rip), %rcx
	movq	%rcx, %rdx
	shrq	$47, %rdx
	cmpl	$131071, %edx
	je	.LBB133_8
	cmpl	$1, %edx
	jne	.LBB133_15
	shlq	$16, %rcx
	sarq	$16, %rcx
	movq	%rcx, %rax
.LBB133_8:
	addq	$20480, %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	je	.LBB133_12
	cmpl	$131071, %ecx
	je	.LBB133_12
	cmpl	$1, %ecx
	jne	.LBB133_17
	shlq	$16, %rax
	sarq	$16, %rax
.LBB133_12:
	movl	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+44(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+36(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+28(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+20(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+12(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+56(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+64(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+72(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+80(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+88(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+96(%rip)
	movq	$0, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+104(%rip)
	movl	$6815744, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+112(%rip)
	movl	$1, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+8(%rip)
	movq	%rax, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+48(%rip)
	movb	$0, 112(%rsp)
	movl	$2, %eax
	xchgq	%rax, _ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE(%rip)
	leaq	104(%rsp), %rdi
	callq	*_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17hb6d03ae45e193650E@GOTPCREL(%rip)
	jmp	.LBB133_13
	.p2align	4, 0x90
.LBB133_26:
	movq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E(%rip), %rax
.LBB133_27:
	cmpq	$1, %rax
	je	.LBB133_26
	cmpq	$2, %rax
	jne	.LBB133_21
	leaq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E+16(%rip), %rax
	addq	$120, %rsp
	retq
	.p2align	4, 0x90
.LBB133_18:
	movq	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE(%rip), %rax
.LBB133_19:
	cmpq	$1, %rax
	je	.LBB133_18
	cmpq	$2, %rax
	jne	.LBB133_21
.LBB133_13:
	movq	96(%rsp), %rax
	cmpq	$7, %rax
	jae	.LBB133_14
	leaq	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE+12(%rip), %rcx
	movl	%ecx, %edx
	andl	$16777212, %edx
	shlq	$16, %rdx
	movl	%ecx, %esi
	andl	$-16777216, %esi
	shlq	$32, %rsi
	orq	%rdx, %rsi
	movabsq	$150633093005415, %rdx
	orq	%rsi, %rdx
	movq	%rdx, 32(%rsp,%rax,8)
	movq	96(%rsp), %rdx
	leaq	1(%rdx), %rdi
	movq	%rdi, 96(%rsp)
	cmpq	$8, %rdi
	jae	.LBB133_30
	shrq	$32, %rcx
	movq	%rcx, 40(%rsp,%rdx,8)
	addq	$1, 96(%rsp)
	shll	$3, %eax
	leaq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E+16(%rip), %rdi
	leaq	32(%rsp), %rsi
	movl	$9, %ecx
	rep;movsq (%rsi), %es:(%rdi)
	movq	$1, _ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E+8(%rip)
	movabsq	$9007302335004680, %rcx
	movq	%rcx, _ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E+88(%rip)
	movw	$40, _ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E+96(%rip)
	movw	%ax, _ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E+98(%rip)
	movb	$0, 24(%rsp)
	movl	$2, %eax
	xchgq	%rax, _ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E(%rip)
	leaq	16(%rsp), %rdi
	callq	*_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17hb6d03ae45e193650E@GOTPCREL(%rip)
	leaq	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E+16(%rip), %rax
	addq	$120, %rsp
	retq
.LBB133_30:
	leaq	.L__unnamed_305(%rip), %rdx
	movl	$8, %esi
	callq	*_ZN4core9panicking18panic_bounds_check17h7f6539b946f45151E@GOTPCREL(%rip)
	ud2
.LBB133_21:
	testq	%rax, %rax
	jne	.LBB133_29
	leaq	.L__unnamed_122(%rip), %rdi
	leaq	.L__unnamed_258(%rip), %rdx
	movl	$40, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB133_29:
	leaq	.L__unnamed_259(%rip), %rdi
	leaq	.L__unnamed_260(%rip), %rdx
	movl	$17, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB133_14:
	leaq	.L__unnamed_306(%rip), %rdi
	leaq	.L__unnamed_307(%rip), %rdx
	movl	$52, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB133_15:
	movq	%rcx, 8(%rsp)
	jmp	.LBB133_16
.LBB133_17:
	movq	%rax, 8(%rsp)
.LBB133_16:
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	8(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.Lfunc_end133:
	.size	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E, .Lfunc_end133-_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h43d89fdeb22428a4E

	.section	".text._ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E,@function
_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movl	$7528, %eax
	callq	__rust_probestack
	subq	%rax, %rsp
	movq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4128(%rip), %rax
	testq	%rax, %rax
	jne	.LBB134_70
	movl	$1, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4128(%rip)
	jne	.LBB134_70
	leaq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4128(%rip), %rax
	movq	%rax, 400(%rsp)
	movb	$1, 408(%rsp)
	leaq	416(%rsp), %rax
	leaq	4000(%rsp), %rcx
	movabsq	$15393162788864, %rdx
	.p2align	4, 0x90
.LBB134_3:
	movq	%rdx, (%rax)
	movq	$0, 8(%rax)
	movq	%rdx, 16(%rax)
	movq	$0, 24(%rax)
	movq	%rdx, 32(%rax)
	movq	$0, 40(%rax)
	movq	%rdx, 48(%rax)
	movq	$0, 56(%rax)
	addq	$64, %rax
	cmpq	%rcx, %rax
	jne	.LBB134_3
	leaq	4000(%rsp), %rdi
	leaq	416(%rsp), %rsi
	movq	memcpy@GOTPCREL(%rip), %rbx
	movl	$272, %edx
	callq	*%rbx
	movzwl	692(%rsp), %eax
	movl	%eax, 44(%rsp)
	leaq	700(%rsp), %rsi
	leaq	4272(%rsp), %rdi
	movl	$1284, %edx
	callq	*%rbx
	movzwl	1988(%rsp), %r13d
	leaq	1996(%rsp), %rsi
	leaq	5556(%rsp), %rdi
	movl	$1972, %edx
	callq	*%rbx
	movzwl	3972(%rsp), %eax
	movl	%eax, 52(%rsp)
	movl	3980(%rsp), %r12d
	movzwl	3988(%rsp), %eax
	movl	%eax, 48(%rsp)
	movl	3996(%rsp), %r15d
	leaq	_ZN7cryptos10interrupts12double_fault17h8e4873e22efc8641E(%rip), %rbx
	movq	%rbx, %rax
	shrq	$47, %rax
	je	.LBB134_8
	leaq	_ZN7cryptos10interrupts12double_fault17h8e4873e22efc8641E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_8
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, %rbx
.LBB134_8:
	leaq	_ZN7cryptos10interrupts10page_fault17h14408972bb69c536E(%rip), %rbp
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movl	%eax, %r14d
	movq	%rbp, %rax
	shrq	$47, %rax
	je	.LBB134_12
	leaq	_ZN7cryptos10interrupts10page_fault17h14408972bb69c536E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_12
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, %rbp
.LBB134_12:
	movq	%rbp, 128(%rsp)
	leaq	_ZN7cryptos10interrupts6sigfpe17h82499bbf9478eb0bE(%rip), %rbp
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movq	%rbp, %rcx
	shrq	$47, %rcx
	je	.LBB134_16
	leaq	_ZN7cryptos10interrupts6sigfpe17h82499bbf9478eb0bE(%rip), %rdx
	movq	%rdx, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_16
	cmpl	$1, %ecx
	jne	.LBB134_68
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rdx, %rbp
.LBB134_16:
	movw	%ax, 36(%rsp)
	movw	%r14w, 38(%rsp)
	movq	%rbx, 384(%rsp)
	movq	%rbp, 392(%rsp)
	leaq	_ZN7cryptos10interrupts11invalid_tss17h3abe796b13aa3102E(%rip), %r14
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movq	%r14, 88(%rsp)
	shrq	$47, %r14
	je	.LBB134_20
	leaq	_ZN7cryptos10interrupts11invalid_tss17h3abe796b13aa3102E(%rip), %rdx
	movq	%rdx, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_20
	cmpl	$1, %ecx
	jne	.LBB134_68
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rdx, 88(%rsp)
.LBB134_20:
	movl	%r13d, %ebx
	movw	%ax, 34(%rsp)
	leaq	_ZN7cryptos10interrupts6sigbus17h597adb0c8286a2c9E(%rip), %r14
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movl	%eax, %r13d
	movq	%r14, 80(%rsp)
	shrq	$47, %r14
	je	.LBB134_24
	leaq	_ZN7cryptos10interrupts6sigbus17h597adb0c8286a2c9E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_24
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, 80(%rsp)
.LBB134_24:
	leaq	_ZN7cryptos10interrupts7sigsegv17h8aa57eeff995121dE(%rip), %rbp
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movl	%eax, %r14d
	movq	%rbp, %rax
	shrq	$47, %rax
	je	.LBB134_28
	leaq	_ZN7cryptos10interrupts7sigsegv17h8aa57eeff995121dE(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_28
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, %rbp
.LBB134_28:
	movl	%r12d, 96(%rsp)
	movl	%r15d, 100(%rsp)
	movl	%ebx, 40(%rsp)
	leaq	_ZN7cryptos10interrupts18general_protection17h832b4df9a2f4e224E(%rip), %r12
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movq	%r12, 72(%rsp)
	shrq	$47, %r12
	je	.LBB134_32
	leaq	_ZN7cryptos10interrupts18general_protection17h832b4df9a2f4e224E(%rip), %rdx
	movq	%rdx, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_32
	cmpl	$1, %ecx
	jne	.LBB134_68
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rdx, 72(%rsp)
.LBB134_32:
	movw	%ax, 32(%rsp)
	leaq	_ZN7cryptos10interrupts10breakpoint17h330af6ef4a811bedE(%rip), %rbx
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movl	%eax, %r12d
	movq	%rbx, 64(%rsp)
	movq	%rbx, %rax
	shrq	$47, %rax
	je	.LBB134_36
	leaq	_ZN7cryptos10interrupts10breakpoint17h330af6ef4a811bedE(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_36
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, 64(%rsp)
.LBB134_36:
	movq	%rbp, 120(%rsp)
	movw	%r14w, 30(%rsp)
	leaq	_ZN7cryptos10interrupts20bound_range_exceeded17hd3290ea832cb4869E(%rip), %r14
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movl	%eax, %ebp
	movq	%r14, %rax
	shrq	$47, %rax
	je	.LBB134_40
	leaq	_ZN7cryptos10interrupts20bound_range_exceeded17hd3290ea832cb4869E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_40
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, %r14
.LBB134_40:
	leaq	_ZN7cryptos10interrupts10invalid_op17h4915a7a0cce04ae0E(%rip), %rbx
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movq	%rbx, 56(%rsp)
	movq	%rbx, %rcx
	shrq	$47, %rcx
	je	.LBB134_44
	leaq	_ZN7cryptos10interrupts10invalid_op17h4915a7a0cce04ae0E(%rip), %rdx
	movq	%rdx, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_44
	cmpl	$1, %ecx
	jne	.LBB134_68
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rdx, 56(%rsp)
.LBB134_44:
	movw	%ax, 24(%rsp)
	movw	%bp, 26(%rsp)
	movw	%r13w, 28(%rsp)
	leaq	_ZN7cryptos10interrupts6navail17h6c40fefd72062ad0E(%rip), %rbp
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movl	%eax, %r15d
	movq	%rbp, %rax
	shrq	$47, %rax
	je	.LBB134_48
	leaq	_ZN7cryptos10interrupts6navail17h6c40fefd72062ad0E(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_48
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, %rbp
.LBB134_48:
	leaq	_ZN7cryptos10interrupts5timer17ha266d846786d7f80E(%rip), %rbx
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movq	%rbx, %rcx
	shrq	$47, %rcx
	je	.LBB134_52
	leaq	_ZN7cryptos10interrupts5timer17ha266d846786d7f80E(%rip), %rdx
	movq	%rdx, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_52
	cmpl	$1, %ecx
	jne	.LBB134_68
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rdx, %rbx
.LBB134_52:
	movl	%r12d, %r13d
	movw	%ax, 20(%rsp)
	movq	%rbp, 112(%rsp)
	movw	%r15w, 22(%rsp)
	leaq	_ZN7cryptos10interrupts9lapic_err17h896d0c5d0cc01ae1E(%rip), %r12
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movq	%r12, %r15
	shrq	$47, %r12
	je	.LBB134_56
	leaq	_ZN7cryptos10interrupts9lapic_err17h896d0c5d0cc01ae1E(%rip), %rdx
	movq	%rdx, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_56
	cmpl	$1, %ecx
	jne	.LBB134_68
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rdx, %r15
.LBB134_56:
	movw	%ax, 18(%rsp)
	movq	%r14, 104(%rsp)
	movq	%rbx, %r12
	leaq	_ZN7cryptos10interrupts8spurious17h3ca489531f11108dE(%rip), %rbp
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movq	%rbp, %rbx
	shrq	$47, %rbx
	movq	%rbp, %r14
	je	.LBB134_60
	leaq	_ZN7cryptos10interrupts8spurious17h3ca489531f11108dE(%rip), %rdx
	movq	%rdx, %rcx
	shrq	$47, %rcx
	movq	%rbp, %r14
	cmpl	$131071, %ecx
	je	.LBB134_60
	cmpl	$1, %ecx
	jne	.LBB134_68
	shlq	$16, %rdx
	sarq	$16, %rdx
	movq	%rdx, %r14
.LBB134_60:
	movw	%ax, 14(%rsp)
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movw	%ax, 12(%rsp)
	testq	%rbx, %rbx
	movw	%r13w, 16(%rsp)
	je	.LBB134_64
	leaq	_ZN7cryptos10interrupts8spurious17h3ca489531f11108dE(%rip), %rax
	movq	%rax, %rcx
	shrq	$47, %rcx
	cmpl	$131071, %ecx
	je	.LBB134_64
	cmpl	$1, %ecx
	jne	.LBB134_66
	shlq	$16, %rax
	sarq	$16, %rax
	movq	%rax, %rbp
.LBB134_64:
	movq	%r14, 312(%rsp)
	orl	$32768, 48(%rsp)
	movq	%r14, %rcx
	shrq	$32, %rcx
	movq	%rcx, 376(%rsp)
	shrq	$16, %r14
	movq	%r14, 368(%rsp)
	orl	$32768, 44(%rsp)
	movq	%r15, 328(%rsp)
	movq	%r15, %rsi
	shrq	$32, %rsi
	movq	%rsi, 360(%rsp)
	shrq	$16, %r15
	movq	%r15, 344(%rsp)
	orl	$32768, 52(%rsp)
	movq	%r12, 320(%rsp)
	movq	%r12, %rsi
	shrq	$32, %rsi
	movq	%rsi, 352(%rsp)
	shrq	$16, %r12
	movq	%r12, 336(%rsp)
	movq	112(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 264(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 256(%rsp)
	movq	56(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 232(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 224(%rsp)
	movq	104(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 192(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 176(%rsp)
	movq	64(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 152(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 144(%rsp)
	movq	72(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 280(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 272(%rsp)
	movq	120(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 248(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 240(%rsp)
	movq	80(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 216(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 200(%rsp)
	movq	88(%rsp), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movq	%rax, 168(%rsp)
	movq	%rcx, %rax
	shrq	$16, %rax
	movq	%rax, 160(%rsp)
	movq	%rbp, %rax
	movq	%rbp, 288(%rsp)
	movq	392(%rsp), %r12
	movq	%r12, %rbp
	shrq	$32, %rbp
	movq	%r12, %r13
	shrq	$16, %r13
	movq	128(%rsp), %rdx
	movq	%rdx, %rcx
	shrq	$32, %rcx
	movq	%rcx, 208(%rsp)
	movq	%rdx, %rcx
	shrq	$16, %rcx
	movq	%rcx, 184(%rsp)
	movq	384(%rsp), %r15
	movq	%r15, %rcx
	shrq	$32, %rcx
	movq	%rcx, 136(%rsp)
	movq	%r15, %r14
	shrq	$16, %r14
	movq	%rax, %rcx
	shrq	$16, %rcx
	movq	%rcx, 304(%rsp)
	movq	%rax, %rcx
	shrq	$32, %rcx
	movq	%rcx, 296(%rsp)
	callq	*_ZN6x86_6412instructions12segmentation106_$LT$impl$u20$x86_64..registers..segmentation..Segment$u20$for$u20$x86_64..registers..segmentation..CS$GT$7get_reg17hbb4e5fdc6ad0e6b0E@GOTPCREL(%rip)
	movw	%ax, 10(%rsp)
	orl	$32768, 40(%rsp)
	leaq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+544(%rip), %rdi
	leaq	4000(%rsp), %rsi
	movl	$272, %edx
	movq	memcpy@GOTPCREL(%rip), %rbx
	callq	*%rbx
	leaq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+828(%rip), %rdi
	leaq	4272(%rsp), %rsi
	movl	$1284, %edx
	callq	*%rbx
	leaq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+2124(%rip), %rdi
	leaq	5556(%rsp), %rsi
	movl	$1972, %edx
	callq	*%rbx
	movb	$1, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E(%rip)
	movb	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+16(%rip)
	movw	%r12w, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+32(%rip)
	movzwl	34(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+34(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+36(%rip)
	movw	%r13w, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+38(%rip)
	movl	%ebp, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+40(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+44(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+52(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+54(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+60(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+68(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+70(%rip)
	movw	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+78(%rip)
	movq	64(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+80(%rip)
	movzwl	26(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+82(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+84(%rip)
	movq	144(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+86(%rip)
	movq	152(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+88(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+92(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+100(%rip)
	movw	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+110(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+102(%rip)
	movq	104(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+112(%rip)
	movzwl	24(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+114(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+116(%rip)
	movq	176(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+118(%rip)
	movq	192(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+120(%rip)
	movl	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+124(%rip)
	movq	56(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+128(%rip)
	movzwl	22(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+130(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+132(%rip)
	movq	224(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+134(%rip)
	movq	232(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+136(%rip)
	movl	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+140(%rip)
	movq	112(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+144(%rip)
	movzwl	20(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+146(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+148(%rip)
	movq	256(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+150(%rip)
	movq	264(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+152(%rip)
	movl	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+156(%rip)
	movw	%r15w, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+160(%rip)
	movzwl	38(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+162(%rip)
	movw	$-29183, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+164(%rip)
	movw	%r14w, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+166(%rip)
	movq	136(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+168(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+172(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+180(%rip)
	movw	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+190(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+182(%rip)
	movq	88(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+192(%rip)
	movzwl	28(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+194(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+196(%rip)
	movq	160(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+198(%rip)
	movq	168(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+200(%rip)
	movl	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+204(%rip)
	movq	80(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+208(%rip)
	movzwl	30(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+210(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+212(%rip)
	movq	200(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+214(%rip)
	movq	216(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+216(%rip)
	movl	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+220(%rip)
	movq	120(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+224(%rip)
	movzwl	32(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+226(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+228(%rip)
	movq	240(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+230(%rip)
	movq	248(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+232(%rip)
	movl	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+236(%rip)
	movq	72(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+240(%rip)
	movzwl	16(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+242(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+244(%rip)
	movq	272(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+246(%rip)
	movq	280(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+248(%rip)
	movl	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+252(%rip)
	movq	128(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+256(%rip)
	movzwl	36(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+258(%rip)
	movw	$-29184, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+260(%rip)
	movq	184(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+262(%rip)
	movq	208(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+264(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+268(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+276(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+284(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+278(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+292(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+300(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+294(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+308(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+316(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+310(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+324(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+332(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+326(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+340(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+348(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+342(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+356(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+364(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+358(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+372(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+380(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+374(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+388(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+396(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+390(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+404(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+412(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+406(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+420(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+428(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+422(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+436(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+444(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+438(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+452(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+460(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+454(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+468(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+476(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+470(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+484(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+492(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+486(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+500(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+508(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+502(%rip)
	movw	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+516(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+524(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+518(%rip)
	movl	$3584, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+532(%rip)
	movq	$0, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+536(%rip)
	movq	328(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+816(%rip)
	movzwl	14(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+818(%rip)
	movl	44(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+820(%rip)
	movq	344(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+822(%rip)
	movq	360(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+824(%rip)
	movq	288(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+2112(%rip)
	movzwl	10(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+2114(%rip)
	movl	40(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+2116(%rip)
	movq	304(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+2118(%rip)
	movq	296(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+2120(%rip)
	movq	320(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4096(%rip)
	movzwl	18(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4098(%rip)
	movl	52(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4100(%rip)
	movq	336(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4102(%rip)
	movq	352(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4104(%rip)
	movl	96(%rsp), %eax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4108(%rip)
	movq	312(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4112(%rip)
	movzwl	12(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4114(%rip)
	movl	48(%rsp), %eax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4116(%rip)
	movq	368(%rsp), %rax
	movw	%ax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4118(%rip)
	movq	376(%rsp), %rax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4120(%rip)
	movl	100(%rsp), %eax
	movl	%eax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4124(%rip)
	movb	$0, 408(%rsp)
	movl	$2, %eax
	xchgq	%rax, _ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4128(%rip)
	leaq	400(%rsp), %rdi
	callq	*_ZN60_$LT$spin..once..Finish$u20$as$u20$core..ops..drop..Drop$GT$4drop17hb6d03ae45e193650E@GOTPCREL(%rip)
	jmp	.LBB134_65
	.p2align	4, 0x90
.LBB134_69:
	movq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+4128(%rip), %rax
.LBB134_70:
	cmpq	$1, %rax
	je	.LBB134_69
	cmpq	$2, %rax
	jne	.LBB134_72
.LBB134_65:
	leaq	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E+16(%rip), %rax
	addq	$7528, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB134_72:
	testq	%rax, %rax
	jne	.LBB134_74
	leaq	.L__unnamed_122(%rip), %rdi
	leaq	.L__unnamed_258(%rip), %rdx
	movl	$40, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB134_74:
	leaq	.L__unnamed_259(%rip), %rdi
	leaq	.L__unnamed_260(%rip), %rdx
	movl	$17, %esi
	callq	*_ZN4core9panicking5panic17h980461d6bf8aff67E@GOTPCREL(%rip)
	ud2
.LBB134_66:
	movq	%rax, 416(%rsp)
	jmp	.LBB134_67
.LBB134_68:
	movq	%rdx, 416(%rsp)
.LBB134_67:
	leaq	.L__unnamed_48(%rip), %rdi
	leaq	.L__unnamed_49(%rip), %rcx
	leaq	.L__unnamed_50(%rip), %r8
	leaq	416(%rsp), %rdx
	movl	$74, %esi
	callq	*_ZN4core6result13unwrap_failed17hff9109cb19756ecaE@GOTPCREL(%rip)
	ud2
.Lfunc_end134:
	.size	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E, .Lfunc_end134-_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref17h8adafbb64fdd79f3E

	.section	.text._start,"ax",@progbits
	.globl	_start
	.p2align	4, 0x90
	.type	_start,@function
_start:
	pushq	%rax
	callq	_ZN7cryptos5maink17h58f915735fd959feE
	ud2
.Lfunc_end135:
	.size	_start, .Lfunc_end135-_start

	.type	.L__unnamed_308,@object
	.section	.rodata..L__unnamed_308,"a",@progbits
.L__unnamed_308:
	.ascii	"no entry with index "
	.size	.L__unnamed_308, 20

	.type	.L__unnamed_4,@object
	.section	.data.rel.ro..L__unnamed_4,"aw",@progbits
	.p2align	3
.L__unnamed_4:
	.quad	.L__unnamed_308
	.asciz	"\024\000\000\000\000\000\000"
	.size	.L__unnamed_4, 16

	.type	.L__unnamed_309,@object
	.section	.rodata..L__unnamed_309,"a",@progbits
.L__unnamed_309:
	.ascii	"entry "
	.size	.L__unnamed_309, 6

	.type	.L__unnamed_310,@object
	.section	.rodata..L__unnamed_310,"a",@progbits
.L__unnamed_310:
	.ascii	" is an diverging exception (must not return)"
	.size	.L__unnamed_310, 44

	.type	.L__unnamed_2,@object
	.section	.data.rel.ro..L__unnamed_2,"aw",@progbits
	.p2align	3
.L__unnamed_2:
	.quad	.L__unnamed_309
	.asciz	"\006\000\000\000\000\000\000"
	.quad	.L__unnamed_310
	.asciz	",\000\000\000\000\000\000"
	.size	.L__unnamed_2, 32

	.type	.L__unnamed_311,@object
	.section	.rodata.cst32,"aM",@progbits,32
.L__unnamed_311:
	.ascii	" is an exception with error code"
	.size	.L__unnamed_311, 32

	.type	.L__unnamed_3,@object
	.section	.data.rel.ro..L__unnamed_3,"aw",@progbits
	.p2align	3
.L__unnamed_3:
	.quad	.L__unnamed_309
	.asciz	"\006\000\000\000\000\000\000"
	.quad	.L__unnamed_311
	.asciz	" \000\000\000\000\000\000"
	.size	.L__unnamed_3, 32

	.type	.L__unnamed_312,@object
	.section	.rodata..L__unnamed_312,"a",@progbits
.L__unnamed_312:
	.ascii	" is reserved"
	.size	.L__unnamed_312, 12

	.type	.L__unnamed_1,@object
	.section	.data.rel.ro..L__unnamed_1,"aw",@progbits
	.p2align	3
.L__unnamed_1:
	.quad	.L__unnamed_309
	.asciz	"\006\000\000\000\000\000\000"
	.quad	.L__unnamed_312
	.asciz	"\f\000\000\000\000\000\000"
	.size	.L__unnamed_1, 32

	.type	.L__unnamed_59,@object
	.section	.rodata..L__unnamed_59,"a",@progbits
	.p2align	3
.L__unnamed_59:
	.size	.L__unnamed_59, 0

	.type	.L__unnamed_18,@object
	.section	.rodata..L__unnamed_18,"a",@progbits
.L__unnamed_18:
	.ascii	"OnceCell instance has been poisoned."
	.size	.L__unnamed_18, 36

	.type	.L__unnamed_313,@object
	.section	.rodata..L__unnamed_313,"a",@progbits
.L__unnamed_313:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/conquer-once-0.3.2/src/cell.rs"
	.size	.L__unnamed_313, 81

	.type	.L__unnamed_122,@object
	.section	.rodata..L__unnamed_122,"a",@progbits
.L__unnamed_122:
	.ascii	"internal error: entered unreachable code"
	.size	.L__unnamed_122, 40

	.type	.L__unnamed_294,@object
	.section	.data.rel.ro..L__unnamed_294,"aw",@progbits
	.p2align	3
.L__unnamed_294:
	.quad	.L__unnamed_313
	.asciz	"Q\000\000\000\000\000\000\000T\002\000\000+\000\000"
	.size	.L__unnamed_294, 24

	.type	.L__unnamed_21,@object
	.section	.rodata..L__unnamed_21,"a",@progbits
.L__unnamed_21:
	.ascii	"called `Option::unwrap()` on a `None` value"
	.size	.L__unnamed_21, 43

	.type	.L__unnamed_22,@object
	.section	.data.rel.ro..L__unnamed_22,"aw",@progbits
	.p2align	3
.L__unnamed_22:
	.quad	.L__unnamed_313
	.asciz	"Q\000\000\000\000\000\000\000S\001\000\0007\000\000"
	.size	.L__unnamed_22, 24

	.type	.L__unnamed_19,@object
	.section	.data.rel.ro..L__unnamed_19,"aw",@progbits
	.p2align	3
.L__unnamed_19:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	_ZN69_$LT$conquer_once..state..PoisonError$u20$as$u20$core..fmt..Debug$GT$3fmt17h0598e7202f305984E
	.size	.L__unnamed_19, 32

	.type	.L__unnamed_62,@object
	.section	.data.rel.ro..L__unnamed_62,"aw",@progbits
	.p2align	3
.L__unnamed_62:
	.quad	.L__unnamed_313
	.asciz	"Q\000\000\000\000\000\000\000\245\000\000\000\017\000\000"
	.size	.L__unnamed_62, 24

	.type	.L__unnamed_314,@object
	.section	.rodata..L__unnamed_314,"a",@progbits
.L__unnamed_314:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/conquer-once-0.3.2/src/spin.rs"
	.size	.L__unnamed_314, 81

	.type	.L__unnamed_61,@object
	.section	.data.rel.ro..L__unnamed_61,"aw",@progbits
	.p2align	3
.L__unnamed_61:
	.quad	.L__unnamed_314
	.asciz	"Q\000\000\000\000\000\000\000P\000\000\000#\000\000"
	.size	.L__unnamed_61, 24

	.type	.L__unnamed_315,@object
	.section	.rodata..L__unnamed_315,"a",@progbits
.L__unnamed_315:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/conquer-once-0.3.2/src/state.rs"
	.size	.L__unnamed_315, 82

	.type	.L__unnamed_20,@object
	.section	.data.rel.ro..L__unnamed_20,"aw",@progbits
	.p2align	3
.L__unnamed_20:
	.quad	.L__unnamed_315
	.asciz	"R\000\000\000\000\000\000\000:\000\000\000\017\000\000"
	.size	.L__unnamed_20, 24

	.type	.L__unnamed_316,@object
	.section	.rodata..L__unnamed_316,"a",@progbits
.L__unnamed_316:
	.ascii	"Fatal error while executing AML (encountered DefFatal op). fatal_type = "
	.size	.L__unnamed_316, 72

	.type	.L__unnamed_317,@object
	.section	.rodata..L__unnamed_317,"a",@progbits
.L__unnamed_317:
	.ascii	", fatal_code = "
	.size	.L__unnamed_317, 15

	.type	.L__unnamed_318,@object
	.section	.rodata..L__unnamed_318,"a",@progbits
.L__unnamed_318:
	.ascii	", fatal_arg = "
	.size	.L__unnamed_318, 14

	.type	.L__unnamed_23,@object
	.section	.data.rel.ro..L__unnamed_23,"aw",@progbits
	.p2align	3
.L__unnamed_23:
	.quad	.L__unnamed_316
	.asciz	"H\000\000\000\000\000\000"
	.quad	.L__unnamed_317
	.asciz	"\017\000\000\000\000\000\000"
	.quad	.L__unnamed_318
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_23, 48

	.type	.L__unnamed_319,@object
	.section	.rodata..L__unnamed_319,"a",@progbits
.L__unnamed_319:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/aml-0.16.1/src/lib.rs"
	.size	.L__unnamed_319, 72

	.type	.L__unnamed_24,@object
	.section	.data.rel.ro..L__unnamed_24,"aw",@progbits
	.p2align	3
.L__unnamed_24:
	.quad	.L__unnamed_319
	.asciz	"H\000\000\000\000\000\000\000\265\002\000\000\t\000\000"
	.size	.L__unnamed_24, 24

	.type	.L__unnamed_320,@object
	.section	.rodata.cst32,"aM",@progbits,32
.L__unnamed_320:
	.ascii	"Found ACPI table with signature "
	.size	.L__unnamed_320, 32

	.type	.L__unnamed_321,@object
	.section	.rodata..L__unnamed_321,"a",@progbits
.L__unnamed_321:
	.ascii	" and length "
	.size	.L__unnamed_321, 12

	.type	.L__unnamed_28,@object
	.section	.data.rel.ro..L__unnamed_28,"aw",@progbits
	.p2align	3
.L__unnamed_28:
	.quad	.L__unnamed_320
	.asciz	" \000\000\000\000\000\000"
	.quad	.L__unnamed_321
	.asciz	"\f\000\000\000\000\000\000"
	.size	.L__unnamed_28, 32

	.type	.L__unnamed_322,@object
	.section	.rodata.cst4,"aM",@progbits,4
.L__unnamed_322:
	.ascii	"acpi"
	.size	.L__unnamed_322, 4

	.type	.L__unnamed_323,@object
	.section	.rodata..L__unnamed_323,"a",@progbits
.L__unnamed_323:
	.ascii	"/opt/rust/git/checkouts/acpi-e8f6effd6e7bed6b/e7c00ea/acpi/src/lib.rs"
	.size	.L__unnamed_323, 69

	.type	.L__unnamed_29,@object
	.section	.data.rel.ro..L__unnamed_29,"aw",@progbits
	.p2align	3
.L__unnamed_29:
	.quad	.L__unnamed_322
	.asciz	"\004\000\000\000\000\000\000"
	.quad	.L__unnamed_322
	.asciz	"\004\000\000\000\000\000\000"
	.quad	.L__unnamed_323
	.asciz	"E\000\000\000\000\000\000\000\325\000\000"
	.zero	4
	.size	.L__unnamed_29, 56

	.type	.L__unnamed_32,@object
	.section	.data.rel.ro..L__unnamed_32,"aw",@progbits
	.p2align	3
.L__unnamed_32:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h97aa9e3a076b37b7E
	.size	.L__unnamed_32, 32

	.type	.L__unnamed_149,@object
	.section	.data.rel.ro..L__unnamed_149,"aw",@progbits
	.p2align	3
.L__unnamed_149:
	.quad	.L__unnamed_59
	.zero	8
	.size	.L__unnamed_149, 16

	.type	.L__unnamed_259,@object
	.section	.rodata..L__unnamed_259,"a",@progbits
.L__unnamed_259:
	.ascii	"Once has panicked"
	.size	.L__unnamed_259, 17

	.type	.L__unnamed_324,@object
	.section	.rodata..L__unnamed_324,"a",@progbits
.L__unnamed_324:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/spin-0.5.2/src/once.rs"
	.size	.L__unnamed_324, 73

	.type	.L__unnamed_260,@object
	.section	.data.rel.ro..L__unnamed_260,"aw",@progbits
	.p2align	3
.L__unnamed_260:
	.quad	.L__unnamed_324
	.asciz	"I\000\000\000\000\000\000\000\200\000\000\000\035\000\000"
	.size	.L__unnamed_260, 24

	.type	.L__unnamed_258,@object
	.section	.data.rel.ro..L__unnamed_258,"aw",@progbits
	.p2align	3
.L__unnamed_258:
	.quad	.L__unnamed_324
	.asciz	"I\000\000\000\000\000\000\000{\000\000\000\037\000\000"
	.size	.L__unnamed_258, 24

	.type	.L__unnamed_117,@object
	.section	.rodata..L__unnamed_117,"a",@progbits
.L__unnamed_117:
	.ascii	"Too many lock readers, cannot safely proceed"
	.size	.L__unnamed_117, 44

	.type	.L__unnamed_325,@object
	.section	.rodata..L__unnamed_325,"a",@progbits
.L__unnamed_325:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/spin-0.9.4/src/rwlock.rs"
	.size	.L__unnamed_325, 75

	.type	.L__unnamed_118,@object
	.section	.data.rel.ro..L__unnamed_118,"aw",@progbits
	.p2align	3
.L__unnamed_118:
	.quad	.L__unnamed_325
	.asciz	"K\000\000\000\000\000\000\000\004\001\000\000\r\000\000"
	.size	.L__unnamed_118, 24

	.type	.L__unnamed_39,@object
	.section	.rodata.cst32,"aM",@progbits,32
.L__unnamed_39:
	.ascii	"assertion failed: idx < CAPACITY"
	.size	.L__unnamed_39, 32

	.type	.L__unnamed_326,@object
	.section	.rodata..L__unnamed_326,"a",@progbits
.L__unnamed_326:
	.ascii	"/opt/rust/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/alloc/src/collections/btree/node.rs"
	.size	.L__unnamed_326, 118

	.type	.L__unnamed_37,@object
	.section	.rodata..L__unnamed_37,"a",@progbits
.L__unnamed_37:
	.ascii	"assertion failed: edge.height == self.height - 1"
	.size	.L__unnamed_37, 48

	.type	.L__unnamed_38,@object
	.section	.data.rel.ro..L__unnamed_38,"aw",@progbits
	.p2align	3
.L__unnamed_38:
	.quad	.L__unnamed_326
	.asciz	"v\000\000\000\000\000\000\000\207\002\000\000\t\000\000"
	.size	.L__unnamed_38, 24

	.type	.L__unnamed_40,@object
	.section	.data.rel.ro..L__unnamed_40,"aw",@progbits
	.p2align	3
.L__unnamed_40:
	.quad	.L__unnamed_326
	.asciz	"v\000\000\000\000\000\000\000\213\002\000\000\t\000\000"
	.size	.L__unnamed_40, 24

	.type	.L__unnamed_33,@object
	.section	.rodata..L__unnamed_33,"a",@progbits
.L__unnamed_33:
	.ascii	"assertion failed: src.len() == dst.len()"
	.size	.L__unnamed_33, 40

	.type	.L__unnamed_34,@object
	.section	.data.rel.ro..L__unnamed_34,"aw",@progbits
	.p2align	3
.L__unnamed_34:
	.quad	.L__unnamed_326
	.asciz	"v\000\000\000\000\000\000\000\322\006\000\000\005\000\000"
	.size	.L__unnamed_34, 24

	.type	.L__unnamed_35,@object
	.section	.data.rel.ro..L__unnamed_35,"aw",@progbits
	.p2align	3
.L__unnamed_35:
	.quad	.L__unnamed_326
	.asciz	"v\000\000\000\000\000\000\000V\004\000\000\026\000\000"
	.size	.L__unnamed_35, 24

	.type	.L__unnamed_36,@object
	.section	.data.rel.ro..L__unnamed_36,"aw",@progbits
	.p2align	3
.L__unnamed_36:
	.quad	.L__unnamed_326
	.asciz	"v\000\000\000\000\000\000\000\226\004\000\000\026\000\000"
	.size	.L__unnamed_36, 24

	.type	.L__unnamed_327,@object
	.section	.rodata..L__unnamed_327,"a",@progbits
.L__unnamed_327:
	.ascii	"/opt/rust/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/alloc/src/collections/btree/navigate.rs"
	.size	.L__unnamed_327, 122

	.type	.L__unnamed_30,@object
	.section	.data.rel.ro..L__unnamed_30,"aw",@progbits
	.p2align	3
.L__unnamed_30:
	.quad	.L__unnamed_327
	.asciz	"z\000\000\000\000\000\000\000L\002\000\000\r\000\000"
	.size	.L__unnamed_30, 24

	.type	.L__unnamed_31,@object
	.section	.data.rel.ro..L__unnamed_31,"aw",@progbits
	.p2align	3
.L__unnamed_31:
	.quad	.L__unnamed_327
	.asciz	"z\000\000\000\000\000\000\000\272\000\000\000\025\000\000"
	.size	.L__unnamed_31, 24

	.type	.L__unnamed_119,@object
	.section	.rodata..L__unnamed_119,"a",@progbits
.L__unnamed_119:
	.ascii	"called `Result::unwrap()` on an `Err` value"
	.size	.L__unnamed_119, 43

	.type	.L__unnamed_41,@object
	.section	.rodata.cst4,"aM",@progbits,4
.L__unnamed_41:
	.ascii	"Some"
	.size	.L__unnamed_41, 4

	.type	.L__unnamed_43,@object
.L__unnamed_43:
	.ascii	"None"
	.size	.L__unnamed_43, 4

	.type	.L__unnamed_42,@object
	.section	.data.rel.ro..L__unnamed_42,"aw",@progbits
	.p2align	3
.L__unnamed_42:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hbf18ad751ac441a4E
	.size	.L__unnamed_42, 32

	.type	.L__unnamed_51,@object
	.section	.data.rel.ro..L__unnamed_51,"aw",@progbits
	.p2align	3
.L__unnamed_51:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17hb7256e89aecd4c85E
	.size	.L__unnamed_51, 32

	.type	.L__unnamed_306,@object
	.section	.rodata..L__unnamed_306,"a",@progbits
.L__unnamed_306:
	.ascii	"GDT requires two free spaces to hold a SystemSegment"
	.size	.L__unnamed_306, 52

	.type	.L__unnamed_328,@object
	.section	.rodata..L__unnamed_328,"a",@progbits
.L__unnamed_328:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/x86_64-0.14.10/src/structures/gdt.rs"
	.size	.L__unnamed_328, 87

	.type	.L__unnamed_307,@object
	.section	.data.rel.ro..L__unnamed_307,"aw",@progbits
	.p2align	3
.L__unnamed_307:
	.quad	.L__unnamed_328
	.asciz	"W\000\000\000\000\000\000\000o\000\000\000\025\000\000"
	.size	.L__unnamed_307, 24

	.type	.L__unnamed_305,@object
	.section	.data.rel.ro..L__unnamed_305,"aw",@progbits
	.p2align	3
.L__unnamed_305:
	.quad	.L__unnamed_328
	.asciz	"W\000\000\000\000\000\000\000r\000\000\000\021\000\000"
	.size	.L__unnamed_305, 24

	.type	.L__unnamed_64,@object
	.section	.rodata..L__unnamed_64,"a",@progbits
.L__unnamed_64:
	.ascii	"physical addresses must not have any bits in the range 52 to 64 set"
	.size	.L__unnamed_64, 67

	.type	.L__unnamed_329,@object
	.section	.rodata..L__unnamed_329,"a",@progbits
.L__unnamed_329:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/x86_64-0.14.10/src/addr.rs"
	.size	.L__unnamed_329, 77

	.type	.L__unnamed_65,@object
	.section	.data.rel.ro..L__unnamed_65,"aw",@progbits
	.p2align	3
.L__unnamed_65:
	.quad	.L__unnamed_329
	.asciz	"M\000\000\000\000\000\000\000\260\001\000\000\027\000\000"
	.size	.L__unnamed_65, 24

	.type	.L__unnamed_44,@object
	.section	.rodata..L__unnamed_44,"a",@progbits
.L__unnamed_44:
	.ascii	"assertion failed: addr.is_aligned(Size4KiB::SIZE)"
	.size	.L__unnamed_44, 49

	.type	.L__unnamed_330,@object
	.section	.rodata..L__unnamed_330,"a",@progbits
.L__unnamed_330:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/x86_64-0.14.10/src/structures/paging/page_table.rs"
	.size	.L__unnamed_330, 101

	.type	.L__unnamed_45,@object
	.section	.data.rel.ro..L__unnamed_45,"aw",@progbits
	.p2align	3
.L__unnamed_45:
	.quad	.L__unnamed_330
	.asciz	"e\000\000\000\000\000\000\000P\000\000\000\t\000\000"
	.size	.L__unnamed_45, 24

	.type	.L__unnamed_331,@object
	.section	.rodata..L__unnamed_331,"a",@progbits
.L__unnamed_331:
	.ascii	"/opt/rust/registry/src/github.com-1ecc6299db9ec823/x86_64-0.14.10/src/structures/paging/mapper/mapped_page_table.rs"
	.size	.L__unnamed_331, 115

	.type	.L__unnamed_46,@object
	.section	.rodata..L__unnamed_46,"a",@progbits
.L__unnamed_46:
	.ascii	"entry should be mapped at this point"
	.size	.L__unnamed_46, 36

	.type	.L__unnamed_47,@object
	.section	.data.rel.ro..L__unnamed_47,"aw",@progbits
	.p2align	3
.L__unnamed_47:
	.quad	.L__unnamed_331
	.asciz	"s\000\000\000\000\000\000\000\001\003\000\0003\000\000"
	.size	.L__unnamed_47, 24

	.type	.L__unnamed_48,@object
	.section	.rodata..L__unnamed_48,"a",@progbits
.L__unnamed_48:
	.ascii	"address passed to VirtAddr::new must not contain any data in bits 48 to 64"
	.size	.L__unnamed_48, 74

	.type	.L__unnamed_49,@object
	.section	.data.rel.ro..L__unnamed_49,"aw",@progbits
	.p2align	3
.L__unnamed_49:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN67_$LT$x86_64..addr..VirtAddrNotValid$u20$as$u20$core..fmt..Debug$GT$3fmt17h56c6c9594001e8f8E
	.size	.L__unnamed_49, 32

	.type	.L__unnamed_50,@object
	.section	.data.rel.ro..L__unnamed_50,"aw",@progbits
	.p2align	3
.L__unnamed_50:
	.quad	.L__unnamed_329
	.asciz	"M\000\000\000\000\000\000\000H\000\000\000\t\000\000"
	.size	.L__unnamed_50, 24

	.type	.L__unnamed_265,@object
	.section	.data.rel.ro..L__unnamed_265,"aw",@progbits
	.p2align	3
.L__unnamed_265:
	.quad	.L__unnamed_329
	.asciz	"M\000\000\000\000\000\000\0006\001\000\000\027\000\000"
	.size	.L__unnamed_265, 24

	.type	.L__unnamed_52,@object
	.section	.data.rel.ro..L__unnamed_52,"aw",@progbits
	.p2align	3
.L__unnamed_52:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h7f90e13ca7477986E
	.size	.L__unnamed_52, 32

	.type	.L__unnamed_332,@object
	.section	.rodata..L__unnamed_332,"a",@progbits
.L__unnamed_332:
	.ascii	"PhysFrame["
	.size	.L__unnamed_332, 10

	.type	.L__unnamed_333,@object
	.section	.rodata..L__unnamed_333,"a",@progbits
.L__unnamed_333:
	.ascii	"]("
	.size	.L__unnamed_333, 2

	.type	.L__unnamed_334,@object
	.section	.rodata..L__unnamed_334,"a",@progbits
.L__unnamed_334:
	.byte	41
	.size	.L__unnamed_334, 1

	.type	.L__unnamed_26,@object
	.section	.data.rel.ro..L__unnamed_26,"aw",@progbits
	.p2align	3
.L__unnamed_26:
	.quad	.L__unnamed_332
	.asciz	"\n\000\000\000\000\000\000"
	.quad	.L__unnamed_333
	.asciz	"\002\000\000\000\000\000\000"
	.quad	.L__unnamed_334
	.asciz	"\001\000\000\000\000\000\000"
	.size	.L__unnamed_26, 48

	.type	.L__unnamed_335,@object
	.section	.rodata.cst4,"aM",@progbits,4
.L__unnamed_335:
	.ascii	"4KiB"
	.size	.L__unnamed_335, 4

	.type	.L__unnamed_25,@object
	.section	.data.rel.ro..L__unnamed_25,"aw",@progbits
	.p2align	3
.L__unnamed_25:
	.quad	.L__unnamed_335
	.asciz	"\004\000\000\000\000\000\000"
	.size	.L__unnamed_25, 16

	.type	.L__unnamed_27,@object
	.section	.rodata..L__unnamed_27,"a",@progbits
	.p2align	3
.L__unnamed_27:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\000\000\000\000\003"
	.zero	7
	.asciz	"\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\004\000\000\000\003"
	.zero	7
	.size	.L__unnamed_27, 112

	.type	.L__unnamed_55,@object
	.section	.rodata..L__unnamed_55,"a",@progbits
.L__unnamed_55:
	.ascii	"PageAlreadyMapped"
	.size	.L__unnamed_55, 17

	.type	.L__unnamed_56,@object
	.section	.data.rel.ro..L__unnamed_56,"aw",@progbits
	.p2align	3
.L__unnamed_56:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h33eac4d4d6bf9555E
	.size	.L__unnamed_56, 32

	.type	.L__unnamed_53,@object
	.section	.rodata..L__unnamed_53,"a",@progbits
.L__unnamed_53:
	.ascii	"ParentEntryHugePage"
	.size	.L__unnamed_53, 19

	.type	.L__unnamed_54,@object
	.section	.rodata..L__unnamed_54,"a",@progbits
.L__unnamed_54:
	.ascii	"FrameAllocationFailed"
	.size	.L__unnamed_54, 21

	.type	.L__unnamed_336,@object
	.section	.rodata..L__unnamed_336,"a",@progbits
.L__unnamed_336:
	.ascii	"Already have a page here; skipping mapping"
	.size	.L__unnamed_336, 42

	.type	.L__unnamed_57,@object
	.section	.data.rel.ro..L__unnamed_57,"aw",@progbits
	.p2align	3
.L__unnamed_57:
	.quad	.L__unnamed_336
	.asciz	"*\000\000\000\000\000\000"
	.size	.L__unnamed_57, 16

	.type	.L__unnamed_337,@object
	.section	.rodata..L__unnamed_337,"a",@progbits
.L__unnamed_337:
	.ascii	"cryptos::acpi_impl"
	.size	.L__unnamed_337, 18

	.type	.L__unnamed_338,@object
	.section	.rodata.cst16,"aM",@progbits,16
.L__unnamed_338:
	.ascii	"src/acpi_impl.rs"
	.size	.L__unnamed_338, 16

	.type	.L__unnamed_60,@object
	.section	.data.rel.ro..L__unnamed_60,"aw",@progbits
	.p2align	3
.L__unnamed_60:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000+\000\000"
	.zero	4
	.size	.L__unnamed_60, 56

	.type	.L__unnamed_339,@object
	.section	.rodata..L__unnamed_339,"a",@progbits
.L__unnamed_339:
	.ascii	"Already have a huge page here; skipping mapping"
	.size	.L__unnamed_339, 47

	.type	.L__unnamed_58,@object
	.section	.data.rel.ro..L__unnamed_58,"aw",@progbits
	.p2align	3
.L__unnamed_58:
	.quad	.L__unnamed_339
	.asciz	"/\000\000\000\000\000\000"
	.size	.L__unnamed_58, 16

	.type	.L__unnamed_340,@object
	.section	.rodata..L__unnamed_340,"a",@progbits
.L__unnamed_340:
	.ascii	"Out of memory"
	.size	.L__unnamed_340, 13

	.type	.L__unnamed_68,@object
	.section	.data.rel.ro..L__unnamed_68,"aw",@progbits
	.p2align	3
.L__unnamed_68:
	.quad	.L__unnamed_340
	.asciz	"\r\000\000\000\000\000\000"
	.size	.L__unnamed_68, 16

	.type	.L__unnamed_66,@object
	.section	.data.rel.ro..L__unnamed_66,"aw",@progbits
	.p2align	3
.L__unnamed_66:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000+\000\000\000\t\000\000"
	.size	.L__unnamed_66, 24

	.type	.L__unnamed_67,@object
	.section	.data.rel.ro..L__unnamed_67,"aw",@progbits
	.p2align	3
.L__unnamed_67:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\0004\000\000\000\r\000\000"
	.size	.L__unnamed_67, 24

	.type	.L__unnamed_69,@object
	.section	.data.rel.ro..L__unnamed_69,"aw",@progbits
	.p2align	3
.L__unnamed_69:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000@\000\000"
	.zero	4
	.size	.L__unnamed_69, 56

	.type	.L__unnamed_70,@object
	.section	.data.rel.ro..L__unnamed_70,"aw",@progbits
	.p2align	3
.L__unnamed_70:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000@\000\000\000\t\000\000"
	.size	.L__unnamed_70, 24

	.type	.L__unnamed_71,@object
	.section	.data.rel.ro..L__unnamed_71,"aw",@progbits
	.p2align	3
.L__unnamed_71:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000K\000\000"
	.zero	4
	.size	.L__unnamed_71, 56

	.type	.L__unnamed_72,@object
	.section	.data.rel.ro..L__unnamed_72,"aw",@progbits
	.p2align	3
.L__unnamed_72:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000K\000\000\000\t\000\000"
	.size	.L__unnamed_72, 24

	.type	.L__unnamed_73,@object
	.section	.data.rel.ro..L__unnamed_73,"aw",@progbits
	.p2align	3
.L__unnamed_73:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000V\000\000"
	.zero	4
	.size	.L__unnamed_73, 56

	.type	.L__unnamed_74,@object
	.section	.data.rel.ro..L__unnamed_74,"aw",@progbits
	.p2align	3
.L__unnamed_74:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000V\000\000\000\t\000\000"
	.size	.L__unnamed_74, 24

	.type	.L__unnamed_75,@object
	.section	.data.rel.ro..L__unnamed_75,"aw",@progbits
	.p2align	3
.L__unnamed_75:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000a\000\000"
	.zero	4
	.size	.L__unnamed_75, 56

	.type	.L__unnamed_76,@object
	.section	.data.rel.ro..L__unnamed_76,"aw",@progbits
	.p2align	3
.L__unnamed_76:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000a\000\000\000\t\000\000"
	.size	.L__unnamed_76, 24

	.type	.L__unnamed_77,@object
	.section	.data.rel.ro..L__unnamed_77,"aw",@progbits
	.p2align	3
.L__unnamed_77:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000l\000\000"
	.zero	4
	.size	.L__unnamed_77, 56

	.type	.L__unnamed_78,@object
	.section	.data.rel.ro..L__unnamed_78,"aw",@progbits
	.p2align	3
.L__unnamed_78:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000l\000\000\000\t\000\000"
	.size	.L__unnamed_78, 24

	.type	.L__unnamed_79,@object
	.section	.data.rel.ro..L__unnamed_79,"aw",@progbits
	.p2align	3
.L__unnamed_79:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000y\000\000"
	.zero	4
	.size	.L__unnamed_79, 56

	.type	.L__unnamed_80,@object
	.section	.data.rel.ro..L__unnamed_80,"aw",@progbits
	.p2align	3
.L__unnamed_80:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000y\000\000\000\t\000\000"
	.size	.L__unnamed_80, 24

	.type	.L__unnamed_81,@object
	.section	.data.rel.ro..L__unnamed_81,"aw",@progbits
	.p2align	3
.L__unnamed_81:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\206\000\000"
	.zero	4
	.size	.L__unnamed_81, 56

	.type	.L__unnamed_82,@object
	.section	.data.rel.ro..L__unnamed_82,"aw",@progbits
	.p2align	3
.L__unnamed_82:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\206\000\000\000\t\000\000"
	.size	.L__unnamed_82, 24

	.type	.L__unnamed_83,@object
	.section	.data.rel.ro..L__unnamed_83,"aw",@progbits
	.p2align	3
.L__unnamed_83:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\223\000\000"
	.zero	4
	.size	.L__unnamed_83, 56

	.type	.L__unnamed_84,@object
	.section	.data.rel.ro..L__unnamed_84,"aw",@progbits
	.p2align	3
.L__unnamed_84:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\223\000\000\000\t\000\000"
	.size	.L__unnamed_84, 24

	.type	.L__unnamed_85,@object
	.section	.data.rel.ro..L__unnamed_85,"aw",@progbits
	.p2align	3
.L__unnamed_85:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\327\000\000"
	.zero	4
	.size	.L__unnamed_85, 56

	.type	.L__unnamed_86,@object
	.section	.data.rel.ro..L__unnamed_86,"aw",@progbits
	.p2align	3
.L__unnamed_86:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\327\000\000\000\t\000\000"
	.size	.L__unnamed_86, 24

	.type	.L__unnamed_87,@object
	.section	.data.rel.ro..L__unnamed_87,"aw",@progbits
	.p2align	3
.L__unnamed_87:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\357\000\000"
	.zero	4
	.size	.L__unnamed_87, 56

	.type	.L__unnamed_88,@object
	.section	.data.rel.ro..L__unnamed_88,"aw",@progbits
	.p2align	3
.L__unnamed_88:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\357\000\000\000\t\000\000"
	.size	.L__unnamed_88, 24

	.type	.L__unnamed_89,@object
	.section	.data.rel.ro..L__unnamed_89,"aw",@progbits
	.p2align	3
.L__unnamed_89:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\007\001\000"
	.zero	4
	.size	.L__unnamed_89, 56

	.type	.L__unnamed_90,@object
	.section	.data.rel.ro..L__unnamed_90,"aw",@progbits
	.p2align	3
.L__unnamed_90:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000\007\001\000\000\t\000\000"
	.size	.L__unnamed_90, 24

	.type	.L__unnamed_91,@object
	.section	.data.rel.ro..L__unnamed_91,"aw",@progbits
	.p2align	3
.L__unnamed_91:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000'\001\000"
	.zero	4
	.size	.L__unnamed_91, 56

	.type	.L__unnamed_92,@object
	.section	.data.rel.ro..L__unnamed_92,"aw",@progbits
	.p2align	3
.L__unnamed_92:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000'\001\000\000\t\000\000"
	.size	.L__unnamed_92, 24

	.type	.L__unnamed_93,@object
	.section	.data.rel.ro..L__unnamed_93,"aw",@progbits
	.p2align	3
.L__unnamed_93:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000I\001\000"
	.zero	4
	.size	.L__unnamed_93, 56

	.type	.L__unnamed_94,@object
	.section	.data.rel.ro..L__unnamed_94,"aw",@progbits
	.p2align	3
.L__unnamed_94:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000I\001\000\000\t\000\000"
	.size	.L__unnamed_94, 24

	.type	.L__unnamed_95,@object
	.section	.data.rel.ro..L__unnamed_95,"aw",@progbits
	.p2align	3
.L__unnamed_95:
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_337
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000k\001\000"
	.zero	4
	.size	.L__unnamed_95, 56

	.type	.L__unnamed_96,@object
	.section	.data.rel.ro..L__unnamed_96,"aw",@progbits
	.p2align	3
.L__unnamed_96:
	.quad	.L__unnamed_338
	.asciz	"\020\000\000\000\000\000\000\000k\001\000\000\t\000\000"
	.size	.L__unnamed_96, 24

	.type	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE,@object
	.section	.bss._ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE,"aw",@nobits
	.p2align	3
_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE:
	.zero	16
	.zero	16
	.size	_ZN7cryptos4ahci3hba9EIO_DEBUG17h81ffea899b833b2eE, 32

	.type	_ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E,@object
	.section	.data._ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E,"aw",@progbits
	.p2align	3
_ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E:
	.asciz	"\000\000\000\000\000\000\000\000\005\000\000"
	.zero	4
	.size	_ZN7cryptos4ahci3hba10EIO_STATUS17h3225712599fe1494E, 16

	.type	_ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE,@object
	.section	.bss._ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE,"aw",@nobits
	.p2align	3
_ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE:
	.zero	12
	.zero	4
	.size	_ZN7cryptos4ahci3hba9GLOBAL_IS17ha80eb59c7e3cd38eE, 16

	.type	.L__unnamed_341,@object
	.section	.rodata..L__unnamed_341,"a",@progbits
.L__unnamed_341:
	.ascii	"src/ahci/hba/mod.rs"
	.size	.L__unnamed_341, 19

	.type	.L__unnamed_342,@object
	.section	.rodata..L__unnamed_342,"a",@progbits
.L__unnamed_342:
	.ascii	"Initialized AHCI with command vector "
	.size	.L__unnamed_342, 37

	.type	.L__unnamed_97,@object
	.section	.data.rel.ro..L__unnamed_97,"aw",@progbits
	.p2align	3
.L__unnamed_97:
	.quad	.L__unnamed_342
	.asciz	"%\000\000\000\000\000\000"
	.size	.L__unnamed_97, 16

	.type	.L__unnamed_10,@object
	.section	.rodata..L__unnamed_10,"a",@progbits
	.p2align	3
.L__unnamed_10:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\004\000\000\000\003"
	.zero	7
	.size	.L__unnamed_10, 56

	.type	.L__unnamed_343,@object
	.section	.rodata..L__unnamed_343,"a",@progbits
.L__unnamed_343:
	.ascii	"cryptos::ahci::hba"
	.size	.L__unnamed_343, 18

	.type	.L__unnamed_98,@object
	.section	.data.rel.ro..L__unnamed_98,"aw",@progbits
	.p2align	3
.L__unnamed_98:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\216\000\000"
	.zero	4
	.size	.L__unnamed_98, 56

	.type	.L__unnamed_116,@object
	.section	.data.rel.ro..L__unnamed_116,"aw",@progbits
	.p2align	3
.L__unnamed_116:
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\245\000\000\000#\000\000"
	.size	.L__unnamed_116, 24

	.type	.L__unnamed_344,@object
	.section	.rodata..L__unnamed_344,"a",@progbits
.L__unnamed_344:
	.ascii	"internal error: entered unreachable code: "
	.size	.L__unnamed_344, 42

	.type	.L__unnamed_100,@object
	.section	.data.rel.ro..L__unnamed_100,"aw",@progbits
	.p2align	3
.L__unnamed_100:
	.quad	.L__unnamed_344
	.asciz	"*\000\000\000\000\000\000"
	.size	.L__unnamed_100, 16

	.type	.L__unnamed_345,@object
	.section	.rodata..L__unnamed_345,"a",@progbits
.L__unnamed_345:
	.ascii	"only have 4 error bits to choose from here"
	.size	.L__unnamed_345, 42

	.type	.L__unnamed_99,@object
	.section	.data.rel.ro..L__unnamed_99,"aw",@progbits
	.p2align	3
.L__unnamed_99:
	.quad	.L__unnamed_345
	.asciz	"*\000\000\000\000\000\000"
	.size	.L__unnamed_99, 16

	.type	.L__unnamed_101,@object
	.section	.data.rel.ro..L__unnamed_101,"aw",@progbits
	.p2align	3
.L__unnamed_101:
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\353\000\000\000\026\000\000"
	.size	.L__unnamed_101, 24

	.type	.L__unnamed_120,@object
	.section	.data.rel.ro..L__unnamed_120,"aw",@progbits
	.p2align	3
.L__unnamed_120:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\004\000\000\000\000\000\000\000\004\000\000\000\000\000\000"
	.quad	_ZN58_$LT$syscall..error..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h77d959c082dd1971E
	.size	.L__unnamed_120, 32

	.type	.L__unnamed_121,@object
	.section	.data.rel.ro..L__unnamed_121,"aw",@progbits
	.p2align	3
.L__unnamed_121:
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\370\000\000\000\024\000\000"
	.size	.L__unnamed_121, 24

	.type	.L__unnamed_123,@object
	.section	.data.rel.ro..L__unnamed_123,"aw",@progbits
	.p2align	3
.L__unnamed_123:
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000H\001\000\000\026\000\000"
	.size	.L__unnamed_123, 24

	.type	.L__unnamed_105,@object
	.section	.rodata..L__unnamed_105,"a",@progbits
.L__unnamed_105:
	.ascii	"SATA interface encountered an error that it couldn't recover from"
	.size	.L__unnamed_105, 65

	.type	.L__unnamed_104,@object
	.section	.rodata..L__unnamed_104,"a",@progbits
.L__unnamed_104:
	.ascii	"Attempted write has been performed using invalid or corrupt data"
	.size	.L__unnamed_104, 64

	.type	.L__unnamed_103,@object
	.section	.rodata..L__unnamed_103,"a",@progbits
.L__unnamed_103:
	.ascii	"Host bus encountered an error (i.e. null pointer) from which it could not recover"
	.size	.L__unnamed_103, 81

	.type	.L__unnamed_102,@object
	.section	.rodata..L__unnamed_102,"a",@progbits
.L__unnamed_102:
	.ascii	"Task file error"
	.size	.L__unnamed_102, 15

	.type	.L__unnamed_346,@object
	.section	.rodata..L__unnamed_346,"a",@progbits
.L__unnamed_346:
	.ascii	"Serial identifier: "
	.size	.L__unnamed_346, 19

	.type	.L__unnamed_106,@object
	.section	.data.rel.ro..L__unnamed_106,"aw",@progbits
	.p2align	3
.L__unnamed_106:
	.quad	.L__unnamed_346
	.asciz	"\023\000\000\000\000\000\000"
	.size	.L__unnamed_106, 16

	.type	.L__unnamed_107,@object
	.section	.data.rel.ro..L__unnamed_107,"aw",@progbits
	.p2align	3
.L__unnamed_107:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000'\001\000"
	.zero	4
	.size	.L__unnamed_107, 56

	.type	.L__unnamed_347,@object
	.section	.rodata..L__unnamed_347,"a",@progbits
.L__unnamed_347:
	.ascii	"Firmware identifier: "
	.size	.L__unnamed_347, 21

	.type	.L__unnamed_108,@object
	.section	.data.rel.ro..L__unnamed_108,"aw",@progbits
	.p2align	3
.L__unnamed_108:
	.quad	.L__unnamed_347
	.asciz	"\025\000\000\000\000\000\000"
	.size	.L__unnamed_108, 16

	.type	.L__unnamed_109,@object
	.section	.data.rel.ro..L__unnamed_109,"aw",@progbits
	.p2align	3
.L__unnamed_109:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000(\001\000"
	.zero	4
	.size	.L__unnamed_109, 56

	.type	.L__unnamed_348,@object
	.section	.rodata..L__unnamed_348,"a",@progbits
.L__unnamed_348:
	.ascii	"Model identifier: "
	.size	.L__unnamed_348, 18

	.type	.L__unnamed_110,@object
	.section	.data.rel.ro..L__unnamed_110,"aw",@progbits
	.p2align	3
.L__unnamed_110:
	.quad	.L__unnamed_348
	.asciz	"\022\000\000\000\000\000\000"
	.size	.L__unnamed_110, 16

	.type	.L__unnamed_111,@object
	.section	.data.rel.ro..L__unnamed_111,"aw",@progbits
	.p2align	3
.L__unnamed_111:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000)\001\000"
	.zero	4
	.size	.L__unnamed_111, 56

	.type	.L__unnamed_349,@object
	.section	.rodata.cst8,"aM",@progbits,8
.L__unnamed_349:
	.ascii	"-bit LBA"
	.size	.L__unnamed_349, 8

	.type	.L__unnamed_112,@object
	.section	.data.rel.ro..L__unnamed_112,"aw",@progbits
	.p2align	3
.L__unnamed_112:
	.quad	.L__unnamed_59
	.zero	8
	.quad	.L__unnamed_349
	.asciz	"\b\000\000\000\000\000\000"
	.size	.L__unnamed_112, 32

	.type	.L__unnamed_113,@object
	.section	.data.rel.ro..L__unnamed_113,"aw",@progbits
	.p2align	3
.L__unnamed_113:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000*\001\000"
	.zero	4
	.size	.L__unnamed_113, 56

	.type	.L__unnamed_350,@object
	.section	.rodata..L__unnamed_350,"a",@progbits
.L__unnamed_350:
	.ascii	"Size: "
	.size	.L__unnamed_350, 6

	.type	.L__unnamed_351,@object
	.section	.rodata..L__unnamed_351,"a",@progbits
.L__unnamed_351:
	.ascii	" MB"
	.size	.L__unnamed_351, 3

	.type	.L__unnamed_114,@object
	.section	.data.rel.ro..L__unnamed_114,"aw",@progbits
	.p2align	3
.L__unnamed_114:
	.quad	.L__unnamed_350
	.asciz	"\006\000\000\000\000\000\000"
	.quad	.L__unnamed_351
	.asciz	"\003\000\000\000\000\000\000"
	.size	.L__unnamed_114, 32

	.type	.L__unnamed_115,@object
	.section	.data.rel.ro..L__unnamed_115,"aw",@progbits
	.p2align	3
.L__unnamed_115:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000+\001\000"
	.zero	4
	.size	.L__unnamed_115, 56

	.type	.L__unnamed_352,@object
	.section	.rodata..L__unnamed_352,"a",@progbits
.L__unnamed_352:
	.ascii	"AHCI control address: "
	.size	.L__unnamed_352, 22

	.type	.L__unnamed_128,@object
	.section	.data.rel.ro..L__unnamed_128,"aw",@progbits
	.p2align	3
.L__unnamed_128:
	.quad	.L__unnamed_352
	.asciz	"\026\000\000\000\000\000\000"
	.size	.L__unnamed_128, 16

	.type	.L__unnamed_129,@object
	.section	.data.rel.ro..L__unnamed_129,"aw",@progbits
	.p2align	3
.L__unnamed_129:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000f\001\000"
	.zero	4
	.size	.L__unnamed_129, 56

	.type	.L__unnamed_353,@object
	.section	.rodata..L__unnamed_353,"a",@progbits
.L__unnamed_353:
	.ascii	"DMA block address: "
	.size	.L__unnamed_353, 19

	.type	.L__unnamed_130,@object
	.section	.data.rel.ro..L__unnamed_130,"aw",@progbits
	.p2align	3
.L__unnamed_130:
	.quad	.L__unnamed_353
	.asciz	"\023\000\000\000\000\000\000"
	.size	.L__unnamed_130, 16

	.type	.L__unnamed_131,@object
	.section	.data.rel.ro..L__unnamed_131,"aw",@progbits
	.p2align	3
.L__unnamed_131:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000j\001\000"
	.zero	4
	.size	.L__unnamed_131, 56

	.type	.L__unnamed_354,@object
	.section	.rodata..L__unnamed_354,"a",@progbits
.L__unnamed_354:
	.ascii	"Sector count: "
	.size	.L__unnamed_354, 14

	.type	.L__unnamed_132,@object
	.section	.data.rel.ro..L__unnamed_132,"aw",@progbits
	.p2align	3
.L__unnamed_132:
	.quad	.L__unnamed_354
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_132, 16

	.type	.L__unnamed_133,@object
	.section	.data.rel.ro..L__unnamed_133,"aw",@progbits
	.p2align	3
.L__unnamed_133:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000k\001\000"
	.zero	4
	.size	.L__unnamed_133, 56

	.type	.L__unnamed_355,@object
	.section	.rodata..L__unnamed_355,"a",@progbits
.L__unnamed_355:
	.ascii	"Is write command? "
	.size	.L__unnamed_355, 18

	.type	.L__unnamed_134,@object
	.section	.data.rel.ro..L__unnamed_134,"aw",@progbits
	.p2align	3
.L__unnamed_134:
	.quad	.L__unnamed_355
	.asciz	"\022\000\000\000\000\000\000"
	.size	.L__unnamed_134, 16

	.type	.L__unnamed_135,@object
	.section	.data.rel.ro..L__unnamed_135,"aw",@progbits
	.p2align	3
.L__unnamed_135:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000l\001\000"
	.zero	4
	.size	.L__unnamed_135, 56

	.type	.L__unnamed_356,@object
	.section	.rodata..L__unnamed_356,"a",@progbits
.L__unnamed_356:
	.ascii	"Sector count too large"
	.size	.L__unnamed_356, 22

	.type	.L__unnamed_126,@object
	.section	.data.rel.ro..L__unnamed_126,"aw",@progbits
	.p2align	3
.L__unnamed_126:
	.quad	.L__unnamed_356
	.asciz	"\026\000\000\000\000\000\000"
	.size	.L__unnamed_126, 16

	.type	.L__unnamed_127,@object
	.section	.data.rel.ro..L__unnamed_127,"aw",@progbits
	.p2align	3
.L__unnamed_127:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000s\001\000"
	.zero	4
	.size	.L__unnamed_127, 56

	.type	.L__unnamed_357,@object
	.section	.rodata.cst32,"aM",@progbits,32
.L__unnamed_357:
	.ascii	"Must specify at least one sector"
	.size	.L__unnamed_357, 32

	.type	.L__unnamed_136,@object
	.section	.data.rel.ro..L__unnamed_136,"aw",@progbits
	.p2align	3
.L__unnamed_136:
	.quad	.L__unnamed_357
	.asciz	" \000\000\000\000\000\000"
	.size	.L__unnamed_136, 16

	.type	.L__unnamed_137,@object
	.section	.data.rel.ro..L__unnamed_137,"aw",@progbits
	.p2align	3
.L__unnamed_137:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000p\001\000"
	.zero	4
	.size	.L__unnamed_137, 56

	.type	.L__unnamed_124,@object
	.section	.data.rel.ro..L__unnamed_124,"aw",@progbits
	.p2align	3
.L__unnamed_124:
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\311\001\000\000\026\000\000"
	.size	.L__unnamed_124, 24

	.type	.L__unnamed_358,@object
	.section	.rodata..L__unnamed_358,"a",@progbits
.L__unnamed_358:
	.ascii	"Initializing memory space for disk access"
	.size	.L__unnamed_358, 41

	.type	.L__unnamed_239,@object
	.section	.data.rel.ro..L__unnamed_239,"aw",@progbits
	.p2align	3
.L__unnamed_239:
	.quad	.L__unnamed_358
	.asciz	")\000\000\000\000\000\000"
	.size	.L__unnamed_239, 16

	.type	.L__unnamed_240,@object
	.section	.data.rel.ro..L__unnamed_240,"aw",@progbits
	.p2align	3
.L__unnamed_240:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\323\001\000"
	.zero	4
	.size	.L__unnamed_240, 56

	.type	.L__unnamed_359,@object
	.section	.rodata..L__unnamed_359,"a",@progbits
.L__unnamed_359:
	.ascii	"Base host capability pointer: "
	.size	.L__unnamed_359, 30

	.type	.L__unnamed_243,@object
	.section	.data.rel.ro..L__unnamed_243,"aw",@progbits
	.p2align	3
.L__unnamed_243:
	.quad	.L__unnamed_359
	.asciz	"\036\000\000\000\000\000\000"
	.size	.L__unnamed_243, 16

	.type	.L__unnamed_244,@object
	.section	.data.rel.ro..L__unnamed_244,"aw",@progbits
	.p2align	3
.L__unnamed_244:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\324\001\000"
	.zero	4
	.size	.L__unnamed_244, 56

	.type	.L__unnamed_360,@object
	.section	.rodata..L__unnamed_360,"a",@progbits
.L__unnamed_360:
	.ascii	"Global host control pointer: "
	.size	.L__unnamed_360, 29

	.type	.L__unnamed_241,@object
	.section	.data.rel.ro..L__unnamed_241,"aw",@progbits
	.p2align	3
.L__unnamed_241:
	.quad	.L__unnamed_360
	.asciz	"\035\000\000\000\000\000\000"
	.size	.L__unnamed_241, 16

	.type	.L__unnamed_242,@object
	.section	.data.rel.ro..L__unnamed_242,"aw",@progbits
	.p2align	3
.L__unnamed_242:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\325\001\000"
	.zero	4
	.size	.L__unnamed_242, 56

	.type	.L__unnamed_361,@object
	.section	.rodata..L__unnamed_361,"a",@progbits
.L__unnamed_361:
	.ascii	"Interrupt status: "
	.size	.L__unnamed_361, 18

	.type	.L__unnamed_245,@object
	.section	.data.rel.ro..L__unnamed_245,"aw",@progbits
	.p2align	3
.L__unnamed_245:
	.quad	.L__unnamed_361
	.asciz	"\022\000\000\000\000\000\000"
	.size	.L__unnamed_245, 16

	.type	.L__unnamed_246,@object
	.section	.data.rel.ro..L__unnamed_246,"aw",@progbits
	.p2align	3
.L__unnamed_246:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\331\001\000"
	.zero	4
	.size	.L__unnamed_246, 56

	.type	.L__unnamed_362,@object
	.section	.rodata..L__unnamed_362,"a",@progbits
.L__unnamed_362:
	.ascii	"Port implementation pointer: "
	.size	.L__unnamed_362, 29

	.type	.L__unnamed_247,@object
	.section	.data.rel.ro..L__unnamed_247,"aw",@progbits
	.p2align	3
.L__unnamed_247:
	.quad	.L__unnamed_362
	.asciz	"\035\000\000\000\000\000\000"
	.size	.L__unnamed_247, 16

	.type	.L__unnamed_248,@object
	.section	.data.rel.ro..L__unnamed_248,"aw",@progbits
	.p2align	3
.L__unnamed_248:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\334\001\000"
	.zero	4
	.size	.L__unnamed_248, 56

	.type	.L__unnamed_363,@object
	.section	.rodata..L__unnamed_363,"a",@progbits
.L__unnamed_363:
	.ascii	"Version: "
	.size	.L__unnamed_363, 9

	.type	.L__unnamed_251,@object
	.section	.data.rel.ro..L__unnamed_251,"aw",@progbits
	.p2align	3
.L__unnamed_251:
	.quad	.L__unnamed_363
	.asciz	"\t\000\000\000\000\000\000"
	.size	.L__unnamed_251, 16

	.type	.L__unnamed_252,@object
	.section	.data.rel.ro..L__unnamed_252,"aw",@progbits
	.p2align	3
.L__unnamed_252:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\335\001\000"
	.zero	4
	.size	.L__unnamed_252, 56

	.type	.L__unnamed_364,@object
	.section	.rodata..L__unnamed_364,"a",@progbits
.L__unnamed_364:
	.ascii	"Extended host capability pointer: "
	.size	.L__unnamed_364, 34

	.type	.L__unnamed_249,@object
	.section	.data.rel.ro..L__unnamed_249,"aw",@progbits
	.p2align	3
.L__unnamed_249:
	.quad	.L__unnamed_364
	.asciz	"\"\000\000\000\000\000\000"
	.size	.L__unnamed_249, 16

	.type	.L__unnamed_250,@object
	.section	.data.rel.ro..L__unnamed_250,"aw",@progbits
	.p2align	3
.L__unnamed_250:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\336\001\000"
	.zero	4
	.size	.L__unnamed_250, 56

	.type	.L__unnamed_365,@object
	.section	.rodata..L__unnamed_365,"a",@progbits
.L__unnamed_365:
	.ascii	"BIOS/OS handoff controller pointer: "
	.size	.L__unnamed_365, 36

	.type	.L__unnamed_253,@object
	.section	.data.rel.ro..L__unnamed_253,"aw",@progbits
	.p2align	3
.L__unnamed_253:
	.quad	.L__unnamed_365
	.asciz	"$\000\000\000\000\000\000"
	.size	.L__unnamed_253, 16

	.type	.L__unnamed_254,@object
	.section	.data.rel.ro..L__unnamed_254,"aw",@progbits
	.p2align	3
.L__unnamed_254:
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_343
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\342\001\000"
	.zero	4
	.size	.L__unnamed_254, 56

	.type	.L__unnamed_296,@object
	.section	.data.rel.ro..L__unnamed_296,"aw",@progbits
	.p2align	3
.L__unnamed_296:
	.quad	.L__unnamed_341
	.asciz	"\023\000\000\000\000\000\000\000\350\001\000\000%\000\000"
	.size	.L__unnamed_296, 24

	.type	.L__unnamed_125,@object
	.section	.rodata..L__unnamed_125,"a",@progbits
.L__unnamed_125:
	.ascii	"Slot entry value must be between 0 and 32"
	.size	.L__unnamed_125, 41

	.type	.L__unnamed_366,@object
	.section	.rodata..L__unnamed_366,"a",@progbits
.L__unnamed_366:
	.ascii	"src/ahci/satapi.rs"
	.size	.L__unnamed_366, 18

	.type	.L__unnamed_138,@object
	.section	.data.rel.ro..L__unnamed_138,"aw",@progbits
	.p2align	3
.L__unnamed_138:
	.quad	.L__unnamed_366
	.asciz	"\022\000\000\000\000\000\000\000x\000\000\000\034\000\000"
	.size	.L__unnamed_138, 24

	.type	str.1,@object
	.section	.rodata.str.1,"a",@progbits
	.p2align	4
str.1:
	.ascii	"attempt to divide by zero"
	.size	str.1, 25

	.type	.L__unnamed_139,@object
	.section	.data.rel.ro..L__unnamed_139,"aw",@progbits
	.p2align	3
.L__unnamed_139:
	.quad	.L__unnamed_366
	.asciz	"\022\000\000\000\000\000\000\000\205\000\000\000\023\000\000"
	.size	.L__unnamed_139, 24

	.type	.L__unnamed_140,@object
	.section	.data.rel.ro..L__unnamed_140,"aw",@progbits
	.p2align	3
.L__unnamed_140:
	.quad	.L__unnamed_366
	.asciz	"\022\000\000\000\000\000\000\000\275\000\000\000\034\000\000"
	.size	.L__unnamed_140, 24

	.type	.L__unnamed_141,@object
	.section	.data.rel.ro..L__unnamed_141,"aw",@progbits
	.p2align	3
.L__unnamed_141:
	.quad	.L__unnamed_366
	.asciz	"\022\000\000\000\000\000\000\000\312\000\000\000\023\000\000"
	.size	.L__unnamed_141, 24

	.type	.L__unnamed_367,@object
	.section	.rodata..L__unnamed_367,"a",@progbits
.L__unnamed_367:
	.ascii	"Port "
	.size	.L__unnamed_367, 5

	.type	.L__unnamed_368,@object
	.section	.rodata..L__unnamed_368,"a",@progbits
.L__unnamed_368:
	.ascii	": "
	.size	.L__unnamed_368, 2

	.type	.L__unnamed_6,@object
	.section	.data.rel.ro..L__unnamed_6,"aw",@progbits
	.p2align	3
.L__unnamed_6:
	.quad	.L__unnamed_367
	.asciz	"\005\000\000\000\000\000\000"
	.quad	.L__unnamed_368
	.asciz	"\002\000\000\000\000\000\000"
	.size	.L__unnamed_6, 32

	.type	.L__unnamed_7,@object
	.section	.rodata..L__unnamed_7,"a",@progbits
	.p2align	3
.L__unnamed_7:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\004\000\000\000\003"
	.zero	7
	.asciz	"\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\024\000\000\000\003"
	.zero	7
	.size	.L__unnamed_7, 112

	.type	.L__unnamed_369,@object
	.section	.rodata..L__unnamed_369,"a",@progbits
.L__unnamed_369:
	.ascii	"cryptos::ahci"
	.size	.L__unnamed_369, 13

	.type	.L__unnamed_370,@object
	.section	.rodata..L__unnamed_370,"a",@progbits
.L__unnamed_370:
	.ascii	"src/ahci/mod.rs"
	.size	.L__unnamed_370, 15

	.type	.L__unnamed_8,@object
	.section	.data.rel.ro..L__unnamed_8,"aw",@progbits
	.p2align	3
.L__unnamed_8:
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_370
	.asciz	"\017\000\000\000\000\000\000\000.\000\000"
	.zero	4
	.size	.L__unnamed_8, 56

	.type	.L__unnamed_371,@object
	.section	.rodata..L__unnamed_371,"a",@progbits
.L__unnamed_371:
	.ascii	"Failed to initialize the given ATAPI disk: "
	.size	.L__unnamed_371, 43

	.type	.L__unnamed_9,@object
	.section	.data.rel.ro..L__unnamed_9,"aw",@progbits
	.p2align	3
.L__unnamed_9:
	.quad	.L__unnamed_371
	.asciz	"+\000\000\000\000\000\000"
	.size	.L__unnamed_9, 16

	.type	.L__unnamed_11,@object
	.section	.data.rel.ro..L__unnamed_11,"aw",@progbits
	.p2align	3
.L__unnamed_11:
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_370
	.asciz	"\017\000\000\000\000\000\000\000A\000\000"
	.zero	4
	.size	.L__unnamed_11, 56

	.type	.L__unnamed_372,@object
	.section	.rodata..L__unnamed_372,"a",@progbits
.L__unnamed_372:
	.ascii	"Found disk with type "
	.size	.L__unnamed_372, 21

	.type	.L__unnamed_15,@object
	.section	.data.rel.ro..L__unnamed_15,"aw",@progbits
	.p2align	3
.L__unnamed_15:
	.quad	.L__unnamed_372
	.asciz	"\025\000\000\000\000\000\000"
	.size	.L__unnamed_15, 16

	.type	.L__unnamed_16,@object
	.section	.data.rel.ro..L__unnamed_16,"aw",@progbits
	.p2align	3
.L__unnamed_16:
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_370
	.asciz	"\017\000\000\000\000\000\000\000=\000\000"
	.zero	4
	.size	.L__unnamed_16, 56

	.type	.L__unnamed_5,@object
	.section	.data.rel.ro..L__unnamed_5,"aw",@progbits
	.p2align	3
.L__unnamed_5:
	.quad	_ZN4core3ptr63drop_in_place$LT$cryptos..ahci..satapi..SataPacketInterface$GT$17hdd4b93432faaed4aE
	.asciz	"`\003\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$2id17h94f8cf6360dae590E
	.quad	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4size17hb58db37b873ace22E
	.quad	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$4read17h72502a8e09a7dc1dE
	.quad	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$5write17h7254cb8ae50b8e13E
	.quad	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17h96a39cec06098b17E
	.quad	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hbf3f2186a90ff66dE
	.quad	_ZN82_$LT$cryptos..ahci..satapi..SataPacketInterface$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h627f7b2a11f1eb6bE
	.size	.L__unnamed_5, 80

	.type	.L__unnamed_373,@object
	.section	.rodata..L__unnamed_373,"a",@progbits
.L__unnamed_373:
	.ascii	"Failed to initialize the given SATA disk: "
	.size	.L__unnamed_373, 42

	.type	.L__unnamed_12,@object
	.section	.data.rel.ro..L__unnamed_12,"aw",@progbits
	.p2align	3
.L__unnamed_12:
	.quad	.L__unnamed_373
	.asciz	"*\000\000\000\000\000\000"
	.size	.L__unnamed_12, 16

	.type	.L__unnamed_13,@object
	.section	.data.rel.ro..L__unnamed_13,"aw",@progbits
	.p2align	3
.L__unnamed_13:
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_370
	.asciz	"\017\000\000\000\000\000\000\0007\000\000"
	.zero	4
	.size	.L__unnamed_13, 56

	.type	.L__unnamed_17,@object
	.section	.data.rel.ro..L__unnamed_17,"aw",@progbits
	.p2align	3
.L__unnamed_17:
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_369
	.asciz	"\r\000\000\000\000\000\000"
	.quad	.L__unnamed_370
	.asciz	"\017\000\000\000\000\000\000\0003\000\000"
	.zero	4
	.size	.L__unnamed_17, 56

	.type	.L__unnamed_14,@object
	.section	.data.rel.ro..L__unnamed_14,"aw",@progbits
	.p2align	3
.L__unnamed_14:
	.quad	_ZN4core3ptr50drop_in_place$LT$cryptos..ahci..sata..SataDisk$GT$17h760db4982a32399cE
	.asciz	"\220\003\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$2id17h3ac9995b8a0a165aE
	.quad	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4size17hfa6520d0654e5028E
	.quad	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$4read17h6c015b82e161daedE
	.quad	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$5write17hfcd4340d7caf4021E
	.quad	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$6blklen17hfa72892bbaba06b2E
	.quad	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$21read_interrupt_status17hd7ece94927294c83E
	.quad	_ZN69_$LT$cryptos..ahci..sata..SataDisk$u20$as$u20$cryptos..ahci..Disk$GT$22write_interrupt_status17h5b0b6a4c6f109bccE
	.size	.L__unnamed_14, 80

	.type	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E,@object
	.section	.data._ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E,"aw",@progbits
	.p2align	3
_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	24
	.size	_ZN7cryptos9apic_impl9LAPIC_IDS17ha77cac5835237242E, 32

	.type	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E,@object
	.section	.data._ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E,"aw",@progbits
	.p2align	3
_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E:
	.zero	1
	.zero	7
	.asciz	"\002\000\000\000\000\000\000"
	.zero	736
	.size	_ZN7cryptos9apic_impl10LOCAL_APIC17h12326fd1f26c9281E, 752

	.type	.L__unnamed_374,@object
	.section	.rodata..L__unnamed_374,"a",@progbits
.L__unnamed_374:
	.ascii	"cryptos::apic_impl"
	.size	.L__unnamed_374, 18

	.type	.L__unnamed_375,@object
	.section	.rodata.cst16,"aM",@progbits,16
.L__unnamed_375:
	.ascii	"src/apic_impl.rs"
	.size	.L__unnamed_375, 16

	.type	.L__unnamed_221,@object
	.section	.data.rel.ro..L__unnamed_221,"aw",@progbits
	.p2align	3
.L__unnamed_221:
	.quad	.L__unnamed_374
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_374
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000E\000\000"
	.zero	4
	.size	.L__unnamed_221, 56

	.type	.L__unnamed_282,@object
	.section	.data.rel.ro..L__unnamed_282,"aw",@progbits
	.p2align	3
.L__unnamed_282:
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000E\000\000\000\t\000\000"
	.size	.L__unnamed_282, 24

	.type	.L__unnamed_222,@object
	.section	.data.rel.ro..L__unnamed_222,"aw",@progbits
	.p2align	3
.L__unnamed_222:
	.quad	.L__unnamed_374
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_374
	.asciz	"\022\000\000\000\000\000\000"
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000d\000\000"
	.zero	4
	.size	.L__unnamed_222, 56

	.type	.L__unnamed_261,@object
	.section	.data.rel.ro..L__unnamed_261,"aw",@progbits
	.p2align	3
.L__unnamed_261:
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000d\000\000\000\r\000\000"
	.size	.L__unnamed_261, 24

	.type	.L__unnamed_289,@object
	.section	.data.rel.ro..L__unnamed_289,"aw",@progbits
	.p2align	3
.L__unnamed_289:
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000=\000\000\000)\000\000"
	.size	.L__unnamed_289, 24

	.type	.L__unnamed_376,@object
	.section	.rodata..L__unnamed_376,"a",@progbits
.L__unnamed_376:
	.ascii	"Error building the local APIC: "
	.size	.L__unnamed_376, 31

	.type	.L__unnamed_283,@object
	.section	.data.rel.ro..L__unnamed_283,"aw",@progbits
	.p2align	3
.L__unnamed_283:
	.quad	.L__unnamed_376
	.asciz	"\037\000\000\000\000\000\000"
	.size	.L__unnamed_283, 16

	.type	.L__unnamed_284,@object
	.section	.data.rel.ro..L__unnamed_284,"aw",@progbits
	.p2align	3
.L__unnamed_284:
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000R\000\000\000!\000\000"
	.size	.L__unnamed_284, 24

	.type	.L__unnamed_266,@object
	.section	.rodata..L__unnamed_266,"a",@progbits
.L__unnamed_266:
	.ascii	"Legacy 8259 PIC not supported"
	.size	.L__unnamed_266, 29

	.type	.L__unnamed_257,@object
	.section	.data.rel.ro..L__unnamed_257,"aw",@progbits
	.p2align	3
.L__unnamed_257:
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000\211\000\000\000(\000\000"
	.size	.L__unnamed_257, 24

	.type	.L__unnamed_285,@object
	.section	.data.rel.ro..L__unnamed_285,"aw",@progbits
	.p2align	3
.L__unnamed_285:
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000\203\000\000\000\t\000\000"
	.size	.L__unnamed_285, 24

	.type	.L__unnamed_267,@object
	.section	.data.rel.ro..L__unnamed_267,"aw",@progbits
	.p2align	3
.L__unnamed_267:
	.quad	.L__unnamed_375
	.asciz	"\020\000\000\000\000\000\000\000\177\000\000\000\034\000\000"
	.size	.L__unnamed_267, 24

	.type	_ZN7cryptos10interrupts10TICK_COUNT17h3a5a3930a2c7f489E,@object
	.section	.bss._ZN7cryptos10interrupts10TICK_COUNT17h3a5a3930a2c7f489E,"aw",@nobits
	.p2align	3
_ZN7cryptos10interrupts10TICK_COUNT17h3a5a3930a2c7f489E:
	.zero	8
	.size	_ZN7cryptos10interrupts10TICK_COUNT17h3a5a3930a2c7f489E, 8

	.type	.L__unnamed_377,@object
	.section	.rodata..L__unnamed_377,"a",@progbits
.L__unnamed_377:
	.ascii	"src/interrupts.rs"
	.size	.L__unnamed_377, 17

	.type	.L__unnamed_142,@object
	.section	.data.rel.ro..L__unnamed_142,"aw",@progbits
	.p2align	3
.L__unnamed_142:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000I\000\000\000\016\000\000"
	.size	.L__unnamed_142, 24

	.type	.L__unnamed_378,@object
	.section	.rodata..L__unnamed_378,"a",@progbits
.L__unnamed_378:
	.ascii	"Received spurious interrupt"
	.size	.L__unnamed_378, 27

	.type	.L__unnamed_143,@object
	.section	.data.rel.ro..L__unnamed_143,"aw",@progbits
	.p2align	3
.L__unnamed_143:
	.quad	.L__unnamed_378
	.asciz	"\033\000\000\000\000\000\000"
	.size	.L__unnamed_143, 16

	.type	.L__unnamed_379,@object
	.section	.rodata..L__unnamed_379,"a",@progbits
.L__unnamed_379:
	.ascii	"cryptos::interrupts"
	.size	.L__unnamed_379, 19

	.type	.L__unnamed_144,@object
	.section	.data.rel.ro..L__unnamed_144,"aw",@progbits
	.p2align	3
.L__unnamed_144:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000M\000\000"
	.zero	4
	.size	.L__unnamed_144, 56

	.type	.L__unnamed_145,@object
	.section	.data.rel.ro..L__unnamed_145,"aw",@progbits
	.p2align	3
.L__unnamed_145:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000N\000\000\000\016\000\000"
	.size	.L__unnamed_145, 24

	.type	.L__unnamed_380,@object
	.section	.rodata..L__unnamed_380,"a",@progbits
.L__unnamed_380:
	.ascii	"Local APIC error; check the status for details"
	.size	.L__unnamed_380, 46

	.type	.L__unnamed_146,@object
	.section	.data.rel.ro..L__unnamed_146,"aw",@progbits
	.p2align	3
.L__unnamed_146:
	.quad	.L__unnamed_380
	.asciz	".\000\000\000\000\000\000"
	.size	.L__unnamed_146, 16

	.type	.L__unnamed_147,@object
	.section	.data.rel.ro..L__unnamed_147,"aw",@progbits
	.p2align	3
.L__unnamed_147:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000R\000\000"
	.zero	4
	.size	.L__unnamed_147, 56

	.type	.L__unnamed_148,@object
	.section	.data.rel.ro..L__unnamed_148,"aw",@progbits
	.p2align	3
.L__unnamed_148:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000S\000\000\000\016\000\000"
	.size	.L__unnamed_148, 24

	.type	.L__unnamed_154,@object
	.section	.data.rel.ro..L__unnamed_154,"aw",@progbits
	.p2align	3
.L__unnamed_154:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000y\000\000"
	.zero	4
	.size	.L__unnamed_154, 56

	.type	.L__unnamed_153,@object
	.section	.data.rel.ro..L__unnamed_153,"aw",@progbits
	.p2align	3
.L__unnamed_153:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000w\000\000"
	.zero	4
	.size	.L__unnamed_153, 56

	.type	.L__unnamed_152,@object
	.section	.data.rel.ro..L__unnamed_152,"aw",@progbits
	.p2align	3
.L__unnamed_152:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000u\000\000"
	.zero	4
	.size	.L__unnamed_152, 56

	.type	.L__unnamed_151,@object
	.section	.data.rel.ro..L__unnamed_151,"aw",@progbits
	.p2align	3
.L__unnamed_151:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000t\000\000"
	.zero	4
	.size	.L__unnamed_151, 56

	.type	.L__unnamed_150,@object
	.section	.data.rel.ro..L__unnamed_150,"aw",@progbits
	.p2align	3
.L__unnamed_150:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000s\000\000"
	.zero	4
	.size	.L__unnamed_150, 56

	.type	.L__unnamed_155,@object
	.section	.data.rel.ro..L__unnamed_155,"aw",@progbits
	.p2align	3
.L__unnamed_155:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000r\000\000\000\023\000\000"
	.size	.L__unnamed_155, 24

	.type	.L__unnamed_156,@object
	.section	.data.rel.ro..L__unnamed_156,"aw",@progbits
	.p2align	3
.L__unnamed_156:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000}\000\000\000\016\000\000"
	.size	.L__unnamed_156, 24

	.type	.L__unnamed_157,@object
	.section	.data.rel.ro..L__unnamed_157,"aw",@progbits
	.p2align	3
.L__unnamed_157:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000k\000\000\000\021\000\000"
	.size	.L__unnamed_157, 24

	.type	.L__unnamed_381,@object
	.section	.rodata..L__unnamed_381,"a",@progbits
.L__unnamed_381:
	.ascii	"Bound range exceeded\nStack frame: "
	.size	.L__unnamed_381, 34

	.type	.L__unnamed_158,@object
	.section	.data.rel.ro..L__unnamed_158,"aw",@progbits
	.p2align	3
.L__unnamed_158:
	.quad	.L__unnamed_381
	.asciz	"\"\000\000\000\000\000\000"
	.size	.L__unnamed_158, 16

	.type	.L__unnamed_159,@object
	.section	.data.rel.ro..L__unnamed_159,"aw",@progbits
	.p2align	3
.L__unnamed_159:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\201\000\000\000\005\000\000"
	.size	.L__unnamed_159, 24

	.type	.L__unnamed_382,@object
	.section	.rodata..L__unnamed_382,"a",@progbits
.L__unnamed_382:
	.ascii	"Invalid opcode\nOffending instruction: "
	.size	.L__unnamed_382, 38

	.type	.L__unnamed_383,@object
	.section	.rodata..L__unnamed_383,"a",@progbits
.L__unnamed_383:
	.ascii	"\nStack frame: "
	.size	.L__unnamed_383, 14

	.type	.L__unnamed_160,@object
	.section	.data.rel.ro..L__unnamed_160,"aw",@progbits
	.p2align	3
.L__unnamed_160:
	.quad	.L__unnamed_382
	.asciz	"&\000\000\000\000\000\000"
	.quad	.L__unnamed_383
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_160, 32

	.type	.L__unnamed_161,@object
	.section	.rodata..L__unnamed_161,"a",@progbits
	.p2align	3
.L__unnamed_161:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\024\000\000\000\003"
	.zero	7
	.asciz	"\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\004\000\000\000\003"
	.zero	7
	.size	.L__unnamed_161, 112

	.type	.L__unnamed_162,@object
	.section	.data.rel.ro..L__unnamed_162,"aw",@progbits
	.p2align	3
.L__unnamed_162:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\206\000\000\000\005\000\000"
	.size	.L__unnamed_162, 24

	.type	.L__unnamed_384,@object
	.section	.rodata..L__unnamed_384,"a",@progbits
.L__unnamed_384:
	.ascii	"Device not available\nStack frame: "
	.size	.L__unnamed_384, 34

	.type	.L__unnamed_163,@object
	.section	.data.rel.ro..L__unnamed_163,"aw",@progbits
	.p2align	3
.L__unnamed_163:
	.quad	.L__unnamed_384
	.asciz	"\"\000\000\000\000\000\000"
	.size	.L__unnamed_163, 16

	.type	.L__unnamed_164,@object
	.section	.data.rel.ro..L__unnamed_164,"aw",@progbits
	.p2align	3
.L__unnamed_164:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\212\000\000\000\005\000\000"
	.size	.L__unnamed_164, 24

	.type	.L__unnamed_385,@object
	.section	.rodata..L__unnamed_385,"a",@progbits
.L__unnamed_385:
	.ascii	"Reached breakpoint; waiting for debugger to give the all-clear"
	.size	.L__unnamed_385, 62

	.type	.L__unnamed_165,@object
	.section	.data.rel.ro..L__unnamed_165,"aw",@progbits
	.p2align	3
.L__unnamed_165:
	.quad	.L__unnamed_385
	.asciz	">\000\000\000\000\000\000"
	.size	.L__unnamed_165, 16

	.type	.L__unnamed_166,@object
	.section	.data.rel.ro..L__unnamed_166,"aw",@progbits
	.p2align	3
.L__unnamed_166:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\216\000\000"
	.zero	4
	.size	.L__unnamed_166, 56

	.type	.L__unnamed_386,@object
	.section	.rodata.cst8,"aM",@progbits,8
.L__unnamed_386:
	.ascii	"Resuming"
	.size	.L__unnamed_386, 8

	.type	.L__unnamed_167,@object
	.section	.data.rel.ro..L__unnamed_167,"aw",@progbits
	.p2align	3
.L__unnamed_167:
	.quad	.L__unnamed_386
	.asciz	"\b\000\000\000\000\000\000"
	.size	.L__unnamed_167, 16

	.type	.L__unnamed_168,@object
	.section	.data.rel.ro..L__unnamed_168,"aw",@progbits
	.p2align	3
.L__unnamed_168:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\224\000\000"
	.zero	4
	.size	.L__unnamed_168, 56

	.type	.L__unnamed_387,@object
	.section	.rodata..L__unnamed_387,"a",@progbits
.L__unnamed_387:
	.ascii	"Double fault at address "
	.size	.L__unnamed_387, 24

	.type	.L__unnamed_388,@object
	.section	.rodata..L__unnamed_388,"a",@progbits
.L__unnamed_388:
	.ascii	"\nBacktrace: "
	.size	.L__unnamed_388, 12

	.type	.L__unnamed_169,@object
	.section	.data.rel.ro..L__unnamed_169,"aw",@progbits
	.p2align	3
.L__unnamed_169:
	.quad	.L__unnamed_387
	.asciz	"\030\000\000\000\000\000\000"
	.quad	.L__unnamed_388
	.asciz	"\f\000\000\000\000\000\000"
	.size	.L__unnamed_169, 32

	.type	.L__unnamed_170,@object
	.section	.rodata..L__unnamed_170,"a",@progbits
	.p2align	3
.L__unnamed_170:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\004\000\000\000\003"
	.zero	7
	.asciz	"\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\004\000\000\000\003"
	.zero	7
	.size	.L__unnamed_170, 112

	.type	.L__unnamed_171,@object
	.section	.data.rel.ro..L__unnamed_171,"aw",@progbits
	.p2align	3
.L__unnamed_171:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\233\000\000\000\005\000\000"
	.size	.L__unnamed_171, 24

	.type	.L__unnamed_389,@object
	.section	.rodata..L__unnamed_389,"a",@progbits
.L__unnamed_389:
	.ascii	"Page fault: Attempt to access address "
	.size	.L__unnamed_389, 38

	.type	.L__unnamed_390,@object
	.section	.rodata..L__unnamed_390,"a",@progbits
.L__unnamed_390:
	.ascii	" returned a "
	.size	.L__unnamed_390, 12

	.type	.L__unnamed_391,@object
	.section	.rodata..L__unnamed_391,"a",@progbits
.L__unnamed_391:
	.ascii	" error\n Backtrace: "
	.size	.L__unnamed_391, 19

	.type	.L__unnamed_172,@object
	.section	.data.rel.ro..L__unnamed_172,"aw",@progbits
	.p2align	3
.L__unnamed_172:
	.quad	.L__unnamed_389
	.asciz	"&\000\000\000\000\000\000"
	.quad	.L__unnamed_390
	.asciz	"\f\000\000\000\000\000\000"
	.quad	.L__unnamed_391
	.asciz	"\023\000\000\000\000\000\000"
	.size	.L__unnamed_172, 48

	.type	.L__unnamed_173,@object
	.section	.rodata..L__unnamed_173,"a",@progbits
	.p2align	3
.L__unnamed_173:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\004\000\000\000\003\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\004\000\000\000\003\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\004\000\000\000\003\000\000\000\000\000\000"
	.size	.L__unnamed_173, 168

	.type	.L__unnamed_174,@object
	.section	.data.rel.ro..L__unnamed_174,"aw",@progbits
	.p2align	3
.L__unnamed_174:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\243\000\000\000\005\000\000"
	.size	.L__unnamed_174, 24

	.type	.L__unnamed_392,@object
	.section	.rodata..L__unnamed_392,"a",@progbits
.L__unnamed_392:
	.ascii	"Attempt to divide by zero\nBacktrace: "
	.size	.L__unnamed_392, 37

	.type	.L__unnamed_175,@object
	.section	.data.rel.ro..L__unnamed_175,"aw",@progbits
	.p2align	3
.L__unnamed_175:
	.quad	.L__unnamed_392
	.asciz	"%\000\000\000\000\000\000"
	.size	.L__unnamed_175, 16

	.type	.L__unnamed_176,@object
	.section	.data.rel.ro..L__unnamed_176,"aw",@progbits
	.p2align	3
.L__unnamed_176:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\254\000\000"
	.zero	4
	.size	.L__unnamed_176, 56

	.type	.L__unnamed_393,@object
	.section	.rodata.cst32,"aM",@progbits,32
.L__unnamed_393:
	.ascii	"Invalid TSS at segment selector "
	.size	.L__unnamed_393, 32

	.type	.L__unnamed_177,@object
	.section	.data.rel.ro..L__unnamed_177,"aw",@progbits
	.p2align	3
.L__unnamed_177:
	.quad	.L__unnamed_393
	.asciz	" \000\000\000\000\000\000"
	.quad	.L__unnamed_388
	.asciz	"\f\000\000\000\000\000\000"
	.size	.L__unnamed_177, 32

	.type	.L__unnamed_178,@object
	.section	.data.rel.ro..L__unnamed_178,"aw",@progbits
	.p2align	3
.L__unnamed_178:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\260\000\000"
	.zero	4
	.size	.L__unnamed_178, 56

	.type	.L__unnamed_394,@object
	.section	.rodata..L__unnamed_394,"a",@progbits
.L__unnamed_394:
	.ascii	"Segment selector at index "
	.size	.L__unnamed_394, 26

	.type	.L__unnamed_395,@object
	.section	.rodata..L__unnamed_395,"a",@progbits
.L__unnamed_395:
	.ascii	" is not present\nDescriptor table involved: "
	.size	.L__unnamed_395, 43

	.type	.L__unnamed_396,@object
	.section	.rodata..L__unnamed_396,"a",@progbits
.L__unnamed_396:
	.ascii	"\nSelector index: "
	.size	.L__unnamed_396, 17

	.type	.L__unnamed_180,@object
	.section	.data.rel.ro..L__unnamed_180,"aw",@progbits
	.p2align	3
.L__unnamed_180:
	.quad	.L__unnamed_394
	.asciz	"\032\000\000\000\000\000\000"
	.quad	.L__unnamed_395
	.asciz	"+\000\000\000\000\000\000"
	.quad	.L__unnamed_396
	.asciz	"\021\000\000\000\000\000\000"
	.quad	.L__unnamed_388
	.asciz	"\f\000\000\000\000\000\000"
	.size	.L__unnamed_180, 64

	.type	.L__unnamed_181,@object
	.section	.rodata..L__unnamed_181,"a",@progbits
	.p2align	3
.L__unnamed_181:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\024\000\000\000\003\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\004\000\000\000\003\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\004\000\000\000\003\000\000\000\000\000\000\000\003\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\004\000\000\000\003\000\000\000\000\000\000"
	.size	.L__unnamed_181, 224

	.type	.L__unnamed_182,@object
	.section	.data.rel.ro..L__unnamed_182,"aw",@progbits
	.p2align	3
.L__unnamed_182:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\270\000\000\000\005\000\000"
	.size	.L__unnamed_182, 24

	.type	.L__unnamed_179,@object
	.section	.data.rel.ro..L__unnamed_179,"aw",@progbits
	.p2align	3
.L__unnamed_179:
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\267\000\000\000\024\000\000"
	.size	.L__unnamed_179, 24

	.type	.L__unnamed_397,@object
	.section	.rodata..L__unnamed_397,"a",@progbits
.L__unnamed_397:
	.ascii	"Stack segment fault of unknown cause\nBacktrace: "
	.size	.L__unnamed_397, 48

	.type	.L__unnamed_185,@object
	.section	.data.rel.ro..L__unnamed_185,"aw",@progbits
	.p2align	3
.L__unnamed_185:
	.quad	.L__unnamed_397
	.asciz	"0\000\000\000\000\000\000"
	.size	.L__unnamed_185, 16

	.type	.L__unnamed_186,@object
	.section	.data.rel.ro..L__unnamed_186,"aw",@progbits
	.p2align	3
.L__unnamed_186:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\320\000\000"
	.zero	4
	.size	.L__unnamed_186, 56

	.type	.L__unnamed_398,@object
	.section	.rodata..L__unnamed_398,"a",@progbits
.L__unnamed_398:
	.ascii	" caused a stack segment fault\nBacktrace: "
	.size	.L__unnamed_398, 41

	.type	.L__unnamed_183,@object
	.section	.data.rel.ro..L__unnamed_183,"aw",@progbits
	.p2align	3
.L__unnamed_183:
	.quad	.L__unnamed_394
	.asciz	"\032\000\000\000\000\000\000"
	.quad	.L__unnamed_398
	.asciz	")\000\000\000\000\000\000"
	.size	.L__unnamed_183, 32

	.type	.L__unnamed_184,@object
	.section	.data.rel.ro..L__unnamed_184,"aw",@progbits
	.p2align	3
.L__unnamed_184:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\313\000\000"
	.zero	4
	.size	.L__unnamed_184, 56

	.type	.L__unnamed_399,@object
	.section	.rodata..L__unnamed_399,"a",@progbits
.L__unnamed_399:
	.ascii	"General protection fault of unknown cause\nBacktrace: "
	.size	.L__unnamed_399, 53

	.type	.L__unnamed_189,@object
	.section	.data.rel.ro..L__unnamed_189,"aw",@progbits
	.p2align	3
.L__unnamed_189:
	.quad	.L__unnamed_399
	.asciz	"5\000\000\000\000\000\000"
	.size	.L__unnamed_189, 16

	.type	.L__unnamed_190,@object
	.section	.data.rel.ro..L__unnamed_190,"aw",@progbits
	.p2align	3
.L__unnamed_190:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\342\000\000"
	.zero	4
	.size	.L__unnamed_190, 56

	.type	.L__unnamed_400,@object
	.section	.rodata..L__unnamed_400,"a",@progbits
.L__unnamed_400:
	.ascii	" caused a general protection fault\nBacktrace: "
	.size	.L__unnamed_400, 46

	.type	.L__unnamed_187,@object
	.section	.data.rel.ro..L__unnamed_187,"aw",@progbits
	.p2align	3
.L__unnamed_187:
	.quad	.L__unnamed_394
	.asciz	"\032\000\000\000\000\000\000"
	.quad	.L__unnamed_400
	.asciz	".\000\000\000\000\000\000"
	.size	.L__unnamed_187, 32

	.type	.L__unnamed_188,@object
	.section	.data.rel.ro..L__unnamed_188,"aw",@progbits
	.p2align	3
.L__unnamed_188:
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_379
	.asciz	"\023\000\000\000\000\000\000"
	.quad	.L__unnamed_377
	.asciz	"\021\000\000\000\000\000\000\000\335\000\000"
	.zero	4
	.size	.L__unnamed_188, 56

	.type	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E,@object
	.section	.data._ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E,"aw",@progbits
	.p2align	3
_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	8
	.size	_ZN7cryptos11PHYS_OFFSET17hef352082a60f42c6E, 16

	.type	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE,@object
	.section	.data._ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE,"aw",@progbits
	.p2align	3
_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	112
	.size	_ZN7cryptos15INTERRUPT_MODEL17h9d9f36d1a546917fE, 120

	.type	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E,@object
	.section	.data._ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E,"aw",@progbits
	.p2align	3
_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	24
	.size	_ZN7cryptos10PCI_CONFIG17h168a6baeb5e86c41E, 32

	.type	.L__unnamed_401,@object
	.section	.rodata..L__unnamed_401,"a",@progbits
.L__unnamed_401:
	.ascii	"src/main.rs"
	.size	.L__unnamed_401, 11

	.type	.L__unnamed_63,@object
	.section	.data.rel.ro..L__unnamed_63,"aw",@progbits
	.p2align	3
.L__unnamed_63:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000Y\000\000\000\005\000\000"
	.size	.L__unnamed_63, 24

	.type	.L__unnamed_191,@object
	.section	.data.rel.ro..L__unnamed_191,"aw",@progbits
	.p2align	3
.L__unnamed_191:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000]\000\000\000\005\000\000"
	.size	.L__unnamed_191, 24

	.type	_ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E,@object
	.section	.data._ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E,"aw",@progbits
	.p2align	3
_ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	88
	.size	_ZN7cryptos6PRINTK17h9e4c39d7e03ee5b5E, 96

	.type	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE,@object
	.section	.data._ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE,"aw",@progbits
	.p2align	3
_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	24
	.size	_ZN7cryptos6MAPPER17h6eb8b45b7c8c0cddE, 32

	.type	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E,@object
	.section	.data._ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E,"aw",@progbits
	.p2align	3
_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	24
	.size	_ZN7cryptos15FRAME_ALLOCATOR17h473f07cb9aefada5E, 32

	.type	.L__unnamed_402,@object
	.section	.data.rel.ro..L__unnamed_402,"aw",@progbits
	.p2align	3
.L__unnamed_402:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"X\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.size	.L__unnamed_402, 24

	.type	.L__unnamed_194,@object
	.section	.data.rel.ro..L__unnamed_194,"aw",@progbits
	.p2align	3
.L__unnamed_194:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"X\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	.L__unnamed_402
	.quad	_ZN49_$LT$printk..LockedPrintk$u20$as$u20$log..Log$GT$7enabled17h134901946eecff9bE
	.quad	_ZN49_$LT$printk..LockedPrintk$u20$as$u20$log..Log$GT$3log17h87e179dce5d128faE
	.quad	_ZN49_$LT$printk..LockedPrintk$u20$as$u20$log..Log$GT$5flush17h63df1e71a680362bE
	.size	.L__unnamed_194, 56

	.type	.L__unnamed_272,@object
	.section	.rodata..L__unnamed_272,"a",@progbits
.L__unnamed_272:
	.ascii	"Logger has already been set!"
	.size	.L__unnamed_272, 28

	.type	.L__unnamed_273,@object
	.section	.data.rel.ro..L__unnamed_273,"aw",@progbits
	.p2align	3
.L__unnamed_273:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	_ZN56_$LT$log..SetLoggerError$u20$as$u20$core..fmt..Debug$GT$3fmt17h4981fa686cc24b69E
	.size	.L__unnamed_273, 32

	.type	.L__unnamed_274,@object
	.section	.data.rel.ro..L__unnamed_274,"aw",@progbits
	.p2align	3
.L__unnamed_274:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\200\000\000\000\005\000\000"
	.size	.L__unnamed_274, 24

	.type	.L__unnamed_403,@object
	.section	.rodata.cst16,"aM",@progbits,16
.L__unnamed_403:
	.ascii	"CryptOS v. 0.1.0"
	.size	.L__unnamed_403, 16

	.type	.L__unnamed_195,@object
	.section	.data.rel.ro..L__unnamed_195,"aw",@progbits
	.p2align	3
.L__unnamed_195:
	.quad	.L__unnamed_403
	.asciz	"\020\000\000\000\000\000\000"
	.size	.L__unnamed_195, 16

	.type	.L__unnamed_404,@object
	.section	.rodata..L__unnamed_404,"a",@progbits
.L__unnamed_404:
	.ascii	"cryptos"
	.size	.L__unnamed_404, 7

	.type	.L__unnamed_196,@object
	.section	.data.rel.ro..L__unnamed_196,"aw",@progbits
	.p2align	3
.L__unnamed_196:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\211\000\000"
	.zero	4
	.size	.L__unnamed_196, 56

	.type	.L__unnamed_405,@object
	.section	.rodata..L__unnamed_405,"a",@progbits
.L__unnamed_405:
	.ascii	"Kernel panic -- not syncing: "
	.size	.L__unnamed_405, 29

	.type	.L__unnamed_192,@object
	.section	.data.rel.ro..L__unnamed_192,"aw",@progbits
	.p2align	3
.L__unnamed_192:
	.quad	.L__unnamed_405
	.asciz	"\035\000\000\000\000\000\000"
	.size	.L__unnamed_192, 16

	.type	.L__unnamed_193,@object
	.section	.data.rel.ro..L__unnamed_193,"aw",@progbits
	.p2align	3
.L__unnamed_193:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\216\000\000"
	.zero	4
	.size	.L__unnamed_193, 56

	.type	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE,@object
	.section	.data._ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE,"aw",@progbits
	.p2align	3
_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE:
	.asciz	"\001\000\000\000\000\000\000"
	.zero	32
	.size	_ZN7cryptos9ALL_DISKS17h27f0b88bfa552d7aE, 40

	.type	.L__unnamed_406,@object
	.section	.rodata..L__unnamed_406,"a",@progbits
.L__unnamed_406:
	.ascii	"Using version "
	.size	.L__unnamed_406, 14

	.type	.L__unnamed_407,@object
	.section	.rodata..L__unnamed_407,"a",@progbits
.L__unnamed_407:
	.byte	46
	.size	.L__unnamed_407, 1

	.type	.L__unnamed_408,@object
	.section	.rodata..L__unnamed_408,"a",@progbits
.L__unnamed_408:
	.ascii	" of crates.io/crates/bootloader"
	.size	.L__unnamed_408, 31

	.type	.L__unnamed_199,@object
	.section	.data.rel.ro..L__unnamed_199,"aw",@progbits
	.p2align	3
.L__unnamed_199:
	.quad	.L__unnamed_406
	.asciz	"\016\000\000\000\000\000\000"
	.quad	.L__unnamed_407
	.asciz	"\001\000\000\000\000\000\000"
	.quad	.L__unnamed_407
	.asciz	"\001\000\000\000\000\000\000"
	.quad	.L__unnamed_408
	.asciz	"\037\000\000\000\000\000\000"
	.size	.L__unnamed_199, 64

	.type	.L__unnamed_200,@object
	.section	.data.rel.ro..L__unnamed_200,"aw",@progbits
	.p2align	3
.L__unnamed_200:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\316\000\000"
	.zero	4
	.size	.L__unnamed_200, 56

	.type	.L__unnamed_409,@object
	.section	.rodata..L__unnamed_409,"a",@progbits
.L__unnamed_409:
	.ascii	"RSDP address: "
	.size	.L__unnamed_409, 14

	.type	.L__unnamed_197,@object
	.section	.data.rel.ro..L__unnamed_197,"aw",@progbits
	.p2align	3
.L__unnamed_197:
	.quad	.L__unnamed_409
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_197, 16

	.type	.L__unnamed_198,@object
	.section	.data.rel.ro..L__unnamed_198,"aw",@progbits
	.p2align	3
.L__unnamed_198:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\323\000\000"
	.zero	4
	.size	.L__unnamed_198, 56

	.type	.L__unnamed_410,@object
	.section	.rodata..L__unnamed_410,"a",@progbits
.L__unnamed_410:
	.ascii	"Memory region start address: "
	.size	.L__unnamed_410, 29

	.type	.L__unnamed_201,@object
	.section	.data.rel.ro..L__unnamed_201,"aw",@progbits
	.p2align	3
.L__unnamed_201:
	.quad	.L__unnamed_410
	.asciz	"\035\000\000\000\000\000\000"
	.size	.L__unnamed_201, 16

	.type	.L__unnamed_202,@object
	.section	.data.rel.ro..L__unnamed_202,"aw",@progbits
	.p2align	3
.L__unnamed_202:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\324\000\000"
	.zero	4
	.size	.L__unnamed_202, 56

	.type	.L__unnamed_288,@object
	.section	.data.rel.ro..L__unnamed_288,"aw",@progbits
	.p2align	3
.L__unnamed_288:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\326\000\000\000\n\000\000"
	.size	.L__unnamed_288, 24

	.type	.L__unnamed_275,@object
	.section	.data.rel.ro..L__unnamed_275,"aw",@progbits
	.p2align	3
.L__unnamed_275:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\005\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	_ZN52_$LT$acpi..AcpiError$u20$as$u20$core..fmt..Debug$GT$3fmt17heb31ffe3dd630a3dE
	.size	.L__unnamed_275, 32

	.type	.L__unnamed_276,@object
	.section	.data.rel.ro..L__unnamed_276,"aw",@progbits
	.p2align	3
.L__unnamed_276:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\331\000\000\000\033\000\000"
	.size	.L__unnamed_276, 24

	.type	.L__unnamed_277,@object
	.section	.data.rel.ro..L__unnamed_277,"aw",@progbits
	.p2align	3
.L__unnamed_277:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\337\000\000\000\026\000\000"
	.size	.L__unnamed_277, 24

	.type	.L__unnamed_411,@object
	.section	.data.rel.ro..L__unnamed_411,"aw",@progbits
	.p2align	3
.L__unnamed_411:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.size	.L__unnamed_411, 24

	.type	.L__unnamed_203,@object
	.section	.data.rel.ro..L__unnamed_203,"aw",@progbits
	.p2align	3
.L__unnamed_203:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	.L__unnamed_411
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$7read_u817h1c5a0919e0f0e004E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u1617haa2e80c0b1f229f2E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u3217h59a5b92a53c033f0E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8read_u6417h970ff3ac5eba872aE
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$8write_u817hfde206ba5bcf3dc3E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u1617ha8f3fa2ddcbcce39E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u3217hae13c58c9a2a05b5E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$9write_u6417h84f3c8d27ecc7834E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$10read_io_u817he891d122dd88baf1E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u1617h1631af9c88ea5e2bE
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_io_u3217h76d4a76581fc95bfE
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11write_io_u817hde8550b94fffdb1dE
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u1617h477a853211be2555E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_io_u3217hc94076676b810c02E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$11read_pci_u817had7477e863baba28E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u1617hcd931558e67a9d30E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12read_pci_u3217heb4807b9b56a97f0E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$12write_pci_u817hfeeee468c1b36c6bE
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u1617h87b2238581fade75E
	.quad	_ZN63_$LT$cryptos..acpi_impl..KernelAcpi$u20$as$u20$aml..Handler$GT$13write_pci_u3217h5b4d07c28c1b4838E
	.quad	_ZN3aml7Handler18handle_fatal_error17hfae004f06f039a51E
	.size	.L__unnamed_203, 200

	.type	.L__unnamed_278,@object
	.section	.data.rel.ro..L__unnamed_278,"aw",@progbits
	.p2align	3
.L__unnamed_278:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\346\000\000\000\036\000\000"
	.size	.L__unnamed_278, 24

	.type	.L__unnamed_279,@object
	.section	.data.rel.ro..L__unnamed_279,"aw",@progbits
	.p2align	3
.L__unnamed_279:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\351\000\000\000\025\000\000"
	.size	.L__unnamed_279, 24

	.type	.L__unnamed_412,@object
	.section	.rodata..L__unnamed_412,"a",@progbits
.L__unnamed_412:
	.ascii	"DSDT address: "
	.size	.L__unnamed_412, 14

	.type	.L__unnamed_204,@object
	.section	.data.rel.ro..L__unnamed_204,"aw",@progbits
	.p2align	3
.L__unnamed_204:
	.quad	.L__unnamed_412
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_204, 16

	.type	.L__unnamed_205,@object
	.section	.data.rel.ro..L__unnamed_205,"aw",@progbits
	.p2align	3
.L__unnamed_205:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\352\000\000"
	.zero	4
	.size	.L__unnamed_205, 56

	.type	.L__unnamed_206,@object
	.section	.data.rel.ro..L__unnamed_206,"aw",@progbits
	.p2align	3
.L__unnamed_206:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\361\000\000"
	.zero	4
	.size	.L__unnamed_206, 56

	.type	.L__unnamed_281,@object
	.section	.data.rel.ro..L__unnamed_281,"aw",@progbits
	.p2align	3
.L__unnamed_281:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\361\000\000\000\005\000\000"
	.size	.L__unnamed_281, 24

	.type	.L__unnamed_207,@object
	.section	.rodata..L__unnamed_207,"a",@progbits
.L__unnamed_207:
	.ascii	"\\_PIC"
	.size	.L__unnamed_207, 5

	.type	.L__unnamed_290,@object
	.section	.data.rel.ro..L__unnamed_290,"aw",@progbits
	.p2align	3
.L__unnamed_290:
	.quad	_ZN4core3ptr34drop_in_place$LT$aml..AmlError$GT$17h2b4a532816f56a79E
	.asciz	" \000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN50_$LT$aml..AmlError$u20$as$u20$core..fmt..Debug$GT$3fmt17h8494d2c2b27ce791E
	.size	.L__unnamed_290, 32

	.type	.L__unnamed_291,@object
	.section	.data.rel.ro..L__unnamed_291,"aw",@progbits
	.p2align	3
.L__unnamed_291:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\004\001\000\000\022\000\000"
	.size	.L__unnamed_291, 24

	.type	.L__unnamed_208,@object
	.section	.rodata..L__unnamed_208,"a",@progbits
.L__unnamed_208:
	.ascii	"\\_SB.PCI0._PRT"
	.size	.L__unnamed_208, 14

	.type	.L__unnamed_292,@object
	.section	.data.rel.ro..L__unnamed_292,"aw",@progbits
	.p2align	3
.L__unnamed_292:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\021\001\000\000\022\000\000"
	.size	.L__unnamed_292, 24

	.type	.L__unnamed_413,@object
	.section	.rodata..L__unnamed_413,"a",@progbits
.L__unnamed_413:
	.ascii	"IRQ descriptor A: "
	.size	.L__unnamed_413, 18

	.type	.L__unnamed_209,@object
	.section	.data.rel.ro..L__unnamed_209,"aw",@progbits
	.p2align	3
.L__unnamed_209:
	.quad	.L__unnamed_413
	.asciz	"\022\000\000\000\000\000\000"
	.size	.L__unnamed_209, 16

	.type	.L__unnamed_210,@object
	.section	.data.rel.ro..L__unnamed_210,"aw",@progbits
	.p2align	3
.L__unnamed_210:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\025\001\000"
	.zero	4
	.size	.L__unnamed_210, 56

	.type	.L__unnamed_211,@object
	.section	.data.rel.ro..L__unnamed_211,"aw",@progbits
	.p2align	3
.L__unnamed_211:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\026\001\000\000\025\000\000"
	.size	.L__unnamed_211, 24

	.type	.L__unnamed_414,@object
	.section	.rodata..L__unnamed_414,"a",@progbits
.L__unnamed_414:
	.ascii	"IRQ descriptor B: "
	.size	.L__unnamed_414, 18

	.type	.L__unnamed_212,@object
	.section	.data.rel.ro..L__unnamed_212,"aw",@progbits
	.p2align	3
.L__unnamed_212:
	.quad	.L__unnamed_414
	.asciz	"\022\000\000\000\000\000\000"
	.size	.L__unnamed_212, 16

	.type	.L__unnamed_213,@object
	.section	.data.rel.ro..L__unnamed_213,"aw",@progbits
	.p2align	3
.L__unnamed_213:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\031\001\000"
	.zero	4
	.size	.L__unnamed_213, 56

	.type	.L__unnamed_214,@object
	.section	.data.rel.ro..L__unnamed_214,"aw",@progbits
	.p2align	3
.L__unnamed_214:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\032\001\000\000\025\000\000"
	.size	.L__unnamed_214, 24

	.type	.L__unnamed_415,@object
	.section	.rodata..L__unnamed_415,"a",@progbits
.L__unnamed_415:
	.ascii	"IRQ descriptor C: "
	.size	.L__unnamed_415, 18

	.type	.L__unnamed_215,@object
	.section	.data.rel.ro..L__unnamed_215,"aw",@progbits
	.p2align	3
.L__unnamed_215:
	.quad	.L__unnamed_415
	.asciz	"\022\000\000\000\000\000\000"
	.size	.L__unnamed_215, 16

	.type	.L__unnamed_216,@object
	.section	.data.rel.ro..L__unnamed_216,"aw",@progbits
	.p2align	3
.L__unnamed_216:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\035\001\000"
	.zero	4
	.size	.L__unnamed_216, 56

	.type	.L__unnamed_217,@object
	.section	.data.rel.ro..L__unnamed_217,"aw",@progbits
	.p2align	3
.L__unnamed_217:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\036\001\000\000\025\000\000"
	.size	.L__unnamed_217, 24

	.type	.L__unnamed_416,@object
	.section	.rodata..L__unnamed_416,"a",@progbits
.L__unnamed_416:
	.ascii	"IRQ descriptor D: "
	.size	.L__unnamed_416, 18

	.type	.L__unnamed_218,@object
	.section	.data.rel.ro..L__unnamed_218,"aw",@progbits
	.p2align	3
.L__unnamed_218:
	.quad	.L__unnamed_416
	.asciz	"\022\000\000\000\000\000\000"
	.size	.L__unnamed_218, 16

	.type	.L__unnamed_219,@object
	.section	.data.rel.ro..L__unnamed_219,"aw",@progbits
	.p2align	3
.L__unnamed_219:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000!\001\000"
	.zero	4
	.size	.L__unnamed_219, 56

	.type	.L__unnamed_220,@object
	.section	.data.rel.ro..L__unnamed_220,"aw",@progbits
	.p2align	3
.L__unnamed_220:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\"\001\000\000\025\000\000"
	.size	.L__unnamed_220, 24

	.type	.L__unnamed_417,@object
	.section	.rodata..L__unnamed_417,"a",@progbits
.L__unnamed_417:
	.ascii	"Interrupt model: "
	.size	.L__unnamed_417, 17

	.type	.L__unnamed_223,@object
	.section	.data.rel.ro..L__unnamed_223,"aw",@progbits
	.p2align	3
.L__unnamed_223:
	.quad	.L__unnamed_417
	.asciz	"\021\000\000\000\000\000\000"
	.size	.L__unnamed_223, 16

	.type	.L__unnamed_224,@object
	.section	.data.rel.ro..L__unnamed_224,"aw",@progbits
	.p2align	3
.L__unnamed_224:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000*\001\000"
	.zero	4
	.size	.L__unnamed_224, 56

	.type	.L__unnamed_293,@object
	.section	.data.rel.ro..L__unnamed_293,"aw",@progbits
	.p2align	3
.L__unnamed_293:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000*\001\000\000&\000\000"
	.size	.L__unnamed_293, 24

	.type	.L__unnamed_418,@object
	.section	.rodata..L__unnamed_418,"a",@progbits
.L__unnamed_418:
	.ascii	"TLS template: "
	.size	.L__unnamed_418, 14

	.type	.L__unnamed_225,@object
	.section	.data.rel.ro..L__unnamed_225,"aw",@progbits
	.p2align	3
.L__unnamed_225:
	.quad	.L__unnamed_418
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_225, 16

	.type	.L__unnamed_226,@object
	.section	.data.rel.ro..L__unnamed_226,"aw",@progbits
	.p2align	3
.L__unnamed_226:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000,\001\000"
	.zero	4
	.size	.L__unnamed_226, 56

	.type	.L__unnamed_419,@object
	.section	.rodata..L__unnamed_419,"a",@progbits
.L__unnamed_419:
	.ascii	"PCI Configuration Regions: "
	.size	.L__unnamed_419, 27

	.type	.L__unnamed_227,@object
	.section	.data.rel.ro..L__unnamed_227,"aw",@progbits
	.p2align	3
.L__unnamed_227:
	.quad	.L__unnamed_419
	.asciz	"\033\000\000\000\000\000\000"
	.size	.L__unnamed_227, 16

	.type	.L__unnamed_228,@object
	.section	.rodata..L__unnamed_228,"a",@progbits
	.p2align	3
.L__unnamed_228:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.zero	8
	.asciz	"\002\000\000\000\000\000\000"
	.zero	8
	.ascii	" \000\000\000\024\000\000\000\003"
	.zero	7
	.size	.L__unnamed_228, 56

	.type	.L__unnamed_229,@object
	.section	.data.rel.ro..L__unnamed_229,"aw",@progbits
	.p2align	3
.L__unnamed_229:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000-\001\000"
	.zero	4
	.size	.L__unnamed_229, 56

	.type	.L__unnamed_230,@object
	.section	.data.rel.ro..L__unnamed_230,"aw",@progbits
	.p2align	3
.L__unnamed_230:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\0007\001\000"
	.zero	4
	.size	.L__unnamed_230, 56

	.type	.L__unnamed_264,@object
	.section	.data.rel.ro..L__unnamed_264,"aw",@progbits
	.p2align	3
.L__unnamed_264:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\0007\001\000\000\t\000\000"
	.size	.L__unnamed_264, 24

	.type	.L__unnamed_420,@object
	.section	.rodata..L__unnamed_420,"a",@progbits
.L__unnamed_420:
	.ascii	"Found AHCI controller "
	.size	.L__unnamed_420, 22

	.type	.L__unnamed_421,@object
	.section	.rodata..L__unnamed_421,"a",@progbits
.L__unnamed_421:
	.byte	58
	.size	.L__unnamed_421, 1

	.type	.L__unnamed_422,@object
	.section	.rodata.cst4,"aM",@progbits,4
.L__unnamed_422:
	.ascii	" at "
	.size	.L__unnamed_422, 4

	.type	.L__unnamed_231,@object
	.section	.data.rel.ro..L__unnamed_231,"aw",@progbits
	.p2align	3
.L__unnamed_231:
	.quad	.L__unnamed_420
	.asciz	"\026\000\000\000\000\000\000"
	.quad	.L__unnamed_421
	.asciz	"\001\000\000\000\000\000\000"
	.quad	.L__unnamed_422
	.asciz	"\004\000\000\000\000\000\000"
	.size	.L__unnamed_231, 48

	.type	.L__unnamed_232,@object
	.section	.rodata..L__unnamed_232,"a",@progbits
	.p2align	3
.L__unnamed_232:
	.asciz	"\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\000\000\000\000\003\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\000\000\000\000\003\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000 \000\000\000\004\000\000\000\003\000\000\000\000\000\000"
	.size	.L__unnamed_232, 168

	.type	.L__unnamed_233,@object
	.section	.data.rel.ro..L__unnamed_233,"aw",@progbits
	.p2align	3
.L__unnamed_233:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000B\001\000"
	.zero	4
	.size	.L__unnamed_233, 56

	.type	.L__unnamed_423,@object
	.section	.rodata..L__unnamed_423,"a",@progbits
.L__unnamed_423:
	.ascii	"Class Code: "
	.size	.L__unnamed_423, 12

	.type	.L__unnamed_236,@object
	.section	.data.rel.ro..L__unnamed_236,"aw",@progbits
	.p2align	3
.L__unnamed_236:
	.quad	.L__unnamed_423
	.asciz	"\f\000\000\000\000\000\000"
	.size	.L__unnamed_236, 16

	.type	.L__unnamed_237,@object
	.section	.data.rel.ro..L__unnamed_237,"aw",@progbits
	.p2align	3
.L__unnamed_237:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000F\001\000"
	.zero	4
	.size	.L__unnamed_237, 56

	.type	.L__unnamed_424,@object
	.section	.rodata..L__unnamed_424,"a",@progbits
.L__unnamed_424:
	.ascii	"Interrupt pin: "
	.size	.L__unnamed_424, 15

	.type	.L__unnamed_234,@object
	.section	.data.rel.ro..L__unnamed_234,"aw",@progbits
	.p2align	3
.L__unnamed_234:
	.quad	.L__unnamed_424
	.asciz	"\017\000\000\000\000\000\000"
	.size	.L__unnamed_234, 16

	.type	.L__unnamed_235,@object
	.section	.data.rel.ro..L__unnamed_235,"aw",@progbits
	.p2align	3
.L__unnamed_235:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000H\001\000"
	.zero	4
	.size	.L__unnamed_235, 56

	.type	.L__unnamed_238,@object
	.section	.data.rel.ro..L__unnamed_238,"aw",@progbits
	.p2align	3
.L__unnamed_238:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000R\001\000"
	.zero	4
	.size	.L__unnamed_238, 56

	.type	.L__unnamed_295,@object
	.section	.data.rel.ro..L__unnamed_295,"aw",@progbits
	.p2align	3
.L__unnamed_295:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000R\001\000\000\021\000\000"
	.size	.L__unnamed_295, 24

	.type	.L__unnamed_425,@object
	.section	.rodata..L__unnamed_425,"a",@progbits
.L__unnamed_425:
	.ascii	"Found "
	.size	.L__unnamed_425, 6

	.type	.L__unnamed_426,@object
	.section	.rodata..L__unnamed_426,"a",@progbits
.L__unnamed_426:
	.ascii	" disks"
	.size	.L__unnamed_426, 6

	.type	.L__unnamed_255,@object
	.section	.data.rel.ro..L__unnamed_255,"aw",@progbits
	.p2align	3
.L__unnamed_255:
	.quad	.L__unnamed_425
	.asciz	"\006\000\000\000\000\000\000"
	.quad	.L__unnamed_426
	.asciz	"\006\000\000\000\000\000\000"
	.size	.L__unnamed_255, 32

	.type	.L__unnamed_256,@object
	.section	.data.rel.ro..L__unnamed_256,"aw",@progbits
	.p2align	3
.L__unnamed_256:
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_404
	.asciz	"\007\000\000\000\000\000\000"
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000Z\001\000"
	.zero	4
	.size	.L__unnamed_256, 56

	.type	.L__unnamed_280,@object
	.section	.data.rel.ro..L__unnamed_280,"aw",@progbits
	.p2align	3
.L__unnamed_280:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\353\000\000\000\024\000\000"
	.size	.L__unnamed_280, 24

	.type	.L__unnamed_271,@object
	.section	.data.rel.ro..L__unnamed_271,"aw",@progbits
	.p2align	3
.L__unnamed_271:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\314\000\000\000\020\000\000"
	.size	.L__unnamed_271, 24

	.type	.L__unnamed_270,@object
	.section	.data.rel.ro..L__unnamed_270,"aw",@progbits
	.p2align	3
.L__unnamed_270:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\310\000\000\000\022\000\000"
	.size	.L__unnamed_270, 24

	.type	.L__unnamed_269,@object
	.section	.data.rel.ro..L__unnamed_269,"aw",@progbits
	.p2align	3
.L__unnamed_269:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\277\000\000\000\031\000\000"
	.size	.L__unnamed_269, 24

	.type	.L__unnamed_287,@object
	.section	.data.rel.ro..L__unnamed_287,"aw",@progbits
	.p2align	3
.L__unnamed_287:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\271\000\000\000\017\000\000"
	.size	.L__unnamed_287, 24

	.type	.L__unnamed_286,@object
	.section	.data.rel.ro..L__unnamed_286,"aw",@progbits
	.p2align	3
.L__unnamed_286:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\270\000\000\000\017\000\000"
	.size	.L__unnamed_286, 24

	.type	.L__unnamed_268,@object
	.section	.data.rel.ro..L__unnamed_268,"aw",@progbits
	.p2align	3
.L__unnamed_268:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\253\000\000\000\t\000\000"
	.size	.L__unnamed_268, 24

	.type	.L__unnamed_427,@object
	.section	.rodata..L__unnamed_427,"a",@progbits
.L__unnamed_427:
	.ascii	"Failed to initialize heap: "
	.size	.L__unnamed_427, 27

	.type	.L__unnamed_262,@object
	.section	.data.rel.ro..L__unnamed_262,"aw",@progbits
	.p2align	3
.L__unnamed_262:
	.quad	.L__unnamed_427
	.asciz	"\033\000\000\000\000\000\000"
	.size	.L__unnamed_262, 16

	.type	.L__unnamed_263,@object
	.section	.data.rel.ro..L__unnamed_263,"aw",@progbits
	.p2align	3
.L__unnamed_263:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000\273\000\000\000\031\000\000"
	.size	.L__unnamed_263, 24

	.type	.L__unnamed_428,@object
	.section	.rodata..L__unnamed_428,"a",@progbits
.L__unnamed_428:
	.ascii	"Out of memory!"
	.size	.L__unnamed_428, 14

	.type	.L__unnamed_297,@object
	.section	.data.rel.ro..L__unnamed_297,"aw",@progbits
	.p2align	3
.L__unnamed_297:
	.quad	.L__unnamed_428
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_297, 16

	.type	.L__unnamed_298,@object
	.section	.data.rel.ro..L__unnamed_298,"aw",@progbits
	.p2align	3
.L__unnamed_298:
	.quad	.L__unnamed_401
	.asciz	"\013\000\000\000\000\000\000\000i\001\000\000\005\000\000"
	.size	.L__unnamed_298, 24

	.type	.L__unnamed_304,@object
	.section	.rodata..L__unnamed_304,"a",@progbits
.L__unnamed_304:
	.ascii	"EnclosureManagementBridge"
	.size	.L__unnamed_304, 25

	.type	.L__unnamed_303,@object
	.section	.rodata..L__unnamed_303,"a",@progbits
.L__unnamed_303:
	.ascii	"PortMultiplier"
	.size	.L__unnamed_303, 14

	.type	.L__unnamed_302,@object
	.section	.rodata..L__unnamed_302,"a",@progbits
.L__unnamed_302:
	.ascii	"SataPacketInterface"
	.size	.L__unnamed_302, 19

	.type	.L__unnamed_301,@object
	.section	.rodata..L__unnamed_301,"a",@progbits
.L__unnamed_301:
	.ascii	"SataDrive"
	.size	.L__unnamed_301, 9

	.type	.L__unnamed_299,@object
	.section	.rodata..L__unnamed_299,"a",@progbits
.L__unnamed_299:
	.ascii	"Unknown"
	.size	.L__unnamed_299, 7

	.type	.L__unnamed_300,@object
	.section	.data.rel.ro..L__unnamed_300,"aw",@progbits
	.p2align	3
.L__unnamed_300:
	.quad	_ZN4core3ptr27drop_in_place$LT$$RF$u8$GT$17h1b99e7ed400a7488E
	.asciz	"\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN42_$LT$$RF$T$u20$as$u20$core..fmt..Debug$GT$3fmt17h19fb2e808af40e0aE
	.size	.L__unnamed_300, 32

	.type	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE,@object
	.section	.bss._ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE,"aw",@nobits
	.p2align	3
_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE:
	.zero	1
	.zero	7
	.zero	8
	.zero	448
	.size	_ZN7cryptos7cralloc5ALLOC17h7c9191c8254e59ceE, 464

	.type	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref23__static_ref_initialize5STACK17h7a2ac005a7d2dfb0E,@object
	.section	".bss._ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref23__static_ref_initialize5STACK17h7a2ac005a7d2dfb0E","aw",@nobits
_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref23__static_ref_initialize5STACK17h7a2ac005a7d2dfb0E:
	.zero	20480
	.size	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref23__static_ref_initialize5STACK17h7a2ac005a7d2dfb0E, 20480

	.type	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE,@object
	.section	".bss._ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE","aw",@nobits
	.p2align	3
_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE:
	.zero	12
	.zero	108
	.size	_ZN68_$LT$cryptos..exceptions..TSS$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hdf70d1d3c46fc8acE, 120

	.type	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E,@object
	.section	".bss._ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E","aw",@nobits
	.p2align	3
_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E:
	.zero	16
	.zero	88
	.size	_ZN68_$LT$cryptos..exceptions..GDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h0b5bb1eff099c838E, 104

	.type	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E,@object
	.section	".bss._ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E","aw",@nobits
	.p2align	4
_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E:
	.zero	1
	.zero	4111
	.zero	8
	.zero	8
	.size	_ZN74_$LT$cryptos..interrupts..IDT_CLONE$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17hcdb9f4f28efc74e0E, 4128

	.type	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E,@object
	.section	".bss._ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E","aw",@nobits
	.p2align	4
_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E:
	.zero	1
	.zero	4127
	.zero	8
	.zero	8
	.size	_ZN68_$LT$cryptos..interrupts..IDT$u20$as$u20$core..ops..deref..Deref$GT$5deref11__stability4LAZY17h5a1e894c2d780c44E, 4144

	.type	.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E,@object
	.section	.rodata.str4.4,"aMS",@progbits,4
	.p2align	2
.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E:
	.long	5
	.long	3
	.long	2
	.long	5
	.long	1
	.long	5
	.long	5
	.long	5
	.long	0
	.size	.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$9sata_stop17h35352b16f589cad1E, 36

	.type	.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E,@object
	.section	".rodata..Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E","a",@progbits
	.p2align	2
.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	5
	.long	5
	.size	.Lswitch.table._ZN7cryptos4ahci3hba54_$LT$impl$u20$cryptos..ahci..hba..structs..HbaPort$GT$10satapi_dma17h52c7db15950b21e7E, 24

	.section	".note.GNU-stack","",@progbits
