/* -------------------------------------------
	Function:	AddFromKeyb
	Class:		CS3B
	Purpose:	Add string from keyboard.
	------------------------------------------
	Parameters needed:
		R1: head
		R2: tail
	------------------------------------------
	Returns:
		R0: # of nodes
		R1: new head
		R2: new tail
		R3: data allocated
	------------------------------------------*/
	
	.global AddFromKeyb
	.equ BUFSIZE, 1024
	
	.data
strPrompt:	.asciz	"Enter string: "
szInput:	.skip	BUFSIZE
iInput:		.word	0
head:		.word	0
tail:		.word	0

	.text
	.balign 4
AddFromKeyb:
	push {r4-r12, lr}
	
	ldr r5, =head
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]
	
	ldr r1, =strPrompt
	bl putstring
	
	ldr r1, =szInput
	ldr r2, =BUFSIZE
	bl getstring
	
	ldr r3, =szInput
	ldr r1, =iInput
	str r1, [r3]		@ Store into r3 the data
	
	ldr r1, =head
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	bl llInsert		@ Insert node into linked list
	add r6, #1		@ Keep track of # of nodes

	ldr r5, =head		@ store new head and tail
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]

	add r4, #8		@ keep track of data allocated
	add r4, r4, r1
	
	mov r0, r6		@ R0: # of nodes
	mov r3, r4		@ R3: data allocated
	
	
	pop {r4-r12, lr}
	bx lr
  .end
