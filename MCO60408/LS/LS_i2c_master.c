/* -----------------------------------------------------------------------------
 * File:                        LS_i2c_master.c
 * Module:                      I2C Peripheral Controller
 * Author:                      Leandro Schwarz
 *                                      Fábio Cabral Pacheco
 * Version:                     1.1
 * Last edition:        09/08/2013
 * -------------------------------------------------------------------------- */
 
// -----------------------------------------------------------------------------
// Header files ----------------------------------------------------------------
 
#include "LS_i2c_master.h"
#if __LS_I2C_MASTER_H != 11
		#error Error 101 - Version mismatch on header and source code files (LS_i2c_master).
#endif
 
// -----------------------------------------------------------------------------
// Global variables ------------------------------------------------------------
 
static uint8 i2cBuffer[I2C_BUFFER_SIZE];        // Transceiver buffer
static uint8 i2cMsgSize;                        // Number of bytes to be transmitted.
static uint8 i2cState = I2C_NO_STATE;           // State byte. Default set to TWI_NO_STATE.
union i2cStatusReg_t i2cStatusReg = {0};        // i2cStatusReg is defined in TWI_Master.h
 
// -----------------------------------------------------------------------------
// Function definitions --------------------------------------------------------
 
/* -----------------------------------------------------------------------------
 * Sets up the I2C master to its initial standby state. Remember to enable
 * interrupts from the main application after initializing the I2C.
 * -------------------------------------------------------------------------- */
 
void i2cMasterInit(void)
{
		uint32 aux;
 
		aux = (uint32)F_CPU / (uint32)I2C_BAUD_RATE;
 
		if(aux <= 526){         // Prescaler 1
				clrBit(TWSR, TWPS1);
				clrBit(TWSR, TWPS0);
				TWBR = (uint8)(((uint32)(F_CPU / 2) / (uint32)I2C_BAUD_RATE) - 8);
		}else if(aux <= 2056){  // Prescaler 4
				clrBit(TWSR, TWPS1);
				setBit(TWSR, TWPS0);
				TWBR = (uint8)((((uint32)(F_CPU / 2) / (uint32)I2C_BAUD_RATE) / 4) - 2);
		}else if(aux <= 8176){  // Prescaler 16
				setBit(TWSR, TWPS1);
				clrBit(TWSR, TWPS0);
				TWBR = (uint8)(((uint32)(F_CPU / 2) / (uint32)I2C_BAUD_RATE) / 16);
		}else if(aux <= 32656){ // Prescaler 64
				setBit(TWSR, TWPS1);
				setBit(TWSR, TWPS0);
				TWBR = (uint8)(((uint32)(F_CPU / 2) / (uint32)I2C_BAUD_RATE) / 64);
		}
		TWDR = 0xFF;            // Default content = SDA released
		TWCR = 1 << TWEN;       // Activates i2c interface
		return;
}
 
/* -----------------------------------------------------------------------------
 * Tests if the i2c interruption is busy transmitting
 * -------------------------------------------------------------------------- */
 
uint8 i2cIsTransceiverBusy(void)
{
		return (TWCR & (1 << TWIE));
}
 
/* -----------------------------------------------------------------------------
 * Sends a prepared message. The message must contain the data to be sent, or
 * empty locations for data to be read from the slave. Also include how many
 * bytes that should be sent/read. The function will hold execution (loop) until
 * the i2c interruption has completed with the previous operation, then
 * initialize the next operation and return.
 * -------------------------------------------------------------------------- */
 
void i2cMasterSendData(uint8 address, uint8 readWrite, uint8 *msg, uint8 msgSize)
{
		uint8 i;
 
		while(i2cIsTransceiverBusy())
				;       // Wait until TWI is ready for next transmission.
		i2cMsgSize = msgSize + 1;
		i2cBuffer[0] = (address << 1) |  readWrite;
		if(readWrite == I2C_WRITE){
				for(i = 0;i < msgSize;i++)
						i2cBuffer[i + 1] = msg[i];
		}
		i2cStatusReg.all = 0;
		i2cState = I2C_NO_STATE;
		TWCR = (1 << TWEN) | (1 << TWIE) | (1 << TWINT) | (1 << TWSTA);
		return;
}
 
/* -----------------------------------------------------------------------------
 * Reads out the requested data from the i2c transceiver buffer. Must call the
 * i2cMasterSendData function first to send a request for data to the slave.
 * This function requires a pointer to where to place the data and the number of
 * bytes requested (including the address field) in the function call. The
 * function will hold execution (loop) until the i2c interruption has completed
 * with the previous operation, before reading out the data and returning. If
 * there was an error in the previous transmission the function will return the
 * i2c error code.
 * -------------------------------------------------------------------------- */
 
uint8 i2cMasterReadFromBuffer(uint8 *msg, uint8 msgSize)
{
		uint8 i;
 
		while(i2cIsTransceiverBusy())
				;       // Wait until TWI is ready for next transmission
		if(i2cStatusReg.lastTransOK){   // Last transmission competed successfully
				for(i = 0;i < msgSize;i++){     // Copy data from Transceiver buffer
						msg[i] = i2cBuffer[i + 1];
				}
		}
		return(i2cStatusReg.lastTransOK);
}
 
/* -----------------------------------------------------------------------------
 * Fetchs the state information of the previous operation. The function will
 * hold execution (loop) until the i2c interrupt has completed with the previous
 * operation. If there was an error, then the function will return the i2c State
 * code.
 * -------------------------------------------------------------------------- */
 
uint8 i2cGetStatus(void)
{
		while(i2cIsTransceiverBusy())
				;       // Wait until TWI has completed the transmission
		return(i2cState);
}
 
/* -----------------------------------------------------------------------------
 * Resends the last message. The driver will reuse the data previously put in
 * the transceiver buffers. The function will hold execution (loop) until the
 * i2c cinterrupt has completed with the previous operation, then initialize
 * the next operation and return.
 * -------------------------------------------------------------------------- */
 
void i2cMasterResendData(void)
{
		while(i2cIsTransceiverBusy())
				;       // Wait until TWI is ready for next transmission
		i2cStatusReg.all = 0;
		i2cState = I2C_NO_STATE;
		TWCR = (1 << TWEN) | (1 << TWIE) | (1 << TWINT) | (1 << TWSTA);
		return;
}
 
/* -----------------------------------------------------------------------------
 * Determines the nature of the failure and take appropriate actions. If
 * received a NACK on the slave address, then a retransmission will be
 * initiated.
 * -------------------------------------------------------------------------- */
 
uint8 i2cMasterErrorHandler(uint8 i2cErrorCode)
{
		if((i2cErrorCode == I2C_MTX_ADR_NACK) | (i2cErrorCode == I2C_MRX_ADR_NACK))
				i2cMasterResendData();
		return i2cErrorCode;
}
 
// -----------------------------------------------------------------------------
// Interruption handler --------------------------------------------------------
 
ISR(TWI_vect)
{
		static uint8 i2cBufferPtr;
 
		switch(TWSR){
		case I2C_START:                 // START has been transmitted
		case I2C_REP_START:             // Repeated START has been transmitted
				i2cBufferPtr = 0;       // Set buffer pointer to the TWI Address location
		case I2C_MTX_ADR_ACK:           // SLA+W has been tramsmitted and ACK received
		case I2C_MTX_DATA_ACK:          // Data byte has been tramsmitted and ACK received
				if(i2cBufferPtr < i2cMsgSize){
						TWDR = i2cBuffer[i2cBufferPtr++];
						TWCR = (1 << TWEN) | (1 << TWIE) | (1 << TWINT);
				}else{                  // Send STOP after last byte
						i2cStatusReg.lastTransOK = TRUE;        // Set status bits to completed successfully
						TWCR = (1 << TWEN) | (1 << TWINT) | (1 << TWSTO);
				}
				break;
		case I2C_MRX_DATA_ACK:          // Data byte has been received and ACK tramsmitted
				i2cBuffer[i2cBufferPtr++] = TWDR;
		case I2C_MRX_ADR_ACK:           // SLA+R has been tramsmitted and ACK received
				if(i2cBufferPtr < (i2cMsgSize - 1))     // Detect the last byte to NACK it
						TWCR = (1 << TWEN) | (1 << TWIE) | (1 << TWINT) | (1 << TWEA);
				else                    // Send NACK after next reception
						TWCR = (1 << TWEN) | (1 << TWIE) | (1 << TWINT);
				break;
		case I2C_MRX_DATA_NACK:         // Data byte has been received and NACK tramsmitted
				i2cBuffer[i2cBufferPtr] = TWDR;
				i2cStatusReg.lastTransOK = TRUE;        // Set status bits to completed successfully
				TWCR = (1 << TWEN) | (1 << TWINT) | (1 << TWSTO);
				break;
		case I2C_ARB_LOST:              // Arbitration lost
				TWCR = (1 << TWEN) | (1 << TWIE) | (1 << TWINT) | (1 << TWSTA);
				break;
		case I2C_MTX_ADR_NACK:          // SLA+W has been tramsmitted and NACK received
		case I2C_MRX_ADR_NACK:          // SLA+R has been tramsmitted and NACK received    
		case I2C_MTX_DATA_NACK:         // Data byte has been tramsmitted and NACK received
		case I2C_BUS_ERROR:             // Bus error due to an illegal START or STOP condition
		default:
				i2cState = TWSR;        // Store TWSR and automatically sets clears noErrors bit
				TWCR = (1 << TWEN);     // Reset TWI Interface
				break;
		}
		return;
}