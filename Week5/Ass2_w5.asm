.data
	thesumof:	.asciiz "The sum of "
	ands: 		.asciiz " and "
	is:		.asciiz " is: "	
.text
	li	$s0, 10
	li	$s1, 20
	add	$t1, $s0, $s1
	li	$v0, 4
	la	$a0, thesumof
	syscall
	li	$v0, 1
	la	$a0, ($s0)
	syscall
	li	$v0, 4
	la	$a0, ands
	syscall
	li	$v0, 1
	la	$a0, ($s1)
	syscall
	li	$v0, 4
	la	$a0, is
	syscall
	li	$v0, 1
	la	$a0, ($t1)
	syscall
	
	
	
	
	