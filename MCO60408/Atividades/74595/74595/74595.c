/*
 * numero_random.c
 *
 * Created: 08/10/2015 14:25:08
 *  Author: Aluno
 */ 

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>

#define set_bit(Y,bit_x) (Y|=(1<<bit_x))
#define clr_bit(Y,bit_x) (Y&=~(1<<bit_x))
#define cpl_bit(Y,bit_x) (Y^=(1<<bit_x))
#define tst_bit(Y,bit_x) (Y&(1<<bit_x))

#define SN74595_DDR DDRC
#define SN74595_PORT PORTC

#define SN74595_SER PC0
#define SN74595_SRCLK PC2
#define SN74595_SRCLR PC1
#define SN74595_RCLK PC3
#define SN74595_OE PC4
								
int main(void)
{
	unsigned char i = 0;
	unsigned char cont = 0;
	SN74595_DDR = 0b00011111;
	SN74595_PORT = 0x00;
	
	unsigned char Tabela[16] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78,
								0x00, 0x18, 0x08, 0x03, 0x46, 0x21, 0x06, 0x0E};
	
	set_bit(SN74595_PORT, PC5);
	set_bit(SN74595_PORT, SN74595_SRCLR);
	
    while(1)
    {
		//armazenar dado
		for(i=0; i < 8; i++)
		{
			if(tst_bit(Tabela[cont],i))
				set_bit(SN74595_PORT, SN74595_SER);
			else
				clr_bit(SN74595_PORT,SN74595_SER);
			set_bit(SN74595_PORT, SN74595_SRCLK);
			clr_bit(SN74595_PORT, SN74595_SRCLK);
		}
		//mostrar dado
			set_bit(SN74595_PORT, SN74595_RCLK);
			_delay_ms(200);
			clr_bit(SN74595_PORT, SN74595_RCLK);
			_delay_ms(200);
		//incrementar dado
		cont++;
		if(cont >= 16)	
			cont = 0;	
	}
	return 0;
}