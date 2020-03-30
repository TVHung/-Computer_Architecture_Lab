.data
	printString: .asciiz "xin chao moi nguoi toi laf Truong Van Hung\n"
.text
	li $v0, 4
	la $a0, printString
	syscall