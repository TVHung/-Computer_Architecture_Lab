.data
	x: .word 100
	y: .word 0x10
	message: .asciiz "Hello World"

.text
	la $a0, message 
	li $v0, 4
	syscall 
	
	li $t0, 100
	addi $t1, $zero, 20 