.data

primes: .space 1000

enterSearchLimit: .string "Please enter search limit> "

newline: .string "\n"

findingPrimes: .string "Finding primes... \n"

hitPrime: .string "Hit prime: "

searchLimitTooSmallText: .string "Search Limit is too small. Program exiting.\n"

searchLimitTooBigText: .string "Search Limit is too big. Program exiting.\n"

numberOfPrimes: .string "Number of primes found: "

done: .string "Done\n"

.text 
	
main: 
	# print enter search limit text
	li a7, 4
	la a0, enterSearchLimit
	ecall
	
	#listen after search limit (int)
	li a7, 5
	ecall
	add a1, a0, zero # save input to function argument

	li a7, 4
	la a0, findingPrimes
	ecall	

	jal ra, sieveOfEratosthenes
	nop
	
	li a7, 4
	la a0, done
	ecall
	# assume code executed successfully, exit with code 0
	addi a7, zero, 10
	ecall
	
	
	

sieveOfEratosthenes:
	add s11, a1, zero # save search limit to s11
	add s9, ra, zero # save return address to s9 because we KNOW we will call multiply later
	
	li s1, 1
	li s10, 1000
	# if not ok: print error message, then exit program with code 1
	ble s11, s1,  searchLimitTooSmall
	bgt s11, s10, searchLimitTooBig
	searchLimitOk:
	
	# Serach limit ok. Initialising integer array to ones
	
	la t0, primes # a memory pointer. we will start it at 2 
	# addi t0, t0, 2
	la s0, primes # save the start pointer, we will need it later

	
	# initialise the array with 1's starting at index 2, rest at 0
	sb zero, (t0)
	addi t0, t0, 1
	sb zero, (t0)
	addi t0, t0, 1
	
	# initialise the array to ones from index 2
	
	li t1, 2 # iterator variable
	li t2, 999 # comparison number
	initLoop:
		sb s1, (t0)
		addi t0, t0, 1
		addi t1, t1, 1
		blt t1, t2, initLoop
	
	add t0, s0, zero # reset memory pointer
	addi t0, t0, 1
	li t1, 1
	li t2, 31 # magic number: 31 = int(sqrt(1000)
	primeFinderLoop:
		lb t5, (t0) # t5 = primes[t0]
		beqz t5, endPrimeSetterLoop # go to endPrimeSetterLoop if t5 = 0
		
		# print if hit prime 
		li a7, 4
		la a0, hitPrime
		ecall
		li a7, 1
		add a0, t1, zero
		ecall
		li a7, 4
		la a0, newline
		ecall
		
		add a1, t1, zero
		add a2, t1, zero
		jal ra multiply
		nop
		
		add t4, a6, zero
		primeSetterLoop:
			
			# primes[t4] = 0
			add t6, s0, t4
			sb zero, (t6)
			
			add t4, t4, t1
			ble t4, s11, primeSetterLoop
		endPrimeSetterLoop:
		
		addi t0, t0, 1
		addi t1, t1, 1
		ble t1, s11, primeFinderLoop
	
	
	
	add t0, s0, zero # reset pointer
	add t1, zero, zero # reset iterator to 0
	add s2, zero, zero # s2 is number of primes. Initialise to 0
	printPrimesLoop:
		lb t5, (t0) # t5 = is_prime[0]
		beqz t5, noPrint
			addi s2, s2, 1
		noPrint:
		addi t0, t0, 1
		addi t1, t1, 1
		blt t1, s11, printPrimesLoop
	
	# print number of primes
	li a7, 4
	la a0, numberOfPrimes
	ecall
	li a7, 1
	add a0, s2, zero
	ecall
	li a7, 4
	la a0, newline
	ecall
	
	return:
	jr s9
	
	searchLimitTooSmall:
		# print error message
		li a7, 4
		la a0, searchLimitTooSmallText
		ecall
		
		# Exit with code 1
		li a7, 93
		li a0, 1
		ecall
	
	searchLimitTooBig:
		# print error message
		li a7, 4
		la a0, searchLimitTooBigText
		ecall
		
		# Exit with code 1
		li a7, 93
		li a0, 1
		ecall
		
multiply: # arguments in a1, a2
	add a6, zero, zero #initialize return variable (sum) to 0
	li t1, 0 #t1 is iterator
	blez a2, end_addition_loop
	addition_loop:
		addi t1, t1, 1
		slt t2, t1, a2 # t2 is comparison variable
		
		add a6, a6, a1
		
		bgtz t2, addition_loop
	end_addition_loop:
	jr ra
