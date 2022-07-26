# nano4k_ahb_led
Example AHB-lite LED peripheral for the Nano 4K board with embedded Cortex M3 core

Includes Gowin EDA VHDL project and Keil uVision C project, use Gowin EDA Education V1.9.8.03 to flash the board.

"FPGAProject\CM3_AHB_LED\impl\pnr\CM3_AHB_LED.fs" for the bitsream.

"KeilProject\nano4k_ahb_led\nano4k_ahb_led.bin" for the Cortex M3 binary.

Connect each cathode of four LEDs to pins 27, 28, 29 and 30, and connect their anode to the 2.5V supply onboard,
you should see a 4-bit counter!

Connect pin 19 to the UART RX pin of a USB-UART converter to see debug stuff.
