#include <reg51.h>
	

/* prototipo de funcao externa */
extern unsigned short   inc_arg(unsigned short);

void main(void)
{
unsigned short teste;

teste=0;

while(1) {
	  
	  teste=inc_arg(teste);  // função salva em outro arquivo...
			        // ... Irá incrementar o parâmetro passado
	}

}