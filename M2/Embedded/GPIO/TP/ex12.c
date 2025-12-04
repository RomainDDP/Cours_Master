#include "stm32f4/io.h"
#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/nvic.h>
#include <stm32f4/exti.h>
#include <stm32f4/syscfg.h>
#include <stm32f4/tim.h>
#include <stm32f4/adc.h>


#define INTERNAL_LED_PIN    12  // PD12
#define EXTERNAL_LED_PIN    0   // PA0       
#define ADC_INPUT_PIN       3   // PA3
#define ADC_INPUT_CHANNEL   3   // ADC123_IN3

#define THRESHOLD           2000

void init_ADC(void) {

    GPIOA_MODER = REP_BITS(GPIOA_MODER, ADC_INPUT_PIN*2, 2, GPIO_MODER_ANA);
    ADC1_SQR3 = REP_BITS(ADC1_SQR3, 0, 5, ADC_INPUT_CHANNEL);   // first channel to be converted
    ADC1_SQR1 = REP_BITS(ADC1_SQR1, 20, 4, 0);   // number of chennels converted - 1
    ADC1_CR1 = 0;   // Disable everything + mode 12bits
    ADC1_CR2 = ADC_ADON; // Enable ADC
}

void init_leds(void) {
    GPIOD_MODER = REP_BITS(GPIOD_MODER, INTERNAL_LED_PIN*2, 2, GPIO_MODER_OUT);
    GPIOD_OTYPER &= ~(1<<INTERNAL_LED_PIN);
    GPIOD_BSRR |= (1 << (INTERNAL_LED_PIN + 16));

    GPIOA_MODER = REP_BITS(GPIOA_MODER, EXTERNAL_LED_PIN*2, 2, GPIO_MODER_OUT);
    GPIOA_OTYPER &= ~(1<<EXTERNAL_LED_PIN);
    GPIOA_BSRR |= (1 << (EXTERNAL_LED_PIN + 16));
}

int main() {
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;
	RCC_APB2ENR |= RCC_ADC1EN;

	// initialization
    init_ADC();
    init_leds();

	// main loop
	printf("Endless loop!\n");
    int x = 0, old_x = 0;
	while(1) {
        ADC1_CR2 |= ADC_SWSTART;
        while((ADC1_SR & ADC_EOC) == 0);
        old_x = x;
        x = ADC1_DR;
        if (x != old_x) {
            printf("light : %d\n", x);
            if (x < THRESHOLD) {
                GPIOD_BSRR |= (1 << INTERNAL_LED_PIN);
                GPIOA_BSRR |= (1 << EXTERNAL_LED_PIN);
            } else {
                GPIOD_BSRR |= (1 << (INTERNAL_LED_PIN + 16));
                GPIOA_BSRR |= (1 << (EXTERNAL_LED_PIN + 16));
            }
        }
    }

}


