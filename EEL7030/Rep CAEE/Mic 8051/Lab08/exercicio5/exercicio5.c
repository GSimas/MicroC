#include <reg51.h> // Arquivo com os endere�os dos registradores do 8051

unsigned char timerRounds = 0;
void main()
{
	short i;
	P0 = 0x00;		//Desabilita 7 seg
	P1 = 0xFF;
	P3 = 0xFF;		//Mantem todos os pinos P3 em alto (P3.3 (A0) e P3.4 (A1) est�o ligados ao decoder)
	IE = 0x82;		//Ativa a interrup��o do timer 0
	TMOD = 0x02; 	//Timer 0 no modo 2
	TH0	= 0xFF;		//Valor alto do timer 0 (usado para o reload)
	TL0 = 0x00;		//Valor baixo do timer 0 (usado para contagem)
	TR0 = 1;		//Ativa timer 0

	while(1)
	{
		unsigned char data deslocated; 		//Vari�vel utilizada para salvar valor que ir� para os LEDs
		for(i = 0;i<8;i++) 					//Rotaciona 8 vezes os LEDs (ligando eles no EDSIM)
		{
			deslocated = 0xFF << i;			//Desloca i vezes para a esquerda o valor FFh
			while(timerRounds != 0x0020){}	//Aguarda o timerRounds ficar no valor desejado. Para tal est� sendo utilizado o timer 0
			P1 = deslocated;				//Joga o valor de deslocated para P1, exibindo nos LEDs
			timerRounds = 0x00;				//Zera o timerRounds para uma nova contagem
		}
		for(i = 0;i<8;i++) 					//Rotaciona 8 vezes os LEDs (desligando eles no EDSIM)
		{
			deslocated = 0xFF << i;			//Desloca i vezes para a esquerda o valor FFh
			while(timerRounds != 0x0020){}	//Aguarda o timerRounds ficar no valor desejado. Para tal est� sendo utilizado o timer 0
			P1 = ~deslocated;				//Joga o valor de deslocated para P1, exibindo nos LEDs
			timerRounds = 0x00;				//Zera o timerRounds para uma nova contagem
		}
	}

}

void isr_timer0 (void) interrupt 1
//Fun��o que � utilizada para tratar a interrup��o 1 (endere�o 0x0B) que � relativa ao timer 0
{
	timerRounds++; //Incrementa timerRounds toda vez que � feito TL0 vai de FFh para 00h
	TL0 = 0x00;
}