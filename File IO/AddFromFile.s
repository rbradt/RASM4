	.global AddFromFile
/**************************************************************************
 * 								getline
 *
 *		This function loads text from an input file and stores it into the 
 *	linked list passed
 *-------------------------------------------------------------------------
 * input:
 *	r1 = head
 *	r2 = tail
 *	r3 = pointer to string with file name
 * 
 * output:
 *	r0 = bytes allocated
 *	r1 = new head
 *	r2 = new tail
 *-------------------------------------------------------------------------
 * note:
 *	Call this function with a 0 in r1 to create a new linked list.
 **************************************************************************/
	
	.data
buff:		.space 1024
head:		.word 0
tail:		.word 0
fileHandle:	.word 0
	
	.text
AddFromFile:
	push {r3-r11, lr}

	ldr r5, =head			@ save head and tail
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]
	
	/* -------------- Open File -------------- */
	mov r0, r3			@ r0 has fileName
	mov r1, #00			@ Flag - Can read
	mov r2, #0644		@ Mode - I can read/write, others read
	mov r7, #5			@ Open file (returns fileName)
	svc 0				@ Supervisor call
	
	ldr r2, =fileHandle		@ save file handle
	str r0, [r2]
	
	mov r4, #0
	loop:
		ldr r1, =buff		@ getline from text file
		ldr r2, =fileHandle
		ldr r2, [r2]
		bl getline
		
		cmp r1, #0			@ if nothing was read
		beq return
		
		ldr r1, =head		@ insert string into linked list
		ldr r1, [r1]
		ldr r2, =tail
		ldr r2, [r2]
		mov r3, r0
		bl llInsert
		
		ldr r5, =head		@ store new head and tail
		str r1, [r5]
		ldr r5, =tail
		str r2, [r5]
		
		add r4, r4, #8		@ keep track of data allocated
		add r4, r4, r1
		
		b loop

return:
	mov r7, #6			@ Close file
	svc 0
	
	ldr r1, =head		@ return r0-r2
	ldr r1, [r1]
	ldr r2, =tail
	ldr r2, [r2]
	mov r0, r4
	
	pop {r3-r11, lr}
	bx lr
	
	
