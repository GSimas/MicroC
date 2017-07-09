/* -----------------------------------------------------------------------------
 * File:                LS_DS1307.h
 * Module:              DS1307 Real-Time Clock Interface
 * Author:              Leandro Schwarz
 * Version:             7.0
 * Last edition:        09/08/2013
 * -------------------------------------------------------------------------- */
 
#ifndef __LS_DS1307_H
#define __LS_DS1307_H 70
 
// -----------------------------------------------------------------------------
// Header files ----------------------------------------------------------------
 
#include "LS_defines.h"
#if __LS_DEFINES_H < 86
		#error Wrong definition file (LS_defines.h).
#endif
#include "LS_i2c_master.h"
 
// -----------------------------------------------------------------------------
// Constants definitions -------------------------------------------------------
 
#define DS1307_I2C_ADDRESS              0x68
#define DS1307_ADDRESS_SECONDS          0x00
#define DS1307_ADDRESS_MINUTES          0x01
#define DS1307_ADDRESS_HOURS            0x02
#define DS1307_ADDRESS_WEEK_DAY         0x03
#define DS1307_ADDRESS_MONTH_DAY        0x04
#define DS1307_ADDRESS_MONTH            0x05
#define DS1307_ADDRESS_YEAR             0x06
#define DS1307_ADDRESS_CONTROL          0x07
#define DS1307_ADDRESS_RAM              0x08
#define DS1307_24                       0
#define DS1307_PM                       1
#define DS1307_AM                       2
#define DS1307_I2C_MIN_FREQUENCY        0UL
#define DS1307_I2C_MAX_FREQUENCY        100000UL
 
#if I2C_BAUD_RATE > DS1307_I2C_MAX_FREQUENCY
		#error DS1307 requires BAUD RATE  between 0 and 100kHz.
#elif I2C_BAUD_RATE < DS1307_I2C_MIN_FREQUENCY
		#error DS1307 requires BAUD RATE  between 0 and 100kHz.
#endif
 
// -----------------------------------------------------------------------------
// New data type definition ----------------------------------------------------
 
typedef struct ds1307Data_t{
		uint8 hours             : 5;
		uint8 weekDay           : 3;
		uint8 amPm              : 1;
		uint8 minutes           : 6;
		uint8 seconds           : 6;
		uint8 year              : 7;
		uint8 month             : 4;
		uint8 monthDay          : 5;
		uint8 unusedBits        : 5;
} ds1307Data_t;
 
typedef struct ds1307Control_t{
		uint8 squareWaveActivation      : 1;
		uint8 squareWaveOffValue        : 1;
		uint8 squareWaveFrequency       : 2;
		uint8 oscillatorEnable          : 1;
		uint8 mode12h24h                : 1;
		uint8 unusedBits                : 2;
} ds1307Control_t;
 
// -----------------------------------------------------------------------------
// Global variables ------------------------------------------------------------
 
extern ds1307Data_t     ds1307Data;
extern ds1307Control_t  ds1307Control;
 
// -----------------------------------------------------------------------------
// Macro functions definitions -------------------------------------------------
 
#define ds1307EnableClock()                     do{ds1307Read(DS1307_ADDRESS_SECONDS);ds1307Control.oscillatorEnable = 1;ds1307Write(ds1307Data.seconds, DS1307_ADDRESS_SECONDS);}while(0)
#define ds1307DisableClock()            do{ds1307Read(DS1307_ADDRESS_SECONDS);ds1307Control.oscillatorEnable = 0;ds1307Write(ds1307Data.seconds,DS1307_ADDRESS_SECONDS);}while(0)
#define ds1307SquareWave1Hz()   do{ds1307Read(DS1307_ADDRESS_CONTROL);ds1307Control.squareWaveActivation = 1;ds1307Control.squareWaveFrequency = 0;ds1307Write((ds1307Control.squareWaveOffValue << 7) | (1 << 4),DS1307_ADDRESS_CONTROL);}while(0)
#define ds1307SquareWave4kHz()  do{ds1307Read(DS1307_ADDRESS_CONTROL);ds1307Control.squareWaveActivation = 1;ds1307Control.squareWaveFrequency = 1;ds1307Write((ds1307Control.squareWaveOffValue << 7) | (1 << 4) | 1,DS1307_ADDRESS_CONTROL);}while(0)
#define ds1307SquareWave8kHz()  do{ds1307Read(DS1307_ADDRESS_CONTROL);ds1307Control.squareWaveActivation = 1;ds1307Control.squareWaveFrequency = 2;ds1307Write((ds1307Control.squareWaveOffValue << 7) | (1 << 4) | (1 << 1),DS1307_ADDRESS_CONTROL);}while(0)
#define ds1307SquareWave32kHz() do{ds1307Read(DS1307_ADDRESS_CONTROL);ds1307Control.squareWaveActivation = 1;ds1307Control.squareWaveFrequency = 3;ds1307Write((ds1307Control.squareWaveOffValue << 7) | (1 << 4) | (1 << 1) | 1,DS1307_ADDRESS_CONTROL);}while(0)
#define ds1307SquareWaveHighLevel()     do{ds1307Read(DS1307_ADDRESS_CONTROL);ds1307Control.squareWaveOffValue = 1;ds1307Control.squareWaveActivation = 0;ds1307Write(((1 << 7) | ds1307Control.squareWaveFrequency),DS1307_ADDRESS_CONTROL);}while(0)
#define ds1307SquareWaveLowLevel()      do{ds1307Read(DS1307_ADDRESS_CONTROL);ds1307Control.squareWaveOffValue = 0;ds1307Control.squareWaveActivation = 0;ds1307Write((ds1307Control.squareWaveFrequency),DS1307_ADDRESS_CONTROL);}while(0)
#define ds1307Set24HoursMode()          do{ds1307Read(DS1307_ADDRESS_HOURS);ds1307Control.mode12h24h = 0;if(ds1307Data.amPm == 1)ds1307Data.hours += 12;ds1307Write(ds1307Data.hours,DS1307_ADDRESS_HOURS);}while(0)
#define ds1307Set12HoursMode()          do{ds1307Read(DS1307_ADDRESS_HOURS);ds1307Control.mode12h24h = 1;if(ds1307Data.hours > 12){ds1307Data.hours -= 12;ds1307Data.amPm = 1;}ds1307Write(ds1307Data.hours,DS1307_ADDRESS_HOURS);}while(0)
 
// -----------------------------------------------------------------------------
// Functions declarations ------------------------------------------------------
 
uint8   ds1307Read(uint8 address);
void    ds1307GetDate(uint8 * year, uint8 * month, uint8 * monthDay, uint8 * weekDay);
uint8   ds1307GetRamData(uint8 position);
void    ds1307GetTime(uint8 * hours, uint8 * minutes, uint8 * seconds, uint8 * mode);
void    ds1307SetDate(uint8 year, uint8 month, uint8 monthDay, uint8 weekDay);
void    ds1307SetRamData(uint8 data, uint8 position);
void    ds1307SetTime(uint8 hour, uint8 minute, uint8 second, uint8 mode);
void    ds1307Write(uint8 i2c_data, uint8 address);
 
#endif