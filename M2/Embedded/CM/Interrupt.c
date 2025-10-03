#define TIME_100MS APB1_CLK/PSC/10


#define END		0
#define DOT		1
#define DASH	2

#define GREEN_LED 12

int message[] = {
	DOT, DOT, DOT,		// S
	DASH, DASH, DASH,	// O
	DOT, DOT, DOT,		// S
	END
};

enum {
	WAIT,
	DOTS,
	DASH_1,
	DASH_2,
	DASH_3,
	ENDS
} state = WAIT;

int current;

void init_TIM4(){

	TIM4_CR1 = 0;
	TIM4_PSC = 1000 - 1;
	TIM4_ARR = TIME_100MS - 1;
	TIM4_EGR = TIM4_UG;
	TIM4_SR = 0;

}

void init_TIM4_IRQ(){

	DISABLE_IRQ;
	NVIC_IRQ(TIM4_IRQ) = (uint32_t) handler_TIM4_IRQ;
	NVIC_IPR(TIM4_IRQ) = 0;
	NVIC_ISPR(TIM4_IRQ / 32) = 1 << (TIM4_IRQ % 32);
	NVIC_ICPR(TIM4_IRQ / 32) = 1 << (TIM4_IRQ % 32);
	TIM4_DIEN = TIM4_UIE;
	ENABLE_IRQS;

}

void handler_TIM4_IRQ() {

	if( (TIM4_SR & TIM_UIF) == 0) return;

	switch (state) {
	
		case WAIT:
			if(message[current] == END)
				state = ENDS;
			else if (message[current] == DOTS) {
				state = DOTS;
				current ++;
				GPIOD_BSRR = 1 << GREEN_LED;
			}
			else {
				state = DASH_1;
				current ++;
				GPIOD_BSRR = 1 << GREEN_LED;
			}
			break;

		case DOTS:
			state = WAIT;
			GPIOD_BSRR = 1 << (GREEN_LED + 16);
			break;

		case DASH_1:
			state = DASH_2;
			break;
		
		case DASH_2:
			state = DASH_3;
			break;

		case DASH_3:
			state = WAIT;
			GPIOD_BSRR = 1 << (GREEN_LED + 16);
			break;
	}

	TIM4_SR &= ~TIM_UIF;
}

void send_message(int *msg) {
	message = msg;
	current = 0;
	state = WAIT;
}

int main() {

	init_GPIOD();
	init_TIM4();
	init_TIM4_IRQ();
	TIM4_CR1 = TIM_CEN;
	while(1);

}
