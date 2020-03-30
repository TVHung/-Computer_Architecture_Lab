.data

.text
	li $t0, 5
	
	subu 	$sp, $sp, 4
	sw	$t0, ($sp)
	
	addu	$sp, $sp, 4
	lw	$t0, ($sp)
	
	