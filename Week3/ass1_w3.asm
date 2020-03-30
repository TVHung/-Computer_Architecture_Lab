.data

.text
	li	$s1, 1
	li	$s2, 0
	li	$t1, 1
	li	$t2, 2
	li	$t3, 3
start:	
	slt 	$t0, $s2, $s1		#neu s2 < s1 
	bne	$t0, $zero, else	#neu t0 = 0 thi chuyen sang else
	addi 	$t1, $t1, 1		#con khong thi tang t1 len 1
	j	endif			#thoat bo qua else
else: 
	addi	$t2, $t2, -1		#giam t2 di 1
	add	$t3, $t3, $t3		#tang t3 len 2 lan
endif:
