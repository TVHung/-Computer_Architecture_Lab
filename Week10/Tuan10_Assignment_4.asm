.data
.eqv	KEY_CODE	0xffff0004
.eqv	KEY_READY	0xffff0000
.eqv	DISPLAY_CODE	0xffff000c
.eqv	DISPLAY_READY	0xffff0008
array: .space 2000000
.text
	li $k0, KEY_CODE
	li $k1, KEY_READY
	li $s0, DISPLAY_CODE
	li $s1, DISPLAY_READY
	add $t8, $zero, $zero
loop:
WaitForKey:
	lw $t1, 0($k1)
	beq $t1, $zero, WaitForKey
ReadKey:
	lw $t0, 0($k0)
	sw $t0, array($t8)
	jal compare
WaitForDis:
	lw $t2, 0($s1)
	beq $t2, $zero, WaitForDis
Encrypt:
	addi $t0, $t0, 1
ShowKey:
	sw $t0, 0($s0)
	j loop
compare:
	add $t7 , $t8, $zero
	lw $t3, array($t7)
	beq $t3, 0x74, continue
	add $t8, $t8, 4
	jr $ra
continue:
	add $t7, $t7, -4
	lw $t3, array($t7)
	beq $t3, 0x69, continue1 
	add $t8, $t8, 4
	j WaitForDis
continue1:
	add $t7, $t7, -4
	lw $t3, array($t7)
	beq $t3, 0x78, continue2
	add $t8, $t8, 4
	j WaitForDis
continue2:
	add $t7, $t7, -4
	lw $t3, array($t7)
	beq $t3, 0x65, exit
	add $t8, $t8, 4
	j WaitForDis
exit: 
	li $v0, 10
	syscall