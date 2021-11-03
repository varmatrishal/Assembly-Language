# File Name: recursive.pgm2.asm
# Author: Trishal Varma

#Modification History: 
	#September 25th 2019: Code is writtne.  
	#September 26th 2019: Code was revised, and minor changes were made. 
	#November 2nd 2021: Code updated for github
	
#Procedures: 
	#data:   Input prompt allowing user to enter an integer.  
	#text:   System call on printing the user's input of integer. 
	


#Author: Trishal Varma - txv130330@utdallas.edu 

#Description: Entering the input number, then displaying the inputted number.  
#Arguments: none.

		

.data
request: .asciiz "\nEnter 1st integer: "
request1: .asciiz "\nEnter 2nd integer: "


#Author: Trishal Varma - txv130330@utdallas.edu
#Modification History:
	#This code was written on September 25th 2019. No changes made to the code other than revision.
#Description: code to print the inputted number. 
#Arguments: $a0 - places the input to print. 



.text

li $v0,4 #user input
la $a0,request #la $a0, request will allow the print
syscall # executing the system call
li $v0,5
syscall #allowing user to enter the input
move $t0,$v0 


li $v0,4
la $a0,request1 #requests will allow the second integer to be entered. 
syscall #executing the system call
li $v0,5
syscall #allowing userto enter the input. 
move $t1,$v0

move $a0,$t0 #this passes the integer parameter to func. 
move $a1,$t1 #does the same, pass parameter to function
jal RecurseFunc #jal : is the recurssion call
move $s3,$v0 #move gets the result
move $a0,$s3 #copies a value from one register to another. 
li $v0,1 #loading the speceific number value to the register. 
syscall


li $v0,10 #load immediate to terminate
syscall


RecurseFunc :
subu $sp,$sp,4 # No overflow trap, points to a new place for the integer.
sw $ra,($sp) # storeword, new content moves to top. 
subu $sp,$sp,4 # point to a new place. 
sw $a0,($sp) # stores the contents of $a0
subu $sp,$sp,4 # subtracting two registers. pointing to the new item
sw $a1,($sp) # storeword, new content to $t5. 

blt $a0,1,zeroValue #checking the termination conditon. 

sub $a0,$a0,1 #(dn-1)
add $a1,$a1,1 #(up+1)
jal RecurseFunc
move $s0,$v0
add $a0,$a0,1 #(dn-1)
sub $a1,$a1,1 #(up+1)

mul $t0,$a0,$a1
add $v0,$s0,$t0
j ifExit

j ifExit
zeroValue:
li $v0,0 #loads the 0. 
j ifExit


ifExit:
lw $a1,($sp)   # stores the contents of $ra to the top of stack.
addu $sp,$sp,4 # addu - points to the content at the top of the stacik. 
lw $a0,($sp)   # stores the contents of $ra to the top of the stack (new). 
addu $sp,$sp,4 # again points to the content at the top of the stack. 
lw $ra,($sp)   # stores to the top of the staick. 
addu $sp,$sp,4 # points to the stop of the stack. 
jr $ra

