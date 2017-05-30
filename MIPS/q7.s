//
//  @authors 
//     @nmf2 e @vags
//
#include <reg.h>
.data
string: .ASCIIZ "nmf2-vags-jgfn"	//Define a string de entrada
char: .ASCIIZ "a"			 		//Define o caractere de entrada
.set noreorder 					 	//Obrigatório para essa questão
.text
.globl start
.ent start
start:
    
    lui $17, char
    lui $20, string    
    lui $16, 0x8002    
        
    srl $17, $17, 16
    srl $20, $20, 16
    
    nop
    nop
    
    add $17, $16, $17
    add $20, $16, $20
        
  	nop
  	
    lbu $18, 0($17) 			// carrega caractere em $18
       
	loop:
		lbu $21, 0($20) 		// carrega string[i] em $21
		addi $20, $20, 1 		// atualiza endereço do próximo caractere de string		
		nop
		beq $0, $21, end 		// Não é o fim da string, continue a execução.
		nop 
		nop 
		nop
		bne $18, $21, loop  	// compara $21{string[i]} com $18{char} é diferente do character de string?		
		nop
		nop
		nop
		addi $2, $2, 1 			// Se não, some o contador
		j loop
		nop
		nop
		nop
	end:
	break //the end
.end start
