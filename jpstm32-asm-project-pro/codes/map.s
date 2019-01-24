;系统各个模块寄存器映射及定义
				
;=================================================
;系统时钟寄存器定义
;=================================================
RCC_BASE		EQU		0x40021000
RCC_CR			EQU		(RCC_BASE + 0x00)
RCC_CFGR        EQU     (RCC_BASE + 0x04)
RCC_CIR         EQU     (RCC_BASE + 0x08)
RCC_APB2RSTR    EQU     (RCC_BASE + 0x0C)
RCC_APB1RSTR    EQU     (RCC_BASE + 0x10)
RCC_AHBENR      EQU     (RCC_BASE + 0x14)
RCC_APB2ENR     EQU     (RCC_BASE + 0x18)
RCC_APB1ENR     EQU     (RCC_BASE + 0x1C)
RCC_BDCR        EQU     (RCC_BASE + 0x20)
RCC_CSR         EQU     (RCC_BASE + 0x24)

;-------------------------------------------------
;=================================================
;GPIOA端口寄存器定义
;=================================================
GPIOA_BASE      EQU     0x40010800
GPIOA_CRL       EQU     (GPIOA_BASE + 0x00)
GPIOA_CRH       EQU     (GPIOA_BASE + 0x04)
GPIOA_IDR       EQU     (GPIOA_BASE + 0x08)
GPIOA_ODR       EQU     (GPIOA_BASE + 0x0C)
GPIOA_BSRR      EQU     (GPIOA_BASE + 0x10)
GPIOA_BRR       EQU     (GPIOA_BASE + 0x14)
GPIOA_LCKR      EQU     (GPIOA_BASE + 0x18)

;-------------------------------------------------
;=================================================
;GPIOB端口寄存器定义
;=================================================
GPIOB_BASE      EQU     0x40010C00
GPIOB_CRL       EQU     (GPIOB_BASE + 0x00)
GPIOB_CRH       EQU     (GPIOB_BASE + 0x04)
GPIOB_IDR       EQU     (GPIOB_BASE + 0x08)
GPIOB_ODR       EQU     (GPIOB_BASE + 0x0C)
GPIOB_BSRR      EQU     (GPIOB_BASE + 0x10)
GPIOB_BRR       EQU     (GPIOB_BASE + 0x14)
GPIOB_LCKR      EQU     (GPIOB_BASE + 0x18)

;-------------------------------------------------
;=================================================
;GPIOC端口寄存器定义
;=================================================
GPIOC_BASE      EQU     0x40011000
GPIOC_CRL       EQU     (GPIOC_BASE + 0x00)
GPIOC_CRH       EQU     (GPIOC_BASE + 0x04)
GPIOC_IDR       EQU     (GPIOC_BASE + 0x08)
GPIOC_ODR       EQU     (GPIOC_BASE + 0x0C)
GPIOC_BSRR      EQU     (GPIOC_BASE + 0x10)
GPIOC_BRR       EQU     (GPIOC_BASE + 0x14)
GPIOC_LCKR      EQU     (GPIOC_BASE + 0x18)

;-------------------------------------------------
;=================================================
;GPIOD端口寄存器定义
;=================================================
GPIOD_BASE      EQU     0x40011400
GPIOD_CRL       EQU     (GPIOD_BASE + 0x00)
GPIOD_CRH       EQU     (GPIOD_BASE + 0x04)
GPIOD_IDR       EQU     (GPIOD_BASE + 0x08)
GPIOD_ODR       EQU     (GPIOD_BASE + 0x0C)
GPIOD_BSRR      EQU     (GPIOD_BASE + 0x10)
GPIOD_BRR       EQU     (GPIOD_BASE + 0x14)
GPIOD_LCKR      EQU     (GPIOD_BASE + 0x18)

;-------------------------------------------------
;=================================================
;GPIOE端口寄存器定义
;=================================================
GPIOE_BASE      EQU     0x40011800
GPIOE_CRL       EQU     (GPIOE_BASE + 0x00)
GPIOE_CRH       EQU     (GPIOE_BASE + 0x04)
GPIOE_IDR       EQU     (GPIOE_BASE + 0x08)
GPIOE_ODR       EQU     (GPIOE_BASE + 0x0C)
GPIOE_BSRR      EQU     (GPIOE_BASE + 0x10)
GPIOE_BRR       EQU     (GPIOE_BASE + 0x14)
GPIOE_LCKR      EQU     (GPIOE_BASE + 0x18)

;-------------------------------------------------
;=================================================
;GPIOF端口寄存器定义
;=================================================
GPIOF_BASE      EQU     0x40011C00
GPIOF_CRL       EQU     (GPIOF_BASE + 0x00)
GPIOF_CRH       EQU     (GPIOF_BASE + 0x04)
GPIOF_IDR       EQU     (GPIOF_BASE + 0x08)
GPIOF_ODR       EQU     (GPIOF_BASE + 0x0C)
GPIOF_BSRR      EQU     (GPIOF_BASE + 0x10)
GPIOF_BRR       EQU     (GPIOF_BASE + 0x14)
GPIOF_LCKR      EQU     (GPIOF_BASE + 0x18)

;-------------------------------------------------
;=================================================
;GPIOG端口寄存器定义
;=================================================
GPIOG_BASE      EQU     0x40012000
GPIOG_CRL       EQU     (GPIOG_BASE + 0x00)
GPIOG_CRH       EQU     (GPIOG_BASE + 0x04)
GPIOG_IDR       EQU     (GPIOG_BASE + 0x08)
GPIOG_ODR       EQU     (GPIOG_BASE + 0x0C)
GPIOG_BSRR      EQU     (GPIOG_BASE + 0x10)
GPIOG_BRR       EQU     (GPIOG_BASE + 0x14)
GPIOG_LCKR      EQU     (GPIOG_BASE + 0x18)

;-------------------------------------------------
;=================================================
;系统中断寄存器定义
;=================================================
NVIC_BASE       EQU     0xE000E100
NVIC_ISER1		EQU		(NVIC_BASE + 0X0000)
NVIC_ISER2		EQU		(NVIC_BASE + 0X0004)
NVIC_ICER1		EQU		(NVIC_BASE + 0X0080)
NVIC_ICER2		EQU		(NVIC_BASE + 0X0084)
NVIC_ISPR1		EQU		(NVIC_BASE + 0X0100)
NVIC_ISPR2		EQU		(NVIC_BASE + 0X0104)
NVIC_ICPR1		EQU		(NVIC_BASE + 0X0180)
NVIC_ICPR2		EQU		(NVIC_BASE + 0X0184)
NVIC_IABR1		EQU		(NVIC_BASE + 0X0200)
NVIC_IABR2		EQU		(NVIC_BASE + 0X0204)
NVIC_IPR_BASE	EQU		(NVIC_BASE + 0X0300)


;-------------------------------------------------
;=================================================
;SCB寄存器组定义
;=================================================
SCB_BASE		EQU		0XE000ED00
SCB_CPUID		EQU		(SCB_BASE + 0X00)
SCB_ICSR		EQU		(SCB_BASE + 0X04)
SCB_VTOR		EQU		(SCB_BASE + 0X08)
SCB_AIRCR		EQU		(SCB_BASE + 0X0C)
SCB_SCR			EQU		(SCB_BASE + 0X10)
SCB_CCR			EQU		(SCB_BASE + 0X14)
SCB_SHPR1		EQU		(SCB_BASE + 0X18)
SCB_SHPR2		EQU		(SCB_BASE + 0X1C)
SCB_SHPR3		EQU		(SCB_BASE + 0X20)
SCB_SHCSR		EQU		(SCB_BASE + 0X24)
SCB_CFSR		EQU		(SCB_BASE + 0X28)
SCB_HFSR		EQU		(SCB_BASE + 0X2C)
SCB_DFSR		EQU		(SCB_BASE + 0X30)
SCB_MMFAR		EQU		(SCB_BASE + 0X34)
SCB_BFAR		EQU		(SCB_BASE + 0X38)
SCB_AFSR		EQU		(SCB_BASE + 0X3C)


;-------------------------------------------------
;=================================================
;Systick reg
;=================================================
SysTick_BASE    EQU     0xE000E010
SYSTICK_CTRL    EQU     (SysTick_BASE + 0x00)
SYSTICK_LOAD    EQU     (SysTick_BASE + 0x04)
SYSTICK_VAL		EQU		(SysTick_BASE + 0X08)
SYSTICK_CALIB	EQU		(SysTick_BASE + 0X0C)
;FLASH配置寄存器
FLASH_ACR       EQU             0x40022000

;-------------------------------------------------
;=================================================
;USART1 寄存器定义
;=================================================
USART1_BASE		EQU		0X40013800
USART1_SR		EQU		(USART1_BASE + 0X00)
USART1_DR		EQU		(USART1_BASE + 0X04)
USART1_BRR		EQU		(USART1_BASE + 0X08)
USART1_CR1		EQU		(USART1_BASE + 0X0C)
USART1_CR2		EQU		(USART1_BASE + 0X10)
USART1_CR3		EQU		(USART1_BASE + 0X14)
USART1_GTPR		EQU		(USART1_BASE + 0X18)

;-------------------------------------------------
;=================================================
;FSMC相关寄存器定义
;=================================================
FSMC_Bank1_R_BASE	EQU		0XA0000000
FSMC_BANK1_BTCR		EQU		(FSMC_Bank1_R_BASE)
FSMC_Bank1E_R_BASE	EQU		0XA0000104
FSMC_BANK1E_BWTR	EQU		(FSMC_Bank1E_R_BASE)

;-------------------------------------------------
;=================================================
;数据位的定义
;=================================================
Bit0            EQU             0x00000001
Bit1            EQU             0x00000002
Bit2            EQU             0x00000004
Bit3            EQU             0x00000008
Bit4            EQU             0x00000010
Bit5            EQU             0x00000020
Bit6            EQU             0x00000040
Bit7            EQU             0x00000080
Bit8            EQU             0x00000100
Bit9            EQU             0x00000200
Bit10           EQU             0x00000400
Bit11           EQU             0x00000800
Bit12           EQU             0x00001000
Bit13           EQU             0x00002000
Bit14           EQU             0x00004000
Bit15           EQU             0x00008000
Bit16           EQU             0x00010000
Bit17           EQU             0x00020000
Bit18           EQU             0x00040000
Bit19           EQU             0x00080000
Bit20           EQU             0x00100000
Bit21           EQU             0x00200000
Bit22           EQU             0x00400000
Bit23           EQU             0x00800000
Bit24           EQU             0x01000000
Bit25           EQU             0x02000000
Bit26           EQU             0x04000000
Bit27           EQU             0x08000000
Bit28           EQU             0x10000000
Bit29           EQU             0x20000000
Bit30           EQU             0x40000000
Bit31           EQU             0x80000000

;-------------------------------------------------
;=================================================
;按键的键值定义
;=================================================
KEY_UP			EQU				0X01
KEY_DOWN		EQU				0X02
KEY_LEFT		EQU				0X04
KEY_RIGHT		EQU				0X08
KEY_CENTER		EQU				0X0C
;-------------------------------------------------
;=================================================
;系统中断号定义
;=================================================

WWDG_IRQChannel              EQU	0x00;)  /* Window WatchDog Interrupt */
PVD_IRQChannel               EQU	0x01;)  /* PVD through EXTI Line detection Interrupt */
TAMPER_IRQChannel            EQU	0x02;)  /* Tamper Interrupt */
RTC_IRQChannel               EQU	0x03;)  /* RTC global Interrupt */
FLASH_IRQChannel             EQU	0x04;)  /* FLASH global Interrupt */
RCC_IRQChannel               EQU	0x05;)  /* RCC global Interrupt */
EXTI0_IRQChannel             EQU	0x06;)  /* EXTI Line0 Interrupt */
EXTI1_IRQChannel             EQU	0x07;)  /* EXTI Line1 Interrupt */
EXTI2_IRQChannel             EQU	0x08;)  /* EXTI Line2 Interrupt */
EXTI3_IRQChannel             EQU	0x09;)  /* EXTI Line3 Interrupt */
EXTI4_IRQChannel             EQU	0x0A;)  /* EXTI Line4 Interrupt */
DMA1_Channel1_IRQChannel     EQU	0x0B;)  /* DMA1 Channel 1 global Interrupt */
DMA1_Channel2_IRQChannel     EQU	0x0C;)  /* DMA1 Channel 2 global Interrupt */
DMA1_Channel3_IRQChannel     EQU	0x0D;)  /* DMA1 Channel 3 global Interrupt */
DMA1_Channel4_IRQChannel     EQU	0x0E;)  /* DMA1 Channel 4 global Interrupt */
DMA1_Channel5_IRQChannel     EQU	0x0F;)  /* DMA1 Channel 5 global Interrupt */
DMA1_Channel6_IRQChannel     EQU	0x10;)  /* DMA1 Channel 6 global Interrupt */
DMA1_Channel7_IRQChannel     EQU	0x11;)  /* DMA1 Channel 7 global Interrupt */
ADC1_2_IRQChannel            EQU	0x12;)  /* ADC1 et ADC2 global Interrupt */
USB_HP_CAN_TX_IRQChannel     EQU	0x13;)  /* USB High Priority or CAN TX Interrupts */
USB_LP_CAN_RX0_IRQChannel    EQU	0x14;)  /* USB Low Priority or CAN RX0 Interrupts */
CAN_RX1_IRQChannel           EQU	0x15;)  /* CAN RX1 Interrupt */
CAN_SCE_IRQChannel           EQU	0x16;)  /* CAN SCE Interrupt */
EXTI9_5_IRQChannel           EQU	0x17;)  /* External Line[9:5] Interrupts */
TIM1_BRK_IRQChannel          EQU	0x18;)  /* TIM1 Break Interrupt */
TIM1_UP_IRQChannel           EQU	0x19;)  /* TIM1 Update Interrupt */
TIM1_TRG_COM_IRQChannel      EQU	0x1A;)  /* TIM1 Trigger and Commutation Interrupt */
TIM1_CC_IRQChannel           EQU	0x1B;)  /* TIM1 Capture Compare Interrupt */
TIM2_IRQChannel              EQU	0x1C;)  /* TIM2 global Interrupt */
TIM3_IRQChannel              EQU	0x1D;)  /* TIM3 global Interrupt */
TIM4_IRQChannel              EQU	0x1E;)  /* TIM4 global Interrupt */
I2C1_EV_IRQChannel           EQU	0x1F;)  /* I2C1 Event Interrupt */
I2C1_ER_IRQChannel           EQU	0x20;)  /* I2C1 Error Interrupt */
I2C2_EV_IRQChannel           EQU	0x21;)  /* I2C2 Event Interrupt */
I2C2_ER_IRQChannel           EQU	0x22;)  /* I2C2 Error Interrupt */
SPI1_IRQChannel              EQU	0x23;)  /* SPI1 global Interrupt */
SPI2_IRQChannel              EQU	0x24;)  /* SPI2 global Interrupt */
USART1_IRQChannel            EQU	0x25;)  /* USART1 global Interrupt */
USART2_IRQChannel            EQU	0x26;)  /* USART2 global Interrupt */
USART3_IRQChannel            EQU	0x27;)  /* USART3 global Interrupt */
EXTI15_10_IRQChannel         EQU	0x28;)  /* External Line[15:10] Interrupts */
RTCAlarm_IRQChannel          EQU	0x29;)  /* RTC Alarm through EXTI Line Interrupt */
USBWakeUp_IRQChannel         EQU	0x2A;)  /* USB WakeUp from suspend through EXTI Line Interrupt */
TIM8_BRK_IRQChannel          EQU	0x2B;)  /* TIM8 Break Interrupt */
TIM8_UP_IRQChannel           EQU	0x2C;)  /* TIM8 Update Interrupt */
TIM8_TRG_COM_IRQChannel      EQU	0x2D;)  /* TIM8 Trigger and Commutation Interrupt */
TIM8_CC_IRQChannel           EQU	0x2E;)  /* TIM8 Capture Compare Interrupt */
ADC3_IRQChannel              EQU	0x2F;)  /* ADC3 global Interrupt */
FSMC_IRQChannel              EQU	0x30;)  /* FSMC global Interrupt */
SDIO_IRQChannel              EQU	0x31;)  /* SDIO global Interrupt */
TIM5_IRQChannel              EQU	0x32;)  /* TIM5 global Interrupt */
SPI3_IRQChannel              EQU	0x33;)  /* SPI3 global Interrupt */
UART4_IRQChannel             EQU	0x34;)  /* UART4 global Interrupt */
UART5_IRQChannel             EQU	0x35;)  /* UART5 global Interrupt */
TIM6_IRQChannel              EQU	0x36;)  /* TIM6 global Interrupt */
TIM7_IRQChannel              EQU	0x37;)  /* TIM7 global Interrupt */
DMA2_Channel1_IRQChannel     EQU	0x38;)  /* DMA2 Channel 1 global Interrupt */
DMA2_Channel2_IRQChannel     EQU	0x39;)  /* DMA2 Channel 2 global Interrupt */
DMA2_Channel3_IRQChannel     EQU	0x3A;)  /* DMA2 Channel 3 global Interrupt */
DMA2_Channel4_5_IRQChannel   EQU	0x3B;)  /* DMA2 Channel 4 and DMA2 Channel 5 global Interrupt */

;颜色定义				
WHITE       	EQU			0x0000FFFF
BLACK      		EQU			0x00000000	  
BLUE       		EQU			0x0000F800 
BRED        	EQU			0X0000F81F
GRED 			EQU			0X0000FFE0
RED         	EQU			0x0000001F
MAGENTA     	EQU			0x0000F81F
GREEN       	EQU			0x000007E0
CYAN        	EQU			0x00007FFF
YELLOW      	EQU			0x000007FF
BROWN 			EQU			0X0000BC40 
BRRED 			EQU			0X0000FC07 
GRAY  			EQU			0X00008430 



				END




