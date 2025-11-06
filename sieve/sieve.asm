.data

primes: .space 1000

enterSearchLimit: .string "Please enter search limit> "

searchLimitTooSmall: .string "Search Limit is too small. Program exiting.\n"

.text 

main: 
	# print enter search limit text
	li a7, 4
	la a0, enterSearchLimit
	ecall
	
	#listen after search limit (int)
	li a7, 5
	ecall
	
	
	add a1, a0, zero
	jal ra, sieveOfEratosthenes
	nop
	# assume code executed successfully, exit with code 0
	addi a7, zero, 10
	ecall
	
	
	

sieveOfEratosthenes:
	li a2, 1
	bgt a1, a2, searchLimitOk
	# if not ok: print error message, then exit program with code 1
	li a7, 4
	la a0, searchLimitTooSmall
	ecall
	li a7, 93
	li a0, 1
	ecall
	
	searchLimitOk:
	
	
	end:
	jr ra
		

