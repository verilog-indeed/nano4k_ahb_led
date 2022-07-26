/* Includes ------------------------------------------------------------------*/
#include "gw1ns4c.h"
#include "ahb_led.h"
#include <stdio.h>


/* Declarations --------------------------------------------------------------*/
void UartInit(void);
void delay_ms(__IO uint32_t delay_ms);

char messageBuff[32];
uint8_t counter;
uint8_t currentData;

/* Functions -----------------------------------------------------------------*/
int main(void) {
	SystemInit();	//Initializes system
	UartInit();
	
	counter = 0x0;
	currentData = 0;
	
	while(1) {
		setData(counter);
		snprintf(messageBuff, 32, "W Data: 0x%X\n", counter);
		UART_SendString(UART0, messageBuff);
		
		delay_ms(150);
		
		currentData = getData();
		snprintf(messageBuff, 32, "R Data: 0x%X\n \n", currentData);
		UART_SendString(UART0, messageBuff);

		counter += 0x00000001;
	}
}

//Initializes UART0
void UartInit(void)
{
  UART_InitTypeDef UART_InitStruct;
	
  UART_InitStruct.UART_Mode.UARTMode_Tx = ENABLE;
  UART_InitStruct.UART_Mode.UARTMode_Rx = DISABLE;
  UART_InitStruct.UART_Int.UARTInt_Tx = DISABLE;
  UART_InitStruct.UART_Int.UARTInt_Rx = DISABLE;
  UART_InitStruct.UART_Ovr.UARTOvr_Tx = DISABLE;
  UART_InitStruct.UART_Ovr.UARTOvr_Rx = DISABLE;
  UART_InitStruct.UART_Hstm = DISABLE;
  UART_InitStruct.UART_BaudRate = 9600;//Baud Rate
	
  UART_Init(UART0,&UART_InitStruct);
}

//delay ms
void delay_ms(__IO uint32_t delay_ms)
{
	for(delay_ms=(SystemCoreClock>>13)*delay_ms; delay_ms != 0; delay_ms--);
}

