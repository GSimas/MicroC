/* -----------------------------------------------------------------------------
 * File:                LS_DS1307.c
 * Module:              DS1307 Real-Time Clock Interface
 * Author:              Leandro Schwarz
 * Version:             7.0
 * Last edition:        09/08/2013
 * -------------------------------------------------------------------------- */
 
// -----------------------------------------------------------------------------
// Header Files ----------------------------------------------------------------
 
#include "LS_DS1307.h"
 
// -----------------------------------------------------------------------------
// Global variables ------------------------------------------------------------
 
ds1307Data_t    ds1307Data;
ds1307Control_t ds1307Control;
 
/* -----------------------------------------------------------------------------
 * Reads the data at the DS1307, returns it and stores at DS1307_data bitfield.
 * -------------------------------------------------------------------------- */
 
uint8 ds1307Read(uint8 address)
{
		uint8 data[4];
 
		data[0] = address;
		i2cMasterSendData(DS1307_I2C_ADDRESS, I2C_WRITE, data, 1);
		i2cMasterSendData(DS1307_I2C_ADDRESS, I2C_READ, data, 1);
		i2cMasterReadFromBuffer(data, 1);
 
		// Decodes the data
		switch(address){
		case DS1307_ADDRESS_SECONDS:
				ds1307Data.seconds = (((0x70 & data[0]) >> 4) * 10) + (0x0F & data[0]);
				break;
		case DS1307_ADDRESS_MINUTES:
				ds1307Data.minutes = (((0x70 & data[0]) >> 4) * 10) + (0x0F & data[0]);
				break;
		case DS1307_ADDRESS_HOURS:
				if(isBitSet(data[0], 6)){       // 12 hour-mode
						ds1307Data.hours = (((0x10 & data[0]) >> 4) * 10) + (0x0F & data[0]);
						ds1307Data.amPm = isBitSet(data[0], 5);
				}else                           // 24 hour-mode
						ds1307Data.hours = (((0x30 & data[0]) >> 4) * 10) + (0x0F & data[0]);
				break;
		case DS1307_ADDRESS_WEEK_DAY:
				ds1307Data.weekDay = 0x07 & data[0];
				break;
		case DS1307_ADDRESS_MONTH_DAY:
				ds1307Data.monthDay = (((0x30 & data[0]) >> 4) * 10) + (0x0F & data[0]);
				break;
		case DS1307_ADDRESS_MONTH:
				ds1307Data.month = (((0x10 & data[0]) >> 4) * 10) + (0x0F & data[0]);
				break;
		case DS1307_ADDRESS_YEAR:
				ds1307Data.year = (((0xF0 & data[0]) >> 4) * 10) + (0x0F & data[0]);
				break;
		case DS1307_ADDRESS_CONTROL:
				ds1307Control.squareWaveFrequency       = data[0] & 0x03;
				ds1307Control.squareWaveActivation      = isBitSet(data[0], 4);
				ds1307Control.squareWaveOffValue        = isBitSet(data[0], 7);
				data[0] = DS1307_ADDRESS_SECONDS;
				i2cMasterSendData(DS1307_I2C_ADDRESS, I2C_WRITE, data, 1);
				i2cMasterSendData(DS1307_I2C_ADDRESS, I2C_READ, data, 1);
				i2cMasterReadFromBuffer(data, 1);
				ds1307Control.oscillatorEnable = isBitClr(data[0], 7);
				data[0] = DS1307_ADDRESS_HOURS;
				i2cMasterSendData(DS1307_I2C_ADDRESS, I2C_WRITE, data, 1);
				i2cMasterSendData(DS1307_I2C_ADDRESS, I2C_READ, data, 1);
				i2cMasterReadFromBuffer(data, 1);
				ds1307Control.mode12h24h = isBitSet(data[0],6);
				break;
		}
 
		return data[0];
}
 
/* -----------------------------------------------------------------------------
 * Writes the data at the given address.
 * -------------------------------------------------------------------------- */
 
void ds1307Write(uint8 data, uint8 address)
{
		uint8 aux[2];
 
		// Codifies the data to be written
		switch(address){
		case DS1307_ADDRESS_SECONDS:
				ds1307Data.seconds = data;
				data = ((data / 10) << 4) | (data % 10);
				if(ds1307Control.oscillatorEnable == 0)
						data |= 0x80;
				break;
		case DS1307_ADDRESS_MINUTES:
				ds1307Data.minutes = data;
				data = ((data / 10) << 4) | (data % 10);
				break;
		case DS1307_ADDRESS_HOURS:
				ds1307Data.hours = data;
				data = ((data / 10) << 4) | (data % 10);
				if(ds1307Control.mode12h24h == 1)       // 12 hour-mode
				{
						data |= 0x40;
						if(ds1307Data.amPm == 1)        // PM
								data |= 0x20;
				}
				break;
		case DS1307_ADDRESS_WEEK_DAY:
				ds1307Data.weekDay = data;
				break;
		case DS1307_ADDRESS_MONTH_DAY:
				ds1307Data.monthDay = data;
				data = ((data / 10) << 4) | (data % 10);
				break;
		case DS1307_ADDRESS_MONTH:
				ds1307Data.month = data;
				data = ((data / 10) << 4) | (data % 10);
				break;
		case DS1307_ADDRESS_YEAR:
				ds1307Data.year = data;
				data = ((data / 10) << 4) | (data % 10);
				break;
		}
 
		aux[0] = address;
		aux[1] = data;
		i2cMasterSendData(DS1307_I2C_ADDRESS, I2C_WRITE, aux, 2);
		return;
}
 
/* -----------------------------------------------------------------------------
 * Sets the given date.
 * -------------------------------------------------------------------------- */
 
void ds1307SetDate(uint8 year, uint8 month, uint8 monthDay, uint8 weekDay)
{
		ds1307Data.year = year;
		ds1307Data.month = month;
		ds1307Data.monthDay = monthDay;
		ds1307Data.weekDay = weekDay;
		ds1307Write(ds1307Data.year, DS1307_ADDRESS_YEAR);
		ds1307Write(ds1307Data.month, DS1307_ADDRESS_MONTH);
		ds1307Write(ds1307Data.monthDay, DS1307_ADDRESS_MONTH_DAY);
		ds1307Write(ds1307Data.weekDay, DS1307_ADDRESS_WEEK_DAY);
		return;
}
 
/* -----------------------------------------------------------------------------
 * Sets the given time
 * -------------------------------------------------------------------------- */
 
void ds1307SetTime(uint8 hour, uint8 minute, uint8 second, uint8 mode)
{
		ds1307Read(DS1307_ADDRESS_CONTROL);
		if(ds1307Control.mode12h24h == 1){      // 12-hour mode
				if(mode == DS1307_24){
						hour++;
						if(hour > 12){
								ds1307Data.amPm = 1;
								ds1307Data.hours = hour - 12;
						}else{
								ds1307Data.amPm = 0;
								ds1307Data.hours = hour;
						}
				}else{
						ds1307Data.hours = hour;
						if(mode == DS1307_AM)
								ds1307Data.amPm = 0;
						else
								ds1307Data.amPm = 1;
				}
		}else{                                                          // 24-hour mode
				if(mode == DS1307_24)
						ds1307Data.hours = hour;
				else{
						ds1307Data.hours = hour - 1;
						if(mode == DS1307_PM)
								ds1307Data.hours += 12;
				}
		}
		ds1307Data.minutes = minute;
		ds1307Data.seconds = second;
		ds1307Write(ds1307Data.hours, DS1307_ADDRESS_HOURS);
		ds1307Write(ds1307Data.minutes, DS1307_ADDRESS_MINUTES);
		ds1307Write(ds1307Data.seconds, DS1307_ADDRESS_SECONDS);
		return;
}
 
/* -----------------------------------------------------------------------------
 * Gets the date.
 * -------------------------------------------------------------------------- */
 
void ds1307GetDate(uint8 * year, uint8 * month, uint8 * monthDay, uint8 * weekDay)
{
		ds1307Read(DS1307_ADDRESS_YEAR);
		ds1307Read(DS1307_ADDRESS_MONTH);
		ds1307Read(DS1307_ADDRESS_MONTH_DAY);
		ds1307Read(DS1307_ADDRESS_WEEK_DAY);
		*year = ds1307Data.year;
		*month = ds1307Data.month;
		*monthDay = ds1307Data.monthDay;
		*weekDay = ds1307Data.weekDay;
		return;
}
 
/* -----------------------------------------------------------------------------
 * Gets the time.
 * -------------------------------------------------------------------------- */
 
void ds1307GetTime(uint8 * hours, uint8 * minutes, uint8 * seconds, uint8 * mode)
{
		ds1307Read(DS1307_ADDRESS_HOURS);
		ds1307Read(DS1307_ADDRESS_MINUTES);
		ds1307Read(DS1307_ADDRESS_SECONDS);
		*hours = ds1307Data.hours;
		*minutes = ds1307Data.minutes;
		*seconds = ds1307Data.seconds;
		*mode = ds1307Data.amPm;
		return;
}
 
/* -----------------------------------------------------------------------------
 * Writes the given data at the posion of the internal RAM.
 * -------------------------------------------------------------------------- */
 
void ds1307SetRamData(uint8 data, uint8 position)
{
		ds1307Write(data, DS1307_ADDRESS_RAM + position);
		return;
}
 
/* -----------------------------------------------------------------------------
 * Returns the data at the posion of the internal RAM.
 * -------------------------------------------------------------------------- */
 
uint8 ds1307GetRamData(uint8 position)
{
		return ds1307Read(DS1307_ADDRESS_RAM + position);
}