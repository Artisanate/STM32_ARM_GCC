.equ STACK_TOP, 		0X20001000             /*定义MSP起始地址值为0X20001000*/
/*rCC相关寄存器定义如下*/
.equ RCC_BASE,  		0X40021000             /*****定义时钟寄存器基地址******/
.equ RCC_CR,            (RCC_BASE + 0X00)
.equ RCC_CFGR,          (RCC_BASE + 0X04)
.equ RCC_CIR,           (RCC_BASE + 0X08)
.equ RCC_APB2RSTR,      (RCC_BASE + 0X0C)
.equ RCC_APB1RSTR,      (RCC_BASE + 0X10)
.equ RCC_AHBENR,		(RCC_BASE + 0X14)
.equ RCC_APB2ENR,		(RCC_BASE + 0X18)
.equ RCC_APB1ENR,		(RCC_BASE + 0X1C)
.equ RCC_BDCR,          (RCC_BASE + 0X20)
.equ RCC_CSR,		    (RCC_BASE + 0X24)
.equ RCC_AHBRSTR,		(RCC_BASE + 0X28)
.equ RCC_CFGR2,		    (RCC_BASE + 0X2C)
.equ FLASH_ACR,          0X40022000
/*****************end*******************/
/*GPIOD相关寄存器定义如下*/
.equ GPIOD_BASE,         0x40011400
.equ GPIOD_CRL,         (GPIOD_BASE + 0x00)
.equ GPIOD_CRH,         (GPIOD_BASE + 0x04)
.equ GPIOD_ODR,         (GPIOD_BASE + 0x0C)
/***************************************/
.equ IO_TDEN,             0x20 

.equ	Bit0  ,		0x00000001
.equ	Bit1  ,		0x00000002
.equ	Bit2  ,		0x00000004
.equ	Bit3  ,		0x00000008
.equ	Bit4  ,		0x00000010
.equ	Bit5  ,		0x00000020
.equ	Bit6  ,		0x00000040
.equ	Bit7  ,		0x00000080
.equ	Bit8  ,		0x00000100
.equ	Bit9  ,		0x00000200
.equ	Bit10 ,		0x00000400
.equ	Bit11 ,		0x00000800
.equ	Bit12 ,		0x00001000
.equ	Bit13 ,		0x00002000
.equ	Bit14 ,		0x00004000
.equ	Bit15 ,		0x00008000
.equ	Bit16 ,		0x00010000
.equ	Bit17 ,		0x00020000
.equ	Bit18 ,		0x00040000
.equ	Bit19 ,		0x00080000
.equ	Bit20 ,		0x00100000
.equ	Bit21 ,		0x00200000
.equ	Bit22 ,		0x00400000
.equ	Bit23 ,		0x00800000
.equ	Bit24 ,		0x01000000
.equ	Bit25 ,		0x02000000
.equ	Bit26 ,		0x04000000
.equ	Bit27 ,		0x08000000
.equ	Bit28 ,		0x10000000
.equ	Bit29 ,		0x20000000
.equ	Bit30 ,		0x40000000
.equ	Bit31 ,		0x80000000

/*****************end*******************/

	
