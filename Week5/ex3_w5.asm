.data 
	Message:	.asciiz "Bomon \nKy thuat May tinh" 
.text    
	li	$v0, 4    
	la	$a0, Message    
	syscall     