/* Includes ------------------------------------------------------------------*/
#include "gw1ns4c.h"


/* Definitions ------------------------------------------------------------------*/
//type definition
typedef struct
{
  __IO   uint8_t  DATA;        /* Offset: 0x000 (R/W) [31:0] */
}AHBLED_TypeDef;

//base address
#define AHBLED_BASE   (0xA000000C)

//mapping
#define AHBLED  ((AHBLED_TypeDef*) AHBLED_BASE)

/* Declarations ------------------------------------------------------------------*/
uint8_t setData(uint8_t ledData);
uint8_t getData(void);
