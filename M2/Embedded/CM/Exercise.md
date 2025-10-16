d = clock * T / N
clock = 42Mhz
T = 0.02 // 20ms
N = 2^16 // on utilise le registre au max
donc d = 12.8 <=> 13

N = T * clock / d
N = 0.02

```
#define SERVO_PSC 14
// 50 parce que 1 / 50 => 0.02
#define SERVO_ARR (APR1_CLOCK / 50 / SERVO_PSC)
#define SERVO_1MS (SERVO_ARR / 20)

void init_servo() {

    TIM3_CR1 = 0;
    TIM3_PSC = SERVO_PSC - 1;
    TIM3_ARR = SERVO_ARR;

    TIM3_CCR1 = SERVO_1MS;
    
    // configure canal 1
    TIM3_CCMR1 = TIM_OC1M_PWM1;
    // active le canal 1
    TIM3_CCER = TIM_CC1E;

    TIM3_EGR = TIM_UG;
    TIM3_CR1 = TIM_CEN;

    }

void set_servo(int n) {

    TIM3_SR = 0;
    TIM3_EGR = TIM_UG;
    TIM3_CCR1 = SERVO_1MS + SERVO_1MS * n / 180;

    }
```

précision en degré : 180 / SERVO_1MS = 0.6° / impulsion

