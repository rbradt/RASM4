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
iInput:			.skip	BUFSIZE
iMemory:		.word	0
iNodes:			.word	0
ptrHead:
ptrTail:
newNode:
	
	
	.text
	.balign 4
	
_start:
	mov r2, #0			@ Init memory consumption
	mov r3, #0			@ Init num of nodes
	
	bl Header			@ Outputs header
	bl Menu				@ Outputs menu

	ldr r1, =strInput	@ Prompt user for input
	bl putstring
	ldr r1, =iInput
	ldr r2, =BUFSIZE
	bl getstring		@ Get input from user



/* -------------- */



	ldr r0, =infileName	@ r0 has infileName
	mov r1, #01101		@ Flag - Can write/create/truncate
	mov r2, #0644		@ Mode - I can read/write, others read

	mov r7, #5			@ Open file (returns fileName)
	svc 0				@ Supervisor call

	mov r0, r4			@ r0 now has fileName
	mov r7, #3			@ Read file
	ldr r1, =BUFSIZE	@ r1 points to where we want to store the data
	bl getch

	









	bl CLS				@ Clear screen function












	mov r7, #1			@ Terminates program
	svc 0
	.end
