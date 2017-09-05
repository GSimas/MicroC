#include <reg51.h> // Arquivo com os endereços dos registradores do 8051

unsigned char convert_7seg(unsigned char);

void main()
{
	short i;
	short count;
	unsigned char data switchsVals;
	unsigned char data P2invert;
	unsigned char j;
	P0 = 0x80;	//Habilita apenas o CS do decoder dos 7seg
	P3 = 0xFF;	//Mantem todos os pinos P3 em alto (P3.3 (A0) e P3.4 (A1) estão ligados ao decoder)
	while(1)
	{
		P2invert = ~P2;				//Complementa os valores de P2 pois é como o EDSIM funciona
		for(j=0;j<8;j++) 			//Loop de 8 turnos para checar cada chave
		{
			for(i=0; i<6000; i++);				//Criando delay
			switchsVals = P2invert << j;   		//Armazena no switchsVals os valores de P2 deslocados em j vezes.
			switchsVals = switchsVals & 0x80;	//Multiplica o MSB do valor deslocado por 1 e o resto por 0. Assim somente o MSB será 1 (ou 0)
			if(switchsVals == 0x80) count++;	//Checa se o MSB é 1 ou não, ou seja, vê se aquela chave está fechada e incrementa a contagem
			//Faz um novo loop e checa a proxima chave (deslocando mais vetores dessa vez)
		}
		P1 = convert_7seg(count); 	//Joga o valor da contagem realizada para o P1 que mostrará no display 7seg
		count = 0;					//Zera o contador
	}

}

unsigned char convert_7seg(unsigned char dado)
{
	//Converte o dado enviado para (de 0 a 15) para o formato compativel com displays hexadecimais (sete segmentos)
	unsigned char led;
	switch(dado)					// "GFEDCBA"
	{
		case 0: led = 0x40; break; 	// "1000000";
		case 1: led = 0x79; break; 	// "1111001";
		case 2: led = 0x24; break; 	// "0100100";
		case 3: led = 0x30; break; 	// "0110000";
		case 4: led = 0x19; break; 	// "0011001";
		case 5: led = 0x12; break; 	// "0010010";
		case 6: led = 0x02; break; 	// "0000010";
		case 7: led = 0x78; break; 	// "1111000";
		case 8: led = 0x00; break; 	// "0000000";
		case 9: led = 0x10; break; 	// "0010000";
		case 10: led = 0x08; break; // "0001000";
		case 11: led = 0x03; break; // "0000011";
		case 12: led = 0x46; break; // "1000110";
		case 13: led = 0x21; break; // "0100001";
		case 14: led = 0x06; break; // "0000110";
		case 15: led = 0x0E; break; // "0001110";
		default: led = 0x80; 		// "0000000";
	}

	return led;
}