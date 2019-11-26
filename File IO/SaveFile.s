  /* -------------------------------------------
	Function:	Save File
	Class:		CS3B
	Purpose:	Saves linked list to output.txt.
	------------------------------------------
	Parameters needed:
    		R1: head ptr
		R2: tail ptr
		R3: # of strings in file
	------------------------------------------*/
  
	.global SaveFile
	
	.data
 outfile:	.asciz "output.txt"
 strSaved:	.asciz "Saved to file."
 endl:		.byte 10
  
  
  SaveFile:
 	   push {r1-r11, lr}
	   
	   str r8, [r1]		@ Put head ptr in r8
	   str r9, [r2]		@ Put tail ptr in r9
    
    /* -------------- Open File -------------- */

  	ldr r0, =outfile  	@ r0 has outfile
  	mov r1, #01101     	@ Flag - Can write/create/truncate
  	mov r2, #0644	    	@ Mode - I can read/write, others read

  	mov r7, #5		@ Open file (returns fileName)
  	svc 0			@ Supervisor call
	
	mov r4, #-1		@ Counter
  loop:				@ Traverse thru ll
  	add r4, #1
	
	
	
	
   
   	mov r7, #4		@ Write to file
  	svc 0            	@ Supervisor call
	
	cmp r4, r3		@ Compare counter to # of strings in file
	blt loop		@ Loop again if less than
	
  endLoop:
  	mov r7, #6		@ Close file
  	svc 0
	
	ldr r1, =endl
	bl putch
	
	ldr r1, =strSaved	@ Output to user that strings were saved
	bl putstring
	
	ldr r1, =endl
	bl putch
    
 	pop {r1-r11, lr}
	bx lr
 	.end
