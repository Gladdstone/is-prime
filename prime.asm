# FILE:         $File$
# AUTHOR:       P. White
# CONTRIBUTORS: M. Reek
# 		Joseph Farrell
#
# DESCRIPTION:
#  	This is a simple program to find the prime numbers between 3 - 101
#	inclusive.  This is done by using the simple algorithm where a 
#	number 'n' is prime if no number between 2 and n-1 divides evenly 
#	into 'n'
#
# ARGUMENTS:
#       None
#
# INPUT:
#	none
#
# OUTPUT:
#	the prime numbers printed 1 to a line
#
# REVISION HISTORY:
#       Dec  03         - P. White, created program
#       Mar  04         - M. Reek, added named constants
#

#
# CONSTANT DECLARATIONS
#
PRINT_INT	= 1		# code for syscall to print integer
PRINT_STRING	= 4		# code for syscall to print a string
MIN		= 3		# minimum value to check
MAX		= 102		# max value to check

#
# DATA DECLARATIONS
#
	.data
newline:
	.asciiz "\n"
#
# MAIN PROGRAM
#
	.text
	.align	2
	.globl	main
main:
        addi    $sp,$sp,-8  	# space for return address/doubleword aligned
        sw      $ra, 0($sp)     # store the ra on the stack

	jal	find_primes

        #
        # Now exit the program.
	#
        lw      $ra, 0($sp)	# clean up stack
        addi    $sp,$sp,8
        jr      $ra

#
# Name:		find_primes 
#
# Description:	find the prime numbers between 3 and 101 inclusive
# Arguments:	none
# Returns:	nothing
#

find_primes:
        addi    $sp,$sp,-40     # allocate stack frame (on doubleword boundary)
        sw      $ra, 32($sp)    # store the ra & s reg's on the stack
        sw      $s7, 28($sp)
        sw      $s6, 24($sp)
        sw      $s5, 20($sp)
        sw      $s4, 16($sp)
        sw      $s3, 12($sp)
        sw      $s2, 8($sp)
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

# ######################################
# ##### BEGIN STUDENT CODE BLOCK 1 #####


# ###### END STUDENT CODE BLOCK 1 ######
# ######################################


        lw      $ra, 32($sp)    # restore the ra & s reg's from the stack
        lw      $s7, 28($sp)
        lw      $s6, 24($sp)
        lw      $s5, 20($sp)
        lw      $s4, 16($sp)
        lw      $s3, 12($sp)
        lw      $s2, 8($sp)
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp,$sp,40      # clean up stack
	jr	$ra

#
# Name:		is_prime 
#
# Description:	checks to see if the num passed in is prime
# Arguments:  	a0	The number to test to see if prime
# Returns: 	v0	a value of 1 if the number in a0 is prime
#			a value of 0 otherwise
#

is_prime:
        addi    $sp,$sp,-40    	# allocate stackframe (doubleword aligned)
        sw      $ra, 32($sp)    # store the ra & s reg's on the stack
        sw      $s7, 28($sp)
        sw      $s6, 24($sp)
        sw      $s5, 20($sp)
        sw      $s4, 16($sp)
        sw      $s3, 12($sp)
        sw      $s2, 8($sp)
        sw      $s1, 4($sp)
        sw      $s0, 0($sp)

# ######################################
# ##### BEGIN STUDENT CODE BLOCK 2 #####

		addi $s0, $zero, 2					# s0 = 0
		loop:								
			slt $t0, $s0, $a0				# if(s0 < a0) { t0 = 1 }
			beq $t0, $zero, return_true		# if(t0 == 0) { goto return_true }
			div $a0, $s0					# lo = a0 / s0, hi = a0 % s0
			mfhi $t1						# t1 = hi
			beq $t1, $zero, return_false	# if(t1 == 0) { goto return_false }
			addi $s0, $s0, 1				# s0++
			j loop							# goto loop
		return_true:
			addi $v0, $zero, 1				# v0 = 1
			j done							# goto done
		return_false:
			addi $v0, $zero, 0				# v0 = 0
			j done							# goto done
		done:

# ###### END STUDENT CODE BLOCK 2 ######
# ######################################

        lw      $ra, 32($sp)    # restore the ra & s reg's from the stack
        lw      $s7, 28($sp)
        lw      $s6, 24($sp)
        lw      $s5, 20($sp)
        lw      $s4, 16($sp)
        lw      $s3, 12($sp)
        lw      $s2, 8($sp)
        lw      $s1, 4($sp)
        lw      $s0, 0($sp)
        addi    $sp,$sp,40      # clean up the stack
	jr	$ra

#
# Name;		print_number 
#
# Description:	This routine reads a number then a newline to stdout
# Arguments:	a0,the number to print
# Returns:	nothing
#
print_number:

        li 	$v0,PRINT_INT
        syscall			#print a0

        la	$a0, newline
        li      $v0,PRINT_STRING
        syscall			#print a newline

        jr      $ra
