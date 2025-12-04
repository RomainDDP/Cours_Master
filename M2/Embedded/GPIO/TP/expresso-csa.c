/* Embedded Systems - Exercise 7 */

#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>
#include <stm32f4/adc.h>

#define ONOFF_BUT	3	/* PA3 */
#define BREW_BUT	4	/* PA4 */

#define ON_LED		12	/* PD12 */
#define READY_LED	13	/* PD13 */

#define TEMP		1	/* PA1 */
#define PRESS		2	/* PA2 */
#define HEATER		4	/* PB4, AF2 */
#define PUMP		5	/* PB5, AF2 */

#define ACT_PSC		1000
#define ACT_PERIOD	(APB1_CLK / 10 / ACT_PSC)

#define REF_TEMP	3500
#define REF_PRESS	3000

#define TEMP_P		.5F
#define TEMP_I		.2F
#define TEMP_D		.3F
#define PRESS_P		.6F
#define PRESS_I		.15F
#define PRESS_D		.4F

int F_temp(int e) {
	static int sum = 0, pe = 0;
	int u;
	sum += e;
	u = TEMP_P*e + TEMP_I*e + TEMP_D*(e - pe);
	pe = e;
	return u;
}

int F_press(int e) {
	static int sum = 0, pe = 0;
	int u;
	sum += e;
	u = PRESS_P*e + PRESS_I*e + PRESS_D*(e - pe);
	pe = e;
	return u;
}


/****** User Interface ******/
 
void init_interface() {

	/* buttons */
	GPIOA_MODER = REP_BITS(GPIOA_MODER, ONOFF_BUT*2, 2, GPIO_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, ONOFF_BUT*2, 2, GPIO_PUPDR_PD);
	GPIOA_MODER = REP_BITS(GPIOA_MODER, BREW_BUT*2, 2, GPIO_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, BREW_BUT*2, 2, GPIO_PUPDR_PD);

	/* LEDs */
	GPIOD_MODER = REP_BITS(GPIOD_MODER, ON_LED*2, 2, GPIO_MODER_OUT);
	GPIOD_BSRR = 1 << (16 + ON_LED);
	GPIOD_MODER = REP_BITS(GPIOD_MODER, READY_LED*2, 2, GPIO_MODER_OUT);
	GPIOD_BSRR = 1 << (16 + READY_LED);
}

void set_on_led(int x) {
	if(x != 0)
		GPIOD_BSRR = 1 << ON_LED;
	else
		GPIOD_BSRR = 1 << (ON_LED + 16);
}

void set_ready_led(int x) {
	if(x != 0)
		GPIOD_BSRR = 1 << READY_LED;
	else
		GPIOD_BSRR = 1 << (READY_LED + 16);
}

int get_onoff_but() {
	static int pushed = 0;
	if((GPIOA_IDR & (1 << ONOFF_BUT)) != 0)
		pushed = 1;
	else if(pushed != 0) {
		pushed = 0;
		return 1;
	}
	return 0;
}

int get_brew_but() {
	static int pushed = 0;
	if((GPIOA_IDR & (1 << BREW_BUT)) != 0)
		pushed = 1;
	else if(pushed != 0) {
		pushed = 0;
		return 1;
	}
	return 0;
}


/****** sensor configuration ******/

void init_sensors() {

	GPIOA_MODER = REP_BITS(GPIOA_MODER, TEMP*2, 2, GPIO_MODER_ANA);
	GPIOA_MODER = REP_BITS(GPIOA_MODER, PRESS*2, 2, GPIO_MODER_ANA);

	ADC1_CR2 = ADC_ADON;
	ADC2_CR2 = ADC_ADON;
	ADC1_SQR3 = 1;
	ADC2_SQR3 = 2;
	ADC1_SQR1 = 0;
	ADC2_SQR1 = 0;

}

int get_temp() {
	ADC1_CR2 |= ADC_SWSTART;
	while((ADC1_SR & ADC_EOC) == 0);
	return ADC1_DR;
}

int get_press() {
	ADC2_CR2 |= ADC_SWSTART;
	while((ADC2_SR & ADC_EOC) == 0);
	return ADC2_DR;
}


/****** actuator configuration ******/

void init_actuators() {
	TIM3_CR1 = 0;

	TIM3_ARR = ACT_PERIOD;
	TIM3_PSC = ACT_PSC-1;

	TIM3_CCMR1 =
		  TIM_CCS1S_OUT | TIM_OC1M_PWM1
		| TIM_CCS2S_OUT | TIM_OC2M_PWM1;
	TIM3_CCER = TIM_CC1E | TIM_CC2E;
	TIM3_CCR1 = 0;
	TIM3_CCR2 = 0;

	GPIOB_MODER = REP_BITS(GPIOB_MODER, HEATER*2, 2, GPIO_MODER_ALT);
	GPIOB_AFRL = REP_BITS(GPIOB_AFRL, HEATER*4, 4, 2);
	GPIOB_MODER = REP_BITS(GPIOB_MODER, PUMP*2, 2, GPIO_MODER_ALT);
	GPIOB_AFRL = REP_BITS(GPIOB_AFRL, PUMP*4, 4, 2);

	TIM3_EGR = TIM_UG;
	TIM3_CR1 = TIM_CEN | TIM_ARPE;
}

void set_heater(int x) {
	TIM3_CCR1 = ACT_PERIOD * x / 100;
}

void set_pump(int x) {
	TIM3_CCR2 = ACT_PERIOD * x / 100;
}

int main() {
	enum { OFF, HEATING, READY, BREWING } state = OFF;
	int temp;
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;

	// main loop
	printf("Endless loop!\n");
	while(1) {

		/* manage updates */
		if(state != OFF) {
			temp = get_temp();
			set_heater(F_temp(REF_TEMP - temp));
		}
	
		/* manage automaton */
		switch(state) {
			
		case OFF:
			if(get_onoff_but() == 1) {
				state = HEATING;
				set_on_led(1);
			}
			break;

		case HEATING:
			if(get_onoff_but() == 1) {
				state = HEATING;
				set_heater(0);
				set_on_led(0);
			}
			else {
				temp = get_temp();
				set_heater(F_temp(REF_TEMP - temp));
				if(temp >= REF_TEMP) {
					state = READY;
					set_ready_led(1);
				}
			}
			break;

		case READY:
			if(get_onoff_but() == 1) {
				state = HEATING;
				set_heater(0);
				set_on_led(0);
				set_ready_led(0);
			}
			else {
				set_heater(REF_TEMP - get_temp());
				if(get_brew_but() == 1)
					state = BREWING;
			}
			break;

		case BREWING:
			if(get_brew_but() == 1) {
				state = READY;
				set_pump(0);
			}
			else {
				set_pump(F_press(REF_PRESS - get_press()));
				set_heater(REF_TEMP - get_temp());
			}
			break;
		
		}
	}

}
