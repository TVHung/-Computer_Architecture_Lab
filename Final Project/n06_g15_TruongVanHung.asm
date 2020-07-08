#----------------------------------------------------------
# Author: Truong Van Hung - 20176776
# Project 6: Viet ham FinSubString() 
#-----------------------------------------------------------

.data
	STRING_MAX_LENGTH:		.word		100
	INPUT_FIRST_STRING:		.space 		100
	INPUT_SECOND_STRING:		.space 		100
	RESULT_SEARCH:			.space 		100
	SEPARATOR:			.asciiz 	", "
	CONTINUE:			.asciiz		"\n*********************\nBan co muon tiep tuc?\n 0. Co\n 1. Khong\nChon: "
	NOT_FOUND:			.asciiz		"Khong tim thay chuoi!"	
	FOUND:				.asciiz		"Chuoi duoc tim thay o vi tri: "
	INPUT_STRING:			.asciiz		"***********************\nNhap chuoi cua ban:\n"
	INPUT_STRING_SEARCH:		.asciiz		"***********************\nNhap chuoi muon tim:\n"
	SEARCH_OPTION:			.asciiz		"***********************\nBan muon tim kiem phan biet chu hoa chu thuong hay khong?\n 0. Co\n 1. Khong\nChon: "

.text
#>>>>>>>>>>>>>>>>>>>>>> Main <<<<<<<<<<<<<<<<<<<<<<
Main:
	li	$v0, 4					
	la	$a0, INPUT_STRING
	syscall
		
	li	$v0, 8					# Doc chuoi vua nhap
	la	$a0, INPUT_FIRST_STRING			
	lw	$a1, STRING_MAX_LENGTH	
	syscall
	
	li	$v0, 4
	la	$a0, INPUT_STRING_SEARCH
	syscall
	
	li	$v0, 8					# Doc chuoi muon tim kiem
	la	$a0, INPUT_SECOND_STRING	
	lw	$a1, STRING_MAX_LENGTH		
	syscall
	
Choose_option:
	li	$v0, 4					# Chon che do tim kiem
	la	$a0, SEARCH_OPTION
	syscall
	
	li	$v0, 5
	syscall

	blt	$v0, $zero, Choose_option		# Kiem tra dieu kien nhap
	bgt	$v0, 1, Choose_option
	
	beq	$v0, 0, Search_case_sensitive		# chon yes thi se tim kiem phan biet hoa thuong
	j	Search_not_case_sensitive		# Nguoc lai se tim kiem khong phan biet hoa thuong
	
Search_case_sensitive:
	li	$a2, 0					# $a2 = 1 tim kiem khong phan biet hoa thuong
	j 	Search_function				# goi den ham search

Search_not_case_sensitive:
	li	$a2, 1					# $a2 = 0 tim kiem phan biet chu hoa thuong
	j	Search_function				# Goi den ham search
	
Search_function:
	la	$a1, INPUT_FIRST_STRING	
	la	$a0, INPUT_SECOND_STRING		# a0 = str1, a1 = str2, a2 = mode
	la	$a3, RESULT_SEARCH			# mang luu ket qua 
	jal	Search					# 
	beq	$v0, 0, Not_found			# Khong tim thay	

	la  	$a3, RESULT_SEARCH			# mang luu ket qua 
		
	li	$v0, 4					# Ket qua
	la	$a0, FOUND
	syscall 			
	
	li	$s6, 0					# $s6 = i
	Print_loop:
		lw 	$t1, ($a3)
		
		li	$v0, 1				# in ket qua
		la	$a0, ($t1)
		syscall
		
		addi	$s6, $s6, 1
		bge	$s6, $s4, Continue
		
		li	$v0, 4				# in dau phay
		la	$a0, SEPARATOR
		syscall
		
		addi	$a3, $a3, 4
		j	Print_loop
Continue:
	li	$v0, 4
	la	$a0, CONTINUE
	syscall
	
	li	$v0, 5
	syscall
	
	beq 	$v0, 0, Main
	
	j	Exit
	
Not_found:
	li	$v0, 4					# in chuoi khong tim thay
	la	$a0, NOT_FOUND				
	syscall 
	
	li	$v0, 4					# Ban co muon tiep tuc
	la	$a0, CONTINUE			
	syscall
	
	li	$v0, 5
	syscall
	
	beq 	$v0, 0, Main
	j	Exit 
	
Exit:
	li	$v0, 10
	syscall
	
# Tim kiem vi tri xuat hien
Search:
	subi	$sp, $sp, 4				
	sw	$ra, 4($sp)
	addi	$s0, $a0, 0				# $s0 = $a0
	addi	$s1, $a1, 0				# $s1 = $a1
	addi	$s3, $a3, 0				# $s3 = $a3 = result array
	li	$s4, 0					# $s4 = len($s3)
	
	addi	$a0, $s0, 0				# Tim va gan do dai chuoi $a0 vao $s2
	jal	Strlen					# 
	addi	$s2, $v0, 0				# $s2 = strlen($a0)
	
	addi	$a0, $s1, 0				# gan chuoi tim kiem cho $a0 de tim do dai chuoi tim kiem
	jal	Strlen					# 
	sub	$s2, $s2, $v0				# $s2 = strlen($a0) - strlen($a1) do dai chuoi thu nhat hon chuoi thu 2
	
	li	$s5, 0					# $s5 = vi tri hien tai trong chuoi $s0

Search_loop:
	bgt  	$s5, $s2, Search_return			# neu i > n
	add	$a0, $s0, $s5				# gan ki tu thu i cho $a0
	addi	$a1, $s1, 0				# gan ki tu dau cho $a1
	jal	Check_string				# goi den ham kiem tra 2 ki tu
	beq	$v0, 0, Check_next_char			# Khong giong thi chuyen sang check kí tu tiep theo
	
	mul 	$t1, $s4, 4 				# 
	add	$t0, $s3, $t1				# Add current offset to the
	sw 	$s5, ($t0)				# integer array $s3
	addi	$s4, $s4, 1				# tang bien counter so luong vi tri tim thay
	
Check_next_char:
	addi	$s5, $s5, 1				# chuyen sang ki tu tiep theo
	j	Search_loop			
	
Search_return:
	addi	$v0, $s4, 0				# return $s4
	lw	$ra, 4($sp)				# lay lai dia chi cho thanh ghi $ra
	addi	$sp, $sp, 4				# Tra la stack
	jr	$ra

# Tim do dai sau
Strlen:
	li	$v0, 0					# i
Strlen_loop:
	add	$t0, $a0, $v0				
	lb 	$t1, ($t0)				
	beq	$t1, 0, Strlen_return			# String rong thi tra ve
	beq	$t1, 0x0A, Strlen_return		# 0x0A ki tu ket thuc
	addi	$v0, $v0, 1				# i++
	j 	Strlen_loop				
Strlen_return:
	jr	$ra

# Kiem tra chuoi con voi chuoi cha xem co giong nhau khong
Check_string:
	subi	$sp, $sp, 12				# Mo rong stack
	sw	$ra, 12($sp)				# Luu dia chi tra ve vi khi goi thanh ghi $ra se bi thay doi dia chi
	sw	$s0, 8($sp)				# luu $S0, $s1 vao stack 
	sw	$s1, 4($sp)				# $s1, $s2 se luu vao $a0 and $a1
	addi	$s0, $a0, 0				# $s0 = $a0
	addi	$s1, $a1, 0				# $s1 = $a1
	
Check_string_loop:
	lb 	$a0, ($s0)				# load gia tri dau cua $s0, $s1
	lb	$a1, ($s1)				# 
	beq	$a1, 0, Check_string_return		# Chuoi rong thi tra lai
	beq	$a1, 0x0a, Check_string_return		# ki tu ket thuc thi tra lai
	jal 	Compare_char				# Neu thoa man thi so sanh 2 ki tu dau tien
	beq	$v0, 0, Check_string_return		
	addi	$s0, $s0, 1				# Tang $s0, $s1
	addi	$s1, $s1, 1				
	j	Check_string_loop			# tiep tuc kiem tra cac ki tu tiep theo
	
Check_string_return:
	lw	$s1, 4($sp)				# tra lai gia tri cu cho $s0, $s1
	lw	$s0, 8($sp)				
	lw	$ra, 12($sp)				# tra lai dia ri tra ve
	addi	$sp, $sp, 12				# Khoi phuc lai thanh ghi $sp
	jr	$ra

# so sanh 2 ki tu
Compare_char:
	beq	$a2, 0, Compare_return			# neu che do la khong phan biet chu hoa chu truong thi bo qua
	beq	$a0, $a1, Compare_return		# Neu 2 ki tu giong nhau thi return  
	bge	$a0, 97, Uppercase			# Nguoc lai se kiem tra neu la chu thuong thi se uppercase, no check 97 truoc nen khong xay ra truong hop la chu hoa
	bge 	$a0, 65, Lowercase			# neu la chu hoa thi se lowercase
	
Uppercase:
	bgt	$a0, 0x7A, Compare_return		# blank if $a0 > 'z', sai nen khong chuyen
	subi	$a0, $a0, 32				# 32 la khoang cach, chuyen $a0 len chu hoa
	j	Compare_return				
	
Lowercase:
	bgt	$a0, 0x5A, Compare_return		# blanl if $a0 > 'Z', sai nen khong chuyen
	addi	$a0, $a0, 32				# 32 la khoang cach, chuyen $a0 xuong chu thuong
	j	Compare_return				
	
Compare_return:						# kiem tra xem 2 ki tu do da giong nhau chua, neu dung tra ve 1, sai tra ve 0
	seq    	$v0, $a0, $a1 	 			#
	jr	$ra					# return address

