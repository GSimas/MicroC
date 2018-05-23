//UNIVERSIDADE FEDERAL DE SANTA CATARINA
//CENTRO TECNOLOGICO - CTC - ENGENHARIA ELETRONICA
//EEL7030 MICROPROCESSADORES
//GUSTAVO SIMAS DA SILVA
//Escreve n?meros hexadecimais  (0 a F) nos 4 displays do 		                     
//...EDSIM51.  Utilizando timer 1 no modo 1 para inserir atraso

#include <reg51.h> 


unsigned char converte_7seg (unsigned char);
void delay (void);


unsigned char bdata cntdsp = 3;
unsigned char atraso;


 sbit  	CS=P0^7;	  
 sbit  	cntdsp_1=cntdsp^1;   
 sbit 	cntdsp_0=cntdsp^0;    
 sbit  	END1=P3^4;      
 sbit  	END0=P3^3;
	     
void main (void) 	     {
unsigned char j=0;
   
		TMOD = 0x10; 	
		TCON = 0;
		EA = 1;
		ET1 = 1;
		CS=0;
  
    while (1)    {	
			
						//end. dsp
						END1=cntdsp_1;	
						END0=cntdsp_0; 
			
						P1= converte_7seg(j);	
			
						j++;
			
						CS=1;

						TH1 = 0x00;
						TL1 = 0x00;
						TR1 = 1;
						atraso = 0;
			
						while(atraso!=3);
						TR1 = 0;
			
						if (cntdsp==0)  cntdsp=4; 
			
						cntdsp--;  
			
						CS=0; 
			
						if ( j == 16) j=0;
			
	        }
     		  	  	} //end of main

								
void delay (void) interrupt 3 {
atraso++;} /* end of delay */						
				

unsigned char converte_7seg (unsigned char dado) //   fun??o retorna valor a ser escrito?
{					  //? nos displays para formar o caractere
 unsigned char leds;
      
switch (dado) 			      	    // GFEDCBA
	{
      		case 0:    leds  = 0x40; break;   // "1000000";
      		case 1:    leds  = 0x79; break;   // "1111001";
					case 2:    leds  = 0x24; break;   // "0100100";
      		case 3:    leds  = 0x30; break;   // "0110000";
      		case 4:    leds  = 0x19; break;   // "0011001";
					case 5:    leds  = 0x12; break;   // "0010010";
      		case 6:    leds  = 0x02; break;   // "0000010";
      		case 7:    leds  = 0x78; break;   // "1111000";
      		case 8:    leds  = 0x00; break;   // "0000000";
      		case 9:    leds  = 0x10; break;   // "0010000";
					case 10:   leds  = 0x08; break;   // "0001000";
      		case 11:   leds  = 0x03; break;   // "0000011";
      		case 12:   leds  = 0x46; break;   // "1000110";
      		case 13:   leds  = 0x21; break;   // "0100001";
      		case 14:   leds =  0x06; break;   // "0000110";
      		case 15:   leds =  0x0E; break;   // "0001110";
      		default:   leds =  0x80;          // "0000000";
        }

   return leds;

      } // end converte
