#define GREEN_LED    12
#define BUTTON 1
#define GPIO 0
#define PSC 1000
#define BLINK_TIME (APB1_CLK / PSC / 4) // APB1_CLK == 42MHz

void init_TIM4(){
    TIM4_CR1 = 0;
    TIM4_PSC = PSC - 1;
    TIM4_ARR = BLINK_TIME - 1;
    TIM4_EGR = TIM4_UG;
    TIM4_SR = 0;
    TIM4_DIER = TIM_UIE;
    NVIC_ICER(TIM4_IRQ/32) = 1 <<(TIM4_IRQ%32);
    NVIC_IRQ(TIM4_IRQ) = handler_tim4;
    NVIC_IPR(TIM4_IRQ) = 0;
    NVIC_ICPR(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);
    NVIC_ISER(TIM4_IRQ/32) = 1 << (TIM4_IRQ % 32);
}

void init_B1() {
    GPIOA_MODER = REP_BITS(GPIOA_MODER, BUTTON*2, 2, GPIO_MODER_IN);
    GPIOA_PUPDR = REP_BITS(GPIO_PUPDR, BUTTON*2, 2, GPIO_PUPDR_PD);

    SYSCFG_EXTICR1 = REP_BITS(SYSCFG_EXTICR1, 1*4, 4, GPIO); // lie GPIOA1 à EXTI1
    EXTI_RTSR |= 1 << BUTTON;   // rising edge
    EXTI_IMR &= ~(1 << BUTTON); // disable interrupt
    EXTI_FTSR |= 1 << BUTTON;   // falling edge
    EXTI_PR |= 1 << BUTTON;     // clear pendaing
    EXTI_IMR |= 1 << BUTTON;    // enable interrupt

    NVIC_ICER(EXTI1_IRQ/32) = 1 << (EXTI1_IRQ%32);
    NVIC_IRQ(EXTI1_IRQ) = handle_B1;
    NVIC_IPR(EXTI1_IRQ) = 0;
    NVIC_ICPR(EXTI1_IRQ/32) = 1 << (EXTI1_IRQ%32);
    NVIC_ISER(EXTI1_IRQ/32) = 1 << (EXTI1_IRQ%32);
}

void handler_B1() {
    static int last = 0;
    if(GPIOA_IDR & (1 << B1) != 0) {
        last = 1;
    } else if (last != 0) {
        if(TIM4_CR1 & TIM_CEN == 0) {
            TIM4_CR1 |= TIM_CEN;
        } else {
            TIM4_CR1 &= ~TIM_CEN;
        }
    }
    EXTI_IPR(EXTI1_IRQ/32) = 1<<(EXTI1_IRQ%32);
}


int main(void) {
    init_tim4();
    init_B1();
    init_LED();
    while(1) {
        NOP;
    }
}
