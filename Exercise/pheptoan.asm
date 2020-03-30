#bai 3: cac phep toan co ban
.data 

.text
	li $t1, 30
	li $t2, 20
#phep cong
	add $t3, $t1, $t2 #$t3 = $t1 + $t2
#phep tru
	sub $t4, $t1, $t2 #$t4 = $t1 - $t2
#phep nhan
	mul $t5, $t1, $t2 #$t5 = $t1 * $t2
#phep chia
	div $t1, $t2 #$t4 = $t1 / $t2
	#lo la thuong
	#hi la phan du
	mflo $t6 #gan $t6 = thuong
	mfhi $t7 #gan $t7 = du