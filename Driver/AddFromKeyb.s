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

	ldr r4, =head
	str r1, [r4]
	ldr r4, =tail
	str r2, [r4]

	mov r4, #0

	ldr r1, =strPrompt
	bl putstring
	
	ldr r1, =szInput
	ldr r2, =BUFSIZE
	bl getstring
	
	bl String_copy		@ Returns into r3 the string
	mov r3, r0
	
	ldr r1, =head
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	bl llInsert		@ Insert node into linked list

	ldr r5, =head		@ store new head and tail
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]

	push {r1-r3}
	ldr r1, [r2]
	bl String_length

	add r4, #9		@ keep track of data allocated
	add r4, r4, r0
	pop {r1-r3}
	
	mov r3, r4
	
	ldr r1, =head
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	pop {r4-r12, lr}
	bx lr
  .end
