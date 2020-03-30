#.data

#.text
#assignment 1
	#li	$s1, 1
	#li	$s2, 2
	#li	$t1, 1
	#li	$t2, 2
	#li	$t3, 3
	#li	$s3, 2
	#li	$s4, 4
#start:	
	#slt 	$t0, $s2, $s1
#assignment 4	
#cau a
	#slt	$t0, $s1, $s2		
#cau b
	#sge	$t0, $s1, $s2		
#cau c
	#add	$t4, $s1, $s2
	#sle 	$t0, $t4, $zero
#cau d
	#add	$t4, $s1, $s2
	#add	$t5, $s3, $s4
	#sgt 	$t0, $t4, $t5

	#bne	$t0, $zero, else	
	#addi 	$t1, $t1, 1		
	#j	endif			
#else: 
	#addi	$t2, $t2, -1		
	#add	$t3, $t3, $t3		
#endif:
#----------------------------------------------------------------------------

#assignment 2
#.data
	#arr:	.word 0, 3, 4, 4, 1, 5, 2
#.text 
	#li	$s1, -1		
	#la	$s2, arr	
	#li	$s3, 2		
	#li 	$s4, 1		
	#li	$s5, 0		
	#li	$t1, 0
#loop:  
	#add	$s1, $s1, $s4  	
	#add	$t1, $s1, $s1  
	#add 	$t1, $t1, $t1  
	#add 	$t1, $t1, $s2 	
	#lw 	$t0, 0($t1)   	
	#add  	$s5, $s5, $t0 	
	#bne 	$s1, $s3, loop 
#assignment 5
#cau a
	#blt 	$s1, $s3, loop
#cau b
	#ble	$s1, $s3, loop
#cau c
	#bge	$s3, $zero, loop
#cau d
	#bne 	$t0, $zero, loop
	
#-----------------------------------------------------------------------------------

#assignment 3
#.data
	#test:	.word
#.text  
	#la	$s0,test  	#load the address of test variable  
	#lw	$s1,0($s0)  	#load the value of test to register $t1  
	#li 	$t0,0   	#load value for test case  
	#li 	$t1,1
	#li 	$t2,2  
	#beq 	$s1,$t0,case_0  
	#beq 	$s1,$t1,case_1  
	#beq 	$s1,$t2,case_2  
	#b 	default 
#case_0:  
	#addi 	$s2,$s2,1  	#a=a+1  
	#b 	continue 
#case_1:  
	#sub 	$s2,$s2,$t1 	#a=a-1  
	#b 	continue 
#case_2:  
	#add 	$s3,$s3,$s3 	#b=2*b  
	#b 	continue 
#default: 
#continue:  
#-----------------------------------------------------------------------------

#assignment 6
.data
	arr:	.word 2, 4, 6, 7, 23, 4, 1, 78, 23, 1309
.text 
	li	$s1, -1		#i
	la	$s2, arr	#load first address of arr in $s2
	li	$s3, 9
	li 	$s4, 1		#step
	li	$s5, 0		#max se duoc luu vao $s5
	li	$t1, 0
#do..while
loop:  
	add	$s1, $s1, $s4  	#i=i+step  
	add	$t1, $s1, $s1  	#t1=2*s1  
	add 	$t1, $t1, $t1  	#t1=4*s1   
	add 	$t1, $t1, $s2 	#t1 store the address of A[i]  
	lw 	$t0, 0($t1)   	#load value of A[i] in $t0  
	#n?u s5 < t0 thì gán s5 = t0
	blt 	$s5, $t0, CHANGEMAX
	blt 	$s1, $s3, loop
	jr	$ra
	
CHANGEMAX: 
	add	$s5, $t0, $zero
	blt 	$s1, $s3, loop
	



