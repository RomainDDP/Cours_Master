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
#define ADC_INPUT_PIN       2   // PA3
#define ADC_INPUT_CHANNEL   2   // ADC123_IN2

#define MIN_VALUE           0
#define MAX_VALUE           4000
#define NB_LEDS             4
#define UNIT                ((MAX_VALUE - MIN_VALUE) / (NB_LEDS+1))

#define SYSCFGEN            0x4000

unsigned int LEDS_GPIOB[NB_LEDS] = {11,12,13,14};

void update_leds(int level) {
    int cur = MIN_VALUE;
    for(int i = 0; i < NB_LEDS; i++) {
        cur += UNIT;
        if(level >= cur) {
            GPIOB_BSRR |= (1 << LEDS_GPIOB[i]);
            printf("1");
        } else {
            GPIOB_BSRR |= (1 << (LEDS_GPIOB[i] + 16));
            printf("0");
        }
    }
    printf("\n");
}

void handler() {
    static int status = 0, prev = 0;
    if ((ADC1_SR & ADC_EOC) != 0) {
        prev = status;
        status = ADC1_DR;
        if (status != prev) {
            printf("light : %d\n", status);
            update_leds(status);
        }
        ADC1_SR &= ~(ADC_EOC);
        for(int i = 0; i < 1000000; i++) {
            NOP;
        }
    }
    ADC1_CR2 |= ADC_SWSTART;
    NVIC_ICPR(ADC_IRQ/32) = 1 << (ADC_IRQ%32);
}

void init_ADC(void) {
    DISABLE_IRQS;

    GPIOA_MODER = REP_BITS(GPIOA_MODER, ADC_INPUT_PIN*2, 2, GPIO_MODER_ANA);
    ADC1_SQR3 = REP_BITS(ADC1_SQR3, 0, 5, ADC_INPUT_CHANNEL);   // first channel to be converted
    ADC1_SQR1 = REP_BITS(ADC1_SQR1, 20, 4, 0);   // number of chennels converted - 1
    ADC1_CR1 = 0;   // Disable everything + mode 12bits
    ADC1_CR1 |= ADC_EOCIE;  // Enable end-of-conversion interrupt
    
    NVIC_ICER(ADC_IRQ>>5) = 1 << (ADC_IRQ & 0x1F);  // disable interrupt in NVIC
    NVIC_IRQ(ADC_IRQ) = (uint32_t)handler;        // config handler
    NVIC_IPR(ADC_IRQ) = 0;                        // setup priority
    NVIC_ICPR(ADC_IRQ>>5) = 1 << (ADC_IRQ & 0x1F);  // clear pending in NVIC
    NVIC_ISER(ADC_IRQ>>5) = 1 << (ADC_IRQ & 0x1F);  // enable interrupt in NVIC
    
    ADC1_CR2 |= ADC_ADON;       // Enable ADC
    ADC1_CR2 |= ADC_SWSTART;    // Start conversion
    ENABLE_IRQS;
}

void init_leds(void) {
    unsigned int led;
    for(int i = 0; i < NB_LEDS; i++) {
        led = LEDS_GPIOB[i];
        GPIOB_MODER = REP_BITS(GPIOB_MODER, led*2, 2, GPIO_MODER_OUT);
        GPIOB_OTYPER &= ~(1<<led);
        GPIOB_BSRR |= (1 << (led + 16));
    }
}


int main() {
	printf("\nStarting...\n");

	// RCC init
	RCC_AHB1ENR |= RCC_GPIOAEN;
    RCC_AHB1ENR |= RCC_GPIOBEN;
	RCC_AHB1ENR |= RCC_GPIODEN;
	RCC_APB1ENR |= RCC_TIM4EN;
	RCC_APB2ENR |= RCC_ADC1EN;
    RCC_APB2ENR |= SYSCFGEN;

	// initialization
    init_leds();
    init_ADC();

	// main loop
	printf("Endless loop!\n");
	while(1) {
    }

}


