.equ STACK_TOP, 		0X20001000             /*����MSP��ʼ��ֵַΪ0X20001000*/
/*rCC��ؼĴ�����������*/
.equ RCC_BASE,  		0X40021000             /*****����ʱ�ӼĴ�������ַ******/
.equ RCC_APB2ENR,		(RCC_BASE + 0X18)
/*****************end*******************/
/*GPIOD��ؼĴ�����������*/
.equ GPIOD_BASE,         0x40011400
.equ GPIOD_CRL,         (GPIOD_BASE + 0x00)
.equ GPIOD_CRH,         (GPIOD_BASE + 0x04)
.equ GPIOD_ODR,         (GPIOD_BASE + 0x0C)
/*****************end*******************/
.equ IO_TDEN,             0x20 


