.data

.text
	addi $v0, $zero, 5 #$v0 = 0 + 5
	syscall
	#thuong se copy sang mot thanh ghi khac vi neu nhap nhieu thi thanh ghi v0 se bi thay doi
	move $t2, $v0