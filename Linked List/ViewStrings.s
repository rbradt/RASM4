/* -------------------------------------------
	Function:	ViewStrings
	Class:		CS3B
	Purpose:	Output all strings in linked list.
	------------------------------------------
	Parameters needed:
		R1: head ptr
		R3: # of nodes
	------------------------------------------
	Returns:
		None.
	------------------------------------------*/
	
	.global ViewStrings
	.data
temp:		.word	0
emptyErr:	.asciz "\n*** ERROR - NO STRINGS IN LIST ***\nEXITING...\n"
endl:		.byte	10
	
	.text
ViewStrings:
	push {r1-r12, lr}
	
	cmp r1, #0
	beq emptyList
	
	ldr r2, =temp
	str r1, [r2]		@ head -> temp
	
	mov r4, #-1		@ Counter
loop:	
	add r4, #1
	
	ldr r5, [r2]		@ Deref temp
	cmp r5, #0
	beq endLoop
	ldr r1, [r5]
	bl putstring
	
	ldr r1, =endl
	bl putch
	
	ldr r6, [r5, #4]
	ldr r2, =temp
	str r6, [r2]
	
	cmp r4, r3
	blt loop		@ Loop if less than
	
endLoop:
	pop {r1-r12, lr}
	bx lr
	
emptyList:
	ldr r1, =emptyErr
	bl putstring
	b endLoop
	
  .end
