	.extern malloc
	.extern free
	.global llInsert
/**************************************************************************
 * 								llInsert
 *
 *		This function inserts a new node with the data passed into the link
 *	list specified by head and tail. If the head and tail are not specified
 *	this function initializes a new singly linked list and inserts the data
 *	into it.
 *-------------------------------------------------------------------------
 * input:
 *	r1 = head
 *	r2 = tail
 *	r3 = data
 * 
 * output:
 *	r1 = new head
 *	r2 = new tail
 *-------------------------------------------------------------------------
 * note:
 *	Call this function with a 0 in r1 to create a new linked list.
 **************************************************************************/
llInsert:
	push {r3-r11, lr}
	
	mov r0, #8		@ create new node
	push {r1-r3}
	bl malloc
	pop {r1-r3}
	
	str r3, [r0]	@ initialize node
	mov r4, #0
	str r4, [r0, #4]
	
	cmp r1, #0
	beq case_1
	b case_2

	case_1: @ initialize linked list
		mov r1, r0
		b return
	
	case_2: @ insert node
		str r0, [r2, #4]
		
	return:
	mov r2, r0
	pop {r3-r11, lr}
	bx lr
