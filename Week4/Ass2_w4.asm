.data

.text

#d ble   $s1,s2,L  
#if (s1 <= $s2)  
#j L
	li	$s1, 100
	li	$s2, 200
	sle	$t0, $s1, $s2 		#neu s1 <= s2
	beq	$t0, 1, L
	j	ENDIF
L:
	li	$s3, 300
ENDIF:
	
#***********************************************************************************
#c not   $s0  
#s0 <= bit invert (s0) 
	#li	$s0, 100
	#sub	$s0, $zero, $s0

#***********************************************************************************
#b move  $s0,s1  
#s0 <= $s1 
	#li	$s1, 100
	#addi	$s0, $s1, 0

#***********************************************************************************
#a  abs   $s0,s1  
#s0 <= | $s1 | 
	#li	$s1, -5
	#addi	$s0, $s1, 0
	#slt 	$t0, $s0, $zero
	#beq	$t0, 1, DAOGIATRI
	#bc1f	KHONGDAO
#DAOGIATRI:
	#sub	$s0, $zero, $s0
#KHONGDAO:
