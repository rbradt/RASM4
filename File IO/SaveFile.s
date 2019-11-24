  /* -------------------------------------------
	Function:	Save File
	Class:		CS3B
	Purpose:	Saves linked list to output.txt.
	------------------------------------------
	Parameters needed:
    None.
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

  	mov r7, #5		    	@ Open file (returns fileName)
  	svc 0			        	@ Supervisor call
  
  /* ----------------------------------------- */
  /*           TRAVERSE THRU LL HERE           */
  /* ----------------------------------------- */
   
    mov r7, #4		  		@ Write to file
  	svc 0            		@ Supervisor call
	
  	mov r7, #6			  	@ Close file
    svc 0
    
    pop {r1-r11, lr}
    bx lr
    .end
