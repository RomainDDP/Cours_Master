#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>

#define ORANGE_LED 13
#define BUTTON 0

#define WAIT_PSC 1000
#define WAIT_DELAY (APB1_CLK / WAIT_PSC)  // 42 MHz / 1000 = 42 kHz
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

    // Enable clocks
    RCC_AHB1ENR |= RCC_GPIOAEN;
    RCC_AHB1ENR |= RCC_GPIODEN;
    RCC_APB1ENR |= RCC_TIM4EN;

    // Init GPIO
    init_button(BUTTON);
    init_led(ORANGE_LED);

    // Init timer
    init_tim4(WAIT_PSC, WAIT_DELAY);
    TIM4_CR1 = TIM_CEN;

    printf("Endless loop!\n");

    // Blink intervals in ticks (1000, 500, 250 ms)
    uint32_t blink_intervals[] = {
        WAIT_DELAY * 1000 / 1000 - 1 , // Merci ChatGPT d'avoir vu celui-ci, mon timer n'arrive jamais à 42000 ticks donc la LED bug sur cet état...
        WAIT_DELAY * 500  / 1000,
        WAIT_DELAY * 250  / 1000
    };
    int num_intervals = sizeof(blink_intervals) / sizeof(blink_intervals[0]);
    int current_interval_index = 0;

    uint32_t last_toggle_time = TIM4_CNT;
    uint32_t last_button_change = 0;
    int last_stable_state = 0;
    int last_read_state = 0;
    int led_state = 0;

    while (1) {
        int current_read = button_pressed(BUTTON);
        uint32_t now = TIM4_CNT;

        // --- Debounce logic ---
        if (current_read != last_read_state) {
            last_read_state = current_read;
            last_button_change = now;
        }

		// On reprend le code de l'ex3.
        uint32_t elapsed_button = (now >= last_button_change)
            ? now - last_button_change
            : (0xFFFF - last_button_change + now);

		if (elapsed_button > DEBOUNCE_TICKS) {
			if (current_read != last_stable_state) {
				last_stable_state = current_read;

				if (current_read) {
					current_interval_index++;
					if (current_interval_index >= num_intervals)
						current_interval_index = 0;

					// Reset l'interval de blink 
					last_toggle_time = now;

					printf("Nouvelle période : %lu ms\n",
						   (blink_intervals[current_interval_index] * 1000) / WAIT_DELAY);
				}
			}
		}

        uint32_t elapsed_blink = (now >= last_toggle_time)
            ? now - last_toggle_time
            : (0xFFFF - last_toggle_time + now);

        if (elapsed_blink >= blink_intervals[current_interval_index]) {
            last_toggle_time = now;
            led_state = !led_state;
            if (led_state)
                GPIOD_BSRR = 1 << ORANGE_LED;
            else
                GPIOD_BSRR = 1 << (ORANGE_LED + 16);
        }
    }
}

