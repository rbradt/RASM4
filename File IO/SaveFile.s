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
	
	mov r4, #-1		@ Counter
  loop:	
  	add r4, #1
	
	ldr r6, [r5]		@ Deref temp
	
	ldr r1, [r6]		@ R1: Memory
	bl String_length
	mov r2, r0		@ R2: Length
	
	ldr r0, =outfile	@ R0: fileName
   	mov r7, #4		@ Write to file
  	svc 0            	@ Supervisor call
	
	ldr r8, [r6, #4]
	ldr r5, =temp
	str r8, [r5]
	
	cmp r4, r3		@ Compare counter to # of strings in file
	blt loop		@ Loop again if less than
	
  closeFile:
  	mov r7, #6		@ Close file
  	svc 0
	
  endLoop:
 	pop {r1-r11, lr}
	bx lr
 	.end
