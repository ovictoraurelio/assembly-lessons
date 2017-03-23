// a = input some value, b = input some value
// the assembly in this file: if(a >= 0 && b <= 64) x = 1 else x =0
.data
	a: .word inputValueHere
	b: .word inputValueHere
	x: .word 0
	
	.text
	.globl start
	.ent start
	
start:
	lw $8, a
	lw $9, b
	lw $10, x
	
	bgez $8, compareB 			// if a >= 0
	j end
	compareB:
		addi $12, $0, 64 		// storing 64 on register 12.
		
		slt $11, $9, $12		//
		bne $11, $0, verdade	//  compare if  < 64 
		
		beq $9, $12, verdade 	//  compare if == 64
		
		j end	
			
		verdade:								
				addi $10, $0, 1
				sw $10, x
	end:
		break;	
.end start	
