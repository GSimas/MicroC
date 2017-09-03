#include <reg51.h> // Arquivo com os endereços dos registradores do 8051

void main()
{
	short i;
	//unsigned char j;
	P0 = 0x80;	//Habilita apenas o CS do decoder dos 7seg
	P3 = 0xFF;	//Mantem todos os pinos P3 em alto (P3.3 (A0) e P3.4 (A1) estão ligados ao decoder)

	while(1)
	{
		for(i=0; i<6000; i++);	//Criando delay
		P1 = ~P2;			
	}

}