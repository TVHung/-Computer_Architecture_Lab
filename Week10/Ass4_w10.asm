.data
	.eqv	KEY_CODE   	0xFFFF0004       		# ASCII code from keyboard, 1 byte      
	.eqv	KEY_READY   	0xFFFF0000			# =1 if has a new keycode ?  
								# Auto clear after lw 
	.eqv 	DISPLAY_CODE   	0xFFFF000C   			# ASCII code to show, 1 byte 
	.eqv 	DISPLAY_READY  	0xFFFF0008   			# =1 if the display has already to do                                  # Auto clear after sw 
 	array: 	.space 		100000
.text             
	li   	$k0, KEY_CODE             
	li   	$k1, KEY_READY                    
	li   	$s0, DISPLAY_CODE              
	li   	$s1, DISPLAY_READY 
 	add 	$t8, $zero, $zero
loop:        
	nop              
WaitForKey:  
	lw   	$t1, 0($k1)            				# $t1 = [$k1] = KEY_READY            
	nop              
	beq  	$t1, $zero, WaitForKey 				# if $t1 == 0 then Polling              \
	nop              
#----------------------------------------------------- 
ReadKey:     
	lw   	$t0, 0($k0)            				# $t0 = [$k0] = KEY_CODE            
	nop
	sw 	$t0, array($t8)
	jal 	compare              
#----------------------------------------------------- 
WaitForDis:  
	lw   	$t2, 0($s1)            				# $t2 = [$s1] = DISPLAY_READY             
	nop 
       	beq  	$t2, $zero, WaitForDis 				# if $t2 == 0 then Polling                         
       	nop                           
#----------------------------------------------------- 
Encrypt:     
	addi 	$t0, $t0, 1            				# change input key              
#----------------------------------------------------- 
ShowKey:     
	sw 	$t0, 0($s0)              			# show key              
	nop            
	j 	loop                 
#-----------------------------------------------------            

# Check Exit
compare:
	add 	$t7 , $t8, $zero
	lw 	$t3, array($t7)
	beq 	$t3, 0x74, continue
	add 	$t8, $t8, 4
	jr 	$ra
continue:
	add 	$t7, $t7, -4
	lw 	$t3, array($t7)
	beq 	$t3, 0x69, continue1 
	add 	$t8, $t8, 4
	j 	WaitForDis
continue1:
	add 	$t7, $t7, -4
	lw 	$t3, array($t7)
	beq 	$t3, 0x78, continue2
	add 	$t8, $t8, 4
	j 	WaitForDis
continue2:
	add 	$t7, $t7, -4
	lw 	$t3, array($t7)
	beq 	$t3, 0x65, exit
	add 	$t8, $t8, 4
	j 	WaitForDis
exit: 
	li 	$v0, 10
	syscall
                                                                                                                  
 
 
