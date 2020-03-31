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
	slt  	$t2, $s3, $s1  
	bltz  	$s1, NEGATIVE 		#Test if $s1 and $s2 is negative?  
	beq 	$t2, $zero, EXIT 	#s1 and $s2 are positive 
					# if $s3 > $s1 then the result is not overflow  
	b 	OVERFLOW      
NEGATIVE:         
	bne 	$t2, $zero, EXIT 	#s1 and $s2 are negative      
					# if $s3 < $s1 then the result is not overflow 
OVERFLOW:  
	li 	$t0,  1   		#the result is overflow 
EXIT: 
