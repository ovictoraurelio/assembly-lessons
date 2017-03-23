org 0x7c00 
jmp 0x0000:start

error: db "Not a number"
negative: db 0
mult: dw 1
num: dw 1
temp: dw 1

start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	get_number:
		mov al, '\0'	;indicar começo da string ( por causa da stack)
		push ax		;manda ax para a pilha (vai servir em .transform)

		mov ah, 0	;instrução para ler do teclado
		int 16h		;interrupt de teclado
		mov di, number	;di recebe o primeiro endereço de 'number'

				;checar se é número negativo
		cmp al, '-'	;checa se o caractere lido é o '-'
		jne .loop	;se não for o '-' vá para loop

		call print_char	;mostra caracter na tela

		jg .nan		;not a number, jump to .nan

		mov di, negative
		mov al, 1	;coloca 1 em al 
		stosb		;pega al e coloca em es:di (es = 0, di = negative)

		.loop:

		mov ah, 0	;instrução para ler do teclado
		int 16h		;interrupt de teclado

		cmp al, '\e'	;comparar com ESC
		je end		;acabar programa
		cmp al, '\n'	;comparar com \n
		je .transform	;fim da string
		cmp al, '0'	;comparar al com '0'
		jl .loop	;se for menor que '0' não é um número, ignore
		cmp al, '9'	;comparar al com '9'
		jg .loop	;se for maior que '9' não é um numero, ignore

				;caso contrario
		call print_char ;imprime o caracter recebido
		sub al, '0'	;transforma ascii em inteiro
		xor ah, ah	;zerar ah
		push ax		;mandar ah e al para a pilha pois al não pode ir sozinho, ah será ignorado
		jmp .loop 	;próximo caractere

		.transform: 	;transformar string em numero
		pop ax		;pop na pilha
		cmp al, 0	;se for o \0
		je .done	;acabou get_number
		mul [mult]	;multiplica ax por mult (mul) e salva em dx:ax
				;salva em 'num'
		mov di, num	;
		stosw		;salva ax em num

		mov ax, [mult]	;salva muti em ax
		mov cl, 10	;cl = 10
		mul cl		;multiplica ax por 10 

		mov di, mult	;di = mult
		stosw		;manda al para mult
		jmp .transform	;recomeça

		.done:
				;imprime a string (salvar string na memoria tbm)
		call calculate	;calculate faz as contas com inteiro (num)

	show_number:
		or [negative], [negative]
		jz .positive 	;se for positivo pule a impressão de '-'

		mov ah, 0x0e	;instrução para imprimir na tela
		mov cl, al	;salva al em cl
		mov al, '-'	;al recebe '-'
		int 10h 	;interrupt de tela - imprime al
		mov al, cl	;coloca o valor de al de volta em al
				;continua para imprimir o número com se fosse positivo
		.positive
		mov ah, 0x0e	;instrução para imprimir na tela
		add al, '0'
		int 10h 	;interrupt de tela
		sub al '0'
	show_char:		;imprime o caracter em al
		mov ah, 0x0e	;instrução para imprimir na tela
		int 10h		;interrup de tela
		ret

	
end:
jmp $
times 510-($-$$) db 0		; preenche o resto do setor com zeros 
dw 0xaa55			; coloca a assinatura de boot no final
				; do setor (x86 : little endian)
