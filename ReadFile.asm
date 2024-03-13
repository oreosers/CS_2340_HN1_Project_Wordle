# openFile: 		input is a string containing path to file, then returns file handler
# getRandWord:	 	input is a file handler of format Word1Word2...Wordn where every word is 5 chars long
#			then returns a random letter in that file.
# closeFile:		input is a file handler, close the file with no output.

.globl	openFileReadOnly, closeFile, getRandWord

.data
wordFilePath:	.asciiz		"./WordleWords.txt"	# path of file
currentWord:	.asciiz		"12345"			# placeholder for actual word
userInput:	.asciiz		"12345"			# placeholder for actual user input


.text

# openFileReadOnly
#
# Input:
# - a0: address of null-terminated string of file path
# Output:
# - v0: file descriptor, or -1 if error

openFileReadOnly:

	# Store $ra, $a0, $a1, $a2 to stack
	addi	$sp, 	$sp, 	-8
	sw	$a1, 	0($sp)
	sw	$a2, 	4($sp)
	
	# open file (descriptor stored in $v0)
	li	$v0,	13	# open file syscall code
	li	$a1,	0	# a1 stores flag: read only
	li	$a2,	0	# a2 stores mode (not applicable for read only)
	syscall
	
	# return $ra, $a0, $a1, $a2 from stack then return to 
	lw	$a1,	0($sp)
	lw	$a2,	4($sp)
	addi	$sp,	$sp,	8
	bge	$v0,	$zero,	noErrOpenFile	# check if file is actually opened
	li 	$v0,	-1
noErrOpenFile:
	jr	$ra
	
# getRandWord:
# Receives input as a file descriptor of a file with words length 5 in the form
#
# Word1
# Word2
# Word3
# ...
# Wordn
#
# then returns a 5-character word
# 
# Input:
# - a0: file descriptor (reset to start)
# Output:
# - $v0: address of a 5-word character

# NOTE: NOT DONE

getRandWord:

	# Store file descriptor in stack
	addi	$sp,	$sp,	-4
	sw	$a0,	0($sp)
	
	#determine amount of max words and store it in $t0
	
	# Gets current time as seed
	li	$v0,	30
	syscall				# seed stored in $v0
	move	$a0,	$v0
	li	$v0,	42
	
	
	
	

# closeFile
#
# Input:
# - a0: file descriptor
# Output:
# - N/A
	
closeFile:
	li	$v0,	16
	syscall
	jr 	$ra

