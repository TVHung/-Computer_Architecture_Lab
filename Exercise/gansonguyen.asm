#bai 1: gan so nguyen cho mot thanh ghi
#gan 10 cho thanh ghi $t1
#gan 15 cho thanh ghi $t1
#gan 20 cho thanh ghi $t1

.data #phan khai bao du lieu
	number: .word 10 #.word la kieu nguyen  
.text #phan code
	#3 cach gan gia tri nguyen
	lw $t1, number 		#lay gia tri cua nhan number gan vao thanh ghi $t1
	li $t2, 15 		#gan truc tiep 15 cho thanh ghi $t2
	addi $t3, $zero, 20	#$t3 = 0 + 20 , phep cong 
	