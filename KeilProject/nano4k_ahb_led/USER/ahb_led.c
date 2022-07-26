/* Includes ------------------------------------------------------------------*/
#include "ahb_led.h"

/* Functions ------------------------------------------------------------------*/
uint8_t setData(uint8_t ledData)
{
	(AHBLED->DATA) = ledData;
	return 1;
}

uint8_t getData(void)
{
	return (AHBLED->DATA);
}
