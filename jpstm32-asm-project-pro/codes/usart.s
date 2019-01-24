;===============================================
;usart.s	usart串口操作
;串口配置
;单字节发送(轮询方式)
;单字节接收(中断方式，带有循环队列作为缓冲区)
;===============================================
				INCLUDE map.s
USART1_RX_BUF_LEN	EQU		0X000000FF	
USART1_RX_BUF_MASK	EQU		0X000000FF
USART1_RX_BUF_EMPTY	EQU		0X00000001
USART1_RX_BUF_FULL	EQU		0X00000002
				AREA	USART_DATA, DATA, READWRITE
USART1_RX_SEEK	DCD		0
USART1_RX_SIZE	DCD		0
USART1_RX_STAT	DCD		0
USART1_RX_BUF	SPACE	USART1_RX_BUF_LEN				

				AREA	USART_PROC, CODE, READONLY
;串口1初始化				
USART1_INIT		PROC
				EXPORT	USART1_INIT
				IMPORT	NVIC_SET_ENABLE
				IMPORT	NVIC_SET_PRIO
				
				PUSH	{R0-R8, LR}
				;PORTA 时钟时能, USART1 时钟时能
				LDR		R0, =RCC_APB2ENR
				LDR		R1, [R0];
				ORR		R1, #Bit2
				ORR		R1, #Bit14
				STR		R1, [R0]
				;初始化RX、TX I/O功能
				LDR		R0, =GPIOA_CRH
				LDR		R1, [R0]
				LDR		R2, =0XFFFFF00F
				AND		R1, R2
				LDR		R2, =0X000008B0
				ORR		R1, R2
				STR		R1, [R0]
				;复位USART1,先置位 再清零
				LDR		R0, =RCC_APB2RSTR
				LDR		R1, [R0]
				ORR		R1, #Bit14
				STR		R1, [R0]
				LDR		R1, [R0]
				BIC		R1, #Bit14
				STR		R1, [R0]
				;设置波特率
				LDR		R0, =USART1_BRR
				;72MHz主频115200波特率时
				;计算出的BRR的值为0x0271
				LDR		R1, =0X0271
				STR		R1, [R0]
				;USART1使能 发送使能 接收使能
				;8位数据位 无校验
				LDR		R0, =USART1_CR1
				LDR		R1, =0X200C
				STR		R1, [R0]
				; 数据接收配置,接收数据缓冲区配置
				LDR		R0, =USART1_RX_SIZE
				MOV		R1, #0
				STR		R1, [R0]
				LDR		R0, =USART1_RX_SEEK
				STR		R1, [R0]
				LDR		R0, =USART1_RX_STAT
				MOV		R1, #0
				ORR		R1, #USART1_RX_BUF_EMPTY
				STR		R1, [R0]
				; 数据接收相关寄存器配置
				LDR		R0, =USART1_CR1
				LDR		R1, [R0]
				;数据接收使能，奇偶校验中断开启
				ORR		R1, #0X0120
				STR		R1, [R0]
				;串口1中断配置
				LDR		R0, =USART1_IRQChannel
				MOV		R1, #10	;设置抢占优先级为10
				BL		NVIC_SET_PRIO
				;使能USART1相关中断
				LDR		R0, =USART1_IRQChannel
				BL		NVIC_SET_ENABLE
				POP		{R0-R8, PC}
				ENDP
				
				
;发送一个字节的数据， r0为参数
USART1_PUTC		PROC
				EXPORT USART1_PUTC
				PUSH	{R0-R8, LR}
				;等待数据发送完毕
USART1_TX_BUSY	LDR		R1, =USART1_SR
				LDR		R2, [R1]
				ANDS	R2, #Bit7
				;将数据放入数据发送寄存器
				BEQ		USART1_TX_BUSY
				LDR		R1, =USART1_DR
				STR		R0, [R1]
				POP		{R0-R8, PC}
				ENDP
				
;从串口读取一个字节的数据
;由R0中返回
USART1_GETC		PROC
				EXPORT	USART1_GETC
				PUSH	{R1-R8, LR}
				;判断缓冲区是否为空
				LDR		R1, =USART1_RX_STAT
				LDR		R2, [R1]
				ANDS	R2, #USART1_RX_BUF_EMPTY
				BNE		USART1_RX_ERR
				;读取当前数据
				LDR		R1, =USART1_RX_BUF
				LDR		R2, =USART1_RX_SEEK
				LDR		R3, [R2]
				LDRB	R0, [R1, R3]
				;偏移量右移一个单位
				ADD		R3, #1
				AND		R3, #USART1_RX_BUF_MASK
				STR		R3, [R2];读偏移量回写
				;判断缓冲区是否被读完
				LDR		R1, =USART1_RX_SIZE
				LDR		R4, [R1]
				LDR		R1, =USART1_RX_STAT
				LDR		R5, [R1]
				CMP		R3, R4
				;如果缓冲区被读完，则设置缓冲区空标记
				ORREQ	R5, #USART1_RX_BUF_EMPTY
				;无论如何都清楚缓冲区满标记
				BIC		R5, R5, #USART1_RX_BUF_FULL
				STR		R5, [R1];缓冲区状态回写
				B		USART1_RX_OK
USART1_RX_ERR	MOV		R0, #0
USART1_RX_OK	POP		{R1-R8, PC}
				ENDP
				

USART1_IRQHandler	PROC
					EXPORT	USART1_IRQHandler
					PUSH	{R0-R8, LR}
					;关闭当前中断及比当前优先级低的中断
					LDR		R0, =USART1_IRQChannel
					MSR		BASEPRI, R0
					;判断当前缓冲区是否为满
					LDR		R0, =USART1_RX_STAT
					LDR		R1, [R0]
					ANDS	R1, #USART1_RX_BUF_FULL
					;如果当前缓冲区已满，则放弃当前操作
					BNE		USART1_PUT_BUF_ERR
					;读取数据寄存中的数据
					LDR		R0, =USART1_DR
					LDR		R1, [R0]
					;将数据放入缓冲区
					LDR		R0, =USART1_RX_BUF
					LDR		R2, =USART1_RX_SIZE
					LDR		R3, [R2]
					STRB	R1, [R0, R3]
					;修改缓冲区偏移量，并回写
					ADD		R3, #1
					AND		R3, #USART1_RX_BUF_MASK
					STR		R3, [R2]
					;判断缓冲区是否被写满并设置标记位
					LDR		R0, =USART1_RX_SEEK
					LDR		R1, [R0]
					LDR		R0, =USART1_RX_STAT
					LDR		R2, [R0]
					CMP		R1, R3
					;如果缓冲区满，则设置满标记有效
					ORREQ	R2, #USART1_RX_BUF_FULL
					;无论如何清除缓冲区空标记
					BIC		R2, #USART1_RX_BUF_EMPTY
					STR		R2, [R0]
					;开启当前中断及比当前优先级低的中断
USART1_PUT_BUF_ERR	MOV		R0, #0
					MSR		BASEPRI, R0
					POP		{R0-R8, PC}
					ENDP



				
				
				ALIGN
				END








