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
  
  
  SaveFile:
 	   push {r1-r11, lr}
		
	   ldr r1, [r1]		@ Dereference head ptr
	   str r1, [r5]		@ Put head in r5
    
    /* -------------- Open File -------------- */

  	ldr r0, =outfile  	@ r0 has outfile
  	mov r1, #0101     	@ Flag - Can write/create
  	mov r2, #0644	    	@ Mode - I can read/write, others read

  	mov r7, #5		@ Open file (returns fileName)
  	svc 0			@ Supervisor call
	
	ldr r6, =temp
	str r5, [r6]		@ head -> temp
	
	mov r4, #-1		@ Counter
  loop:	
  	add r4, #1
	
	ldr r8, [r6]		@ Deref temp

   	mov r7, #4		@ Write to file
  	svc 0            	@ Supervisor call
	
	ldr r1, =endl
	bl putch
	
	ldr r9, [r8, #4]
	ldr r6, =temp
	str r9, [r6]
	
	cmp r4, r3		@ Compare counter to # of strings in file
	blt loop		@ Loop again if less than
	
  endLoop:
  	mov r7, #6		@ Close file
  	svc 0
    
 	pop {r1-r11, lr}
	bx lr
 	.end
