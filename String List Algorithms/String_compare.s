@ Input
@ r1 = string
@ r2 = substring to find in original string

@ Output
@ r0 = index of substring in string

	.global String_compare
String_compare:
	push {r1-r11, lr}
	
	bl String_length
	
	push {r0-r2}
	mov r1, r2
	bl String_length
	mov r6, r0
	pop {r0-r2}
	
	mov r8, #-1
	mov r3, #-1
	mov r7, #0
	
	loop:
		add r3, r3, #1
		
		ldrb r4, [r1, r3]
		ldrb r5, [r2, r7]
		
		cmp r4, r5
		beq next
		
		cmp r4, #0x41		@ str[i] < 'A'
		blt reset
		cmp r4, #0x5a		@ str[i] > 'Z'
		bgt reset
		
		add r4, r4, #0x20
		
		cmp r4, r5
		beq next
		
		reset:
			mov r7, #0
			ldrb r5, [r2, r7]
			cmp r4, r5
			bne end
			
		next:
			cmp r7, #0
			moveq r8, r3
			add r7, r7, #1
			b end
			
		end:
		cmp r7, r6
		beq return
			
		cmp r3, r0
		blt loop
	
	mov r8, #-1
	
return:
	mov r0, r8
	pop {r1-r11, lr}
	bx lr

	.end
