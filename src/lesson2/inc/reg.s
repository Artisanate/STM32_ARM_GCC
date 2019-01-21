.equ STACK_TOP, 		0X20001000             /*定义MSP起始地址值为0X20001000*/
/*rCC相关寄存器定义如下*/
.equ RCC_BASE,  		0X40021000             /*****定义时钟寄存器基地址******/
.equ RCC_APB2ENR,		(RCC_BASE + 0X18)
/*****************end*******************/
/*GPIOD相关寄存器定义如下*/
.equ GPIOD_BASE,         0x40011400
.equ GPIOD_CRL,         (GPIOD_BASE + 0x00)
.equ GPIOD_CRH,         (GPIOD_BASE + 0x04)
.equ GPIOD_ODR,         (GPIOD_BASE + 0x0C)
/*****************end*******************/
.equ IO_TDEN,             0x20 


