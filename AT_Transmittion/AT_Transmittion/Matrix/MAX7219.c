#include <MAX7219.h>
#include <delay.h>
//#include <symbols.h>
#include <mem.h>


#if defined __ATTINY2313A__ || defined __ATTINY2313__
#include <USI_SPI.h>
#else
#include <SPI.h>
#endif

void SendLed(uint8_t adr, uint8_t data);
void SetIntensity(uint8_t a);



#define NO_OP				0x0000
#define NO_DECODE_MODE		0x0900
#define INTENSITY			0x0A00  // (ot 0 do F)
#define SCAN_LIMIT			0x0B00	// (ot 0 do 7)
#define SHUTDOWN			0x0C00	// (0 - shotdown, 1 - no shotdown)
#define DISPLAY_TEST		0x0F00	// (1 - test)

#define CS					PortB4
#define MOSI				PortB5
#define SCK					PortB7


void InitLed(void)
{
	SendLed((DISPLAY_TEST >> 8), (DISPLAY_TEST | 0x00));
	SendLed((INTENSITY >> 8), (INTENSITY | 0x0f));
	SendLed((SCAN_LIMIT >> 8), (SCAN_LIMIT | 0x07));
	SendLed((NO_DECODE_MODE >> 8), (NO_DECODE_MODE | 0x00));
	SendLed((SHUTDOWN >> 8), (SHUTDOWN | 0x01));
	SetIntensity(0x0F);
	WriteNum(SYMBOL_EMTY);
}

void SendLed(uint8_t adr, uint8_t data)
{
	SPI_CS_Down();

	SPI_SendByte(adr);
	SPI_SendByte(data);

	SPI_CS_Up();
}

void SetIntensity(uint8_t a)  // 0 down to 15
{
	SendLed((INTENSITY >> 8), (SHUTDOWN | a));
}

void WriteNum(Matrix_Symbols num)
{
	uint8_t* s_ptr = NULL;
	int i;
	
	s_ptr = GetSymbols(num);

	for(i = 0; i < 8; i++)
	{
		SendLed((i + 1), s_ptr[i]);
	}
}

void WriteSymbol(uint8_t* num)
{
	int i;

	for(i = 0; i < 8; i++)
	{
		SendLed((i + 1), num[i]);
	}
}


uint8_t *GetSymbols(Matrix_Symbols i)
{
	return symbols_ptr[i];	
}



