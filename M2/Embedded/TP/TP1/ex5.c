#include <tinyprintf.h>
#include <stm32f4/rcc.h>
#include <stm32f4/gpio.h>
#include <stm32f4/tim.h>

// -------------------------
// Hardware defines
// -------------------------
#define GREEN_LED   12
#define RED_LED     14
#define BUTTON      0

// -------------------------
// Timing parameters
// -------------------------
#define WAIT_PSC    1000
#define WAIT_DELAY  (APB1_CLK / WAIT_PSC / 4)   // APB1_CLK = 42 MHz
#define ONE_SECOND  (WAIT_DELAY * 4)
#define FIVE_SECONDS (ONE_SECOND * 5)
#define HALF_SECOND (ONE_SECOND / 2)
#define QUARTER_SECOND (ONE_SECOND / 4)

// -------------------------
// States
// -------------------------
enum { NORMAL, ALERT, FROZEN };
int STATE = NORMAL;

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

static inline int button_pressed(int U_BUTTON) {
    return (GPIOA_IDR & (1 << U_BUTTON)) != 0;
}

static inline void led_on(int led) {
    GPIOD_BSRR = 1 << led;
}

static inline void led_off(int led) {
    GPIOD_BSRR = 1 << (led + 16);
}

static inline void led_toggle(int led) {
    GPIOD_ODR ^= (1 << led);
}

// Proper timeout check (using UIF flag)
static inline int timer_elapsed(void) {
    if (TIM4_SR & TIM_UIF) {
        TIM4_SR &= ~TIM_UIF;   // clear flag
        return 1;
    }
    return 0;
}

// -------------------------
// Main
// -------------------------
int main(void) {
    printf("Starting state machine...\n");

    // Clock setup
    RCC_AHB1ENR |= RCC_GPIODEN;
    RCC_AHB1ENR |= RCC_GPIOAEN;
    RCC_APB1ENR |= RCC_TIM4EN;

    // GPIO setup
    init_led(GREEN_LED);
    init_led(RED_LED);
    init_button(BUTTON);

    // Timer setup
    init_tim4(WAIT_PSC, WAIT_DELAY * 40);
    TIM4_CR1 = TIM_CEN;  // start timer

    // Variables
    int button_state = 0;
    uint32_t last_change = 0;
    uint32_t now = 0;

    // Start system in NORMAL mode
    STATE = NORMAL;
    led_on(GREEN_LED);
    led_off(RED_LED);
    TIM4_CNT = 0;

    while (1) {

        switch (STATE) {

        // -----------------------
        // NORMAL: green LED ON for 5 seconds.
        // If button pressed → restart timer
        // Else after 5s → go ALERT
        // -----------------------
        case NORMAL:
            if (timer_elapsed()) {
                now = TIM4_CNT;
                if (now >= FIVE_SECONDS) {
                    STATE = ALERT;
                    printf("→ ALERT state\n");

                    TIM4_CNT = 0;

                    led_off(GREEN_LED);
                    led_off(RED_LED);
                }
            }

            // Button press handling
            if (button_pressed(BUTTON)) {
                button_state = 1;
            } else if (button_state) {
                button_state = 0;
                TIM4_CNT = 0;  // restart timer
                printf("Button press detected → timer reset (NORMAL)\n");
            }

            break;

        // -----------------------
        // ALERT: red LED blinks 5 seconds (500 ms period)
        // If button pressed → back to NORMAL
        // Else after 5s → FROZEN
        // -----------------------
        case ALERT:
            if (timer_elapsed()) {
                now = TIM4_CNT;

                // 250ms toggle
                if (now - last_change >= QUARTER_SECOND) {
                    last_change = now;
                    led_toggle(RED_LED);
                }

                // After 5s of blinking → FROZEN
                if (now >= FIVE_SECONDS) {
                    STATE = FROZEN;
                    printf("→ FROZEN state\n");
                    led_on(RED_LED);
                    led_off(GREEN_LED);
                }
            }

            if (button_pressed(BUTTON)) {
                button_state = 1;
            } else if (button_state) {
                button_state = 0;

                // Back to NORMAL
                printf("Button press detected → back to NORMAL\n");
                STATE = NORMAL;
                TIM4_CNT = 0;
                led_on(GREEN_LED);
                led_off(RED_LED);
            }

            break;

        // -----------------------
        // FROZEN: red LED solid ON, system halts.
        // -----------------------
        case FROZEN:
            printf("System frozen. Red LED ON.\n");
            led_on(RED_LED);
            while (1) ; // freeze system
            break;
        }
    }

    return 0;
}

