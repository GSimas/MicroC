//**********************************************************************************
// Si8250.h
//**********************************************************************************
// Copyright 2005 Silicon Laboratories, Inc.
//
// AUTHOR: RM / FB
// DATE:   13 MAY 05
//
// VERSION: 1.5 (Beta)
//
// Digital SMPS Controller Firmware
// 
// Register/bit definitions for the Si8250 MCU
// 
// Target: Si8250
// Tool chain: KEIL C51 6.03 / KEIL EVAL C51
//
//---------------------------------------------------------------------------------

sfr P0		   =0x80;		/* PORT0 */
sfr SP		   =0x81;		/*STACK POINTER*/
sfr DPL		   =0x82;		/*DATA POINTER- LOW BYTE*/
sfr DPH		   =0x83;		/*DATA POINTER- HIGH BYTE*/
sfr CRC0CN	   =0x84;		/*CRC CONTROL*/
sfr CRC0IN	   =0x85;		/*CRC DATA INPUT*/
sfr CRC0DAT	   =0x86;		/*CRC RESULTS REGISTER*/
sfr PCON	      =0x87;		/*POWER CONTROL*/
sfr TCON	      =0x88;		/*TIMER CONTROL*/
sfr TMOD	      =0x89;		/*TIMER MODE*/
sfr TL0		   =0x8A;		/*TIMER 0 - LOW BYTE*/
sfr TL1		   =0x8B;		/*TIMER 1 - LOW BYTE*/
sfr TH0		   =0x8C;		/*TIMER 0 - HIGH BYTE*/
sfr TH1		   =0x8D;		/*TIMER 1 - HIGH BYTE*/
sfr CKCON	   =0x8E;		/*CLOCK CONTROL*/
sfr PSCTL	   =0x8F;		/*PROGRAM STORE READ/WRITE CONTROL*/

sfr P1		   =0X90;		/*PORT 1*/
sfr TMR3CN	   =0X91;		/*TIMER 3 CONTROL*/
sfr TMR3RLL	   =0X92;		/*TIMER3 LOW RELOAD*/
sfr TMR3RLH	   =0X93;		/*TIMER3 HIGH RELOAD*/
sfr TMR3L	   =0X94;		/*TIMER3 LOW BYTE*/
sfr TMR3H	   =0X95;		/*TIMER 3 HIGH BYTE*/
sfr REFDAC0L	=0X96;		/*RDAC 0 DATA WORD LSB REGISTER*/
sfr REFDAC0H	=0X97;		/*RDAC 0 CONTROL REGISTER*/

sfr SCON0	   =0X98;		/*SERIAL PORT CONTROL*/
sfr SBUF0	   =0X99;		/*SERIAL PORT BUFFER*/
sfr CPT1CN	   =0X9A;		/*COMPARATOR 1 CONTROL*/
sfr CPT0CN	   =0X9B;		/*COMPARATOR 0 CONTROL*/
sfr OSCLCN	   =0X9C;		/*LOW FREQUENCY OSCILLATOR CONTROL*/
sfr CPT0MD	   =0X9D;		/*COMPARATOR 0 MODE*/
sfr CPT1MX	   =0X9E;		/*COMPARATOR 1 MUX SELECT*/
sfr CPT0MX	   =0X9F;		/*COMPARATOR 0 MUX SELECT*/

sfr IPKCN		=0XA0;		/*DSR FLAG REGISTER (DBI ONLY)*/
sfr P2			=0XA0;		/*PORT 2 (non-DBI only)*/
sfr DPWMLCD0	=0XA1;		/*DPWM LCD0 REGISTER*/
sfr DPWMLCD1	=0XA2;		/*DPWM LCD1 REGISTER*/
sfr DPWMLCD2	=0XA3;		/*DPWM LCD2 REGISTER*/
sfr P0MDOUT		=0XA4;		/*PORT 0 MODE OUT*/
sfr P1MDOUT		=0XA5;		/*PORT 1 MODE OUT*/
sfr DPWMOUT		=0XA6;		/*DPWM CONTROL REGISTER*/
sfr SFRPAGE		=0XA7;		/*SFR PAGE REGISTER*/

sfr IE		   =0XA8;		/*INTERRUPT ENABLE*/
sfr CLKSEL	   =0XA9;		/*CLOCK SELECT REGISTER*/
sfr EMI0CN	   =0XAA;		/*EMIF CONTROL*/
sfr ADC0ADDR	=0XAB;		/*ADC0 ADDRESS REGISTER*/
sfr BP1L	      =0XAB;		/*BREAKPOINT 1 - LOW BYTE*/
sfr ADC0DATA	=0XAC;		/*ADC0 DATA REGISTER*/
sfr BP1H	      =0XAC;		/*BREAKPOINT 1 - HIGH BYTE*/
sfr DPWMADDR	=0XAD;		/*DPWM INDIRECT ADDRESS REGISTER*/
sfr XADRL	   =0XAD;		/*XRAM SFR PORT LOW ADDRESS*/
sfr ADDRL	   =0XAE;		/*FLASH ADDRESS LOW*/
sfr DPWMDATA	=0XAE;		/*DPWM INDIRECT DATA REGISTER*/
sfr ONESHOT	   =0XAF;		/*ONESHOT CONTROL REGISTER*/
sfr ADDRH	   =0XAF;		/*FLASH ADDRESS HIGH*/


sfr P0ODEN	   =0XB0;		/*P0 OVERDRIVE ENABLE*/
sfr OSCXCN	   =0XB1;		/*EXTERNAL OSCILLATOR CONTROL*/
sfr OSCICN	   =0XB2;		/*INTERNAL OSCILLATOR CONTROL*/
sfr OSCICL	   =0XB3;		/*INTERNAL OSCILLATOR CALIBRATION*/
sfr DSRCMD	   =0XB4;		/*DSR COMMAND REGISTER*/
sfr ADC0STA0   =0XB5;		/*ADC0 Interrupt Status*/
sfr FLSCL	   =0XB6;		/*FLASH MEMORY TIMING PRESCALER*/
sfr FLKEY	   =0XB7;		/*FLASH LOCK REGISTER*/

sfr IP		   =0XB8;		/*INTERRUPT PRIORITY*/
sfr PLLCN	   =0XB9;		/*PLL200 CONTROL REGISTER*/
sfr ADC0TK	   =0XBA;		/*IDAC 0 CONTROL REGISTER*/
sfr ADC0MX	   =0XBB;		/*ADC 0 MUX CONTROL*/
sfr ADC0CF	   =0XBC;		/*ADC 0 CONFIG REGISTER*/
sfr ADC0L	   =0XBD;		/*ADC 0 LSB RESULT*/
sfr ADC0H	   =0XBE;		/*ADC 0 MSB RESULT*/
sfr ADC0STA1   =0XBF;		/*FLASH DATA REGISTER*/


sfr SMB0CN	   =0XC0;		/*SM BUS CONTROL*/
sfr SMB0CF	   =0XC1;		/*SM BUS CONFIG*/
sfr SMB0DAT	   =0XC2;		/*SM BUS DATA*/
sfr ADC0GTL	   =0XC3;		/*ADC 0 GREATER THAN LSB*/
sfr ADC0GTH	   =0XC4;		/*ADC 0 GREATER THAN MSB*/
sfr ADC0LTL	   =0XC5;		/*ADC 0 LESS THAN LSB*/
sfr ADC0LTH	   =0XC6;		/*ADC 0 LESS THAN MSB*/
sfr ADC0LM0	   =0XC7;		/*PORT 1 MASK REGISTER*/
sfr XADRH	   =0XC7;		/*XRAM SFR PORT HIGH ADDRESS*/


sfr TMR2CN	   =0XC8;		/*TIMER 2 LOW BYTE*/
sfr ADC0LM1	   =0XC9;		/*REGULATOR CONTROL*/
sfr TMR2RLL	   =0XCA;		/*TIMER 2 - LOW BYTE*/
sfr TMR2RLH	   =0XCB;		/*TIMER 2 - HIGH BYTE*/
sfr TMR2L	   =0XCC;		/*TIMER 2 - LOW BYTE*/
sfr TMR2H	   =0XCD;		/*TIMER 2 - HIGH BYTE*/
sfr PIDCN	   =0XCE;		/*BREAKPOINT 2 - LOW BYTE*/
sfr PIDUN	   =0XCF;		/*PID OUTPUT REGISTER*/
sfr BP2H	      =0XCF;		/*BREAKPOINT 2 - HIGH BYTE*/

sfr PSW		   =0XD0;		/*PROGRAM STATUS WORD*/
sfr REF0CN	   =0XD1;		/*VOLTAGE REFERENCE 0 CONTROL*/
sfr ICYCST	   =0XD2;		/*PEAK CURRENT DETECTOR CONTROL REGISTER*/
sfr BP3L	      =0XD2;		/*BREAKPOINT 3 LOW BYTE*/
sfr TRDETCN	   =0XD3;		/*ADC TRANSIENT DETECT CONTROL REGISTER*/
sfr BP3H	      =0XD3;		/*BREAKPOINT 3 HIGH BYTE*/
sfr P0SKIP	   =0XD4;		/*PORT 0 SKIP*/
sfr P1SKIP	   =0XD5;		/*PORT 1 SKIP*/
sfr LEBCN	   =0XD6;		/*Leading edge blanking control register*/
sfr OCPCN	   =0XD7;		/*OVERCURRENT PROTECTION CONTROL REGISTER*/


sfr PCA0CN		=0XD8;		/*PCA 0 COUNTER CONTROL*/
sfr PCA0MD		=0XD9;		/*PCA 0 COUNTER MODE*/
sfr PCA0CPM0	=0XDA;		/*CONTROL REGISTER FOR PCA 0 MODULE 0*/
sfr PCA0CPM1	=0XDB;		/*CONTROL REGISTER FOR PCA 0 MODULE 1*/
sfr PCA0CPM2	=0XDC;		/*CONTROL REGISTER FOR PCA 0 MODULE 2*/
sfr PIDA0CN		=0XDD;		/*PID A0 COEFFICIENT*/
sfr PIDDECCN   =0XDE;		/*PID DECIMATION COEFFICIENT*/
sfr CRC0FLIP	=0XDF;		/*PID CONTROL REGISTER*/
sfr ERASE		=0XDF;		/*FLASH ERASE REGISTER*/


sfr P2_C2	   =0XE0;		/*P2 (C2 XFMR ONLY)*/
sfr ACC		   =0XE0;		/*ACCUMULATOR*/
sfr XBR0	      =0XE1;		/*CROSSBAR CONFIGURATION REGISTER 0*/
sfr XBR1	      =0XE2;		/*CROSSBAR CONFIGURATION REGISTER 1*/
sfr CCH0CN	   =0XE3;		/*CACHE CONTROL REGISTER*/
sfr CCHADDR	   =0XE3;		/*CACHE ADDRESS REGISTER*/
sfr IT01CF	   =0XE4;		/*INT0/1 MUX CONTROL REGISTER*/
sfr DSRROP	   =0XE5;		/*DSR OPERAND REGISTER*/
sfr PIDA3CN	   =0XE5;		/*PID A3 COEFFICIENT*/
sfr EIE1	      =0XE6;		/*EXTERNAL INTERRUPT ENABLE 1*/
sfr EIE2	      =0XE7;		/*EXTERNAL INTERRUPT ENABLE 2*/
sfr CCHDATA	   =0XE7;		/*CACHE DATA REGIATER*/


sfr ADC0CN	   =0XE8;		/*ADC 0 CONTROL*/
sfr PCA0CPL1	=0XE9;		/*PCA 0 COMPARE/CAPTURE 0 - LOW BYTE*/
sfr PCA0CPH1	=0XEA;		/*PCA 0 COMPARE/CAPTURE 0 - HIGH BYTE*/
sfr PCA0CPL2	=0XEB;		/*PCA 0 COMPARE/CAPTURE 1 - LOW BYTE*/
sfr PCA0CPH2	=0XEC;		/*PCA 0 COMPARE/CAPTURE 1 - HIGH BYTE*/
sfr PIDA1CN	   =0XED;		/*PID A1 COEFFICIENT*/
sfr PIDA2CN	   =0XEE;		/*PID A2 COEFFICIENT*/
sfr RSTSRC	   =0XEF;		/*RESET SOURCE*/


sfr B		      =0XF0;		/*B REGISTER*/
sfr REFDACMD	=0XF1;		/*REFDAC MODE REGISTER*/
sfr P1MDIN	   =0XF2;		/*P1 INPUT MODE REGISTER*/
sfr PIDKPCN	   =0XF3;		/*PID KP COEFFICIENT*/
sfr PIDKICN	   =0XF4;		/*PID KI COEFFICIENT*/
sfr PIDKDCN	   =0XF5;		/*PID KD COEFFICIENT*/
sfr EIP1	      =0XF6;		/*EXTERNAL INTERRUPT PRIORITY REGISTER 1*/
sfr EIP2	      =0XF7;		/*EXTERNAL INTERRUPT PRIORITY REGISTER 2*/


sfr DPWMCNTL	=0XF8;		/*DPWM CONTROL*/
sfr PCA0L		=0XF9;		/*PCA 0 TIMER - LOW BYTE*/
sfr PCA0H		=0XFA;		/*PCA 0 TIMER - HIGH BYTE*/
sfr PCA0CPL0	=0XFB;		/*PCA 0 COMPARE/CAPTURE 0 - LOW BYTE*/
sfr PCA0CPH0	=0XFC;		/*PCA 0 COMPARE/CAPTURE 0 - HIGH BYTE*/
sfr ADC1DAT		=0XFD;		/*ADC1 DATA REGISTER*/
sfr ADC1CN		=0XFE;		/*ADC1 CONTROL REGISTER*/
sfr VDM0CN		=0XFF;		/*VDD MONITOR CONTROL*/     


/*BIT Registers*/

/* TCON 0X88 */

sbit IT0	   =TCON ^ 0;	/* EXTERNAL INTERRUPT 0 TYPE */
sbit IE0	   =TCON ^ 1;	/* EXTERNAL INTERRUPT 0 EDGE FLAG */
sbit IT1	   =TCON ^ 2;	/* EXTERNAL INTERRUPT 1 TYPE */
sbit IE1	   =TCON ^ 3;	/* EXTERNAL INTERRUPT 1 EDGE FLAG */
sbit TR0	   =TCON ^ 4;	/* TIMER 0 ON/OFF CONTROL */
sbit TF0	   =TCON ^ 5;	/* TIMER 0 OVERFLOW FLAG */
sbit TR1	   =TCON ^ 6;	/* TIMER 1 ON/OFF CONTROL */
sbit TF1	   =TCON ^ 7;	/* TIMER 1 OVERFLOW FLAG */

/* TMR2CN  0XC8 */

sbit TF2H	=TMR2CN ^ 7;	/* T2 HIGH BYTE OVERFLOW FLAG */
sbit TF2L	=TMR2CN ^ 6;	/* T2 LOW BYTE OVERFLOW FLAG */
sbit IE2L	=TMR2CN ^ 5;	/* T2 LOW BYTE FLAG ENABLE */
sbit T2CAP	=TMR2CN ^ 4;	/* T2 CAPTURE ENABLE */
sbit TS2	   =TMR2CN ^ 3;	/* T2 SPLIT-MODE ENABLE */
sbit TR2	   =TMR2CN ^ 2;	/* T2 ON/OFF CONTROL */
sbit TRS2	=TMR2CN ^ 1;	/* XCLK/RCLK SELECT */
sbit TX2	   =TMR2CN ^ 0;	/* T2 CLK/8 CLOCK SOURCE */

/* SCON0  0X98 */

sbit RI0	   =SCON0 ^ 0;	/* RECEIVE INTERRUPT FLAG */
sbit TI0	   =SCON0 ^ 1;	/* TRANSMIT INTERRUPT FLAG */
sbit RB80	=SCON0 ^ 2;	/* RECEIVE BIT 8 */
sbit TB80	=SCON0 ^ 3;	/* TRANSMIT BIT 8 */
sbit REN0	=SCON0 ^ 4; 	/* RECEIVE ENABLE */
sbit MCE0	=SCON0 ^ 5;	/* MULTIPROCESSOR COMMUNICATION ENABLE */
sbit SM1	   =SCON0 ^ 6;	/* SERIAL MODE CONTROL BIT 1 */
sbit S0MODE	=SCON0 ^ 7;	/* SERIAL MODE CONTROL BIT 0 */

/* IE 0XA8 */

sbit EX0ENABX  =IE ^ 0;	/* EXTERNAL INTERRUPT 0 ENABLE */
sbit EOCP   =IE ^ 1;	/* OVERCURRENT PROTECTION INTERRUPT ENABLE */
sbit EAIN0  =IE ^ 2;	/* ADC0 VIN WINDOW INTERRUPT ENABLE */
sbit ES0	   =IE ^ 3;	/* UART INTERRUPT ENABLE */
sbit ETRDET =IE ^ 4;	/* TRANSIENT DETECTOR INTERRUPT ENABLE */
sbit ECP0   =IE ^ 5;	/* COMPARATOR INTERRUPT ENABLE */
sbit EEN    =IE ^ 6;	/* GENERAL PURPOSE FLAG BIT */
sbit EA	   =IE ^ 7;	/* GLOBAL INTERRUPT ENABLE */

/* IP 0XB8 */

sbit PX0	   =IP ^ 0;	/* EXTERNAL INTERRUPT 0 PRIORITY */
sbit POCP   =IP ^ 1;	/* OVERCURRENT PROTECTION PRIORITY */
sbit PAIN0	=IP ^ 2;	/* EXTERNAL INTERRUPT 1 PRIORITY */
sbit PT1	   =IP ^ 3;	/* TIMER 1 PRIORITY */
sbit PTRDET =IP ^ 4;	/* SERIAL PORT PRIORITY */
sbit PT2    =IP ^ 5;	/* TIMER 2 PRIORITY */
sbit PEN    =IP ^ 6; /* INT1 PRIORITY */

/* SMB0CN  0XC0 */

sbit SI 	   =SMB0CN ^ 0;	/* SMBUS 0 INTERRUPT FLAG */
sbit ACK	   =SMB0CN ^ 1;	/* SMBUS 0 ACK BIT */
sbit ARBLOST=SMB0CN	^ 2;	/* SMBUS 0 ARBITRATION FLAG */
sbit ACKRQ	=SMB0CN ^ 3;	/* SMBUS 0 ACK REQUEST FLAG */
sbit STO	   =SMB0CN ^ 4;	/* SMBUS 0 STOP FLAG */
sbit STA	   =SMB0CN ^ 5;	/* SMBUS 0 START FLAG */
sbit TXMODE	=SMB0CN ^ 6;	/* SMBUS 0 TRANSMIT MODE FLAG */
sbit MASTER	=SMB0CN ^ 7;	/* SMBUS 0 MASTER MODE FLAG */

/* PSW 0XD0 */

sbit P		=PSW ^ 0;	/* ACCUMULATOR PARITY FLAG */
sbit F1		=PSW ^ 1;	/* USER FLAG 1 */
sbit OV		=PSW ^ 2;	/* OVERFLOW FLAG */
sbit RS0	   =PSW ^ 3;	/* REGISTER BANK SELECT 0 */
sbit RS1	   =PSW ^ 4;	/* REGISTER BANK SELECT 1 */
sbit F0 	   =PSW ^ 5;	/* USER FLAG 0 */
sbit AC		=PSW ^ 6;	/* AUXILIARY CARRY FLAG */
sbit CY 	   =PSW ^ 7;	/* CARRY FLAG */

/* PCA0CN  0XD8 */

sbit CCF0	=PCA0CN ^ 0;	/* PCA 0 MODULE 0 INTERRUPT FLAG */
sbit CCF1	=PCA0CN ^ 1;	/* PCA 0 MODULE 1 INTERRUPT FLAG */
sbit CCF2	=PCA0CN ^ 2;	/* PCA 0 MODULE 2 INTERRUPT FLAG */
sbit CCF3 	=PCA0CN ^ 3;	/* PCA 0 MODULE 3 INTERRUPT FLAG */
sbit CCF4	=PCA0CN ^ 4;	/* PCA 0 MODULE 4 INTERRUPT FLAG */
sbit CCF5	=PCA0CN ^ 5; 	/* PCA 0 MODULE 5 INTERRUPT FLAG */
sbit CR		=PCA0CN ^ 6;	/* PCA 0 COUNTER RUN CONTROL BIT */
sbit CF		=PCA0CN ^ 7;	/* PCA 0 COUNTER OVERFLOW FLAG */

/* ADC0CN 0XE8 */

sbit ADC0CM0	=ADC0CN ^ 0;	/* ADC 0 START OF CONVERSION MODE BIT 0 */
sbit ADC0CM1	=ADC0CN ^ 1;	/* ADC 0 START OF CONVERSION MODE BIT 1 */
sbit ADC0ADJL	=ADC0CN ^ 2;	/* ADC 0 ADJUST DATA LEFT */
sbit ADC0WINT	=ADC0CN ^ 3;	/* ADC 0 WINDOW COMPARE INTERRUPT FLAG */
sbit ADC0BUSY	=ADC0CN ^ 4;	/* ADC 0 BUSY FLAG */
sbit ADC0INT	=ADC0CN ^ 5;	/* ADC 0 CONVERSION COMPLETE INTERRUPT FLAG */
sbit ADC0BE		=ADC0CN ^ 6; 	/* ADC 0 BURST ENABLE */
sbit ADC0EN		=ADC0CN ^ 7;	/* ADC 0 ENABLE */

/* DPWMCNTL 0XF8 */

sbit EOFINT		=DPWMCNTL ^ 0;	/* END OF FRAME INTERRUPT */
sbit DPWMINPUT = DPWMCNTL ^ 1;  /* DPWM INPUT MUX CONTROL BIT*/
sbit ENABXPOL	=DPWMCNTL ^ 2;	/* HARDWARE ENABLE POLARITY */
sbit SWBP		=DPWMCNTL ^ 3;	/* SOFTWARE BYPASS CONTROL */
sbit EMGY_EN	=DPWMCNTL ^ 4;	/* EMERGENCY ENABLE/ DISABLE */
sbit HWBP_EN	=DPWMCNTL ^ 5;	/* HARDWARE BYPASS ENABLE */
sbit SYNC_EN	=DPWMCNTL ^ 6;	/* SYNC INPUT FUNCTION ENABLE */
sbit DPWM_EN	=DPWMCNTL ^ 7;	/* DPWM ENABLE/ DISABLE BIT */ 



//---------------------------------------------------------------------------------
// INDIRECT ADDRESS SPACE REGISTERS DPWMADDR AND DPWMDATA
//---------------------------------------------------------------------------------

//#define DPWMCNTL DPWMADDR = 0x00;   DPWMDATA

#define SW_CYC DPWMADDR = 0x01;  DPWMDATA

#define PH_POL DPWMADDR = 0x02;  DPWMDATA

#define ENABX_OUT DPWMADDR = 0x03;  DPWMDATA

#define OCP_OUT DPWMADDR = 0x04; DPWMDATA

#define SWBP_OUT DPWMADDR = 0x05;   DPWMDATA

#define SWBP_OUTEN DPWMADDR = 0x06;   DPWMDATA

#define PH1_CNTL0 DPWMADDR = 0x07;   DPWMDATA

#define PH1_CNTL1 DPWMADDR = 0x08;   DPWMDATA

#define PH1_CNTL2 DPWMADDR = 0x09;   DPWMDATA

#define PH1_CNTL3 DPWMADDR = 0x0A;   DPWMDATA

#define PH2_CNTL0 DPWMADDR = 0x0B;   DPWMDATA

#define PH2_CNTL1 DPWMADDR = 0x0C;   DPWMDATA

#define PH2_CNTL2 DPWMADDR = 0x0D;   DPWMDATA

#define PH2_CNTL3 DPWMADDR = 0x0E;   DPWMDATA

#define PH3_CNTL0 DPWMADDR = 0x0F;   DPWMDATA

#define PH3_CNTL1 DPWMADDR = 0x10;   DPWMDATA

#define PH3_CNTL2 DPWMADDR = 0x11;   DPWMDATA

#define PH3_CNTL3 DPWMADDR = 0x12;   DPWMDATA

#define PH4_CNTL0 DPWMADDR = 0x13;   DPWMDATA

#define PH4_CNTL1 DPWMADDR = 0x14;   DPWMDATA

#define PH4_CNTL2 DPWMADDR = 0x15;   DPWMDATA

#define PH4_CNTL3 DPWMADDR = 0x16;   DPWMDATA

#define PH5_CNTL0 DPWMADDR = 0x17;   DPWMDATA

#define PH5_CNTL1 DPWMADDR = 0x18;   DPWMDATA

#define PH5_CNTL2 DPWMADDR = 0x19;   DPWMDATA

#define PH5_CNTL3 DPWMADDR = 0x1A;   DPWMDATA

#define PH6_CNTL0 DPWMADDR = 0x1B;   DPWMDATA

#define PH6_CNTL1 DPWMADDR = 0x1C;   DPWMDATA

#define PH6_CNTL2 DPWMADDR = 0x1D;   DPWMDATA

#define PH6_CNTL3 DPWMADDR = 0x1E;   DPWMDATA

#define TLLT0 DPWMADDR = 0x1F;  DPWMDATA

#define TLGT0 DPWMADDR = 0x20;  DPWMDATA

#define TLLT1 DPWMADDR = 0x21;  DPWMDATA

#define TLGT1 DPWMADDR = 0x22;  DPWMDATA

#define TLLT2 DPWMADDR = 0x23;  DPWMDATA

#define TLGT2 DPWMADDR = 0x24;  DPWMDATA

#define TLLT3 DPWMADDR = 0x25;  DPWMDATA

#define TLGT3 DPWMADDR = 0x26;  DPWMDATA

#define ULOCK DPWMADDR = 0x27;  DPWMDATA

#define TLCDO DPWMADDR = 0x28;  DPWMDATA

#define TLCD1 DPWMADDR = 0x29;  DPWMDATA

#define TLCD2 DPWMADDR = 0x2A;  DPWMDATA

#define TLCD3 DPWMADDR = 0x2B;  DPWMDATA

#define DPWMOUT DPWMADDR = 0x2C;  DPWMDATA

//------------------------------------------------------------------------------
// INDIRECT ADDRESS SPACE REGISTERS ADC0ADDR AND ADC0DATA
//------------------------------------------------------------------------------

#define TS01CN ADC0ADDR = 0x00 ; ADC0DATA

#define TS23CN ADC0ADDR = 0x01 ; ADC0DATA

#define TS45CN ADC0ADDR = 0x02 ; ADC0DATA

#define TS67CN ADC0ADDR = 0x03 ; ADC0DATA

#define VSENSEH ADC0ADDR = 0x04 ; ADC0DATA

#define VSENSEL ADC0ADDR = 0x05 ; ADC0DATA

#define VSENSEGTH ADC0ADDR = 0x06 ; ADC0DATA

#define VSENSEGTL ADC0ADDR = 0x07 ; ADC0DATA

#define VSENSELTH ADC0ADDR = 0x08 ; ADC0DATA

#define VSENSELTL ADC0ADDR = 0x09 ; ADC0DATA

#define AIN0_VINH ADC0ADDR = 0x0A ; ADC0DATA

#define AIN0_VINL ADC0ADDR = 0x0B ; ADC0DATA

#define AIN0_VINGTH ADC0ADDR = 0x0C ; ADC0DATA

#define AIN0_VINGTL ADC0ADDR = 0x0D ; ADC0DATA

#define AIN0_VINLTH ADC0ADDR = 0x0E ; ADC0DATA

#define AIN0_VINLTL ADC0ADDR = 0x0F ; ADC0DATA

#define AIN1H ADC0ADDR = 0x10 ; ADC0DATA

#define AIN1L ADC0ADDR = 0x11 ; ADC0DATA

#define AIN1GTH ADC0ADDR = 0x12 ; ADC0DATA

#define AIN1GTL ADC0ADDR = 0x13 ; ADC0DATA

#define AIN1LTH ADC0ADDR = 0x14 ; ADC0DATA

#define AIN1LTL ADC0ADDR = 0x15 ; ADC0DATA

#define AIN2H ADC0ADDR = 0x16 ; ADC0DATA

#define AIN2L ADC0ADDR = 0x17 ; ADC0DATA

#define AIN2GTH ADC0ADDR = 0x18 ; ADC0DATA

#define AIN2GTL ADC0ADDR = 0x19 ; ADC0DATA

#define AIN2LTH ADC0ADDR = 0x1A ; ADC0DATA

#define AIN2LTL ADC0ADDR = 0x1B ; ADC0DATA

#define AIN3H ADC0ADDR = 0x1C ; ADC0DATA

#define AIN3L ADC0ADDR = 0x1D ; ADC0DATA

#define AIN3GTH ADC0ADDR = 0x1E ; ADC0DATA

#define AIN3GTL ADC0ADDR = 0x1F ; ADC0DATA

#define AIN3LTH ADC0ADDR = 0x20 ; ADC0DATA

#define AIN3LTL ADC0ADDR = 0x21 ; ADC0DATA

#define AIN4H ADC0ADDR = 0x22 ; ADC0DATA

#define AIN4L ADC0ADDR = 0x23 ; ADC0DATA

#define AIN4GTH ADC0ADDR = 0x24 ; ADC0DATA

#define AIN4GTL ADC0ADDR = 0x25 ; ADC0DATA

#define AIN4LTH ADC0ADDR = 0x26 ; ADC0DATA

#define AIN4LTL ADC0ADDR = 0x27 ; ADC0DATA

#define AIN5H ADC0ADDR = 0x28 ; ADC0DATA

#define AIN5L ADC0ADDR = 0x29 ; ADC0DATA

#define AIN5GTH ADC0ADDR = 0x2A ; ADC0DATA

#define AIN5GTL ADC0ADDR = 0x2B ; ADC0DATA

#define AIN5LTH ADC0ADDR = 0x2C ; ADC0DATA

#define AIN5LTL ADC0ADDR = 0x2D ; ADC0DATA

#define AIN6H ADC0ADDR = 0x2E ; ADC0DATA

#define AIN6L ADC0ADDR = 0x2F ; ADC0DATA

#define AIN6GTH ADC0ADDR = 0x30 ; ADC0DATA

#define AIN6GTL ADC0ADDR = 0x31 ; ADC0DATA

#define AIN6LTH ADC0ADDR = 0x32 ; ADC0DATA

#define AIN6LTL ADC0ADDR = 0x33 ; ADC0DATA

#define AIN7H ADC0ADDR = 0x34 ; ADC0DATA

#define AIN7L ADC0ADDR = 0x35 ; ADC0DATA

#define AIN7GTH ADC0ADDR = 0x36 ; ADC0DATA

#define AIN7GTL ADC0ADDR = 0x37 ; ADC0DATA

#define AIN7LTH ADC0ADDR = 0x38 ; ADC0DATA

#define AIN7LTL ADC0ADDR = 0x39 ; ADC0DATA

#define TEMPH ADC0ADDR = 0x3A ; ADC0DATA

#define TEMPL ADC0ADDR = 0x3B ; ADC0DATA

#define TEMPGTH ADC0ADDR = 0x3C ; ADC0DATA

#define TEMPGTL ADC0ADDR = 0x3D ; ADC0DATA

#define TEMPLTH ADC0ADDR = 0x3E ; ADC0DATA

#define TEMPLTL ADC0ADDR = 0x3F ; ADC0DATA

#define ADC0ASCN ADC0ADDR = 0x40 ; ADC0DATA


























