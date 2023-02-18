/*
 * transmission.c
 *
 * Created: 20.10.2022 22:41:13
 *  Author: Evgeni
 */ 

#include <transmisions.h>
#include <MAX7219.h>
//#include <symbols.h>
#include <setjmp.h>

typedef enum
{
	R = 0,
	ONE = 1,
	TWO = 2,
	THREE = 3,
	FOUR = 4,
	FIVE = 5,
	N = -1,
	none = -2
	
}Transmission_State;

//bool Get_State_Transmision(uint8_t num_trans)
//{
	//return GPIO_Read_Bits(PD, num_trans);
//}

//uint8_t r[8] = {
	//0xF0,
	//0x88,
	//0x88,
	//0xF0,
	//0xA0,
	//0x90,
	//0x88,
	//0x00
//};

Transmission_State Transmission_Get_EN(void)
{
	int i = 0;
	for(i = 0; i <= 5; i++)
	{
		if((PINB & (1<<i)) == 0)
		{
			return i;
		}
	}
	return N;
}

void Animation_HorizRows(Matrix_Symbols symbol)
{
	uint8_t new_frame[8];
	uint8_t symbol_source[8];
	uint8_t i;
	
	memset(new_frame, 0, 8);
	memcpy(symbol_source, GetSymbols(symbol), 8);
	
	for(i = 0; i < 7; i++)
	{
		memcpy(new_frame, symbol_source, i + 1);
		WriteSymbol(new_frame);
		delay_ms(50);
	}
}

void Animation_ProgressBar(Matrix_Symbols symbol)
{
	uint8_t new_frame[8];
	uint8_t symbol_source[8];

	
	memcpy(symbol_source, GetSymbols(symbol), 8);
	
	
	
	WriteSymbol(new_frame);
}

void Animation_Cursor(Matrix_Symbols symbol)
{
	uint8_t new_frame[8];
	uint8_t symbol_source[8];
	uint8_t row, column, mask = 0x80;
	uint8_t used_mask = 0UL;
	
	
	memset(new_frame, 0, 8);
	memcpy(symbol_source, GetSymbols(symbol), 8);
	
	for(row = 0; row < 7; row++)
	{
		for(column = 0; column < 5; column++)
		{
			memcpy(new_frame, symbol_source, row + 1);
			
			if(column == 0)
			{
				used_mask = mask;
			}
			else
			{
				used_mask += (64 / (1 << column-1));
			}
					
			new_frame[row] &= used_mask;
			new_frame[row] |= (0x80 >> column);
			WriteSymbol(new_frame);
			delay_ms(30);
		}
	}
	WriteSymbol(symbol_source);
}

void Animation_SlideShow(Matrix_Symbols symbol)
{
	uint8_t symbol_source[8];
	int8_t row;
	
	memcpy(symbol_source, GetSymbols(symbol), 8);
	
	for(row = 7; row >= 0; row--)
	{
		SendLed((row + 1), 0x00);
		delay_ms(50);
	}
		
	for(row = 0; row <= 7; row++)
	{
		SendLed(row + 1, symbol_source[row]);
		delay_ms(50);
	}
}

void Trans_Poll(void)
{
	static Transmission_State matrix_status_new = none;
	static Transmission_State matrix_status = none;
	static uint8_t count_delay = 0;
	
	matrix_status_new = Transmission_Get_EN();
	
	if(matrix_status != matrix_status_new)
	{
		count_delay++;
	}
	
	if(count_delay == 6)
	{
		switch(matrix_status_new)
		{
			case R:
			{
				WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				Animation_HorizRows(SYMBOL_R);
				//WriteNum(SYMBOL_R);
				break;
			}
			case ONE:
			{
				WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				WriteNum(SYMBOL_ONE);
				break;
			}
			case TWO:
			{
				WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				WriteNum(SYMBOL_TWO);
				break;
			}
			case THREE:
			{
				//WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				Animation_SlideShow(SYMBOL_THREE);
				//WriteNum(SYMBOL_THREE);
				break;
			}
			case FOUR:
			{
				WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				WriteNum(SYMBOL_FOUR);
				break;
			}
			case FIVE:
			{
				WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				Animation_Cursor(SYMBOL_FIVE);
				//WriteNum(SYMBOL_FIVE);
				break;
			}
			default:
			{
				WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				WriteNum(SYMBOL_N);
				break;
			}
		}
		count_delay = 0;
		matrix_status = matrix_status_new;
	}
}

