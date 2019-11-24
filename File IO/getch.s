/* -------------------------------------------
	Function:	getch
	Class:		CS3B
	Purpose:	get character from file
	------------------------------------------
	Parameters needed:
		R1: buffer
		R2: file handle
	------------------------------------------
	Preconditions:
		File exists & is open for reading.
	------------------------------------------
	Return:
		R0:	bytes read
		R1:	buffer
	------------------------------------------*/
	.global getch
	
getch:
	push {r2-r11, lr}
	
	mov r0, r2
	mov r2, #1			@ numBytes
	mov r7, #3			@ Read from file
	svc 0

end:
	pop {r2-r11, lr}
	bx lr
	.end
