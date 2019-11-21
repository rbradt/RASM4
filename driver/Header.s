/* -----------------------------------------------
	Function:	Header
	Class:		CS3B
	Purpose:	Output header.
-----------------------------------------------------*/

	.global Header

	.data
strName:			.asciz "Names:   Riley Bradt, Jehielle David"
strProgram:			.asciz "Program: RASM4"
strClass:			.asciz "Class:   CS3B"
strDate:			.asciz "Date:    11/26/2019"
endl:				.byte	10
returnAddr:			.word	0

	.text
Header:
	push {r1-r12, lr}		@ Preserve contents of the link register
	ldr r1, =strName
	bl putstring
	
	ldr r1, =endl
	bl putch
	
	ldr r1, =strProgram
	bl putstring
	
	ldr r1, =endl
	bl putch
	
	ldr r1, =strClass
	bl putstring
	
	ldr r1, =endl
	bl putch
	
	ldr r1, =strDate
	bl putstring
	
	ldr r1, =endl
	bl putch
	bl putch
	
	pop {r1-r12, pc}		@ Program counter points back to where you
							@ came from
