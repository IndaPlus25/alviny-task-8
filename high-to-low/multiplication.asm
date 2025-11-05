# Multiplication.asm
.data
	multiply_string: .string "13 * 17 = "
	newline: .string "\n"
	

.text

.main:
	li a1, 2
	li a2, 0
	jal ra, multiply
	nop
	
	add s0, t0, zero
	
	li a7, 10 # exit
	ecall
	
do_if_greaterthan_zero:
	add t5, ra, zero
	jal ra, addition_loop
	jr t5
	nop
multiply: # arguments in a1, a2
	
	li t0, 0 #t0 is the sum
	li t1, 0 #t1 is iterator
	add t6, ra, zero
	bgtz a2, do_if_greaterthan_zero
	jr t6
	nop

addition_loop:
	
	addi t1, t1, 1
	slt t2, t1, a2
	add t0, t0, a1
	li a7, 1
	add a0, t0, zero
	ecall
	
	bgtz t2, addition_loop
	jr ra
	nop
	
	

	
	# set t0 = 0, then add a0 to t0 a1 times
	
	
.factorial: # arguments in a0, a1
	# li t1, zero
	
