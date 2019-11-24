	.extern malloc
	.global getline
/**************************************************************************
 * 								getline
 *
 *		This function creates a new string with a single line of characters
 *	from the open file passed.
 *-------------------------------------------------------------------------
 * input:
 *	r1 = buffer
 *	r2 = file handle
 * 
 * output:
 *	r0 = string
 *	r1 = bytes allocated
 *-------------------------------------------------------------------------
 * note:
 *	the number of bytes read will be zero if at the end of the file
 **************************************************************************/
getline:
	push {r2-r11, lr}
	mov r3, #0			@ clear buffer
	str r3, [r1]
	
	
	/* load characters from file into the buffer */
	push {r1}			@ save initial buffer location
	mov r5, #0			@ number of characters
	loadBuffer:
		bl getch		@ load character into buffer
		ldrb r4, [r1]
		
		add r5, r5, r0		@ increment character count (count += bytes_read)
		
		cmp r0, #0		@ if: 1. no bytes are read
		beq createString
		cmp r4, #0xa		@     2. '\n' is read
		beq createString
		cmp r4, #0xd		@     3. '\r' is read
		beq createString	@ the end of the line has been reached
		
		add r1, r1, #1		@ shift buffer
		
		b loadBuffer
		
		
	/* create a new string with the characters from the file */
	createString:
		pop {r1}		@ pop buffer location
		
		cmp r5, #0		@ if no bytes were read -> exit
		beq return
		
		push {r1-r11}		@ allocate memory for new string
		mov r0, r5
		add r0, #1
		bl malloc
		pop {r1-r11}
		
		mov r3, #-1		@ copy characters into new string
		copy:
			add r3, r3, #1
			
			ldrb r4, [r1, r3]
			strb r4, [r0, r3]
			
			cmp r3, r5
			blt copy

		mov r4, #0		@ add null at end of string
		strb r4, [r0, r5]
		add r5, r5, #1
			
return:
	mov r1, r5
	pop {r2-r11, lr}
	bx lr
	.end
