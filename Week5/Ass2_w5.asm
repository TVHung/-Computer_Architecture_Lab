.data
	thesumof:	.asciiz "The sum of "
	and: 		.asciiz "and"
	is:		.asciiz "is"	
.text
	li	$s0, 10
	li	$s0, 20
	add	$t1, $s0, $s1
	