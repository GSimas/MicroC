/*
 * LCD_Asterisk.c
 *
 * Created: 05/11/2015 20:08:31
 * Author : Gustavo
 */ 

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include "ls_defines.h"
#include "ls_atmega328.h"
#include "ls_hd44780.h"


int main(void)
{
    lcdInit();
	lcdStdio();
	int i = 0;
	
	printf("*");
	
    while (1) 
    {
		for(i=0;i<15;i++)
		{
			lcdDisplayShiftRight();
			_delay_ms(100);
		}
		for(i=15;i>0;i--)
		{
			lcdDisplayShiftLeft();
			_delay_ms(100);
		}
    }
}

