org 0x7c00 ;this command

jmp 0x0000:start

start:
				; ax is a reg to geral use
				; ds
	mov ax,0 		;ax = 0
	mov ds,ax 		;ds = 0
;	mov cl,0x0D		;cl = 0

	scanf:
		mov ah,0	; Keyboard read
		int 16h		; Keyboard interrupt



	printKeyboard:

		mov ah, 0xe	; Screen show content of al
		int 10h		; Screen interrupt

		cmp al,0x0D
		je compare

		mov bl,al
		jmp scanf

	compare:

		mov al, 10
		int 10h
		mov al,13
		int 10h

		and bl, 1
		je even

		odd:
			mov al, 'i'
			int 10h
			mov al, 'm'
			int 10h
			mov al, 'p'
			int 10h
			mov al, 'a'
			int 10h
			mov al, 'r'
			int 10h

			jmp endline


		even:
			mov al, 'p'
			int 10h
			mov al, 'a'
			int 10h
			mov al, 'r'
			int 10h

			jmp endline



		endline:
			mov al, 10
			int 10h
			mov al, 13
			int 10h
			jmp scanf


storenumber:
	mov dx, al


end:
	jmp $
	times 510 - ($ - $$) db 0
	dw 0xaa55