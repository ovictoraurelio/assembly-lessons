org 0x7c00 ;this command 

jmp 0x0000:start

;intvideo:
;	mov AH, 0xe
;	mov BH, 13h
;	int 10h

string:
	db "Hello Observe Universe", 0

start:
	; ax is a reg to geral use
	; ds 
	mov ax,0 	;ax = 0
	mov ds,ax 	;ds = 0
	mov cl,0	;cl = 0
	; load first memory postion of my string on SI (source)
	mov si, string
	
	print:
		lodsb
		cmp cl,al
		je end

		;jmp intvideo	
		
		mov ah,0xe
		mov bh, 13h
		int 10h

	jmp print

end:
	jmp $
	times 510 - ($ - $$) db 0
	dw 0xaa55

	
	
	
