// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	/*
	int i = 0;
		volatile unsigned int *LED_PIO = (unsigned int*)0x90; //make a pointer to access the PIO block

		*LED_PIO = 0; //clear all LEDs
		while ( (1+1) != 3) //infinite loop
		{
			for (i = 0; i < 100000; i++); //software delay
			*LED_PIO |= 0x1; //set LSB
			for (i = 0; i < 100000; i++); //software delay
			*LED_PIO &= ~0x1; //clear LSB
		}
		return 1; //never gets here
		*/

	// Accumulator
		volatile unsigned int *LED_PIO = (unsigned int*)0x90; //make a pointer to access the PIO block
		volatile unsigned int *RST = (unsigned int*)0x70;
		volatile unsigned int *ACC = (unsigned int*)0x60;
		volatile unsigned int *SW = (unsigned int*)0x80;

		*LED_PIO = 0; //clear all LEDs

	 	volatile unsigned int sum = 0;
	 	int hold;
	 	hold = 1;

		while ( (1+1) != 3) //infinite loop

			{
				if(hold == 0 && *ACC == 1)	{	// checks if
						sum += *SW;
						hold = 1;
					}
				if(*RST == 1)	{
					sum = 0;
					}
				if(*ACC == 0)	{
					hold = 0;
					}
				*LED_PIO = sum;
			}

		return 1; //never gets here

}
