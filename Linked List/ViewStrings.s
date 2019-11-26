/* -------------------------------------------
	Function:	ViewStrings
	Class:		CS3B
	Purpose:	Output all strings in linked list.
	------------------------------------------
	Parameters needed:
		R1: head ptr
		R2: tail ptr
		R3: # of nodes
	------------------------------------------
	Returns:
		None.
	------------------------------------------*/
	
	.global ViewStrings
	
	.data
	
ViewStrings:
	push {r1-r12, lr}
	
	mov r4, #-1			@ Counter
loop:	
	add r4, #1

	ldr r1, [r1, #4]		@ Traverse thru linked list
	bl putstring			@ Print string in node
	
	cmp r4, r3
	blt loop			@ Loop if less than
	
	pop {r1-r12, lr}
	bx lr
  .end
