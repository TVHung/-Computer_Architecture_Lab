.data 
	A: 	.word 3, -2, 8, 1, 6, 6, 2, 62, 6, 44, 8, 12, 5 
	Aend:   .word   
.text 
main:       
	la   	$a0,A           	#$a0 = Address(A[0]) 
	la   	$a1,Aend        					#load dia chi phan tu cuoi cho a1 la A[n]
	addi 	$a1,$a1,-4      	#$a1 = Address(A[n-1])        	#load a1 = A[n-1]
	j    	sort            	#sort 
after_sort: 
	li   	$v0, 10         	#exit             
	syscall 
end_main: 

sort:       
	beq   	$a0,$a1,done 		#single element list is sorted             
	j   	max        		#call the max procedure 
after_max:  
	lw   	$t0,0($a1) 		#load last element into $t0      	#load gia tri n vao t0       
	sw   	$t0,0($v0) 		#copy last element to max location      #
	sw   	$v1,0($a1) 		#copy max value to last element             
	addi    $a1,$a1,-4      	#decrement pointer to last element             
	j   	sort  			#repeat sort for smaller list 
done:       
	j	after_sort 
max:  
	addi 	$v0,$a0,0         	#init max pointer to first element   	#gan v0 la phan tu dau tien
	lw    	$v1,0($v0)        	#init max value to first value  	#khoi tao gia tri cho max 
	addi 	$t0,$a0,0         	#init next pointer to first 		
loop:  
	beq 	$t0,$a1,ret       	#if next=last, return  			#neu t0 la ptu cuoi cung thi thoat
	addi 	$t0,$t0,4         	#advance to next element  		#neu t0 chua phai pt cuoi thi nhay den pt tiep theo
	lw 	$t1,0($t0)        	#load next element into $t1  		#load gia tri cua no vao t1
	slt 	$t2,$t1,$v1       	#(next)<(max) ?  			#neu t1 < max hien tai thi t1 = 1
	bne 	$t2,$zero,loop 		#if (next)<(max), repeat  		#neu t2 = 1 thi chay lai loop
	addi 	$v0,$t0,0       	#next element is new max element  	#
	addi 	$v1,$t1,0       	#next value is new max value   		#neu t2 = 0 thi cap nhat gia tri max moi
	j loop            	 	#change completed; now repeat 
ret:  
	j     after_max 