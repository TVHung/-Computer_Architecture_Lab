#----------------------------------------------------------
# Author: Truong Van Hung - 20176776
# Project 4: Postscript CNC Marsbot 
#-----------------------------------------------------------

# Mars bot
	.eqv  	HEADING 			0xffff8010 		# Integer: Goc tu 0 den 359
	.eqv 	LEAVETRACK 			0xffff8020		# Boolean: Co ve hay khong
	.eqv 	WHEREX 				0xffff8030		# Integer: Vi tri x hien tai
	.eqv 	WHEREY 				0xffff8040		# Integer: Vi tri y hien tai
	.eqv 	MOVING 				0xffff8050		# Boolean: Co chuyen dong hay khong
	 
# Digital lab sim
	.eqv	IN_ADRESS_HEXA_KEYBOARD 	0xFFFF0012
	.eqv 	OUT_ADRESS_HEXA_KEYBOARD 	0xFFFF0014

.data
	# postscript-DCE => numpad 0
	postscript1: 	.asciiz 	"90,4000,0;180,4000,0;180,5790,1;80,1000,1;60,1000,1;40,1000,1;20,1000,1;0,1000,1;340,1000,1;320,1000,1;300,1000,1;280,1000,1;90,7000,0;260,1000,1;240,1000,1;220,1000,1;200,1000,1;180,1000,1;160,1000,1;140,1000,1;120,1000,1;100,1000,1;90,4500,0;270,3000,1;0,5800,1;90,3000,1;180,2900,0;270,3000,1;90,4000,0;"
	# postscript-ILoveU => numpad 4
	postscript2: 	.asciiz 	"90,4000,0;180,4000,0;90,3000,1;270,1500,0;180,4000,1;270,1500,0;90,3000,1;90,3000,0;315,2500,1;0,1500,1;45,625,1;90,884,1;135,625,1;45,625,1;90,884,1;135,625,1;180,1500,1;225,2500,1;90,3000,0;0,4000,0;180,4000,1;90,3000,1;0,4000,1;90,1000,0;"
	# postscript-BKHN => numpad 8
	postscript3: 	.asciiz 	"90,4000,0;180,4000,0;180,6000,1;90,2000,1;45,1414,1;0,1000,1;315,1414,1;45,1414,1;0,1000,1;315,1414,1;270,2000,1;90,4000,0;180,6000,1;0,3000,0;135,4242,1;315,4242,0;45,4242,1;90,1000,0;180,6000,1;0,3000,0;90,3000,1;0,3000,0;180,6000,1;90,1000,0;0,6000,1;153,6708,1;0,6000,1;90,1000,0;"

.text
	li 	$t3, IN_ADRESS_HEXA_KEYBOARD		# Dia chi vao ra cua digital lab sim
	li 	$t4, OUT_ADRESS_HEXA_KEYBOARD		
	
POLLING: 
	li 	$t5, 0x1 				# check row 1 with key 0, 1, 2, 3	
	sb 	$t5, 0($t3) 				# gan lai hang du kien 1
	lb 	$a0, 0($t4) 				# read scan code of key button
	bne  	$a0, 0x11, NOT_NUMPAD_0	
	la 	$a1, postscript1			
	j 	START
	
NOT_NUMPAD_0:
	li 	$t5, 0x2 				# check row 2 with key 4, 5, 6, 7	
	sb 	$t5, 0($t3)				# gan lai hang du kien 2
	lb 	$a0, 0($t4)				# read scan code of key button
	bne 	$a0, 0x12, NOT_NUMPAD_4
	la 	$a1, postscript2			
	j 	START
	
NOT_NUMPAD_4:
	li 	$t5, 0x4 				# check row 3 with key 8, 9, a, b	
	sb 	$t5, 0($t3)				# gan lai hang du kien 3	
	lb 	$a0, 0($t4)				# read scan code of key button
	bne 	$a0, 0x14, BACK_TO_POLLING
	la 	$a1, postscript3			
	j 	START
	
BACK_TO_POLLING: 
	j 	POLLING 				# Neu cac phim chua duoc nhan thi quay lai

START:
	jal 	GO
	
READ_PSCRIPT: 
	addi 	$t0, $zero, 0 				# bien goc
	addi 	$t1, $zero, 0 				# bien thoi gian
	
READ_ROTATE:
 	add 	$t7, $a1, $t6 				# gan dia chi a1 cho thanh ghi t7
	lb  	$t5, 0($t7)  				# doc cac ki tu cua pscript (doc goc)
	beq 	$t5, 0, END 				# ket thuc pscript
 	beq 	$t5, 44	, READ_TIME 			# gap ki tu ',', chuyen sang doc thoi gian
 	mul  	$t0, $t0, 10				# Moi khi doc duoc so moi thi x10 cac so da doc duoc
 	addi 	$t5, $t5, -48 				# chuyen ve so
 	add 	$t0, $t0, $t5  				# cong cac chu so lai voi nhau.
 	addi 	$t6, $t6, 1 				# tang so bit can dich chuyen len 1
 	j 	READ_ROTATE 				# quay lai doc tiep den khi gap dau ','
 	
READ_TIME: 						# doc thoi gian chuyen dong.
 	add 	$a0, $t0, $zero
	jal 	ROTATE
 	addi 	$t6, $t6, 1
 	add 	$t7, $a1, $t6 				# ($a1 luu dia chi cua pscript)
	lb 	$t5, 0($t7) 
	beq 	$t5, 44, READ_TRACK			# Kiem tra neu ki tu tiep theo là dau ',' thi doc TRACK
	mul 	$t1, $t1, 10
 	addi 	$t5, $t5, -48
 	add 	$t1, $t1, $t5
 	j 	READ_TIME 				# quay lai doc tiep den khi gap dau ','
 	
READ_TRACK:
 	addi 	$v0,$zero,32 				# Keep mars bot running by sleeping with time = $t1
 	add 	$a0, $zero, $t1				
 	addi 	$t6, $t6, 1 
 	add 	$t7, $a1, $t6
	lb 	$t5, 0($t7) 				
 	addi 	$t5, $t5, -48
 	beq 	$t5, $zero, CHECK_UNTRACK 		# 1 = track, 0 = untrack
 	jal 	UNTRACK
	jal 	TRACK
	j 	INCREAMENT
	
CHECK_UNTRACK:
	jal 	UNTRACK
	
INCREAMENT:
	syscall
 	addi 	$t6, $t6, 2 				# bo qua dau ';'
 	j	READ_PSCRIPT
 	
#-----------------------------------------------------------
# GO procedure, to start running				
# param[in] none
#-----------------------------------------------------------
GO: 							
 	li 	$at, MOVING 				# change MOVING port
 	addi 	$k0, $zero, 1 				# to logic 1,
 	sb 	$k0, 0($at) 				# to start running
 	jr 	$ra
 	
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------
STOP: 							
	li 	$at, MOVING 				# change MOVING port to 0
 	sb 	$zero, 0($at)				# to stop
 	jr 	$ra
 	
#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#----------------------------------------------------------- 
TRACK: 						
	li 	$at, LEAVETRACK 			# change LEAVETRACK port
 	addi 	$k0, $zero, 1 				# to logic 1,
	sb 	$k0, 0($at) 				# to start tracking
 	jr 	$ra
 	
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#----------------------------------------------------------- 
UNTRACK:					
	li 	$at, LEAVETRACK 			# change LEAVETRACK port to 0
 	sb 	$zero, 0($at) 				# to stop drawing tail
 	jr 	$ra
 	
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: 
	li 	$at, HEADING 				# change HEADING port
 	sw 	$a0, 0($at) 				# to rotate robot	
 	jr 	$ra
 	
END:
	jal 	STOP		
	li 	$v0, 10
	syscall
	j 	POLLING
