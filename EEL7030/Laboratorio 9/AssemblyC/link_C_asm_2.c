#pragma src  // fun��o  que incrementa o argumento passado e o retorna
#pragma small 		// ao compilar, gera arquivo com extens�o .SRC...
			// ... que deve integrar o projeto com o main.

/* prototipo de funcao externa */

extern void main(void);

/* codigo da funcao */


unsigned short  inc_arg(unsigned short dado)
{
		#pragma asm
		MOV   A,B
		#pragma endasm
return dado;
}
