#bai tap: Nhap ten tuoi sau do in ra man hinh
.data
	inputName: .asciiz "Nhap ten: "
	inputOld: .asciiz "Nhap tuoi: "
	name: .asciiz
.text
#in ra cau nhap ten
	li $v0, 4
	la $a0, inputName
	syscall
#nhap ten	
	li $v0, 8
	la $a0, name
	li $a1, 30
	syscall
# in ra cau nhap tuoi
	li $v0, 4
	la $a0, inputOld
	syscall
#nhap tuoi
	li $v0, 5
	syscall
	move $t1, $v0
#in ra ten
	li $v0, 4
	la $a0, name
	syscall
#in ra tuoi
	li $v0, 1
	move $a0, $t1
	syscall