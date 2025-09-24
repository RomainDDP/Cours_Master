#include <stdio.h>

#define WAIT_PSC 1000
#define WAIT_DELAY (APBI_CLK / SC / 4) // APBI_CLK = 42Mhz
#define ONE_SECOND (WAIT_DELAY * 4)

enum { NORMAL, ALERT, FROZEN };

int STATE = NORMAL;

void init_TIM4 () {
	TIM4_CR1 = 0;
	TIM4_PSC = WAIT_PSC−1;
	TIM4_ARR = ONE_SECOND;
	TIM4_EGR = TIM_UG;
	TIM4_SR = 0;
	GPIOD_MODER = REP_BITS(GPIOD_MODER, RED_LED*2, 2, GPIOD_MODER_OUT);
	GPIOD_OTYPR &= ~(1 << RED_LED);
	GPIOA_MODER = REP_BITS(GPIOA_MODER, B1*2, 2, GPIOA_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, B1*2, 2, GPIO_PUPDR_PD);
}

inline int button_pressed() {
	return (GPIOA_IDR & (1 << B1)) != 0;
}

inline int time_out() {
	return (TIME4_SR & TIM_UIF) == 0;
}

void freeze() { while(1); }

int main() {

	int b1_state = 0;
	int blink = 0;
	init_TIM4();

	TIM_CR4 = TIM_CEN;
	while(1) {

		switch (STATE) {

			case NORMAL:
				printf("NORMAL\n");

				if (time_out()) { 
					STATE = ALERT;
					TIM4_ARR = WAIT_DELAY;
					GPIOD_BSSR = 1 << RED_LED;
					blink = 0;
				}
				if (button_pressed()) {
					b1_state = 1;	
				}
				else if (b1_state == 1) {
					TIM4_CNT = 0;
					b1_state = 0;
				}

				break;

			case ALERT:
				printf("ALERT\n");

				if(button_pressed()) {
					b1_state = 1;
				}
				else if (b1_state == 1) {
					TIM4_ARR = ONE_SECOND;
					GPIOD_BSSR = 1 << RED_LED;
					TIM4_CNT = 0;
					STATE = NORMAL;
				} else if (time_out()) {
					if (blink = 7) {
						GPIOD_BSSR = 1 << RED_LED;
						state = FROZEN;
					}
					else {
						blink = blink + 1;
						GPIOD_ODR ^= (1 << RED_LED);
					}
				}
				break;


			default:
				printf("FROZEN\n");
				freeze();
				break;
		}
	}


	return 0;
}
