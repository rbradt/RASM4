	.global editString
	.extern malloc
	.extern free
/**************************************************************************
 * 							editString
 *
 * 		This function allows a user to modify a string at the given index
 *-------------------------------------------------------------------------
 * input:
 *	r1 = head
 *	r2 = tail
 *	r3 = index of string to edit
 *
 * output:
 *	r0 = net change to allocated memory (in bytes) (can be positive or negative)
 *-------------------------------------------------------------------------
 * warnings:
 *	An invalid index or invalid string will return without performing any
 * operations. The output will be zero (ie no change to bytes allocated)
 **************************************************************************/

	.data 
szPrompt: 	.asciz "Please enter new string: \n"
buffer: 	.space 1024

	.text
editString:
	push {r1-r11, lr}
	
	/* Locate string to be modified */
	mov r0, #0
	mov r4, r1
	mov r5, #-1
	locateNode:
		add r5, r5, #1
		
		cmp r4, #0
		beq return
	
		cmp r5, r3
		beq replace
		
		ldr r4, [r4, #4]
		
		b locateNode
		
		
	/* Prompt user to enter new string */
	ldr r1, =szPrompt	@ Prompt user to enter new string
	bl putstring
	
	ldr r1, =buffer		@ Store string in keyboard buffer
	mov r2, #1024
	bl getstring
	
	bl String_length	@ get new string length
	mov r5, r0
	
	cmp r5, #0			@ if the user entered nothing
	beq return
	
	bl String_copy		@ Copy string out of keyboard buffer
	
	
	/* Deallocate old string and store new string */
replace:	
	push {r0-r5}		@ get old string length
	ldr r1, [r4]
	bl String_length
	mov r6, r0
	
	push {r6}			@ free previous string
	mov r0, r1
	bl free
	pop {r0-r6}
	
	str r0, [r4]		@ store new string
	
	sub r0, r5, r6		@ change in bytes = new number of bytes - old number of bytes
	

return:
	pop {r1-r11, lr}
	bx lr