/* -------------------------------------------
	Function:	CLS
	Class:		CS3B
	Purpose:	Clear screen
	------------------------------------------
	Parameters needed:
		None.
	------------------------------------------*/
	
	.global CLS
	.data
endl:	.byte 10
	
	
CLS:
	push {r4-r8, r10, r11, lr}
	
loop:
	cmp r3, #50
	beq endLoop
	
	ldr r1, =endl
	bl putstring
	
	add r3, #1


endLoop:
	pop {r4-r8, r10, r11, lr}
	bx lr

