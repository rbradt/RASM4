/* -------------------------------------------
	Function:	getline
	Class:		CS3B
	Purpose:	get line from file
	------------------------------------------
	Parameters needed:
		R2:	File handle
		R1:	Buffer
	------------------------------------------
	Preconditions:
		File exists & is open for reading.
	------------------------------------------
	Returns:
		R0: Bytes read
		R3: Copied string
	------------------------------------------*/

	.global getline
	
getline:
	push {r4-r8, r10, r11, lr}
	
	mov r6, #0
	mov r4, #0
	str r4, [r1]
	
	mov r4, r1			@ r4 has buffer
	mov r5, #-1			@ Counter

loop:
	add r5, #1			@ Update counter
	mov r0, r2
	bl getch
	cmp r0, #0			@ if r0 != 0
	beq copy

	cmp r1, #0xa			@ if ch = \n
	beq lineNew
	cmp r1, #0xd			@ if ch = \r
	beq lineNew
	
	strb r1, [r4, r5]	@ Put the char into buffer
	
	b loop
	
lineNew:
	mov r6, r1
	mov r1, #'a'
	strb r1, [r4, r5]
	
copy:
	mov r1, r4	
	bl String_copy
	mov r3, r0
	
	cmp r6, #0
	beq end
	
	strb r6, [r3, r5]

end:
	pop {r4-r8, r10, r11, lr}
	bx lr
	.end
