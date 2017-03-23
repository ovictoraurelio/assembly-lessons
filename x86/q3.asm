org 0x7c00 ;this command

;   ♥ ♥ ♥ ♥ ♥
;   Assembly is love
;   @ovictoraurelio


jmp 0x0000:start

stringH: times 64 db 0
stringL: times 64 db 0
stringMesmoTamanho: db 13, 10, 'As strings tem o mesmo tamanho' , 13, 10 , 0

start:
	; ax is a reg to geral use
	; ds
	mov ax,0 	;ax = 0
  mov ds, ax
	mov es, ax

  mov ch,0  ; ch=0
	mov cl,0	; cl=0







  get_stringH:
      mov ch,0
      ;mov al, '\0'	;indicar começo da string ( por causa da stack)
      mov al, ' '
      mov di, stringH	    ;di recebe o primeiro endereço de 'string1'
      stosb
      .loop:

          mov ah, 0	    ;instrução para ler do teclado
      		int 16h		    ;interrupt de teclado

          cmp al, 0x1B	;comparar com ESC
          je end			  ;acabar programa
          cmp al, 0x0D	;comparar com \n
          je .done	;fim da string

          ;; IS A VALID char
          call show_char	    ;mostra caracter na tela

          ;push ax		          ;manda ax para a pilha (vai servir em .transform)
          stosb			        ;manda char em al para string e di++
          ;pop ax
          inc ch              ; INCREMENT ch

          jmp .loop 		;próximo caractere
    .done:
          mov al, 0;
          stosb
          mov al,0x0A
          call show_char
          mov al,0x0D
          call show_char
        ;  add ch, 48
        ;  mov al, ch
        ;  call show_char

        ;  mov al,0x0A
        ;  call show_char
        ;  mov al,0x0D
        ;  call show_char
        ;  mov si, stringH

        ;  call show_string









get_stringL:
    mov cl,0
    mov al, ' '	;indicar começo da string ( por causa da stack)
    mov di, stringL    ;di recebe o primeiro endereço de 'string1'
    stosb

    .loop:
          mov ah, 0	    ;instrução para ler do teclado
      		int 16h		    ;interrupt de teclado

          cmp al, 0x1B	;comparar com ESC
          je end			  ;acabar programa
          cmp al, 0x0D	;comparar com \n
          je .done	;fim da string

          ;; IS A VALID char
          call show_char	    ;mostra caracter na tela

          ;push ax		          ;manda ax para a pilha (vai servir em .transform)
          stosb			        ;manda char em al para string e di++
          ;pop ax
          inc cl              ; INCREMENT cl

          jmp .loop 		;próximo caractere
    .done:
        mov al, 0
        stosb
        mov al,0x0A
        call show_char
        mov al,0x0D
        call show_char
        ;add cl, 48
        ;mov al,cl
        ;call show_char















        ;jmp get_stringH

logical:
    cmp cl,ch
    je .mesmoTamanho

    cmp cl,ch
    jl .printH
        .printL:
          mov cl,0
          mov si, stringL
          call show_string
          jmp get_stringH
        .printH:
          mov cl,0
          mov si, stringH
          call show_string
          jmp get_stringH

    .mesmoTamanho:
        mov si, stringMesmoTamanho
        call show_string
        jmp get_stringH
























show_string:
	lodsb		; load al, si index and si++
	cmp al,0	; compare al with 0 (0, was set as end of string)
	je endshowstring

	mov ah,0xe	; instruction to show on screen
	mov bh, 13h
	int 10h		; call video interrupt

jmp show_string
endshowstring: ret



show_char:		;imprime o caracter em al
    mov ah, 0x0e	;instrução para imprimir na tela
    int 10h		;interrup de tela
ret

print:
	lodsb		     ; load al, si index and si++
	cmp cl,al	   ; compare al with 0 (0, was set as end of string)
	je endprint

	mov ah,0xe	  ; instruction to show on screen
	mov bh, 13h
	int 10h		    ; call video interrupt

jmp print
endprint: ret  ;this remove print from stack

end:
	jmp $
	times 510 - ($ - $$) db 0
	dw 0xaa55