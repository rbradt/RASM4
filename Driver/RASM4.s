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
outFileName:		.asciz "output.txt"
strIndex:		.asciz "Please enter the index # of the node: "
strDeleted:		.asciz "String deleted."
strSaved:		.asciz "Strings saved to file."
iInputVal:		.skip	BUFSIZE
inputIndex:		.skip	BUFSIZE
iIndex:			.word	0
iInputInt:		.word 	0
iMemory:		.word	0
iNodes:			.word	0
endl:			.byte	10

	.text
	.balign 4
	
_start:
	mov r2, #0		@ Init memory consumption
	mov r3, #0		@ Init num of nodes
	ldr r8, =iInputInt	@ .word, where input # will be stored
	
	bl Header		@ Outputs header

/* -------------- Begin Menu Loop While Input != '7' -------------- */
whileNotQuit:
	bl CLS			@ Clear screen
	bl Menu			@ Outputs menu - need mem consump in r2, # of nodes in r3

	ldr r1, =strInput	@ Prompt user for input
	bl putstring
	ldr r1, =iInputVal
	ldr r2, =BUFSIZE
	bl getstring		@ Get input from user
	
	ldr r1, =iInputVal
	bl ascint32		@ Convert input to number
	str r0, [r8]		@ Store into word (iInputInt)
	
switch:
	cmp r8, #7
	beq end
	
	cmp r8, #1
	beq ifChoice1
	cmp r8, #'2a'
	beq ifChoice2a
	cmp r8, #'2b'
	beq ifChoice2b
	cmp r8, #3
	beq ifChoice3
	cmp r8, #4
	beq ifChoice4
	cmp r8, #5
	beq ifChoice5
	cmp r8, #6
	beq ifChoice6


ifChoice1:			@ If user chooses to view all strings
	bl CLS
	bl ViewStrings
	b whileNotQuit		@ Go back to menu
	
ifChoice2a:			@ If user chooses to add string from keyboard
	bl AddFromKeyb
	b whileNotQuit		@ Go back to menu
	
ifChoice2b:			@ If user chooses to add string from file
	mov r6, r3		@ Need to pass in current # of nodes
	bl AddFromFile		@ Returns in r3 the updated # of nodes
	b whileNotQuit		@ Go back to menu
	
ifChoice3:			@ If user chooses to delete string
	bl CLS
	ldr r1, =strIndex
	bl putstring
	ldr r1, =inputIndex
	ldr r2, =BUFSIZE
	bl getstring
	ldr r1, =inputIndex
	bl ascint32		@ Change into int
	ldr r5, =iInput
	str r0, [r5]		@ Store index into r5
	
	ldr r1, =endl
	bl putch
	
	mov r3, r5		@ Move index to r3 to pass into func
	mov r5, #0		@ Clear r5
	bl llRemoveAtIndex
	
	ldr r1, =strDeleted
	bl putstring		@ Output confirmation
	
	b whileNotQuit

ifChoice4:			@ If user chooses to edit string
	bl CLS
	ldr r1, =strIndex
	bl putstring
	ldr r1, =inputIndex
	ldr r2, =BUFSIZE
	bl getstring
	ldr r1, =inputIndex
	bl ascint32		@ Change into int
	ldr r5, =iInput
	str r0, [r5]		@ Store index into r5
	
	/* FUNC HERE */
	
	b whileNotQuit		@ Go back to menu
	
ifChoice5:			@ If user chooses to search for a string
	/* FUNC HERE */
	b whileNotQuit		@ Go back to menu
	
ifChoice6:			@ If user chooses to save file
	bl CLS
	bl SaveFile		@ # of nodes must be in r3
	ldr r1, =strSaved
	bl putstring
	b whileNotQuit		@ Go back to menu


end:
	mov r7, #1		@ Terminates program
	svc 0
	.end
