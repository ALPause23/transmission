#ifndef __MAX7219_H__
#define __MAX7219_H__

#include <common.h>
#include <symbols.h>
typedef enum
{
	SYMBOL_R = 0,
	SYMBOL_ONE = 1,
	SYMBOL_TWO = 2,
	SYMBOL_THREE = 3,
	SYMBOL_FOUR = 4,
	SYMBOL_FIVE = 5,
	SYMBOL_N = 6,
	SYMBOL_EMTY = 7
}Matrix_Symbols;

void InitLed(void);
void WriteNum(Matrix_Symbols num);
void SendLed(uint8_t adr, uint8_t data);
void WriteSymbol(uint8_t* num);
uint8_t* GetSymbols(Matrix_Symbols i);

//void MAX7219_InitDriver(void);
//void ClearDisplay();
//void WriteNum(char *z, char *y, char *x);
//void SetIntensity(uint8_t a);
//char* GetNumbers(int i);

//void SPI_Init(void);
//void SPI_SendByte(char byte);



#endif
