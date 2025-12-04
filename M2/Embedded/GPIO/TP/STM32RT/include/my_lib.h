#ifndef MY_LIB

#define GREEN_LED 12
#define ORANGE_LED 13
#define RED_LED 14
#define BLUE_LED 15


// init functions
//void init_interrupt_tim4(void *);
void init_tim4(int, int);
void handler_tim4();
void init_led(int);
void init_button(int);

// util functions
void turn_on(int);
void turn_off(int);
int is_led_on(int);

int button_pressed(int);

int time_out();

#endif // !MY_LIB
