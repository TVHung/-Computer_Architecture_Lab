.data
	chuoi: .asciiz	
.text	
	li $v0, 8
	la $a0, chuoi
	li $a1, 30
	syscall