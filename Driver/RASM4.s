/* -------------------------------------------
	          RASM 4
------------------------------------------*/
	
	.global _start
	.equ BUFSIZE, 1024
	.extern malloc
	.extern free
	
	.data
strInput:		.asciz "Select: "
infileName:		.asciz "input.txt"
outFileName:	.asciz "output.txt"
strChoice2:		.asciz "\n<a> From Keyboard\n<b> From File\n"
strIndex:		.asciz "Please enter the index # of the node: "
strDeleted:		.asciz "String deleted."
strSaved:		.asciz "Strings saved to file."
strSubstring:	.asciz "Enter a substring to search for: "
iIndex:			.word	0
iInputInt:		.word 	0
iMemory:		.word	0
iNodes:			.word	0
endl:			.byte	10

head:			.word 0
tail:			.word 0
buffer:			.space 1024

inputIndex:		.skip	BUFSIZE
iInputVal:		.skip	BUFSIZE

	.text
	.balign 4
	
_start:
@	ldr r8, =iInputInt	@ .word, where input # will be stored

/* -------------- Begin Menu Loop While Input != '7' -------------- */
whileNotQuit:
	ldr r1, =iInputVal
	mov r2, #0
	str r2, [r1]
	mov r1, #0
	ldr r1, =endl
	bl putch
	bl putch
	
	bl Header			@ Outputs header
	ldr r2, =iMemory
	ldr r2, [r2]
	ldr r3, =iNodes
	ldr r3, [r3]
	bl Menu				@ Outputs menu - need mem consump in r2, # of nodes in r3

	ldr r1, =strInput	@ Prompt user for input
	bl putstring
	ldr r1, =iInputVal
	ldr r2, =BUFSIZE
	bl getstring		@ Get input from user
	bl ascint32			@ Convert input to number
	

switch:
	cmp r0, #1
	beq ifChoice1
	cmp r0, #2
	beq ifChoice2
	cmp r0, #3
	beq ifChoice3
	cmp r0, #4
	beq ifChoice4
	cmp r0, #5
	beq ifChoice5
	cmp r0, #6
	beq ifChoice6
	cmp r0, #7
	beq end
	
	b whileNotQuit


ifChoice1:				@ If user chooses to view all strings
	ldr r1, =head
	ldr r1, [r1]
	ldr r3, =iNodes
	ldr r3, [r3]
	
	bl ViewStrings
	
	b whileNotQuit		@ Go back to menu
	
ifChoice2:			@ If user chooses to add string
	ldr r1, =strChoice2
	bl putstring
	ldr r1, =strInput	@ Prompt user for 2nd input (a or b)
	bl putstring
	ldr r1, =iInputVal
	ldr r2, =BUFSIZE
	bl getstring		@ Get input from user

	ldrb r1, [r1]		@ Dereference iInputVal

	cmp r1, #'a'
	beq fromKeyb
	cmp r1, #'A'
	beq fromKeyb
	cmp r1, #'b'
	beq fromFile
	cmp r1, #'B'
	beq fromFile

fromKeyb:				@ If user chooses to add string from keyboard
	push {r1-r11}
	ldr r1, =head
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	
	bl AddFromKeyb
	
	ldr r5, =head		@ save linked list
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]
	
	ldr r5, =iMemory	@ update allocated memory quantity
	ldr r6, [r5]
	add r6, r6, r3
	str r6, [r5]
	
	ldr r5, =iNodes		@ update node counter
	ldr r6, [r5]
	add r6, r6, #1
	str r6, [r5]
	pop {r1-r11}
	
	b whileNotQuit		@ Go back to menu
	
fromFile:				@ If user chooses to add string from file
	push {r1-r11}
	ldr r1, =head
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	ldr r3, =infileName
	bl AddFromFile		@ Returns in r3 # of nodes added to the linked list
	
	ldr r5, =head		@ save linked list
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]
	
	ldr r5, =iMemory	@ update allocated memory quantity
	ldr r6, [r5]
	add r6, r6, r0
	str r6, [r5]
	
	ldr r5, =iNodes		@ update node counter
	ldr r6, [r5]
	add r6, r6, r3
	str r6, [r5]
	pop {r1-r11}
	
	b whileNotQuit		@ Go back to menu
	
ifChoice3:				@ If user chooses to delete string
	ldr r1, =strIndex
	bl putstring
	ldr r1, =inputIndex
	ldr r2, =BUFSIZE
	bl getstring
	ldr r1, =inputIndex
	bl ascint32			@ Change into int
	ldr r5, =iInputInt
	str r0, [r5]		@ Store index into r5
	
	ldr r1, =endl
	bl putch
	
	ldr r3, [r5]		@ Move index to r3 to pass into func
	mov r5, #0			@ Clear r5
	ldr r1, =head
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	bl llRemoveAtIndex
	
	ldr r5, =head		@ save linked list
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]

	cmp r3, #0
	beq whileNotQuit	

	mov r1, r3			@ update allocated memory quantity
	bl String_length
	ldr r5, =iMemory
	ldr r6, [r5]
	add r0, r0, #1
	sub r6, r6, r0
	str r6, [r5]
	
	ldr r5, =iNodes		@ update node counter
	ldr r6, [r5]
	sub r6, r6, #1
	str r6, [r5]
	
	push {r1-r11}		@ free string
	mov r0, r3	
	bl free
	pop {r1-r11}
	
	ldr r1, =strDeleted
	bl putstring		@ Output confirmation
	
	b whileNotQuit

ifChoice4:				@ If user chooses to edit string
	ldr r1, =strIndex
	bl putstring
	ldr r1, =inputIndex
	ldr r2, =BUFSIZE
	bl getstring
	ldr r1, =inputIndex
	bl ascint32			@ Change into int
	ldr r5, =iInputInt
	str r0, [r5]		@ Store index into r5
	
	ldr r1, =head		@ edit string
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	ldr r3, [r5]
	bl editString
	
	ldr r5, =iMemory	@ update allocated memory quantity
	ldr r6, [r5]
	add r6, r6, r0
	str r6, [r5]
	
	b whileNotQuit		@ Go back to menu
	
ifChoice5:				@ If user chooses to search for a string
	ldr r1, =strSubstring
	bl putstring
	ldr r1, =buffer
	ldr r2, =1024
	bl getstring

	ldr r1, =head		@ search for string
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	ldr r3, =buffer
	bl stringSearch
	
	b whileNotQuit		@ Go back to menu
	
ifChoice6:				@ If user chooses to save file
	ldr r1, =head
	ldr r1, [r1]
	ldr r3, =iNodes
	ldr r3, [r3]
	bl SaveFile			@ # of nodes must be in r3
	ldr r1, =endl
	bl putch
	ldr r1, =strSaved
	bl putstring
	b whileNotQuit		@ Go back to menu


end:
	ldr r1, =head
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	bl clearStrings
	mov r7, #1			@ Terminates program
	svc 0
	.end
