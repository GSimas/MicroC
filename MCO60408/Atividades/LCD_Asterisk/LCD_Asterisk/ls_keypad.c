/* -----------------------------------------------------------------------------
 * File:			LS_keypad.c
 * Module:			Keypad Module Interface
 * Author:			Leandro Schwarz
 * Version:			5.0
 * Last edition:	09/08/2013
 * -------------------------------------------------------------------------- */

// -----------------------------------------------------------------------------
// Header Files ----------------------------------------------------------------

#include "LS_keypad.h"
#if __LS_KEYPAD_H != 50
	#error Error 101 - Version mismatch on header and source code files (LS_keypad).
#endif

// -----------------------------------------------------------------------------
// Global variables ------------------------------------------------------------

#ifdef KEYPAD_CONFIGURATION_4X4
	volatile uint8 keypadTable[4][4];
#else
	#ifdef KEYPAD_CONFIGURATION_4X3
		uint8 keypadTable[4][3];
	#else
		#ifdef KEYPAD_CONFIGURATION_5X3
			uint8 keypadTable[5][3];
		#endif
	#endif
#endif

/* -----------------------------------------------------------------------------
 * Performs the keypad initialization.
 * -------------------------------------------------------------------------- */

void keypadInit(uint8 firstKey, ...)
{
	uint8 i;
	uint8 j;
	va_list args;

	va_start(args, firstKey);
	keypadTable[0][0] = firstKey;
	j = 1;
	for(i = 0;i < KEYPAD_LINES;i++){
		for( ;j < KEYPAD_COLUMNS;j++){
			keypadTable[i][j] = (uint8)va_arg(args, int16);
		}
		j = 0;
	}
	va_end(args);
	return;
}

/* -----------------------------------------------------------------------------
 * Reads the keypad and returns the key pressed.
 * -------------------------------------------------------------------------- */

uint8 keypadRead(void)
{
	uint8 i;
	uint8 j;
	uint8 aux;
	uint8 key = 0xFF;

	keypadIOConfigure();
//printf("a");
	for(i = 0;i < KEYPAD_COLUMNS;i++){					// For each column
		clrBit(KEYPAD_COLUMNS_PORT, (i + KEYPAD_COLUMN_FIRST));	// Clear one columns
		noOperation(5);												// Wait for syncronization
		aux = KEYPAD_LINES_PIN >> KEYPAD_LINE_FIRST;
		for(j = 0;j < KEYPAD_LINES;j++){				// For each line
			if(isBitClr(aux, j)){					// Tests if the key is pressed
				key = keypadTable[j][i];			// Decodes the key using the table
				_delay_ms(KEYPAD_DEBOUNCE_TIME);		// Debounce time
			}
			while(isBitClr(KEYPAD_LINES_PIN >> KEYPAD_LINE_FIRST,j)){
			}
				;	// Wait until key is released
		}
		setBit(KEYPAD_COLUMNS_PORT, (i + KEYPAD_COLUMN_FIRST));	// Restore column value
	}
	keypadIORelease();
	return key;
}