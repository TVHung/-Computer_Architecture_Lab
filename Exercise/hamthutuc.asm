.data
	chuoi: .asciiz "Xin chao "
	chuoi2: .asciiz "moi nguoi"
.text
	main:
		jal in_ra_chuoi #goi ham in ra
		jal in_ra_chuoi_2
		#khong duoc dung j hoac b thay cho jal vi la se co loi
		
		#ket thuc chuong trinh
		li $v0, 10
		syscall
		
	in_ra_chuoi:
		li $v0, 4
		la $a0, chuoi
		syscall
		jr $ra # neu khong co cai nay thi chay den day ham se nghi la het code va dung ctrinh lai
		
	in_ra_chuoi_2:
		li $v0, 4
		la $a0, chuoi2
		syscall
		jr $ra
		
		