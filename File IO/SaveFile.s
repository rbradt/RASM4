  /* -------------------------------------------
	Function:	Save File
	Class:		CS3B
	Purpose:	Saves linked list to output.txt.
	------------------------------------------
	Parameters needed:
    		R1: head ptr
		R3: # of strings in file
	------------------------------------------*/
  
	.global SaveFile
	
	.data
 outfile:	.asciz	"output.txt"
 fileHandle:	.word   0
 temp:		.word	0
 endl:		.byte	10
  
	.text
	.balign 4
  SaveFile:
	   push {r1-r11, lr}
	   
	   cmp r3, #0		@ If there are no strings, exit
	   beq endLoop
		
	   ldr r5, =temp
	   str r1, [r5]		@ Put head in r5
    
    /* -------------- Open File -------------- */

  	ldr r0, =outfile  	@ r0 has outfile
  	mov r1, #0101     	@ Flag - Can write/create
  	mov r2, #0644	    	@ Mode - I can read/write, others read

  	mov r7, #5		@ Open file (returns fileName)
  	svc 0			@ Supervisor call
	ldr r4, =fileHandle
	str r0, [r4]
	
	mov r4, #-1		@ Counter
  loop:	
  	add r4, #1
	
	ldr r5, =temp
	ldr r6, [r5]		@ Deref temp
	ldr r6, [r6]
	mov r1, r6		@ R1: Memory
	bl String_length
	mov r2, r0		@ R2: Length
	
	ldr r0, =fileHandle	@ R0: fileName
	ldr r0, [r0]
   	mov r7, #4		@ Write to file
  	svc 0            	@ Supervisor call
	
	ldr r5, =temp
	ldr r5, [r5]
	ldr r8, [r5, #4]
	ldr r5, =temp
	str r8, [r5]
	
	cmp r8, #0		@ Compare counter to # of strings in file
	bne loop		@ Loop again if less than
	
  closeFile:
	ldr r4, =fileHandle
	ldr r0, [r4]
  	mov r7, #6		@ Close file
  	svc 0
	
  endLoop:
 	pop {r1-r11, lr}
	bx lr
 	.end
