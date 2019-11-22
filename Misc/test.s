

	.global _start
	
	.data
file:		.asciz "input.txt"
buff:		.skip 500
	
	.text
	
_start:
	ldr r0, =file	@ r0 has infileName
	mov r1, #00		@ Flag - Can write/create/truncate
	mov r2, #0644		@ Mode - I can read/write, others read

	mov r7, #5			@ Open file (returns fileName)
	svc 0				@ Supervisor call
	
	mov r2, r0
	ldr r1, =buff
	bl getline
	
	mov r1, r0
	bl putstring
	
	mov r7, #6
	svc 0

	mov r7, #1
	svc 0
	.end
