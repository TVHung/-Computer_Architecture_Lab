.data 
	Message:	.asciiz "Bomon \nKy thuat May tinh:"
	Address:	.asciiz " phong 502, B1" 
.text    
	li	$v0, 59    
	la	$a0, Message    
	la	$a1, Address       
	syscall