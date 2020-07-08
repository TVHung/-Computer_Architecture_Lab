.eqv SEVENSEG_LEFT    0xFFFF0011	# Dia chi cua den led 7 doan TRAI	
					# Bit 0 = doan a         
					# Bit 1 = doan b	
					# Bit 7 = dau . 
.eqv SEVENSEG_RIGHT   0xFFFF0010 	# Dia chi cua den led 7 doan PHAI
					# Tuong tu den led TRAI 
.eqv KEY_CODE   0xFFFF0004         	# ASCII code from keyboard, 1 byte 
.eqv KEY_READY  0xFFFF0000        	# =1 if has a new keycode ?                                  
				        # Auto clear after lw  
.eqv DISPLAY_CODE   0xFFFF000C   	# ASCII code to show, 1 byte 
.eqv DISPLAY_READY  0xFFFF0008   	# =1 if the display has already to do  
	                                # Auto clear after sw  
.eqv MASK_CAUSE_KEYBOARD   0x0000034    # Keyboard Cause    
  
.data 
number: 	.byte 	63, 6, 91, 79, 102, 109, 125, 7, 127, 111 	# dia chi cac gia tri cac chu so hien thi tren den led tu 0 den 9
saveString : 	.space 	1000						# bo nho luu cac ky tu nhap vao.
sourceString : 	.asciiz "bo mon ky thuat may tinh"			# xau cho san 
Message1:	.asciiz "\n\nXau vua nhap vao la: "
Message2: 	.asciiz "\nSo ky tu nhap trong giay thu "
Message3:	.asciiz " la: "
numberRightKey: .asciiz "\nSo ky tu nhap dung la: "  

#-----------------------------------------------------------------
# Chuong trinh do toc do so ky tu duoc nhap vao trong 1 giay
# va hien thi so ky tu go dung ra ngoai man hinh dung den LED
# Ham main
# $k0: luu gia tri cua ky tu nhap vao
# $k1: luu gia tri key_ready (1 hoac 0) 
# $s0: luu gia tri cua ky tu de in ra 
# $s1: luu gia tri display_ready  
#----------------------------------------------------------------- 
.text
	li   	$k0, KEY_CODE              
	li   	$k1, KEY_READY                    
	li   	$s0, DISPLAY_CODE              
	li   	$s1, DISPLAY_READY  	
Main:         
	li   	$s3, 0			# dem so vong lap
	li   	$s4, 0 			# dem toan bo so ky tu nhap vao 
	li	$s5, 0			# dem so giay
 	li  	$t4, 10			# $t4 = 10 de thuc hien phep chia de hien thi ra den LED	
  	li   	$t5, 100		# luu gia tri so vong lap. 
	li   	$t6, 0			# dem so ky tu nhap duoc trong 1s

Loop: nop      
WaitForKey:  
 	lw   	$t1, 0($k1)             # $t1 = [$k1] = KEY_READY              
	beq  	$t1, $zero, Done_1s     # if $t1 == 0 then Polling             
MakeIntR:
	addi 	$t6, $t6, 1    		# tang bien dem ky tu nhap vao trong 1s len 1
	teqi 	$t1, 1                  # if $t0 = 1 then raise an Interrupt    

# Nhan Done_1s dung de xac dinh chuong trinh chay duoc 1s hay chua
Done_1s:          
	addi    $s3, $s3, 1      	# dem so ky tu nhap vao tu ban phim
	div 	$s3, $t5		# xac dinh da duoc 1s hay chua bang phep chia
	mfhi 	$t7			# lay phan du
	bne 	$t7, 0, Sleep		# neu chua duoc 1s thi nhay toi sleep
					# neu da duoc 1s thi in ra so ky tu nhap duoc trong 1s
					
# In ra so ky tu nhap duoc trong 1s
Print:
	addi	$s5, $s5, 1		# Tang giay len 1
	li 	$s3, 0			# reset $s3 ve 0 de dem lai so vong lap
	li 	$v0, 4			
	la 	$a0, Message2
	syscall	
	li	$v0, 1
	add	$a0, $zero, $s5
	syscall
	li 	$v0, 4			
	la 	$a0, Message3
	syscall
	li    	$v0, 1            	# in ra so ky tu trong 1s
	add   	$a0, $t6, $zero    		
	syscall
	add	$t6, $zero, $zero	# reset bien dem so ky tu nhap vao trong 1s ve 0
	b	Loop			# tro ve vong lap
	
# Chuong trinh ngu trong moi 10ms
Sleep:  
	addi    $v0, $zero, 32                   
	li      $a0, 10              	# sleep 10 ms         
	syscall         
	nop           	          	# WARNING: nop is mandatory here.          
	b       Loop         	 	# quay lai vong lap
	
End_main: 
	li 	$v0, 10
	syscall 

# Hien thi so ky tu nhap dung ra ngoai man hinh
# Dung phep chia de xac dinh chu so ben trai va bien phai cua den LED
Digital: 
	div 	$t3, $t4		# lay so ky tu nhap dung chia cho 10
	mflo 	$t7			# luu gia tri phan nguyen -> duoc luu o den LED trai
	la 	$s2, number		# lay dia chi cua danh sach luu gia tri cua tung chu so den LED
	add 	$s2, $s2, $t7		# xac dinh dia chi cua gia tri 
	lb 	$a0, 0($s2)                      
	jal   	SHOW_7SEG_LEFT       	# ngay den nhan in ra den LED trai

	mfhi 	$t7			# luu gia tri phan du -> duoc luu o den LED phai
	la 	$s2, number		# lay dia chi cua danh sach luu gia tri cua tung chu so den LED	
	add 	$s2, $s2, $t7		# xac dinh dia chi cua gia tri
	lb 	$a0, 0($s2)                        
	jal  	SHOW_7SEG_RIGHT      	# nhay den nhan in ra den LED phai                                      
	j	End_main

# in so ra 2 den LED	
SHOW_7SEG_LEFT:  
	li   $t0,  SEVENSEG_LEFT 	# assign port's address                   
	sb   $a0,  0($t0)        	# assign new value                    
	jr   $ra 
	
SHOW_7SEG_RIGHT: 
	li   $t0,  SEVENSEG_RIGHT 	# assign port's address                  
	sb   $a0,  0($t0)         	# assign new value                   
	jr   $ra 
#---------------------------------------------------------------
# Interrupt subroutine
#---------------------------------------------------------------
# Khi ngat se goi den day
.ktext    0x80000180         		         
	mfc0  $t1, $13                  	# nguyen nhan tham chieu dia chi bo nho khong hop le
	li    $t2, MASK_CAUSE_KEYBOARD 		# loi do nhap vao tu ban phim?             
	and   $at, $t1,$t2              
	beq   $at, $t2, Counter_Keyboard        # dung la loi nhap vao tu ban phim    
	j    end_process  			# neu khong phai, nhay ve chuong trinh cu

# doc va in ky tu nhap vao ra man hinh
Counter_Keyboard: 
ReadKey:  lb   	$t0, 0($k0)            	# $t0 = [$k0] = KEY_CODE 
	  nop
WaitForDis: 
	  lw   	$t2, 0($s1)            	# $t2 = [$s1] = DISPLAY_READY            
	  beq  	$t2, $zero, WaitForDis	# if $t2 == 0 then Polling                             
ShowKey: 
	  sb 	$t0, 0($s0)             # hien thi ky tu vua nhap tu ban phim tren man hinh MMIO
          la  	$t7, saveString		# $t7 luu dia chi co so cua chuoi nhap vao
          add 	$t7, $t7, $s4		# tang dia chi co so chuoi nhap vao len
          sb 	$t0, 0($t7)		# luu ky tu vao dia chi tuong ung
          nop
          addi 	$s4, $s4, 1		# tang so ky tu da nhap vao len 1
          beq 	$t0, 10, end		# ky tu nhap vao la Enter thi bat dau xet                           
end_process:                         
next_pc:  mfc0    $at, $14	        # $at <= Coproc0.$14 = Coproc0.epc              
	  addi    $at, $at, 4	        # $at = $at + 4 (next instruction)              
          mtc0    $at, $14	       	# Coproc0.$14 = Coproc0.epc <= $at  
return:   eret                       	# Return from exception

# khi ky tu nhap vao la Enter thi bat dau xet so cac ky tu nhap dung
end:
	li 	$v0, 4
	la 	$a0, Message1
	syscall
	li 	$t1, 0 			# $t1 luu so ky tu da xet
	li 	$t3, 0                  # $t3 luu so ky tu nhap dung
	li 	$t8, 24			# $t8 luu do dai cua xau nguon
	slt 	$t7, $s4, $t8		# so sanh do dai xau nhap vao va do dai cua xau nguon
	bne 	$t7, 1, CheckInputString	
	add 	$t8, $0, $s4
	addi 	$t8, $t8, -1		# bo vi tri ky tu cuoi cung la dau enter
CheckInputString:			
	la 	$t2, saveString
	add 	$t2, $t2, $t1
	li 	$v0, 11			# in ra cac ky tu da nhap tu ban phim.
	lb 	$t5, 0($t2)		# lay ky tu thu $t1 trong saveString luu vao $t5
	move 	$a0, $t5
	syscall 
	la 	$t4, sourceString
	add 	$t4, $t4, $t1
	lb 	$t6, 0($t4)		# lay ky tu thu $t1 trong sourceString luu vao $t6
	bne 	$t6, $t5, Continue	# neu 2 ky tu thu $t1 khong giong nhau thi nhay den Continue
	addi 	$t3, $t3, 1		# tang so ky tu nhap dung len 1
Continue: 
	addi 	$t1, $t1, 1		# sau khi so sanh 1 ky tu, tang bien dem len 
	beq 	$t1, $t8, Result	# neu la ky tu cuoi cung thi nhay den nhan Result de in ket qua
	j 	CheckInputString	# quay lai xet tiep cac ky tu con lai
Result:	
	li 	$v0, 4
	la 	$a0, numberRightKey	# in loi nhan
	syscall
	li 	$v0, 1
	add 	$a0, $0, $t3		# in so ky tu nhap dung
	syscall
	li 	$t4, 10			# reset gia tri cho $t4
	b 	Digital 
