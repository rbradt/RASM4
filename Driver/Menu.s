/* -------------------------------------------
	Function:	Menu
	Class:		CS3B
	Purpose:	Output menu.
	------------------------------------------
	Parameters needed:
		R2: Data Structure Memory Consumption
		R3: Number of Nodes
	------------------------------------------*/
	
	.global Menu
	
	.data
strTitle:		.asciz	"\t\tRASM4 TEXT EDITOR\n"
strMemory:		.asciz	"Data Structure Memory Consumption: "
strNodes:		.asciz	"Number of Nodes: "
strView:		.asciz	"<1> View all strings\n\n"
strAdd:			.asciz	"<2> Add string\n"
strFromKeyb:		.asciz	"\t<a> from Keyboard\n"
strFromFile:		.asciz	"\t<b> from File. Static file named input.txt\n\n"
strDelete:		.asciz	"<3> Delete String. Given an index #, delete the entire string and de-allocate memory (including the node).\n\n"
strEdit:		.asciz	"<4> Edit String. Given an index #, replace old string w/ new string. Allocate/De-allocate as needed.\n\n"
strSearch:		.asciz	"<5> String Search. Regardless of case, return all strings that match the substring given.\n\n"
strSave:		.asciz	"<6> Save File (output.txt)\n\n"
strQuit:		.asciz	"<7> Quit\n\n"
buffer:			.space	12
endl:			.byte	10
	
	.text
	.balign 4
Menu:
	push {r1-r12, lr}
	
	ldr r1, =strTitle			@ Output title
	bl putstring
	ldr r1, =strMemory			@ Output memory consumption prompt
	bl putstring
	
	
	mov r0, r2				@ Output memory consumption
	ldr r1, =buffer
	bl intasc32
	bl putstring
	
	ldr r1, =endl
	bl putch
	
	ldr r1, =strNodes			@ Output number of nodes prompt
	bl putstring
	
	mov r0, r3				@ Output number of nodes
	ldr r1, =buffer
	mov r4, #0
	str r4, [r1]
	bl intasc32
	bl putstring
	
	ldr r1, =endl
	bl putch
	
	ldr r1, =strView			@ Output option 1
	bl putstring
	
	ldr r1, =strAdd				@ Output option 2
	bl putstring
	
	ldr r1, =strFromKeyb			@ Output option 2a
	bl putstring
	
	ldr r1, =strFromFile			@ Output option 2b
	bl putstring
	
	ldr r1, =strDelete			@ Output option 3
	bl putstring
	
	ldr r1, =strEdit			@ Output option 4
	bl putstring
	
	ldr r1, =strSearch			@ Output option 5
	bl putstring
	
	ldr r1, =strSave			@ Output option 6
	bl putstring
	
	ldr r1, =strQuit			@ Output option 7
	bl putstring
	
	
	pop {r1-r12, lr}
	bx lr
