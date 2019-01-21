.include "reg.s"
.code 16
.syntax unified
.global _start
.type _start,function
.type kcs_gpio_init,function
.type kcs_led_on,function
.type kcs_led_off,%function
vectors_table: .word STACK_TOP,_start
_start:
					
					bl kcs_gpio_init
loop:
					bl kcs_led_on
					mov r0,#500
					bl kcs_led_deay
					bl kcs_led_off
					mov r0,#500
					bl kcs_led_deay
					b  loop
                /*GPIOD初始化函数*/					
kcs_gpio_init:
					ldr r0,=RCC_APB2ENR
					ldr r1,=IO_TDEN
					str r1,[r0]

					ldr r0,=GPIOD_CRL
					mov r1,#0X00000300
					str r1,[r0]
					ldr r0,=GPIOD_ODR
					mov r1,#0X0
					str r1,[r0]
					nop
					nop
                 /*点亮LED函数*/
kcs_led_on:		    ldr r0,=GPIOD_ODR
					mov r1,#0X0
					str r1,[r0]
					mov pc,lr
                 /*关闭LED函数*/		
kcs_led_off:	  	ldr r0,=GPIOD_ODR
					mov r1,#0X4
					str r1,[r0]
					mov pc,lr	
                 /*延时DELAY函数*/
				.end
					
				 




			