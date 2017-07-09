/* -----------------------------------------------------------------------------
 * File:                        LS_i2c_master.h
 * Module:                      I2C Peripheral Controller
 * Author:                      Leandro Schwarz
 *                                      Fábio Cabral Pacheco
 * Version:                     1.1
 * Last edition:        09/08/2013
 * -------------------------------------------------------------------------- */
 
#ifndef __LS_I2C_MASTER_H
#define __LS_I2C_MASTER_H 11
 
// -----------------------------------------------------------------------------
// Header files ----------------------------------------------------------------
 
#include <avr/io.h>
#include <avr/interrupt.h>
#include "LS_defines.h"
#if __LS_DEFINES_H < 110
		#error Error 100 - The defintion file is outdated (LS_defines must be version 11.0 or greater).
#endif
 
// -----------------------------------------------------------------------------
// Constants definitions -------------------------------------------------------
 
#define I2C_START                       0x08  // START has been transmitted  
#define I2C_REP_START                   0x10  // Repeated START has been transmitted
#define I2C_ARB_LOST                    0x38  // Arbitration lost
#define I2C_MTX_ADR_ACK                 0x18  // SLA+W has been tramsmitted and ACK received
#define I2C_MTX_ADR_NACK                0x20  // SLA+W has been tramsmitted and NACK received
#define I2C_MTX_DATA_ACK                0x28  // Data byte has been tramsmitted and ACK received
#define I2C_MTX_DATA_NACK               0x30  // Data byte has been tramsmitted and NACK received
#define I2C_MRX_ADR_ACK                 0x40  // SLA+R has been tramsmitted and ACK received
#define I2C_MRX_ADR_NACK                0x48  // SLA+R has been tramsmitted and NACK received
#define I2C_MRX_DATA_ACK                0x50  // Data byte has been received and ACK tramsmitted
#define I2C_MRX_DATA_NACK               0x58  // Data byte has been received and NACK tramsmitted
#define I2C_STX_ADR_ACK                 0xA8  // Own SLA+R has been received; ACK has been returned
#define I2C_STX_ADR_ACK_M_ARB_LOST      0xB0  // Arbitration lost in SLA+R/W as Master; own SLA+R has been received; ACK has been returned
#define I2C_STX_DATA_ACK                0xB8  // Data byte in TWDR has been transmitted; ACK has been received
#define I2C_STX_DATA_NACK               0xC0  // Data byte in TWDR has been transmitted; NOT ACK has been received
#define I2C_STX_DATA_ACK_LAST_BYTE      0xC8  // Last data byte in TWDR has been transmitted (TWEA = “0”); ACK has been received
#define I2C_SRX_ADR_ACK                 0x60  // Own SLA+W has been received ACK has been returned
#define I2C_SRX_ADR_ACK_M_ARB_LOST      0x68  // Arbitration lost in SLA+R/W as Master; own SLA+W has been received; ACK has been returned
#define I2C_SRX_GEN_ACK                 0x70  // General call address has been received; ACK has been returned
#define I2C_SRX_GEN_ACK_M_ARB_LOST      0x78  // Arbitration lost in SLA+R/W as Master; General call address has been received; ACK has been returned
#define I2C_SRX_ADR_DATA_ACK            0x80  // Previously addressed with own SLA+W; data has been received; ACK has been returned
#define I2C_SRX_ADR_DATA_NACK           0x88  // Previously addressed with own SLA+W; data has been received; NOT ACK has been returned
#define I2C_SRX_GEN_DATA_ACK            0x90  // Previously addressed with general call; data has been received; ACK has been returned
#define I2C_SRX_GEN_DATA_NACK           0x98  // Previously addressed with general call; data has been received; NOT ACK has been returned
#define I2C_SRX_STOP_RESTART            0xA0  // A STOP condition or repeated START condition has been received while still addressed as Slave
#define I2C_NO_STATE                    0xF8  // No relevant state information available; TWINT = “0”
#define I2C_BUS_ERROR                   0x00  // Bus error due to an illegal START or STOP condition
 
#define I2C_READ        1
#define I2C_WRITE       0
 
// -----------------------------------------------------------------------------
// New data type definition ----------------------------------------------------
 
union i2cStatusReg_t{           // Status byte holding flags.
		uint8 all;
		struct{
				uint8 lastTransOK       :1;  
				uint8 unusedBits        :7;
		};
};
 
// -----------------------------------------------------------------------------
// Global variables ------------------------------------------------------------
 
extern union i2cStatusReg_t i2cStatusReg;
 
// -----------------------------------------------------------------------------
// Functions declarations ------------------------------------------------------
 
uint8   i2cGetStatus(void);
uint8   i2cIsTransceiverBusy(void);
uint8   i2cMasterErrorHandler(uint8 i2cErrorCode);
void    i2cMasterInit(void);
uint8   i2cMasterReadFromBuffer(uint8 *msg, uint8 msgSize);
void    i2cMasterResendData(void);
void    i2cMasterSendData(uint8 address, uint8 readWrite, uint8 *msg, uint8 msgSize);
 
// -----------------------------------------------------------------------------
// Interruption handlers -------------------------------------------------------
 
ISR(TWI_vect);
 
#endif