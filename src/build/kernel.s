	.text
	.file	"main"
	.globl	_start
	.p2align	4, 0x90
	.type	_start,@function
_start:
	.cfi_startproc
	movq	boot_info@GOTPCREL(%rip), %rax
	movl	52(%rax), %ecx
	movl	56(%rax), %edx
	movl	%edx, -24(%rsp)
	movl	%ecx, -20(%rsp)
	movq	fb@GOTPCREL(%rip), %rcx
	movq	%rcx, -16(%rsp)
	movl	$16777215, (%rcx)
	movl	$0, -28(%rsp)
	.p2align	4, 0x90
.LBB0_2:
	movl	-28(%rsp), %edx
	cmpl	-24(%rsp), %edx
	jge	.LBB0_3
	movl	60(%rax), %edx
	imull	-28(%rsp), %edx
	movslq	%edx, %rdx
	addq	%rcx, %rdx
	movl	-20(%rsp), %esi
	addl	%esi, %esi
	movslq	%esi, %rsi
	leaq	(%rdx,%rsi), %rdi
	movq	%rdi, -8(%rsp)
	movl	$16777215, (%rsi,%rdx)
	incl	-28(%rsp)
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_3:
	jmp	.LBB0_3
.Lfunc_end0:
	.size	_start, .Lfunc_end0-_start
	.cfi_endproc

	.section	".note.GNU-stack","",@progbits
