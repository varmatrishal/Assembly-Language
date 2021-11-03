# File Name: openCommand.asm 
# Author: Trishal Varma
# Modification History: This code was modified by Trishal Varma on October 13th 2019.
#Procedures: 
	#data:   File name and its type. 
	#text:   Open the file, read the file, and display its contents 
	
	
#Author: Trishal Varma - txv130330@utdallas.edu 
#Modification History: 
	#October 10th 2019: Code is writtne.  
	#October 13th 2019: Code was revised, and minor changes were made. 
#Description:  
#Arguments: none.

.data
fileName: .space 50
prompt1: .asciiz "Enter the file name: " #JavaPrompt that takes in the file name. ".txt" has to be attached to the file name. 
buffer: .space 40966

#Author: Trishal Varma - txv130330@utdallas.edu
#Modification History:
	#This code was written on October 10th 2019. No changes made to the code other than revision.
#Description: code to ask for the file name that needs to be opened. 
#Arguments: $a0 - opening, reading, and displaying the contents of the .txt file. 


.text
main:
li $v0, 4
la $a0, prompt1 #prompt from .data to be placed, this is the name of the ".txt" file. 
syscall

li $v0, 8 
la $a0, fileName
li $a1, 50
syscall

# Created a loop to contain the register address, that will load the chracter, then increment. 
    la   $s0, fileName   
   add   $s2, $0, $0
   addi   $s3, $0, '\n'   # $s3 = '\n'
loop:
   lb   $s1, 0($s0)   
   beq   $s1, $s3, end   
   addi   $s2, $s2, 1   
   addi   $s0, $s0, 1 
   j   loop
end:
   sb   $0, 0($s0)   # end loop to replace any new line with 0. 
  
  
  # Read File

   li $v0, 13 
   la $a0, fileName 
   li $a1, 0 
   li $a2, 0 
   syscall 
   move $s0, $v0 # file descriptor being saved
  
   
#( This part of the code is for reading the file name and displaying it onces the correct file name has been entered in.)
# !! The ".txt" extention has to be there in order for the file to be read. 

   li $v0, 14    	# File opens for it to be read. 
   move $a0, $s0 
   la $a1, buffer 	# inout address buffer.
   li $a2, 1000 		# Number of chracters that are going to be read before the code stops reading the rest of the file, if > than 1000. 
   syscall 	 #System calls to execute and read the file 
   

   li $v0, 4 
   la $a0, buffer 
   syscall # Prints the string that is in the text file. Displays it 

li $v0, 10 
syscall		

# Finished program


#Author: Trishal Varma - txv130330@utdallas.edu
#Modification History:
	#This code was written on October 10 2019. No changes made to the code other than revision.
#Description: code to print the inputted number. 
#Arguments: none. 
			# Program finishes running. 

