
// #define ONOFF_LED 12...

void init_ui() {

	// set ON/OFF button
	GPIOA_MODER = REP_BITS(GPIOA_MODER, 2*3, 2, GPIOA_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, 2*3, 2, GPIO_PUPDR_PD);

	// set Brew button
	GPIOA_MODER = REP_BITS(GPIOA_MODER, 2*4, 2, GPIOA_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, 2*4, 2, GPIO_PUPDR_PD);

	// set On LED (led, pas besoin de pull-up ou pull-down)
	GPIOD_MODER = REP_BITS(GPIOD_MODER, 2*12, 2, GPIOA_MODER_OUT);
	GPIOD_OTYPER &= ~(1 << 12);

	// set Ready LED (pas besoin de pupd).
	GPIOD_MODER = REP_BITS(GPIOD_MODER, 2*13, 2, GPIOA_MODER_OUT);
	GPIOD_OTYPER &= ~(1 << 13);

}

// Fonction set_ready_led exactement pareil, 
// sauf qu'on change ONOFF_LED par READY_LED
void set_onoff_led(int s) {
	GPIOD_BSSR = 1 << (ONOFF_LED + (s * 16));
}


// fonction test_ready_button pareil,
// sauf qu'on change ONOFF_BUT par READY_BUT
int test_onoff_button() {
	static int state = 0;
	
	if (GPIOD_IDR & (1 << ONOFF_BUT) != 0 ) s = 1;
	else if (s == 1) {
		s = 0;
		return 1;
	}
	return 0;
}



#define PSC 1000
#define ARR (APB1_CLK / PSC / 100)

void init_tim3(){

	TIM3_CR1 = 0;
	TIM3_PSC = PSC - 1;
	TIM3_ARR = ARR;
	TIM3_CCER = TIM_CC1E | TIM_CC2E;
	TIM3_CCMR1 = TIM_OC1M_PWM1 | TIM_OC2M_PWM1;
	TIM3_CCR1 = 0;
	TIM3_CCR2 = 0;

	// Heater PAD4, pareil pour Pump sur PAD5 mais avec 5 au lieu de 4.
	// Mulitplexeur a 16 entrées, donc 4 bits a set ici.
	GPIOD_AFRL = REP_BITS(GPIOD_AFRL, 4*4, 4, 2);
	GPIOD_MODER = REP_BITS(GPIOD_MODER, 4*2, 2, GPIOD_MODER_ALT);
	
	TIM3_CR1 = TIM_CEN;
}

// #define HEATER_INIT 50 ...
// Same pour start_pump PUMP_INIT et CCR2 au lieu de CCR1
void start_heater(){
	TIM3_CCR1 = HEATER_INIT;
}

void stop_heater() {
	TIM3_CCR1 = 0;
}

void set_heater(int n) {
	TIM3_CCR1 = ARR * n / 100;
}

void init_sensors() {

	ADC1_SQR3 = 1;
	ADC1_CR1 = ADC_EOCIE;
	ADC2_SQR3 = 2;
	ADC2_CR1 = ADC_EOCIE;
	ADC1_CR2 = ADC_	

}
