	.data
file:		.asciz "input.txt"
buff:		.space 1024
	
	.text
	.extern malloc
	.extern free
	.global _start

_start:
	ldr r3, =file
	mov r1, #0
	mov r2, #0		
	bl AddFromFile
	
	mov r7, #6
	svc 0

	mov r7, #1
	svc 0
	.end
