#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>

#define ORANGE_LED 13
#define BUTTON 0

#define WAIT_PSC 1000
#define WAIT_DELAY (APB1_CLK / WAIT_PSC) // 42 MHz / 1000 = 42kHz
#define DEBOUNCE_MS 50
#define DEBOUNCE_TICKS (WAIT_DELAY * DEBOUNCE_MS / 1000)

void init_tim4(int prescaler, int delay){

	TIM4_CR1 = 0;
	TIM4_PSC = prescaler - 1;
	TIM4_ARR = delay - 1;
	TIM4_EGR = TIM_UG;
	TIM4_SR = 0;

}

void init_led(int LED) {
	// GPIOD_MODER registre à modifier
	// led * 2 car 2 bits par PIN, 
	// 2 est nb bits a écrire, 
	// GPIO_MODER_OUT est 0b10, donc mode out !
	GPIOD_MODER = REP_BITS(GPIOD_MODER, LED*2, 2, GPIO_MODER_OUT);
	
	// mode push-pull (envoie le courant)
	GPIOD_OTYPER &= ~(1<<LED); 
}

void init_button(int U_BUTTON) {
	GPIOA_MODER = REP_BITS(GPIOA_MODER, U_BUTTON*2, 2, GPIO_MODER_IN);
	GPIOA_PUPDR = REP_BITS(GPIOA_PUPDR, U_BUTTON*2, 2, GPIO_PUPDR_PD);
}

int button_pressed(int U_BUTTON) {
	return (GPIOA_IDR & (1 << U_BUTTON)) != 0;
}

int main() {
    printf("Starting...\n");

    // RCC init
    RCC_AHB1ENR |= RCC_GPIOAEN;
    RCC_AHB1ENR |= RCC_GPIODEN;
    RCC_APB1ENR |= RCC_TIM4EN;

    // GPIO init
    init_button(BUTTON);
    init_led(ORANGE_LED);

    init_tim4(WAIT_PSC, WAIT_DELAY);
    TIM4_CR1 = TIM_CEN;

    printf("Endless loop!\n");

    int led_state = 0;
    int last_stable_state = 0;
    int last_read_state = 0;
    uint32_t last_change_time = 0;

    while (1) {
        int current_read = button_pressed(BUTTON);
        uint32_t now = TIM4_CNT;

        // Un changement détecté ?
        if (current_read != last_read_state) {
            last_read_state = current_read;
            last_change_time = now;
        }

        // Est ce que ca fait assez longtemps ?
		// Penser à gérer le wrap, voir CM1 slide 47
		// cette version marche bien aussi.
        uint32_t elapsed = (now >= last_change_time)
            ? now - last_change_time
            : (0xFFFF - last_change_time + now);

        if (elapsed > DEBOUNCE_TICKS) {
            // If stable and different from last known state
            if (current_read != last_stable_state) {
                last_stable_state = current_read;

                // Detect press edge (not release)
                if (current_read) {
                    led_state = !led_state;
                    if (led_state)
                        GPIOD_BSRR = 1 << ORANGE_LED;
                    else
                        GPIOD_BSRR = 1 << (ORANGE_LED + 16);
                }
            }
        }
    }
}

