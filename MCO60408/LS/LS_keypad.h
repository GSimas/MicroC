/* -----------------------------------------------------------------------------
 * File:                        LS_keypad.h
 * Module:                      Keypad Module Interface
 * Author:                      Leandro Schwarz
 * Version:                     5.0
 * Last edition:        09/08/2013
 * -------------------------------------------------------------------------- */
 
#ifndef __LS_KEYPAD_H
#define __LS_KEYPAD_H 50
 
// -----------------------------------------------------------------------------
// Header files ----------------------------------------------------------------
 
#include "LS_defines.h"
#if __LS_DEFINES_H < 110
		#error Error 100 - The defintion file is outdated (LS_defines must be version 11.0 or greater).
#endif
#include <stdarg.h>
 
// -----------------------------------------------------------------------------
// Constants definitions -------------------------------------------------------
 
#ifndef KEYPAD_CONFIGURATION_4X4
		#ifndef KEYPAD_CONFIGURATION_4X3
				#ifndef KEYPAD_CONFIGURATION_5X3
						#define KEYPAD_CONFIGURATION_4X4
				#endif
		#endif
#endif
#ifdef KEYPAD_CONFIGURATION_4X4
		#define KEYPAD_LINES    4
		#define KEYPAD_COLUMNS  4
#else
		#ifdef KEYPAD_CONFIGURATION_4X3
				#define KEYPAD_LINES    4
				#define KEYPAD_COLUMNS  3
		#else
				#define KEYPAD_LINES    5
				#define KEYPAD_COLUMNS  3
		#endif
#endif
 
// -----------------------------------------------------------------------------
// Global variables ------------------------------------------------------------
 
#ifdef KEYPAD_CONFIGURATION_4X4
		extern volatile uint8 keypadTable[4][4];
#else
		#ifdef KEYPAD_CONFIGURATION_4X3
				extern uint8 keypadTable[4][3];
		#else
				#ifdef KEYPAD_CONFIGURATION_5X3
						extern uint8 keypadTable[5][3];
				#else
						#error Error 102 - No supported KEYPAD_CONFIGURATION selected (LS_defines.h).
				#endif
		#endif
#endif
 
// -----------------------------------------------------------------------------
// Macro functions -------------------------------------------------------------
 
#ifdef KEYPAD_CONFIGURATION_4X4
		#define keypadIOConfigure()             do{KEYPAD_COLUMNS_DDR |= 0x0F << KEYPAD_COLUMN_FIRST;KEYPAD_COLUMNS_PORT |= 0x0F << KEYPAD_COLUMN_FIRST;KEYPAD_LINES_DDR &= ~(0x0F << KEYPAD_LINE_FIRST);KEYPAD_LINES_PORT |= 0x0F << KEYPAD_LINE_FIRST;}while(0)
		#define keypadIORelease()               do{KEYPAD_COLUMNS_DDR &= ~(0x0F << KEYPAD_COLUMN_FIRST);KEYPAD_COLUMNS_PORT &= ~(0x0F << KEYPAD_COLUMN_FIRST);KEYPAD_LINES_DDR &= ~(0x0F << KEYPAD_LINE_FIRST);KEYPAD_LINES_PORT &= ~(0x0F << KEYPAD_LINE_FIRST);}while(0)
#else
		#ifdef KEYPAD_CONFIGURATION_4X3
				#define keypadIOConfigure()     do{KEYPAD_COLUMNS_DDR |= 0x07 << KEYPAD_COLUMN_FIRST;KEYPAD_COLUMNS_PORT |= 0x07 << KEYPAD_COLUMN_FIRST;KEYPAD_LINES_DDR &= ~(0x0F << KEYPAD_LINE_FIRST);KEYPAD_LINES_PORT      |= 0x0F << KEYPAD_LINE_FIRST;}while(0)
				#define keypadIORelease()       do{KEYPAD_COLUMNS_DDR &= ~(0x07 << KEYPAD_COLUMN_FIRST);KEYPAD_COLUMNS_PORT &= ~(0x07 << KEYPAD_COLUMN_FIRST);KEYPAD_LINES_DDR &= ~(0x0F << KEYPAD_LINE_FIRST);KEYPAD_LINES_PORT &= ~(0x0F << KEYPAD_LINE_FIRST);}while(0)
		#else
				#define keypadIOConfigure()     do{KEYPAD_COLUMNS_DDR |= 0x07 << KEYPAD_COLUMN_FIRST;KEYPAD_COLUMNS_PORT |= 0x07 << KEYPAD_COLUMN_FIRST;KEYPAD_LINES_DDR &= ~(0x1F << KEYPAD_LINE_FIRST);KEYPAD_LINES_PORT      |= 0x1F << KEYPAD_LINE_FIRST;}while(0)
				#define keypadIORelease()       do{KEYPAD_COLUMNS_DDR &= ~(0x07 << KEYPAD_COLUMN_FIRST);KEYPAD_COLUMNS_PORT &= ~(0x07 << KEYPAD_COLUMN_FIRST);KEYPAD_LINES_DDR &= ~(0x1F << KEYPAD_LINE_FIRST);KEYPAD_LINES_PORT &= ~(0x1F << KEYPAD_LINE_FIRST);}while(0)
		#endif
#endif
 
// -----------------------------------------------------------------------------
// Functions declarations ------------------------------------------------------
 
void    keypadInit(uint8 firstKey, ...);
uint8   keypadRead(void);
 
#endif