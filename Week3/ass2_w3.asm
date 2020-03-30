.data
	arr:	.word 0, 3, 4, 4, 1, 5, 2
.text 
	li	$s1, 0		#i
	la	$s2, arr	#load first address of arr in $s2
	li	$s3, 3		#n
	li 	$s4, 1		#step
	li	$s5, 0		#sum
	li	$t1, 0
#do..while
loop:  
	add	$s1, $s1, $s4  	#i=i+step  
	add	$t1, $s1, $s1  	#t1=2*s1  
	add 	$t1, $t1, $t1  	#t1=4*s1   
	add 	$t1, $t1, $s2 	#t1 store the address of A[i]  
	lw 	$t0, 0($t1)   	#load value of A[i] in $t0  
	add  	$s5, $s5, $t0 	#sum=sum+A[i]  
	bne 	$s1, $s3, loop  #if i != n, goto loop 
