/*
 * ConversorAD.c
 *
 * Created: 26/11/2015 14:58:31
 *  Author: Aluno
 */ 

#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include "ls_atmega328.h"
#include "ls_hd44780.h"
#include "ls_defines.h"

#define LM35_PORT PORTC
#define LM35_DDR DDRC

#define BUTTON_PORT PORTD
#define BUTTON_DDR DDRD

ISR(INT0_vect); //Int0 do botao
ISR(TIMER0_COMPA_vect); //timer
ISR(ADC_vect);

volatile char escala = 'C';
volatile int temp_LM35 = 10;
volatile int temperatura;
volatile uint8 estado;


int main(void)
{
	LCD_DATA_PORT = 0x00;
	LCD_DATA_DDR = 0xFF;
	
	BUTTON_PORT = 0x00;
	BUTTON_DDR = 0b11110000;
	
	LM35_PORT = 0x00;
	LM35_DDR = 0x00;
	
	int0PullUpEnable();
	int0SenseRisingEdge();
	int0ActivateInterrupt();	
	
	timer0ClockPrescaller1024();
	timer0ActivateCompareAInterrupt();
	timer0CTCMode();
	timer0SetCompareAValue(15);
	
	adcReferenceAvcc();
	adcClockPrescaler128();
	
	adcEnableAutomaticMode();
	adcTriggerTimer0CompareMatchA();	
	
	adcSelectChannel(ADC0); //adcChannel = 0 = PC0
	adcEnableDigitalInput0();
	
	adcResultRightAdjust();
	
	adcEnable();
		
	adcActivateInterrupt();
	
	adcStartConversion();
	
	lcdStdio();
	lcdInit();
	lcdDisplayOn();
		
	sei();
	
	
    while(1)
    {
       switch (estado)
	   {
		   case 0:
		   printf("Sensor de\nTemperatura");
		   _delay_ms(20);
		   lcdClearScreen();
		   printf("Temperatura:\n");
		   estado = 1;
		   break;
		   
		   case 1:
		   lcdCursorMoveFirstLine();
		   lcdCursorMoveNextLine();
		   printf("%d  %c", temperatura, escala);
		   break;
    }
	}
}

ISR(INT0_vect)
{
	
	if(escala == 'C')
	{
		escala = 'F';
	}
	
	else if (escala == 'F')
	{
		escala = 'C';
	}
	
	_delay_ms(20);
}

ISR(TIMER0_COMPA_vect)
{
	
}

ISR(ADC_vect)
{
	temp_LM35 = ADC*500/1024;
	
	if (escala == 'F')
	{
		temperatura = (temp_LM35 * 1.8) + 32;
	}
	
	else if(escala == 'C')
	{
		temperatura = temp_LM35;
	}
	
	adcWaitConversionFinish();
	adcClearInterruptRequest();
	
}
