/*
 * CTC-MotordePasso.c
 *
 * Created: 26/10/2015 19:18:45
 * Author : Gustavo
 */ 

#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/pgmspace.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "ls_atmega328.h"
#include "LS_defines.h"

#define MOTOR_PORT PORTB
#define MOTOR_DDR DDRB

#define BOB0 PB0
#define BOB1 PB1
#define BOB2 PB2
#define BOB3 PB3

ISR(TIMER0_COMPA_vect);

volatile unsigned char cont = 0;

int main(void)
{
	MOTOR_DDR = 0b11111111;
	MOTOR_PORT = 0x00;
	
	timer0ClockPrescaller1024();
	timer0ActivateCompareAInterrupt();
	timer0CTCMode();
	timer0SetCompareAValue(255);
	
	sei();
   
    while (1) 
    {
    }
}

ISR(TIMER0_COMPA_vect)
{
	clrBit(MOTOR_PORT, BOB0);
	clrBit(MOTOR_PORT, BOB1);
	clrBit(MOTOR_PORT, BOB2);
	clrBit(MOTOR_PORT, BOB3);
	
	if(cont == 20)
	setBit(MOTOR_PORT, BOB0);
	
	if(cont == 40)
	setBit(MOTOR_PORT, BOB1);
	
	if(cont == 60)
	setBit(MOTOR_PORT, BOB2);
	
	if(cont == 80)
	setBit(MOTOR_PORT, BOB3);
	
	cont++;
	
	if(cont > 80)
	cont = 0;
}
