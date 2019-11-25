  /* -------------------------------------------
	Function:	Save File
	Class:		CS3B
	Purpose:	Saves linked list to output.txt.
	------------------------------------------
	Parameters needed:
    		R1: head ptr
		R2: tail ptr
	------------------------------------------*/
  
	.global SaveFile
	
	.data
 outfile:   .asciz "output.txt"
  
  
  SaveFile:
 	   push {r1-r11, lr}
    
    /* -------------- Open File -------------- */

  	ldr r0, =outfile  	@ r0 has outfile
  	mov r1, #01101     	@ Flag - Can write/create/truncate
  	mov r2, #0644	    	@ Mode - I can read/write, others read

  	mov r7, #5		@ Open file (returns fileName)
  	svc 0			@ Supervisor call
	
	ldr r5, =head		@ save head and tail
	str r1, [r5]
	ldr r5, =tail
	str r2, [r5]
	
  loop:				@ Traverse thru ll
  	
	
   
   	mov r7, #4		@ Write to file
  	svc 0            	@ Supervisor call
	
  endLoop:
  	mov r7, #6		@ Close file
  	svc 0
    
 	pop {r1-r11, lr}
	bx lr
 	.end
