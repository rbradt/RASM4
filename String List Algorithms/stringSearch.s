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
szNewline: .asciz "\n"

	.text
stringSearch:
	push {r1-r11, lr}
	
	ldrb r4, [r3]			@ if substring is empty
	cmp r4, #0
	beq return
	
	push {r1}				@ convert substring to lowercase
	mov r1, r3
	bl String_toLowerCase
	mov r3, r0
	pop {r1}
	
	search:
		cmp r1, #0			@ head points to null (linked list is empty)
		beq return
		
		ldr r4, [r1]		@ load string from linked list
		
		push {r1-r3}		@ convert string to lowercase
		mov r1, r4
		bl String_toLowerCase
		
		mov r1, r0			@ check if substring exists in string
		mov r2, r3
		bl String_indexOf_3
		
		bl free				@ free lowercase string
		pop {r1-r3}
		
		cmp r0, #-1			@ if substring does not exist in string proceed to next string
		beq continue
		
		print:
			push {r1}		@ print string 
			mov r1, r4
			bl putstring
			ldr r1, =szNewline
			bl putstring
			pop {r1}
			
		continue:			@ iterate to next node
			ldr r1, [r1, #4]
			b search
	
return:	
	mov r0, r3				@ free lowercase substring
	bl free
	pop {r1-r11, lr}
	bx lr