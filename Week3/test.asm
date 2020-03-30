.data

.text
	start: 
		li 	$t0, 0			#No Overflow is default status 
		add 	$s3, $s2, $s1
		xor	$t1, $s1, $s2		#Test if $s1 and $s2 have the same sign (neu cung dau)
		
		bltz 	$t1, EXIT		#If not, exit (neu t1 < 0 thi exit)
		slt	$t2, $s3, $s1		# neu s3 < s1 thi t2 = 1 nguoc lai t2 = 0
		bltz	$s1, NETGATIVE		
		beq 	$t2, $zero, EXIT	#Test if $s1 and $s2 is negative? 
		#if $s3 > $s1 then the result is not overflow
		b	OVERFLOW
	NETGATIVE: 
		bne	$t2, $zero, EXIT
		#if $s3 < $s1 then the result is not overflow
	OVERFLOW: 
		li	$t0, 1			#the result is overflow
	EXIT:
