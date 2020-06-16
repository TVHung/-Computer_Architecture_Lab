.eqv IN_ADRESS_HEXA_KEYBOARD	0xffff0012
.eqv COUNTER			0xffff0013
.eqv MASK_CAUSE_COUNTER		0x00000400
.eqv MASK_CAUSE_KEYMATRIX	0x00000800
.eqv OUT_ADRESS_HEXA_KEYBOARD	0xffff0014
.data
msg_keypress: .asciiz "Someone has pressed a key!\n"
msg_counter:	.asciiz "Time inteval!\n"

.text
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t3, 0x80
	sb $t3, 0($t1)
	li $t1, COUNTER
	sb $t1, 0($t1)
	
loop:
	nop 
	nop
	nop
	li $v0, 32
	li $a0, 200
	syscall
	nop
	b loop
.ktext 0x80000180
IntSR:
dis_int: 
	li $t1, COUNTER
	sb $zero, 0($t1)
get_cause:
	mfc0 $t1, $13
IsCount:
	li $t2, MASK_CAUSE_COUNTER
	and $at, $t1, $t2
	beq $at, $t2, Counter_Intr
IsKeyMa:
	li $t2, MASK_CAUSE_KEYMATRIX
	and $at, $t1, $t2
	beq $at, $t2, KeyMatrix_Intr
	j end_process
KeyMatrix_Intr:
	li $v0, 4
	la $a0, msg_keypress
	syscall
	j end_process
Counter_Intr:
	li $v0, 4
	la  $a0, msg_counter
	syscall
	j end_process
end_process:
	mtc0, $zero, $13
	li $t1, COUNTER
	sb $t1, 0($t1)
next_pc:
	mfc0 $at, $14
	addi $at, $at, 4
	mtc0 $at, $14
	eret
