.data
	chuoi: .asciiz "xin chao moi nguoi \n"
.text
	li $t1, 1 #bien dieu kien lap
	lap: 
		bgt $t1, 5, thoat_lap #dieu kien thoat lap neu ($t1 > 5) --> thoat
		
		#in chuoi ra man hinh
		li $v0, 4
		la $a0, chuoi
		syscall
		
		addi $t1, $t1, 1 #tang bien $t1 len 1
		
		j lap #nhay len lap
	thoat_lap: