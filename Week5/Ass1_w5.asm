#Laboratory Exercise 5, Assignment 1 
.data 
	test:	.asciiz "Truong Hung Viet Nhat C" 
.text    
	li 	$v0, 4    
	la 	$a0, test    
	syscall     