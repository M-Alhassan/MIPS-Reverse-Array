.macro	exit
	li $v0, 10
	syscall
.end_macro
#--------------------------data segment-------------------------
	.eqv N 20
.data
	array: .word 0:N

#--------------------------text segment-------------------------
.text
    
	la $a0, array
	li $a1, N
	jal generateArray
	
	la $a0, array
	li $a1, N
	jal displayArray
	
	la $a0, array
	li $a1, N
	jal reverseArray
	
	la $a0, '\n'
	li $v0, 11
	syscall
	

	la $a0, array
	li $a1, N
	jal displayArray
	
	exit
#--------------------------func segment-------------------------
generateArray:
	li $t0, 0
	move $t2, $a1
	move $t1, $a0 
l1:

	li $v0, 42 
	li $a0, 0x505
	li $a1, 100
	syscall
	sw    $a0, 0($t1)
	addiu $t0, $t0, 1
	addiu $t1, $t1, 4
	blt   $t0, $t2, l1
	jr    $ra 

displayArray:
	li $t0, 0 
	move $t1, $a0 
	move $t2, $a1
	l2:
	lw $t3, 0($t1)
	
	li $v0, 1
	la $a0, ($t3)
	syscall
	
	la $a0, ' '
	li $v0, 11
	syscall
	
	addiu $t0, $t0, 1
	addiu $t1, $t1, 4
	blt   $t0, $t2, l2 
	jr    $ra
		
reverseArray:
	li   $t0, 0 
	move $t1, $a0 
	move $t2, $a1
	l3:
	lw    $t3, 0($t1)
	addi  $sp, $sp, -4
	sw    $t3, 0($sp)
	addiu $t0, $t0, 1
	addiu $t1, $t1, 4
	blt   $t0, $t2, l3
	
	li   $t0, 0
	move $t1, $a0
	l4:
     lw    $t3, 0($sp)
	addi  $sp, $sp, 4
	sw    $t3, 0($t1)
	addiu $t0, $t0, 1
	addiu $t1, $t1, 4
	blt   $t0, $t2, l4
	jr    $ra