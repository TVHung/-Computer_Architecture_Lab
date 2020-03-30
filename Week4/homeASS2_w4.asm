#Laboratory Exercise 4, Home Assignment 2 
.data

.text  
	li	$s0, 100 		#load test value for these function  
	andi 	$t0, $s0, 200 		#Extract the LSB of $s0  
	andi 	$t1, $s0, 300 		#Extract bit 10 of $s0 