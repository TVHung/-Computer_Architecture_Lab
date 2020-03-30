.data 
x: .word 0x01020304
message: .asciiz "Bo mon Ky thuat May tinh"

.text
 la $a0, message 
 li $v0, 4
 syscall 

 addi $t1,$zero,2
 addi $t2,$zero,3
 add $t0, $t1, $t2 