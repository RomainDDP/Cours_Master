#ifndef MY_LIB

#define GREEN_LED 12
#define ORANGE_LED 13
#define RED_LED 14
#define BLUE_LED 15


// init functions
void init_tim(int, int);
void init_led(int);
void init_button(int);

// util functions
void delay(int);
void blink(int, int);
int button_pressed(int);

int time_out();

#endif // !MY_LIB
