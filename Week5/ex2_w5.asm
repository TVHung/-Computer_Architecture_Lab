.data 
	Message: .asciiz "Ngay sinh cua Hung la " 
.text    
	li	$v0, 56               
	la	$a0, Message    
	li	$a1, 1309       	# the interger to be printed is 0x307    
	syscall              		# execute 