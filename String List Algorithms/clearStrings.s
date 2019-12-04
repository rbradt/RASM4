	.global clearStrings
/**************************************************************************
 * 							clearStrings
 *
 * 		This function frees all memory allocated by RASM4 by clearing the
 * linked list nodes and all strings stored
 *-------------------------------------------------------------------------
 * input:
 *	r1 = head
 *	r2 = tail
 *
 * output:
 *	r1 = updated head (head = null)
 *	r2 = updated tail (tail = null)
 **************************************************************************/
	
clearStrings:
	push {r3-r11, lr}
	
	cmp r1, #0
	beq return
	
	/* Delete head nodes until linked list is empty */
	clearNode:
		mov r3, #0
		bl llRemoveAtIndex		@ delete head node
		
		push {r1-r2}			@ free allocated string
		mov r0, r3
		bl free
		pop {r1-r2}
		
		cmp r1, #0				@ linked list is empty when head points to a null
		bne clearNode
	
	return:	
	mov r2, #0
	pop {r3-r11, lr}
	bx lr
	.end
