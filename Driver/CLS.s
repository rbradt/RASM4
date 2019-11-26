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
	
	.balign 4
CLS:
	push {r1-r11, lr}
	
	add r3, #-1
loop:
	add r3, #1
	
	ldr r1, =endl
	bl putch
	
	cmp r3, #50
	bne loop

endLoop:
	pop {r1-r11, lr}
	bx lr
	.end
