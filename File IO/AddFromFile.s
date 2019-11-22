/* -------------------------------------------
	Function:	AddFromFile
	Class:		CS3B
	Purpose:	add from file
	------------------------------------------
	Parameters needed:
		None.
	------------------------------------------
	Preconditions:
		File exists & is open for reading.
	------------------------------------------*/

	.global AddFromFile
	
	.data
buff:		.skip 1024
	
AddFromFile:
	push {r1-r11, lr}


	/* -------------- Open File -------------- */

	ldr r0, =infileName	@ r0 has infileName
	mov r1, #00		@ Flag - Can write/create/truncate
	mov r2, #0644		@ Mode - I can read/write, others read

	mov r7, #5			@ Open file (returns fileName)
	svc 0				@ Supervisor call
	
loop:
	ldr r1, =buff
	mov r4, #0
	str r4, [r1]

	mov r2, r0
	
	bl getline
	
	cmp r0, #0
	b end
	
	mov r1, #0
	mov r2, #0
	bl llInsert
	
	b loop

	
	
	
	
	
	

	mov r7, #6			@ Close file
	svc 0

	pop {r1-r11, lr}
	bx lr
	
	
