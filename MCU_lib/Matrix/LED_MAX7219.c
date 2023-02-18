
//#include <LED_MAX7219.h>

void SPI_WriteStartByte(char data);
void SPI_WriteEndByte(char data);
void SPI_WriteByte(char data);
void SPI_WriteByte(char data);
void SendLed(char adr, char data);


void InitLed()
{
	SPCR=(0<<SPIE) | (1<<SPE) | (0<<DORD) | (1<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	SPSR=(1<<SPI2X);
	
	// init display
	SendLed((DISPLAY_TEST >> 8), (DISPLAY_TEST | 0x00));
	SendLed((INTENSITY >> 8), (INTENSITY | 0x0f));
	SendLed((SCAN_LIMIT >> 8), (SCAN_LIMIT | 0x07));
	SendLed((NO_DECODE_MODE >> 8), (NO_DECODE_MODE | 0x00));
	SendLed((SHUTDOWN >> 8), (SHUTDOWN | 0x00));
}

void SPI_WriteStartByte(char data)
{
	PORTB &= ~(CS);
	SPDR = data;
	while(!(SPSR & (1<<SPIF)));
}

void SPI_WriteEndByte(char data)
{
	SPDR = data;
	while(!(SPSR & (1<<SPIF)));
	PORTB |= (CS);
}

void SPI_WriteByte(char data)
{
	SPDR = data;
	while(!(SPSR & (1<<SPIF)));
}

void SendLed(char adr, char data)
{
	int i = 0;
	PORTB &= ~(CS);
	while(i < 3)
	{
		SPI_WriteByte(adr);
		SPI_WriteByte(data);
		i++;
	}
	PORTB |= CS;
}

void ClearDisplay()
{
	for(char j = 1; j <= 8; j++)
	{
		SendLed(j,0);
	}
	SendLed((SHUTDOWN >> 8), (SHUTDOWN | 0x01));
}

void WriteNum(char *z, char *y, char *x)
{
	//SendLed((SHUTDOWN >> 8), (SHUTDOWN | 0x00));
	for(int i = 0; i < 8; i++)
	{
		PORTB &= ~(CS);
		
		SPI_WriteByte(i + 1);
		SPI_WriteByte(pgm_read_byte(&(z[i])));
		
		SPI_WriteByte(i + 1);
		SPI_WriteByte(pgm_read_byte(&(y[i])));
		
		SPI_WriteByte(i + 1);
		SPI_WriteByte(pgm_read_byte(&(x[i])));
		
		PORTB |= CS;
	}
	//SendLed((SHUTDOWN >> 8), (SHUTDOWN | 0x01));
}

char* GetNumbers(int i)
{
	switch(i)
	{
		case 0:
		{
			return ZERO;
			break;
		}
		case 1:
		{
			return ONE;
			break;
		}
		case 2:
		{
			return TWO;
			break;
		}
		case 3:
		{
			return THREE;
			break;
		}
		case 4:
		{
			return FOUR;
			break;
		}
		case 5:
		{
			return FIVE;
			break;
		}
		case 6:
		{
			return SIX;
			break;
		}
		case 7:
		{
			return SEVEN;
			break;
		}
		case 8:
		{
			return EITHT;
			break;
		}
		case 9:
		{
			return NINE;
			break;
		}
		default:
		{
			return EMPTY;
			break;
		}
	}
}

void SetIntensity(uint8_t a)  // 0 down to 15
{
	SendLed((INTENSITY >> 8), (SHUTDOWN | a));
}