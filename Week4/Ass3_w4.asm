#Laboratory Exercise 4, Home Assignment 0
.data

.text 
	li 	$s1, 0x7fffffff 	#so lon nhat cua day 32 bit
	li 	$s2, 0x7fffffff
START: 	 
	li	$t0, 0  	 	#No Overflow is default status  
	addu  	$s3, $s1, $s2  
	xor 	$t1, $s1, $s2 		#Test if $s1 and $s2 have the same sign/ neu s1 va s2 cung dau 
	
	bltz 	$t1, EXIT 		#If not, exit  
	xor 	$t2, $s3, $s1
	bltz	$t2, OVERFLOW
	j	EXIT
OVERFLOW:  
	li 	$t0,  1   		#the result is overflow 
EXIT: 
