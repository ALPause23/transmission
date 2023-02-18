/*
 * transmission.c
 *
 * Created: 20.10.2022 22:41:13
 *  Author: Evgeni
 */ 

#include <transmisions.h>
#include <MAX7219.h>
//#include <symbols.h>

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

//void Animation(Matrix_Symbols symbol)
//{
	//uint8_t new_frame[8];
	//uint8_t symbol_source[8];
	//uint8_t i;
	//
	//memset(new_frame, 0, 8);
	//memcpy(symbol_source, GetSymbols(symbol), 8);
	//
	//for(i = 0; i < 7; i++)
	//{
		//memcpy(&new_frame[i], &symbol_source[i], 1);
		//WriteSymbol(new_frame);
		//delay_ms(800);
	//}
//}

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
				//Animation(SYMBOL_R);
				WriteNum(SYMBOL_R);
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
				WriteNum(SYMBOL_EMTY);
				delay_ms(5);
				WriteNum(SYMBOL_THREE);
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
				WriteNum(SYMBOL_FIVE);
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

