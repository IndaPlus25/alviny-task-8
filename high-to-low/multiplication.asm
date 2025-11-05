# Multiplication.asm
.data
	multiply_string: .string "13 * 17 = "
	newline: .string "\n"
	factorial_string: .string "7! = "
	

.text


.main:
	li a1, 13
	li a2, 17
	jal ra, multiply
	nop
	
	add s0, t0, zero # save product to s0
	
	# print multiplication string
	li a7, 4
	la a0, multiply_string
	ecall
	li a7, 1
	add a0, s0, zero
	ecall
	li a7, 4
	la a0, newline
	ecall
	
	li a1, 7
	jal ra, factorial
	
	
	add s1, t0, zero # save factorial to s1
	
	# printStr(factorial_string)
	li a7, 4
	la a0, factorial_string
	ecall
	li a7, 1
	add a0, s1, zero
	ecall
	li a7, 4
	la a0, newline
	ecall
		
	li a7, 10 # exit
	ecall
multiply: # arguments in a1, a2
	add t0, zero, zero #initialize return variable (sum) to 0
	li t1, 0 #t1 is iterator
	blez a2, end_addition_loop
	addition_loop:
		addi t1, t1, 1
		slt t2, t1, a2 # t2 is comparison variable
		
		add t0, t0, a1
		
		bgtz t2, addition_loop
	end_addition_loop:
	jr ra


	
	
factorial: # argument in a1
	li s11, 1
	add s10, a1, zero # save a1 to s10
	addi s9, zero, 1 # s9 is always 1
	add a6, a1, zero # a6 is an iterator
	add t6, ra, zero
	factorial_loop:
		add a1, s11, zero
		add a2, a6, zero
		jal ra, multiply
		add s11, t0, zero
		
		addi a6, a6, -1
		bgt a6, s9, factorial_loop
	end_factorial_loop:
	
	# move the product to return address
	add s11, t0, zero
	jr t6