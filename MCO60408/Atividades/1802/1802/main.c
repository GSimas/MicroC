/*
 * 1802.c
 *
 * Created: 18/10/2015 16:10:08
 * Author : Gustavo
 */ 

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/pgmspace.h>
#include <stdlib.h>
#include <stdio.h>

#define set_bit(Y, bit_x) (Y|=(1<<bit_x))
#define clr_bit(Y, bit_x) (Y&=~(1<<bit_x))
#define cpl_bit(Y, bit_x) (Y^=(1<<bit_x))
#define tst_bit(Y, bit_x) (Y&(1<<bit_x))

#define DISPLAY_PORT PORTD
#define DISPLAY_DDR DDRD

#define A_seg PD0
#define B_seg PD1
#define C_seg PD2
#define D_seg PD3
#define E_seg PD4
#define F_seg PD5
#define G_seg PD6

#define BOTAO_PORT PORTB
#define BOTAO_DDR DDRB
#define BOTAO PB7

#define DISPLAY0 PB0
#define DISPLAY1 PB1
#define DISPLAY2 PB2
#define DISPLAY3 PB3

const unsigned char Tabela[] PROGMEM = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78,
										0x00, 0x18, 0x08, 0x03, 0x46, 0x21, 0x06, 0x0E};

int main(void)
{
	DISPLAY_PORT = 0b11111111;
	DISPLAY_DDR = 0xFF;
	BOTAO_PORT = 0b01111111;
	BOTAO_DDR = 0xFF;
	
    unsigned char i = 0;
	unsigned int n = 0;
	unsigned int leds[4];
	unsigned int valor = 1802;
	
	
	
    while (1) 
    {
		leds[0] = (valor % 10) - 1;
		leds[1] = ((valor/10) % 10) - 1;
		leds[2] = ((valor/100) % 10) - 1;
		leds[3] = ((valor/1000) % 10) - 1;
				
			for(i=0; i<4; i++)
			{
				clr_bit(BOTAO_PORT, DISPLAY0);
				clr_bit(BOTAO_PORT, DISPLAY1);
				clr_bit(BOTAO_PORT, DISPLAY2);
				clr_bit(BOTAO_PORT, DISPLAY3);
				
				n = leds[i];
				
				DISPLAY_PORT = pgm_read_byte(&Tabela[n+1]);
				
				if(i == 0)
					set_bit(BOTAO_PORT, DISPLAY0);
				if(i == 1)
					set_bit(BOTAO_PORT, DISPLAY1);
				if(i == 2)
					set_bit(BOTAO_PORT, DISPLAY2);
				if(i == 3)
					set_bit(BOTAO_PORT, DISPLAY3);
				_delay_ms(3);				
			}
		while(tst_bit(PINB, BOTAO))
		{
			leds[0] = (valor % 10) - 1;
			leds[1] = ((valor/10) % 10) - 1;
			leds[2] = ((valor/100) % 10) - 1;
			leds[3] = ((valor/1000) % 10) - 1;
			
			for(i=0; i<4; i++)
			{
				clr_bit(BOTAO_PORT, DISPLAY0);
				clr_bit(BOTAO_PORT, DISPLAY1);
				clr_bit(BOTAO_PORT, DISPLAY2);
				clr_bit(BOTAO_PORT, DISPLAY3);
				
				n = leds[i];
				
				DISPLAY_PORT = pgm_read_byte(&Tabela[n+1]);
				
				if(i == 0)
				set_bit(BOTAO_PORT, DISPLAY0);
				if(i == 1)
				set_bit(BOTAO_PORT, DISPLAY1);
				if(i == 2)
				set_bit(BOTAO_PORT, DISPLAY2);
				if(i == 3)
				set_bit(BOTAO_PORT, DISPLAY3);
				_delay_ms(3);
			}
			if(!tst_bit(PINB, BOTAO))
			valor++;
		}
  }
}

