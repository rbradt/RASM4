	.global stringSearch
	.extern free
/**************************************************************************
 * 							stringSearch
 *
 * 		This function prints all strings in the linked list that contain
 * the given substring 
 *-------------------------------------------------------------------------
 * input:
 *	r1 = head
 *	r2 = tail
 *	r3 = substring to be found in the linked list
 **************************************************************************/

	.data
szNewline:	.asciz "\n"
szOpenB:	.asciz "["
szClosedB:	.asciz "] "
buffer:		.space	12
substring:	.word 0

	.text
stringSearch:
	push {r1-r11, lr}
	
	ldrb r4, [r3]				@ if substring is empty
	cmp r4, #0
	beq return
	
	push {r1}				@ convert substring to lowercase
	mov r1, r3
	bl String_toLowerCase
	ldr r3, =substring
	str r0, [r3]
	pop {r1}
	
	mov r5, #-1
	search:
		add r5, r5, #1

		cmp r1, #0			@ if current points to null the end of the linked list has been reached
		beq return
		
		ldr r4, [r1]			@ load string from linked list

		cmp r4, #0
		beq return	
	
		push {r1-r4}
		mov r1, r4			@ check if substring exists in string
		ldr r3, =substring
		ldr r2, [r3]
		bl String_compare
		pop {r1-r4}
		
		cmp r0, #-1			@ if substring does not exist in string proceed to next string
		beq continue
		
		print:
			push {r1}		@ print string
			ldr r1, =szOpenB
			bl putstring
			mov r0, r5
			ldr r1, =buffer
			bl intasc32
			bl putstring
			ldr r1, =szClosedB
			bl putstring
			mov r1, r4
			bl putstring
			ldr r1, =szNewline
			bl putstring
			pop {r1}
			
		continue:			@ iterate to next node
			ldr r1, [r1, #4]
			b search
	
return:	
	ldr r3, =substring
	ldr r0, [r3]				@ free lowercase substring
	bl free
	pop {r1-r11, lr}
	bx lr
	.end
