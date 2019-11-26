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
iInputVal:		.skip	BUFSIZE
iInputInt:		.word 	0
iMemory:		.word	0
iNodes:			.word	0
ptrHead:		.word	0
ptrTail:		.word	0
newNode:		.word	0

	.text
	.balign 4
	
_start:
	mov r2, #0		@ Init memory consumption
	mov r3, #0		@ Init num of nodes
	ldr r8, =iInputInts	@ .word, where input # will be stored
	
	bl Header		@ Outputs header

/* -------------- Begin Menu Loop While Input != '7' -------------- */
whileNotQuit:
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
	/* FUNC HERE */
	b whileNotQuit		@ Go back to menu
	
ifChoice2a:			@ If user chooses to add string from keyboard
	bl AddFromKeyb
	b whileNotQuit		@ Go back to menu
	
ifChoice2b:			@ If user chooses to add string from file
	bl AddFromFile
	b whileNotQuit		@ Go back to menu
	
ifChoice3:			@ If user chooses to delete string
	/* FUNC HERE */
	b whileNotQuit

ifChoice4:			@ If user chooses to edit string
	/* FUNC HERE */
	b whileNotQuit		@ Go back to menu
	
ifChoice5:			@ If user chooses to search for a string
	/* FUNC HERE */
	b whileNotQuit		@ Go back to menu
	
ifChoice6:			@ If user chooses to save file
	mov r4, @ Put # of strings in r4
	bl SaveFile
	b whileNotQuit		@ Go back to menu





/* -------------- */

	bl CLS			@ Clear screen function
	
/* -------------- */

end:
	mov r7, #1		@ Terminates program
	svc 0
	.end
