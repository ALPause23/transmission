/*
 * USI_SPI.c
 *
 * Created: 11.10.2022 14:54:42
 *  Author: Evgeni
 */ 
#include <USI_SPI.h>
#include <common.h>

typedef enum
{
	LSB,
	MSB,
	CPOL_0,
	CPOL_1,
	
}SPI_USI_Typedef;

uint8_t *CS_Port = &PORTD;
uint8_t CS_Pin = PORTD6;

void SPI_CS_Up(void)
{
	*CS_Port |= (1<<CS_Pin);
}

void SPI_CS_Down(void)
{
	*CS_Port &= ~(1<<CS_Pin);
}

void SPI_Init(void)
{
	DDRB|=((1<<PORTB6)|(1<<PORTB7));//Ножки USI на выход

	PORTB&=~((1<<PORTB6)|(1<<PORTB7));//Ножки USI в низкий уровень
	DDRD |= (1<<PORTD6);
	PORTD |= (1 << 6);//GPIO_Pin_6;
	USICR |= (1<<USIWM0);
}

void SPI_SendByte(uint8_t byte)

{
	USIDR = byte; //данные в регистр
	USISR |= (1<<USIOIF);//установим флаг начала передачи
	//SPI_CS_Down();
	while(!(USISR & (1<<USIOIF)))

	{
		USICR |= ((1<<USIWM0)|(1<<USICS1)|(1<<USICLK)|(1<<USITC));//постепенно передаем байт
		//delay_us(10);
	}
	//SPI_CS_Up();
}
