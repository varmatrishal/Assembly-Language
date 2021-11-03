# File Name: hexProgram4.asm
# Author: Trishal Varma
# Modification History: This code was modified by Trishal Varma on November 2nd 2019.
#Procedures: 
	#data:   File name and its type. 
	#text:   Open the file, read the file, then converst and display its contents 
	
	
#Author: Trishal Varma - txv130330@utdallas.edu 
#Modification History: 
	#November 2rd 2019.: Code is writtne.  
	#November 3rd 2019.: Code was revised, comments were added. 
#Description:  
#Arguments: none.

.data 

filename: .space  128
buffer:   .space  4096

inputPrompt:    .asciiz "Enter the filename: "
result:     .asciiz "The converted values are: \n"

end:  .asciiz "\n"
curr:  .space  128		#value set to 128 and less

#Author: Trishal Varma - txv130330@utdallas.edu
#Modification History:
	#This code was written on November 3rd 2019. No changes made to the code other than revision.
#Description: code to ask for the file name that needs to be opened. 
#Arguments: $a0 - opening, reading, and displaying the contents of the .txt file. 

.text
.globl main

		main:		#Display message asking for a file name in ".txt" format
li   $v0, 4			#print string
la   $a0, inputPrompt
syscall


la   $a0, filename 	#pass file name to $a0
li   $a1, 128
li   $v0, 8
syscall			#System call get file name and read content

la   $s0, filename 
li   $s2, 0
li   $s3, '\n'

     
		change:	
lb    $s1, 0($s0)	#get buffer char value
beq   $s1, $s3, term	#Branch to chracter if counter equals 0
addi  $s2, $s2, 1	#Add immediate from previous value of $s2
addi  $s0, $s0, 1
j     change

term:

sb    $zero, 0($s0)	#Storing new line chratcters
li   $v0, 13		#Load register from the text file information
la   $a0, filename
li   $a1, 0	
li   $a2, 0 
syscall			#Execute system call
 
move $s0, $v0      #file descripter = $s0

li   $v0, 14		#System call read file
move $a0, $s0	
la   $a1, buffer    #address of buffer wo which to read
li   $a2, 4096	 #coded buffer length max
syscall 

li   $v0, 4	
la   $a0, result	#Get result save in register. 
syscall 

li   $v0, 16		#Read answer from register value $v0
move $a0, $s0	 #move $a0 to $s0
syscall 

la   $s0, buffer	#pass buffer to $s0
li   $s2, 0
li   $s3, '\n'		#Buffer loanded

     
		redo:	

lb    $s1, 0($s0)	#Get buffer chrachter value
beq   $s1, $s3, conv	#if reached end then convert
beqz  $s1, EndConv 	#end of conversion
sb    $s1, curr($s2)	#Replace new line with null value 
addi  $s2, $s2, 1	
addi  $s0, $s0, 1
j     redo

#( This part of the code is for reading the file name and displaying it onces the correct file name has been entered in.)
# !! The ".txt" extention has to be there in order for the file to be read. 
     		conv:
la   $t2, curr		#Converted value display in  main
li   $t8, 1
li   $a0, 0
j    htoD
     		htoD:

lb   $t7, 0($t2)
 ble  $t7, '9', strToInt
addi $t7, $t7, -55		#If sum is greater than subtract 55.
j    finalize

          

     		finalize:
bltz $t7, Done		#finalize the program at done end of program.
li   $t6, 16                    
mul  $a0, $a0, $t6              
add  $a0, $a0, $t7              
addi $t2, $t2, 1                

j    htoD

     		strToInt:
addi $t7, $t7, -48		#Convert from Hexadecimal to decimal point
j    finalize

     		Done: 
li   $v0, 1
syscall
#Print string to console
li   $v0, 4
la   $a0, end
syscall		#print string

li   $s2, 0
addi $s0, $s0, 1
j redo 

		EndConv:
li    $v0, 10		#End of life 
syscall 		#execution call end.


#Author: Trishal Varma - txv130330@utdallas.edu
#Modification History:
	#This code was written on November 3rd 2019. No changes made to the code other than revision.
#Description: code to print the inputted number. 
#Arguments: none. 
			# Program finishes running. 





