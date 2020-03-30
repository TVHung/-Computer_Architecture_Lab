.data
	chuoi1: .asciiz "Bang nhau"
	chuoi2: .asciiz "khong bang nhau"
.text
	li $t1, 5
	li $t2, 6
	
	#re nhanh co dieu kien
	beq $t1, $t2, in_chuoi_1	#(t1 = t2) -> dung thi in_chuoi_1, con nhieu loai so sanh khac
	
	#re nhanh khong co dieu kien
	#su dung cu phap
	#b in_chuoi_1
	#thi no se in chuoi1 ma ko can dieu kien gi ca
	
	#in chuoi 2
	li $v0, 4
	la $a0, chuoi2
	syscall
	#bao ket thuc chuong trinh neu dieu kien tren dung
	li $v0, 10
	syscall
	
	#in chuoi 1
	in_chuoi_1:
		li $v0, 4
		la $a0, chuoi1
		syscall
		
	