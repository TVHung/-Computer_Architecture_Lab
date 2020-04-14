.data 
	A: .word 	1, 2, 5, -4, 6, -3 
.text 
main:       
	la 	$a0,A             
	li 	$a1,6             
	j     	mspfx             
	nop
continue: 
lock:       
	j  lock              
	nop 
end_of_main:

#-------------------------------------------------------------- 
#procedure sort (ascending selection sort using pointer) 
#register usage in sort program #$a0 pointer to the first element in unsorted part 
#$a1 pointer to the last element in unsorted part 
#$t0 temporary place for value of last element 
#$v0 pointer to max element in unsorted part 
#$v1 value of max element in unsorted part 
#-------------------------------------------------------------- 

mspfx:  
	addi 	$v0,$zero,0 		#initialize length in $v0 to 0         
	addi 	$v1,$zero,0 		#initialize max sum in $v1to 0         
	addi 	$t0,$zero,0 		#initialize index i in $t0 to 0         
	addi 	$t1,$zero,0 		#initialize running sum in $t1 to 0 
loop: 
	add  	$t2,$t0,$t0       	#put 2i in $t2       
	add 	$t2,$t2,$t2      	#put 4i in $t2  
	add 	$t3,$t2,$a0       	#put 4i+A (address of A[i]) in $t3  	#cong dia chi m?i l?n t?ng 4
	lw 	$t4,0($t3)  		#load A[i] from mem(t3) into $t4  	#gan gia tri A[i] cho $t4
	add 	$t1,$t1,$t4       	#add A[i] to running sum in $t1   	#cong tong dang chay
	slt 	$t5,$v1,$t1       	#set $t5 to 1 if max sum < new sum  	#tong moi lon hon maxsum hien tai thi $t5 = 1
	bne 	$t5,$zero,mdfy  	#if max sum is less, modify results  	#neu t5 = 0 thi chuyen sang mdfy ngc lai ch?y tiep
	j 	test        		#done? 
mdfy: 
	addi 	$v0,$t0,1  		#new max-sum prefix has length i+1  	#do dai tong max tang 1
	addi 	$v1,$t1,0  		#new max sum is the running sum 	#gan gai tri max moi cho v1
test: 
	addi 	$t0,$t0,1  		#advance the index i  			#tang bien i
	slt 	$t5,$t0,$a1      	#set $t5 to 1 if i<n  			#neu i < n thi t5 = 1
	bne 	$t5,$zero,loop 		#repeat if i<n 				#neu t5 = 1 tuc la chua het ptu thi lap lai 
done: 
	j     	continue
mspfx_end:













