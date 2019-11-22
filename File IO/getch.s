/* -------------------------------------------
	Function:	getch
	Class:		CS3B
	Purpose:	get character from file
	------------------------------------------
	Parameters needed:
		R0: file handle
	------------------------------------------
	Preconditions:
		File exists & is open for reading.
	------------------------------------------
	Return:
		R0:	bytes read
		R1:	character
	------------------------------------------*/

	.global getch
	.extern malloc
	
getch:
	push {r2-r11, lr}
	
	push {r0}
	mov r0, #1
	bl malloc
	mov r1, r0
	pop {r0}
	
	mov r2, #1			@ numBytes
	
	mov r7, #3			@ Read from file
	svc 0
	
	cmp r0, #0
	beq end
	
	ldrb r1, [r1]

end:
	pop {r2-r11, lr}
	bx lr
