###########################################################################
# 
#                       EC413
#
#    		Assembly Language Lab -- Programming with Loops.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
Hello:  .asciiz " \n Leonardo Mattos Martins \n"  # declare a zero terminated string
AnInt:	.word	17      # a word initialized to 17
space:	.asciiz	" "	    # declare a zero terminate string
AnotherInt: .word 23	# another word, this time initialized to 23
WordAvg:   .word 0		#use this variable for part 4
ValidInt:  .word 0		#
ValidInt2: .word 0		#
lf:     .byte	10, 0	# string with carriage return and line feed
InLenW:	.word   4       # initialize to number of words in input1 and input2
InLenB:	.word   16      # initialize to number of bytes in input1 and input2
        .align  4       # pad to next 16 byte boundary (address % 16 == 0)
Input1_TAG: .ascii "Input1 starts on next line"
		.align	4
Input1:	.word	0x01020304,0x05060708
	    .word	0x090A0B0C,0x0D0E0F10
        .align  4
Input2_TAG: .ascii "Input2 starts on next line"
        .align  4
Input2: .word   0x01221117,0x090b1d1f   # input
        .word   0x0e1c2a08,0x06040210
        .align  4
Copy_TAG: .ascii "Copy starts on next line"
        .align  4
Copy:  	.space  128		# space to copy input word by word
        .align  4
Input3_TAG: .ascii "Input3 starts on next line"
        .align  4
Input3:	.space	400		# space for data to be transposed
Transpose_TAG: .ascii "Transpose starts on next line"
        .align  4
Transpose: .space 400	# space for transposed data
	.align	4
ArrayLength: .word 10	# length/width of both Input3 and Transpose arrays
	.align  4
#
# The following were added to make the print out to the console a bit nicer
#
divider:	.asciiz "\n===========================================\n"
strTask2: 	.asciiz "TASK 2:\n\n"
strTask3:	.asciiz "TASK 3:\n\n"
strTask4a:	.asciiz "TASK 4a:\n\n"
strTask4b:	.asciiz "TASK 4b:\n\n"
strTask5:	.asciiz "TASK 5:\n\n"
strTask6:	.asciiz "TASK 6:\n\n"
strTask7:	.asciiz "TASK 7:\n\n"
strTask8:	.asciiz "TASK 8:\n\n"
 
############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# print out greeting.  
# Task 2:  change the message so that it prints out your name.
#
main:		
		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		la	$a0,strTask2		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
		
		la	$a0,Hello		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
#
# Print the integer value of AnInt
# Task 3: modify the code so that it prints out two integers
# separated by a space.
#
		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		la	$a0,strTask3		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
		
		lw	$a0,AnInt		# load I/O register with value of AnInt
		li	$v0,1			# system call code for print_int
		syscall				# print the integer
		
		la	$a0,space		# address of space
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		lw	$a0,AnotherInt		# load I/O register with value of AnotherInt
		li	$v0,1			# system call code for print_int
		syscall				# print the integer

#
# Print the integer values of each byte in the array Input1
# Task 4a: modify the code so that it prints spaces between the integers
#
		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		la	$a0,strTask4a		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
		
		la	$s0,Input1		# load pointer to array Input1
		lw	$s1,InLenB		# get length of array Input1 in bytes
task4a:	
		ble	$s1,$zero,done4a	# test if done
		lb	$a0,($s0)		# load next byte into I/O register
		li	$v0,1			# specify print integer
		syscall				# print the integer
	
		la	$a0,space		# address of space
		li	$v0,4			# system call code for print_str
		syscall				# print the string	

		add	$s0,$s0,1		# point to next byte
		sub	$s1,$s1,1		# decrement index variable
		j	task4a			# do it again
done4a:

#
# Task 4b: copy the Task 4 code and paste here.  Modify the code to print
# the array backwards.
#
		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		la	$a0,strTask4b		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
		
		la	$s0,Input1		# load pointer to array Input1
		lw	$s1,InLenB		# get length of array Input1 in bytes
		add	$s0,$s0,$s1		# point to the end of the array
		sub	$s0,$s0,1		
task4b:	
		ble	$s1,$zero,done4b	# test if done
		lb	$a0,($s0)		# load next byte into I/O register
		li	$v0,1			# specify print integer
		syscall				# print the integer
	
		la	$a0,space		# address of space
		li	$v0,4			# system call code for print_str
		syscall				# print the string	

		sub	$s0,$s0,1		# point to next byte
		sub	$s1,$s1,1		# decrement index variable
		j	task4b			# do it again
done4b:
#
# Code for Task 5 -- copy the contents of Input2 to Copy
		la	$s0,Input2		# load pointer to array Input1
		la	$s1,Copy		# load pointer to array Copy
		lw	$s2,InLenB		# get length of array Input1 in bytes
task5:
		ble	$s2,$zero,done5	 	# test if done
		lb	$t0,($s0)		# get the next byte
		sb	$t0,($s1)		# put the byte
		add	$s0,$s0,1		# increment input pointer
		add	$s1,$s1,1		# increment output point
		sub	$s2,$s2,1		# decrement index variable
		j	task5			# continue
done5:
#
# Task 5:  copy the Task 5 code and paste here.  Modify the code to copy
# the data in words rather than bytes.
#
		la	$s0,Input2		# load pointer to array Input1
		la	$s1,Copy		# load pointer to array Copy
		lw	$s2,InLenW		# get length of array Input1 in words
task5b:
		ble	$s2,$zero,done5b	# test if done
		lw	$t0,($s0)		# get the next word
		sw	$t0,($s1)		# put the word
		add	$s0,$s0,4		# increment input pointer
		add	$s1,$s1,4		# increment output point
		sub	$s2,$s2,1		# decrement index variable
		j	task5b			# continue
done5b:
#
# Code for Task 6 -- 
# Print the integer average of the contents of array Input2 (bytes)
#
		la	$s0,Input2		# load pointer to array Input2
		la	$s1,WordAvg		# load pointer to WordAvg
		lw	$s2,InLenB		# get length of array Input2 in words
task6:
		ble	$s2,$zero,done6		# test if done
		lb	$t0,($s0)		# load current word
		lb	$t1,($s1)		# load WordAvg
		add	$t2,$t2,$t0		# add current word to WordAvg
		sb	$t0,($s1)		# store the result
		add 	$s0,$s0,1		# shift pointer to the next word
		sub	$s2,$s2,1		# decrement loop counter
		j	task6	
done6:
		lw 	$s2,InLenB		# load the length again
		div	$t2,$s2			# divide sum by number of words for average
		mflo	$t0

		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		la	$a0,strTask6		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
		
		move	$a0,$t0			# load word average into I/O register
		li	$v0,1			# specify print integer
		syscall				# print the integer


#
# Code for Task 7 --  
# Print the first 25 integers that are divisible by 7 (with spaces)
#
		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		la	$a0,strTask7		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
		
		li	$s0,1			# load loop iterator
		li	$s1,7			# load divisor
		li 	$s2,25			# load loop limit
task7:
		ble	$s2,$zero,done7		# test if done
		div	$s0,$s1
		mfhi	$t0			# compute remainder of division
		
		bne	$t0,$zero,postPrint	# skip printing number if not divisible

		sub	$s2,$s2,1		# decrement loop limit	

		move	$a0,$s0			# copy current number to I/O register 
		li 	$v0,1			# specify print integer
		syscall
		
		la	$a0,space		# address of space
		li	$v0,4			# system call code for print_str
		syscall				# print the string	
postPrint:
		add 	$s0,$s0,1		# increment iterator
		j	task7
done7:

		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
#
# The following code initializes Input3 for Task9
		la	$s0,Input3		# load pointer to Input3
		li	$s1,100			# load size of array in bytes
		li	$t0,3			# start with 3
init8a:
		ble	$s1,$zero,done8a	# test if done
		sb	$t0,($s0)		# write out another byte
		add	$s0,$s0,1		# point to next byte
		sub	$s1,$s1,1		# decrement index variable
		add	$t0,$t0,1		# increase value by 1
		j 	init8a			# continue
done8a:
#
# Code for Task 9 --
# Transpose the 10x10 byte array in Input3 into Transpose
#

		la	$a0,strTask8		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string

		la	$s0,Input3		# load pointer to Input3
		la	$s1,Transpose		# load pointer to Transpose
		lw	$s2,ArrayLength		# load length of the array
		li	$s4,0
outerloop:	
		ble	$s2,$zero,done9		# check if done	
innerloop:
		lw	$s3,ArrayLength
		li	$s5,0
		ble	$s3,$zero,done9b
		lw	$t0,ArrayLength
		mult	$s4,$t0
		mflo	$t1
		add	$t1,$t1,$s5
		mult	$s5,$t0
		mflo	$t2
		add	$t2,$t2,$s4
		lw	$t3,Input3($t1)
		sw	$t3,Transpose($t2)
		j 	innerloop
done9b:
		j	outerloop
		

done9:


		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
# ALL DONE!
		la	$a0,divider		# address of string to print
		li	$v0,4			# system call code for print_str
		syscall				# print the string
Exit:
jr $ra


