/* Embedded Systems - Exercise 1 */

#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>

#include <my_lib.h>

// GPIOD
#define ORANGE_LED	13

// GPIODA
#define BUTTON 0

// TIMER
#define WAIT_PSC 1000
#define WAIT_DELAY (APB1_CLK / WAIT_PSC) // APBI_CLK = 42Mhz
#define QUART_SEC (WAIT_DELAY / 4)
#define FIFTY_MS (WAIT_DELAY / 20)

int main() {
	printf("Starting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;

	// GPIO init
	init_button(BUTTON);
	init_led(ORANGE_LED);

	init_tim(WAIT_PSC, WAIT_DELAY);

	// 0 = off, 1 = on.
	int current_state = 0;
	int last_button = 0;
	int button_state = 0;

	// Start timer
	TIM4_CR1 = TIM_CEN;
	int HALF_PERIOD = 0;
	printf("Endless loop!\n");
	while(1) {

		while(time_out()) {
			if(button_pressed(BUTTON)) {
				if(!button_state)
					last_button = TIM4_CNT;

				button_state = 1;
			} else if (button_state) {
				int now = TIM4_CNT;
				if (now <= last_button) 
					now += HALF_PERIOD;
				if (now - last_button >= FIFTY_MS) {
					button_state = 0;
					HALF_PERIOD += 200;
				}


			}
		}


		switch(current_state) {
			
			case 0:
				if(button_pressed(BUTTON)) current_state = 1;
				GPIOD_BSRR = 1 << (ORANGE_LED + 16);
				break;

			default:
				if(button_pressed(BUTTON)) current_state = 0;
				GPIOD_BSRR = 1 << ORANGE_LED;
				break;
		}

	}

}
