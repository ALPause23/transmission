/*
 * USI_SPI.h
 *
 * Created: 11.10.2022 14:58:40
 *  Author: Evgeni
 */ 


#ifndef USI_SPI_H_
#define USI_SPI_H_

#include <common.h>

void SPI_Init(void);
void SPI_SendByte(char byte);

void SPI_CS_Up(void);
void SPI_CS_Down(void);

#endif /* USI_SPI_H_ */