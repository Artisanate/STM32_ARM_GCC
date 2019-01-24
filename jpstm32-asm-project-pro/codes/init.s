;============================================
;系统启动文件
;初始化异常向量表、时钟等
;初始化主堆栈
;初始化线程堆栈
;初始化异常向量表
;初始化外部中断向量表
;初始化部分硬件
;============================================

;============================================
;导入其他文件
				INCLUDE map.s		
;============================================

;============================================
;主堆栈以及线程堆栈的定义
;============================================
MSP_SIZE		EQU		0X00000400
PSP_SIZE		EQU		0X00000400
				AREA	USER_STACK, NOINIT, READWRITE
MSP_STACK		SPACE	MSP_SIZE
MSP_TOP;主堆栈栈顶
PSP_STACK		SPACE	PSP_SIZE
PSP_TOP;线程堆栈栈顶
;--------------------------------------------
;============================================
;异常向量表及系统默认数据段
;============================================
				;初始化数据段，存放异常向量表
				AREA	RESET, DATA, READONLY
				EXPORT  __Vectors
				EXPORT  __Vectors_End
				EXPORT  __Vectors_Size

__Vectors   	DCD     MSP_TOP               	   ; Top of Stack
				DCD     Reset_Handler              ; Reset Handler
				DCD     NMI_Handler                ; NMI Handler
				DCD     HardFault_Handler          ; Hard Fault Handler
				DCD     MemManage_Handler          ; MPU Fault Handler
				DCD     BusFault_Handler           ; Bus Fault Handler
				DCD     UsageFault_Handler         ; Usage Fault Handler
				DCD     0                          ; Reserved
				DCD     0                          ; Reserved
				DCD     0                          ; Reserved
				DCD     0                          ; Reserved
				DCD     SVC_Handler                ; SVCall Handler
				DCD     DebugMon_Handler           ; Debug Monitor Handler
				DCD     0                          ; Reserved
				DCD     PendSV_Handler             ; PendSV Handler
				DCD     SysTick_Handler            ; SysTick Handler
				
				; External Interrupts
                DCD     WWDG_IRQHandler            ; Window Watchdog
                DCD     PVD_IRQHandler             ; PVD through EXTI Line detect
                DCD     TAMPER_IRQHandler          ; Tamper
                DCD     RTC_IRQHandler             ; RTC
                DCD     FLASH_IRQHandler           ; Flash
                DCD     RCC_IRQHandler             ; RCC
                DCD     EXTI0_IRQHandler           ; EXTI Line 0
                DCD     EXTI1_IRQHandler           ; EXTI Line 1
                DCD     EXTI2_IRQHandler           ; EXTI Line 2
                DCD     EXTI3_IRQHandler           ; EXTI Line 3
                DCD     EXTI4_IRQHandler           ; EXTI Line 4
                DCD     DMA1_Channel1_IRQHandler   ; DMA1 Channel 1
                DCD     DMA1_Channel2_IRQHandler   ; DMA1 Channel 2
                DCD     DMA1_Channel3_IRQHandler   ; DMA1 Channel 3
                DCD     DMA1_Channel4_IRQHandler   ; DMA1 Channel 4
                DCD     DMA1_Channel5_IRQHandler   ; DMA1 Channel 5
                DCD     DMA1_Channel6_IRQHandler   ; DMA1 Channel 6
                DCD     DMA1_Channel7_IRQHandler   ; DMA1 Channel 7
                DCD     ADC1_2_IRQHandler          ; ADC1 & ADC2
                DCD     USB_HP_CAN1_TX_IRQHandler  ; USB High Priority or CAN1 TX
                DCD     USB_LP_CAN1_RX0_IRQHandler ; USB Low  Priority or CAN1 RX0
                DCD     CAN1_RX1_IRQHandler        ; CAN1 RX1
                DCD     CAN1_SCE_IRQHandler        ; CAN1 SCE
                DCD     EXTI9_5_IRQHandler         ; EXTI Line 9..5
                DCD     TIM1_BRK_IRQHandler        ; TIM1 Break
                DCD     TIM1_UP_IRQHandler         ; TIM1 Update
                DCD     TIM1_TRG_COM_IRQHandler    ; TIM1 Trigger and Commutation
                DCD     TIM1_CC_IRQHandler         ; TIM1 Capture Compare
                DCD     TIM2_IRQHandler            ; TIM2
                DCD     TIM3_IRQHandler            ; TIM3
                DCD     TIM4_IRQHandler            ; TIM4
                DCD     I2C1_EV_IRQHandler         ; I2C1 Event
                DCD     I2C1_ER_IRQHandler         ; I2C1 Error
                DCD     I2C2_EV_IRQHandler         ; I2C2 Event
                DCD     I2C2_ER_IRQHandler         ; I2C2 Error
                DCD     SPI1_IRQHandler            ; SPI1
                DCD     SPI2_IRQHandler            ; SPI2
                DCD     USART1_IRQHandler          ; USART1
                DCD     USART2_IRQHandler          ; USART2
                DCD     USART3_IRQHandler          ; USART3
                DCD     EXTI15_10_IRQHandler       ; EXTI Line 15..10
                DCD     RTCAlarm_IRQHandler        ; RTC Alarm through EXTI Line
                DCD     USBWakeUp_IRQHandler       ; USB Wakeup from suspend
                DCD     TIM8_BRK_IRQHandler        ; TIM8 Break
                DCD     TIM8_UP_IRQHandler         ; TIM8 Update
                DCD     TIM8_TRG_COM_IRQHandler    ; TIM8 Trigger and Commutation
                DCD     TIM8_CC_IRQHandler         ; TIM8 Capture Compare
                DCD     ADC3_IRQHandler            ; ADC3
                DCD     FSMC_IRQHandler            ; FSMC
                DCD     SDIO_IRQHandler            ; SDIO
                DCD     TIM5_IRQHandler            ; TIM5
                DCD     SPI3_IRQHandler            ; SPI3
                DCD     UART4_IRQHandler           ; UART4
                DCD     UART5_IRQHandler           ; UART5
                DCD     TIM6_IRQHandler            ; TIM6
                DCD     TIM7_IRQHandler            ; TIM7
                DCD     DMA2_Channel1_IRQHandler   ; DMA2 Channel1
                DCD     DMA2_Channel2_IRQHandler   ; DMA2 Channel2
                DCD     DMA2_Channel3_IRQHandler   ; DMA2 Channel3
                DCD     DMA2_Channel4_5_IRQHandler ; DMA2 Channel4 & Channel5
				SPACE	200
__Vectors_End
__Vectors_Size  EQU  __Vectors_End - __Vectors
				
				AREA	SYS_DATA, DATA, READONLY
BRIUP			DCB	"www.briup.com",'\0'				

;--------------------------------------------			
;============================================
;系统异常处理函数，系统默认代码段
;============================================
				AREA |.TEXT|, CODE, READONLY
				IMPORT	KEY_INIT
				IMPORT	KEY_SCAN
				IMPORT	LED_INIT
				IMPORT	LEDR_ON
				IMPORT	LEDR_OFF
				IMPORT	LEDG_ON
				IMPORT	LEDG_OFF
				IMPORT	LEDB_ON
				IMPORT	LEDB_OFF
				IMPORT	USR_DELAY
				IMPORT	SYSTICK_INIT
				IMPORT	SYS_DELAY_MS
				IMPORT	USART1_INIT
				IMPORT	USART1_PUTC
				IMPORT	NVIC_SET_GROUP
				IMPORT	USART1_GETC
				IMPORT	LCD_INIT
				IMPORT	LCD_CLEAR
				IMPORT	LCD_DRAW_POINT
				IMPORT	LCD_DRAW_CHAR
				IMPORT	LCD_DRAW_STR
; Reset handler
Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				
				;系统时钟初始化
				BL		RCC_INIT
				BL		NVIC_SET_GROUP
				BL		LED_INIT
				BL		KEY_INIT
				BL		SYSTICK_INIT
				BL		USART1_INIT
				BL		LCD_INIT
				
					
				MOV		R0, #YELLOW
				BL		LCD_CLEAR
				MOV		R0, #100
				MOV		R1, #100
				LDR		R2, =BRIUP
				BL		LCD_DRAW_STR
MAIN			BL		USART1_GETC
				MOV		R1, #0X31
				CMP		R0, R1
				BLEQ	LEDR_ON
				MOV		R0, #500
				BLEQ	SYS_DELAY_MS
				BLEQ	LEDR_OFF
				MOV		R0, #500
				BLEQ	SYS_DELAY_MS
				B		MAIN
                B		Reset_Handler              
                ENDP
                
; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler                [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler          [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler          [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler           [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler         [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler                [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler           [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler             [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler            [WEAK]
                IMPORT	DELAY_NTIME
				PUSH	{R0-R8, LR}
				LDR		R0, =DELAY_NTIME
				LDR		R1, [R0]
				SUB		R1, #1
				STR		R1, [R0]
				POP		{R0-R8, PC}
                ENDP

Default_Handler PROC
                EXPORT  WWDG_IRQHandler            [WEAK]
                EXPORT  PVD_IRQHandler             [WEAK]
                EXPORT  TAMPER_IRQHandler          [WEAK]
                EXPORT  RTC_IRQHandler             [WEAK]
                EXPORT  FLASH_IRQHandler           [WEAK]
                EXPORT  RCC_IRQHandler             [WEAK]
                EXPORT  EXTI0_IRQHandler           [WEAK]
                EXPORT  EXTI1_IRQHandler           [WEAK]
                EXPORT  EXTI2_IRQHandler           [WEAK]
                EXPORT  EXTI3_IRQHandler           [WEAK]
                EXPORT  EXTI4_IRQHandler           [WEAK]
                EXPORT  DMA1_Channel1_IRQHandler   [WEAK]
                EXPORT  DMA1_Channel2_IRQHandler   [WEAK]
                EXPORT  DMA1_Channel3_IRQHandler   [WEAK]
                EXPORT  DMA1_Channel4_IRQHandler   [WEAK]
                EXPORT  DMA1_Channel5_IRQHandler   [WEAK]
                EXPORT  DMA1_Channel6_IRQHandler   [WEAK]
                EXPORT  DMA1_Channel7_IRQHandler   [WEAK]
                EXPORT  ADC1_2_IRQHandler          [WEAK]
                EXPORT  USB_HP_CAN1_TX_IRQHandler  [WEAK]
                EXPORT  USB_LP_CAN1_RX0_IRQHandler [WEAK]
                EXPORT  CAN1_RX1_IRQHandler        [WEAK]
                EXPORT  CAN1_SCE_IRQHandler        [WEAK]
                EXPORT  EXTI9_5_IRQHandler         [WEAK]
                EXPORT  TIM1_BRK_IRQHandler        [WEAK]
                EXPORT  TIM1_UP_IRQHandler         [WEAK]
                EXPORT  TIM1_TRG_COM_IRQHandler    [WEAK]
                EXPORT  TIM1_CC_IRQHandler         [WEAK]
                EXPORT  TIM2_IRQHandler            [WEAK]
                EXPORT  TIM3_IRQHandler            [WEAK]
                EXPORT  TIM4_IRQHandler            [WEAK]
                EXPORT  I2C1_EV_IRQHandler         [WEAK]
                EXPORT  I2C1_ER_IRQHandler         [WEAK]
                EXPORT  I2C2_EV_IRQHandler         [WEAK]
                EXPORT  I2C2_ER_IRQHandler         [WEAK]
                EXPORT  SPI1_IRQHandler            [WEAK]
                EXPORT  SPI2_IRQHandler            [WEAK]
                IMPORT  USART1_IRQHandler          
                EXPORT  USART2_IRQHandler          [WEAK]
                EXPORT  USART3_IRQHandler          [WEAK]
                EXPORT  EXTI15_10_IRQHandler       [WEAK]
                EXPORT  RTCAlarm_IRQHandler        [WEAK]
                EXPORT  USBWakeUp_IRQHandler       [WEAK]
                EXPORT  TIM8_BRK_IRQHandler        [WEAK]
                EXPORT  TIM8_UP_IRQHandler         [WEAK]
                EXPORT  TIM8_TRG_COM_IRQHandler    [WEAK]
                EXPORT  TIM8_CC_IRQHandler         [WEAK]
                EXPORT  ADC3_IRQHandler            [WEAK]
                EXPORT  FSMC_IRQHandler            [WEAK]
                EXPORT  SDIO_IRQHandler            [WEAK]
                EXPORT  TIM5_IRQHandler            [WEAK]
                EXPORT  SPI3_IRQHandler            [WEAK]
                EXPORT  UART4_IRQHandler           [WEAK]
                EXPORT  UART5_IRQHandler           [WEAK]
                EXPORT  TIM6_IRQHandler            [WEAK]
                EXPORT  TIM7_IRQHandler            [WEAK]
                EXPORT  DMA2_Channel1_IRQHandler   [WEAK]
                EXPORT  DMA2_Channel2_IRQHandler   [WEAK]
                EXPORT  DMA2_Channel3_IRQHandler   [WEAK]
                EXPORT  DMA2_Channel4_5_IRQHandler [WEAK]

WWDG_IRQHandler
PVD_IRQHandler
TAMPER_IRQHandler
RTC_IRQHandler
FLASH_IRQHandler
RCC_IRQHandler
EXTI0_IRQHandler
EXTI1_IRQHandler
EXTI2_IRQHandler
EXTI3_IRQHandler
EXTI4_IRQHandler
DMA1_Channel1_IRQHandler
DMA1_Channel2_IRQHandler
DMA1_Channel3_IRQHandler
DMA1_Channel4_IRQHandler
DMA1_Channel5_IRQHandler
DMA1_Channel6_IRQHandler
DMA1_Channel7_IRQHandler
ADC1_2_IRQHandler
USB_HP_CAN1_TX_IRQHandler
USB_LP_CAN1_RX0_IRQHandler
CAN1_RX1_IRQHandler
CAN1_SCE_IRQHandler
EXTI9_5_IRQHandler
TIM1_BRK_IRQHandler
TIM1_UP_IRQHandler
TIM1_TRG_COM_IRQHandler
TIM1_CC_IRQHandler
TIM2_IRQHandler
TIM3_IRQHandler
TIM4_IRQHandler
I2C1_EV_IRQHandler
I2C1_ER_IRQHandler
I2C2_EV_IRQHandler
I2C2_ER_IRQHandler
SPI1_IRQHandler
SPI2_IRQHandler
;USART1_IRQHandler
USART2_IRQHandler
USART3_IRQHandler
EXTI15_10_IRQHandler
RTCAlarm_IRQHandler
USBWakeUp_IRQHandler
TIM8_BRK_IRQHandler
TIM8_UP_IRQHandler
TIM8_TRG_COM_IRQHandler
TIM8_CC_IRQHandler
ADC3_IRQHandler
FSMC_IRQHandler
SDIO_IRQHandler
TIM5_IRQHandler
SPI3_IRQHandler
UART4_IRQHandler
UART5_IRQHandler
TIM6_IRQHandler
TIM7_IRQHandler
DMA2_Channel1_IRQHandler
DMA2_Channel2_IRQHandler
DMA2_Channel3_IRQHandler
DMA2_Channel4_5_IRQHandler				
				B		.
				ENDP
				ALIGN

;系统时钟初始化
RCC_INIT		PROC
				EXPORT	RCC_INIT
				PUSH	{R0-R8, LR}
				;外部高速时钟时能 RCC->CR |= Bit16
				LDR		R0, =RCC_CR
				LDR		R1, [R0]
				ORR		R1, #Bit16
				STR		R1, [R0]
				;检验外部时钟是否就绪
RCC_CLK_NOTOK	LDR		R1, [R0]
				ANDS	R1, #Bit17
				BEQ		RCC_CLK_NOTOK
				LDR		R1, [R0]
				ORR		R1, #Bit17
				STR		R1, [R0]
				;FLASH缓冲区及访问速度配置
				LDR		R0, =FLASH_ACR
				MOV		R1, #0X00000032
				STR		R1, [R0]
				;设置系统时钟倍频
				LDR		R0, =RCC_CFGR
				LDR		R1, [R0]
				;HCLK 2分频
				ORR		R1, #Bit10
				;9倍频[21:18]-->0111
				ORR		R1, #Bit18
				ORR		R1, #Bit19
				ORR		R1, #Bit20
				;设置ADC的预分频为PCLK2的4分频
				ORR		R1, #Bit14
				;设置HSE为PLL输入时钟源
				ORR		R1, #Bit16
				STR		R1, [R0]
				;开启倍频
				LDR		R0, =RCC_CR
				LDR		R1, [R0]
				ORR		R1, #Bit24
				STR		R1, [R0]
				;等待倍频生效
RCC_PLL_NOTOK	LDR		R1, [R0]
				ANDS	R1, #Bit25
				BEQ		RCC_PLL_NOTOK
				;设置PLL为当前系统时钟
				LDR		R0, =RCC_CFGR
				LDR		R1, [R0]
				ORR		R1, #Bit1
				STR		R1, [R0]
				;验证系统时钟状态是否切换为PLL
				MOV		R2, #0X02
RCC_PLL_NOTRDY	LDR		R1, [R0]
				LSR		R1, R1, #2
				AND		R1, #0X03
				CMP		R1, R2
				BNE		RCC_PLL_NOTRDY
				POP		{R0-R8, PC}
				ENDP

				ALIGN			
;--------------------------------------------			
				END






