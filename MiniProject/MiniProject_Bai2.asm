.data
	inputA:		.asciiz "Nhap so thu 1: \n"
	inputB: 	.asciiz "Nhap so thu 2: \n"
	nhapSai: 	.asciiz "Ban da nhap sai quy tac! Vui long nhap so duong, so thu 1 phai nho hon so thu 2\n"
	cacSoNguyenTo:	.asciiz "Cac so nguyen to la: \n"
	tieptuc:	.asciiz "\nBan co muon tiep tuc?\n1. Co\n0. Khong\n"
	daucach:	.asciiz " "
	arrNguyenTo:	.word 100
.text
While:
	li	$t6, 0				# Luu kich thuoc cua mang so nguyen to
Nhap:
	# Nhap so thu nhat
	li	$v0, 4			
	la	$a0, inputA
	syscall
	li	$v0, 5
	syscall
	move	$t1, $v0			# $t1 chua gia tri bien thu nhat
	# Nhap so thu 2
	li	$v0, 4			
	la	$a0, inputB
	syscall
	li	$v0, 5
	syscall
	move	$t2, $v0			# $t2 chua gia tri bien thu hai
	# xu ly nhap dung hay chua
	slt  	$t3, $t1, $t2 			# kiem tra xem $t1 < $t2 khong
	beqz 	$t3, NhapSai 
	slt 	$t4, $zero, $t1  		# kiem tra so am
	beqz 	$t4, NhapSai 
	slt	$t5, $zero, $t2
	beqz 	$t5, NhapSai
	
	la	$a1, arrNguyenTo		# $a0 = arrNguyenTo[0]
	# xu ly kiem tra so nguyen to
	b	NguyenToGiuaAVaB

	# xu ly co muon tiep tuc
	b	TiepTuc

NguyenToGiuaAVaB:
	# $s0 = i
		add  	$s0, $t1, $zero 	# i = a
		add 	$t0, $t2, $zero  	# $t0 = b
	for1: 	
		bgt   	$s0, $t0, done  	# Neu i > b, thoát
		b	KiemTraNguyenTo 	# Neu i<b thì kiem tra so nguyen so 
	tang:
		addi 	$s0, $s0, 1 		# tang i thêm 1 
		j    	for1 			# quay lai for 
	done:
		b	SauKhiTim
KiemTraNguyenTo:
	# Kiem tra i co phai so nguy to $s0
	blt	$s0, 2, tang			# neu n < 2 thi chuyen sang so nguyen tiep theo
	beq  	$s0, 2, done2  			# Neu n = 2 thi no là so nguyen so
	beq	$s0, 4, tang			# Nei n = 4 thi khong phai so nguyen to thi kiem tra gia tri tiep theo
		li	$t7, 2
		addi  	$s1, $zero, 2 		# i = 2
		div  	$s0, $t7  		# $t3 = n/2  $lo = thuong, $hi = so du
		mflo	$t3			# $t3 = lo (thuong) = n/2
	for2: 
		bge 	$s1, $t3, done2		# neu i = n/2 thì no la so nguyen to
		div	$s0, $s1   		# Neu i < n/2 thì n/i
		mfhi	$t4			# thuong luu vao $t4
		beq  	$t4, $zero, tang	# neu n/i == 0 thi khong phai so nguyen to thi quay lai for1 de duyet phan tu tiep theo
		addi 	$s1, $s1, 1 		# con neu van chua chia het thi tiep tuc tang i
	
		b	for2  			# neu i <= n/2 thi tuc chia
		
	done2: 
		#chay den day tuc la so do la so nguyen thi luu vao mang
		sw 	$s0, ($a1)
		addi	$t6, $t6, 1
		addi	$a1, $a1, 4
		addi 	$s0, $s0, 1 
		b	for1
	
SauKhiTim:
	# in ra ket qua
	li	$v0, 4
	la	$a0, cacSoNguyenTo
	syscall
	
	la	$a1, arrNguyenTo
	li	$s1, 0
	add	$t1, $t6, $zero
	while3:	
		beq  	$s1, $t1, done3
		lw 	$t2, ($a1)
		
		li	$v0, 1			# in ket qua
		la	$a0, ($t2)
		syscall
		
		li	$v0, 4			# in dau cach
		la	$a0, daucach
		syscall
		
		addi	$a1, $a1, 4
		addi	$s1, $s1, 1
		b	while3	
	done3:
		b	TiepTuc

TiepTuc:
	li	$v0, 4
	la	$a0, tieptuc
	syscall
	li	$v0, 5
	syscall
	move	$t1, $v0
	bnez  	$t1, While
	b	Thoat

NhapSai:
	li	$v0, 4
	la	$a0, nhapSai
	syscall
	b	Nhap
	
Thoat:
