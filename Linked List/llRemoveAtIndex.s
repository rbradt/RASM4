	.global llRemoveAtIndex
/**************************************************************************
 * 							llRemoveAtIndex
 *
 * 		This function removes the node at the specified index from the
 *	linked list.
 *-------------------------------------------------------------------------
 * input:
 *	r1 = head
 *	r2 = tail
 *	r3 = index of node to delete
 *
 * output:
 *	r1 = updated head
 *	r2 = updated tail
 *	r3 = address of data previously in the node
 *-------------------------------------------------------------------------
 * warnings:
 *	This function only deletes the node and not any allocated memory stored
 *	in the node. It does, however, return the stored data.
 *
 *	An invalid index will return without modifying r1, r2 or r3.
 **************************************************************************/
llRemoveAtIndex:
	push {r4-r11, lr}
	
	cmp r3, #0
	beq head
	blt return
	
	/* Locate node at index */
	mov r4, r1
	mov r7, #0
	locateNode:
		add r7, r7, #1
	
		mov r6, r4
		ldr r4, [r4, #4]
		
		cmp r4, #0			@ index is out of range
		beq outofrange
		
		cmp r7, r3			@ node was found
		beq regular
		
		b locateNode
		
	/* Delete head node */
	head:					
		mov r0, r1			
		ldr r3, [r1]		@ save data
		
		ldr r1, [r1, #4]	@ update head
		
		push {r1-r5}		@ delete node
		bl free
		pop {r1-r5}
		
		b return
	
	/* Delete a regular node */
	regular:
		ldr r5, [r4, #4]	@ r5 = current->next
		ldr r3, [r4]		@ r3 = current->data
		
		mov r0, r4			@ delete node
		push {r1-r5}		
		bl free
		pop {r1-r5}
		
		cmp r5, #0			@ update tail
		mov r2, r6
		
		str r5, [r6, #4]	@ previous->next = current->next
	
		b return

	outofrange:
		mov r3, #0
		
	return:
		pop {r4-r11, lr}
		bx lr
