.data
	buffer: 	.space 50
	input:		.asciiz "Input string: "
	output:		.asciiz "\nString reverse: "
	
.text
	la 	$s0, buffer 			# dia chi luu tru
	li 	$s1, 0  			# index 
	
	li 	$s2, 20 			# Max of length
	li 	$s3, 10 			# ASCII of enter '\n'
	
	li 	$s4, 0  			# i = 0
	
	li	$v0, 4
	la	$a0, input
	syscall
start_read_char:
	li 	$v0, 12
	syscall
	
	add 	$s1, $s0, $s4  		# index[i]
	addi 	$s4, $s4, 1  	 	# i++
	
	beq 	$v0, $s3, end_of_char 	# end if enter
	beq 	$s4, $s2, end_of_char 	# end if length > 20
	
	sb 	$v0, 0($s1)		#read character in $v0
	j 	start_read_char

end_of_char:
	li	$v0, 4
	la	$a0, output
	syscall
print_resever:
	li 	$v0, 11			# print character
	lb 	$a0, 0($s1)		# load character in $a0
	syscall
	beq 	$s1, $s0, end		# if index = 0 then blanch end
	addi 	$s1, $s1, -1		# i = i - 1
	j 	print_resever		
	
end: