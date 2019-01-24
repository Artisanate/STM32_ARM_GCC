;===============================================
;液晶屏初始化及相关操作
;LCD9486驱动芯片
;480*320分辨率
;实现lcd初始化
;清屏子程序
;打印16*8点阵ASC码子程序
;打印水平方向字符串子程序
;===============================================
				INCLUDE		map.s

;lcd命令地址与数据地址
LCD_ADDR_BASE	EQU			0x6C0007FE
LCD_CMD_ADDR	EQU			(LCD_ADDR_BASE + 0X00)
LCD_DATA_ADDR	EQU			(LCD_ADDR_BASE + 0X02)
LCD_WIDTH		EQU			480
LCD_HEIGHT		EQU			320
LCD_CMD_WR		EQU			0X002C
LCD_CMD_X		EQU			0X002A
LCD_CMD_Y		EQU			0X002B
LCD_PEN_COLOR	EQU			BLACK				
				AREA	TFTLCD_CODE, CODE, READONLY
				IMPORT	SYS_DELAY_MS
				IMPORT	USART1_PUTC
;液晶屏初始化函数
LCD_INIT		PROC
				EXPORT	LCD_INIT
				PUSH	{R0-R8, LR}
				;相关I/O端口初始化
LCD_IO_INIT		LDR		R0, =RCC_AHBENR
				;开启FSMC时钟
				LDR		R1, [R0]
				ORR		R1, #Bit8
				STR		R1, [R0]
				;使能GPIO B D E G端口时钟
				LDR		R0, =RCC_APB2ENR
				LDR		R1, [R0]
				ORR		R1, #0X0168
				STR		R1, [R0]
				;PB0推挽输出，控制lcd背光
				LDR		R0, =GPIOB_CRL
				LDR		R1, [R0]
				BIC		R1, #0X0F
				ORR		R1, #0X03
				STR		R1, [R0]
				;GPIOD 0 1 4 5 8 9 10 14 15 设置为复用功能
				LDR		R0, =GPIOD_CRH
				LDR		R1, [R0]
				LDR		R2, =0X00FFF000
				AND		R1, R2
				LDR		R2, =0XBB000BBB
				ORR		R1, R2
				STR		R1, [R0]
				LDR		R0, =GPIOD_CRL
				LDR		R1, [R0]
				LDR		R2, =0XFF00FF00
				AND		R1, R2
				LDR		R2, =0X00BB00BB
				ORR		R1, R2
				STR		R1, [R0]
				;E口设置,相关引脚设置为复用功能
				LDR		R0, =GPIOE_CRH
				LDR		R1, =0XBBBBBBBB
				STR		R1, [R0]
				LDR		R0, =GPIOE_CRL
				LDR		R1, [R0]
				LDR		R2, =0X0FFFFFFF
				AND		R1, R2
				LDR		R2, =0XB0000000
				ORR		R1, R2
				STR		R1, [R0]
				;G口设置
				LDR		R0, =GPIOG_CRH
				LDR		R1, [R0]
				LDR		R2, =0XFFF0FFFF
				AND		R1, R2
				LDR		R2, =0X000B0000
				ORR		R1, R2
				STR		R1, [R0]
				LDR		R0, =GPIOG_CRL
				LDR		R1, [R0]
				LDR		R2, =0XFFFFFFF0
				AND		R1, R2
				LDR		R2, =0X0000000B
				ORR		R1, R2
				STR		R1, [R0]
				;FSMC功能配置
LCD_FSMC_INIT	LDR		R0, =FSMC_BANK1_BTCR
				MOV		R2, #24
				MOV		R1, #0
				;bcr[4] 的第4、12、14位置1
				LDR		R3, =0X00005011
				ORR		R1, R3
				STR		R1, [R0, R2]
				MOV		R2, #28
				MOV		R1, #0
				LDR		R3, =0X00000F01
				ORR		R1, R3
				STR		R1, [R0, R2]
				LDR		R0, =FSMC_BANK1E_BWTR
				MOV		R2, #24
				MOV		R1, #0
				ORR		R1, #0X00000300
				STR		R1, [R0, R2]
				MOV		R0, #50
				BL		SYS_DELAY_MS
				;启动LCD时钟
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				MOV		R2, #0X0000
				STRH	R2, [R7]
				MOV		R2, #0X0001
				STRH	R2, [R8]
				MOV		R0, #50
				BL		SYS_DELAY_MS
				;如果需要获取芯片ID则不执行此指令
				;B		LCD_CONFIG_PARM
				;获取驱动芯片ID
				MOV		R0, #0
				STRH	R0, [R7]
				NOP
				NOP
				NOP
				LDRH	R0, [R8]
				LDR		R1, =0XFFFF
				CMP		R0, #0XFF
				BLO		LCD_GET_ID
				CMP		R0, R1
				BEQ		LCD_GET_ID
				B		LCD_INIT_OVER
LCD_GET_ID		MOV		R0, #0X00D3
				STRH	R0, [R7]
				LDRH	R0, [R8]
				LDRH	R0, [R8]
				LDRH	R0, [R8]
				LSL		R0, #8
				LDRH	R1, [R8]
				ORR		R0, R1
				BL		USART1_PUTC
				LSR		R0, #8
LCD_GET_ID_OVER	BL		USART1_PUTC

LCD_CONFIG_PARM MOV		R0, #0X0013
				STRH	R0, [R7]
				MOV		R0, #0X00B1
				STRH	R0, [R7]
				MOV		R0, #0X00A0
				STRH	R0, [R8]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				MOV		R0, #0X00B4
				STRH	R0, [R7]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				;设置水平方向显示边界 480
				MOV		R0, #0X002A
				STRH	R0, [R7]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				STRH	R0, [R8]
				MOV		R0, #0X0001
				STRH	R0, [R8]
				MOV		R0, #0X00DF
				STRH	R0, [R8]
				;设置垂直方向显示边界 320
				MOV		R0, #0X002B
				STRH	R0, [R7]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				STRH	R0, [R8]
				MOV		R0, #0X0001
				STRH	R0, [R8]
				MOV		R0, #0X003F
				STRH	R0, [R8]
				MOV		R0, #0X0035
				STRH	R0, [R7]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				MOV		R0, #0X0036
				STRH	R0, [R7]
				MOV		R0, #0X0030
				STRH	R0, [R8]
				;设置灰度正向电压调整伽马值
				MOV		R0, #0X00E0
				STRH	R0, [R7]
				MOV		R0, #0X0009
				STRH	R0, [R8]
				MOV		R0, #0X000A
				STRH	R0, [R8]
				MOV		R0, #0X000E
				STRH	R0, [R8]
				MOV		R0, #0X000D
				STRH	R0, [R8]
				MOV		R0, #0X0007
				STRH	R0, [R8]
				MOV		R0, #0X0018
				STRH	R0, [R8]
				MOV		R0, #0X000D
				STRH	R0, [R8]
				STRH	R0, [R8]
				MOV		R0, #0X000E
				STRH	R0, [R8]
				MOV		R0, #0X0004
				STRH	R0, [R8]
				MOV		R0, #0X0005
				STRH	R0, [R8]
				MOV		R0, #0X0006
				STRH	R0, [R8]
				MOV		R0, #0X000E
				STRH	R0, [R8]
				MOV		R0, #0X0025
				STRH	R0, [R8]
				MOV		R0, #0X0022
				STRH	R0, [R8]
				;设置灰度负向电压调整伽马值
				MOV		R0, #0X00E1
				STRH	R0, [R7]
				MOV		R0, #0X001F
				STRH	R0, [R8]
				MOV		R0, #0X003F
				STRH	R0, [R8]
				STRH	R0, [R8]
				MOV		R0, #0X000F
				STRH	R0, [R8]
				MOV		R0, #0X001F
				STRH	R0, [R8]
				MOV		R0, #0X000F
				STRH	R0, [R8]
				MOV		R0, #0X0046
				STRH	R0, [R8]
				MOV		R0, #0X0049
				STRH	R0, [R8]
				MOV		R0, #0X0031
				STRH	R0, [R8]
				MOV		R0, #0X0005
				STRH	R0, [R8]
				MOV		R0, #0X0009
				STRH	R0, [R8]
				MOV		R0, #0X0003
				STRH	R0, [R8]
				MOV		R0, #0X001C
				STRH	R0, [R8]
				MOV		R0, #0X001A
				STRH	R0, [R8]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				;设置像素格式 16位色
				MOV		R0, #0X003A
				STRH	R0, [R7]
				MOV		R0, #0X0055
				STRH	R0, [R8]
				;Write Tear Scan Line
				MOV		R0, #0X0044
				STRH	R0, [R7]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				MOV		R0, #0X0001
				STRH	R0, [R8]
				;TURN OFF SLEEP MODE
				MOV		R0, #0X0011
				STRH	R0, [R7]
				MOV		R0, #150
				BL		SYS_DELAY_MS
				;NV memory write
				MOV		R0, #0X00D0
				STRH	R0, [R7]
				MOV		R0, #0X0007
				STRH	R0, [R8]
				STRH	R0, [R8]
				;NV memory protection key
				MOV		R0, #0X00D1
				STRH	R0, [R7]
				MOV		R0, #0X0003
				STRH	R0, [R8]
				MOV		R0, #0X0052
				STRH	R0, [R8]
				MOV		R0, #0X0010
				STRH	R0, [R8]
				;NV memory status read
				MOV		R0, #0X00D2
				STRH	R0, [R7]
				MOV		R0, #0X0003
				STRH	R0, [R8]
				MOV		R0, #0X0024
				STRH	R0, [R8]
				MOV		R0, #0X0020
				STRH	R0, [R7]
				;Interface mode control
				MOV		R0, #0X00B0
				STRH	R0, [R7]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				;Display on
				MOV		R0, #0X0029
				STRH	R0, [R7]
				MOV		R0, #10
				BL		SYS_DELAY_MS
				;点亮lcd背光 PB0 
				LDR		R0, =GPIOB_ODR
				LDR		R1, [R0]
				ORR		R1, #0X00000001
				STR		R1, [R0]
				
				;利用白色填充整个屏幕
				LDR		R0, =RED
				BL		LCD_CLEAR
LCD_INIT_OVER	POP		{R0-R8, PC}
				;定义文字池，相当于常量区
				ALIGN
				LTORG
				ENDP
				
;设定一个矩形的显示区域
;R0  水平方向 左边界
;R1  垂直方向 上边界
;R2  水平方向 右边界
;R3  垂直方向 下边界
LCD_SET_WINDOW	PROC
				EXPORT	LCD_SET_WINDOW
				PUSH	{R0-R8, LR}
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				MOV		R4, #LCD_CMD_X
				STRH	R4, [R7]
				LSR		R5, R0, #8
				STRH	R5, [R8];左边界高8位
				STRH	R0, [R8];左边界低8位
				LSR		R5, R2, #8
				STRH	R5, [R8];右边界高8位
				STRH	R2, [R8];右边界低8位
				MOV		R4, #LCD_CMD_Y
				STRH	R4, [R7]
				LSR		R5, R1, #8
				STRH	R5, [R8];上边界高8位
				STRH	R1, [R8];上边界低8位
				LSR		R5, R3, #8
				STRH	R5, [R8];下边界高8位
				STRH	R3, [R8];下边界低8位
				;启用写寄存器
				MOV		R4, #LCD_CMD_WR
				STRH	R4, [R7]
				POP		{R0-R8, PC}
				;定义文字池，相当于常量区
				ALIGN
				LTORG
				ENDP
;用单一颜色填充整个屏幕
;R0 颜色值
LCD_CLEAR		PROC
				EXPORT	LCD_CLEAR
				PUSH	{R0-R8, LR}
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				PUSH	{R0}
				;选定整个屏幕区域
				MOV		R0, #0
				MOV		R1, #0
				MOV		R2, #480
				MOV		R3, #320
				BL		LCD_SET_WINDOW
				MOV		R0, #480
				MOV		R1, #320
				MUL		R1, R0
				;将像素数据写入屏幕
				POP		{R0}
LCD_WRITE_DATA	SUBS	R1, #1
				STRH	R0, [R8]
				BNE		LCD_WRITE_DATA
				POP			{R0-R8, PC}
				ENDP


;在屏幕上画点
;r0	水平坐标
;r1	垂直坐标
;r2	颜色
LCD_DRAW_POINT	PROC
				EXPORT	LCD_DRAW_POINT
				PUSH	{R0-R8, LR}
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				;设定水平方向坐标
				MOV		R3, #LCD_CMD_X
				STRH	R3, [R7]
				LSR		R4, R0, #8
				STRH	R4, [R8]
				STRH	R0, [R8]
				STRH	R4, [R8]
				STRH	R0, [R8]				
				;设定垂直方向的坐标
				MOV		R3, #LCD_CMD_Y
				STRH	R3, [R7]
				LSR		R4, R1, #8
				STRH	R4, [R8]
				STRH	R1, [R8]
				STRH	R4, [R8]
				STRH	R1, [R8]
				MOV		R3, #LCD_CMD_WR
				STRH	R3, [R7]
				STRH	R2, [R8]
				POP			{R0-R8, PC}
				ENDP

;在指定坐标位置绘制一个英文字符
;r0	水平坐标
;r1 垂直坐标
;r2 要打印的字符
LCD_DRAW_CHAR	PROC
				IMPORT	F_ASCII_16
				EXPORT	LCD_DRAW_CHAR
				PUSH	{R0-R8, LR}
				;获取当前字符在字库中的偏移位置
				MOV		R3, #' '
				SUB		R2, R3
				LSL		R2, #4
				LDR		R3, =F_ASCII_16
				ADD		R2, R3
				;保存垂直坐标初始值
				MOV		R9, R1
				;开始绘制
				MOV		R3, #0
DRAW_NEXT_BYTE	LDRB	R4, [R2, R3]
				MOV		R8, #0
				MOV		R7, #0X80
				PUSH	{R2}
				MOV		R2, #LCD_PEN_COLOR
DRAW_NEXT_BIT	ANDS	R6, R4, R7
				BLNE	LCD_DRAW_POINT
				;绘制完当前坐标，垂直坐标下移
				ADD		R1, #1
				;bit标记量自加
				ADD		R8, #1
				LSL		R4, #1
				CMP		R8, #8
				BNE		DRAW_NEXT_BIT
				SUB		R10, R1, R9
				CMP		R10, #16
				;扫描完一列，开启新的一列
				MOVEQ	R1, R9
				ADDEQ	R0, #1
				POP		{R2}
				ADD		R3, #1
				CMP		R3, #16
				BNE		DRAW_NEXT_BYTE
				POP		{R0-R8, PC}
				ENDP
;在屏幕上沿水平方向打印一个以'\0'结尾的字符串
;r0	x坐标
;r1 y坐标
;r2 字符串首地址
LCD_DRAW_STR	PROC
				EXPORT	LCD_DRAW_STR
				PUSH	{R0-R8, LR}
DRAW_NEXT_CHR	LDRB	R3, [R2]
				CMP		R3, #0
				BEQ		DRAW_STR_OVER
				;后面子程序需要r2传递参数，固在此入栈保存
				PUSH	{R2}
				MOV		R2, R3
				BL		LCD_DRAW_CHAR
				POP		{R2}
				;字符串指针向后移动一个字节
				ADD		R2, #1
				;水平向右移动8个像素
				ADD		R0, #8
				B		DRAW_NEXT_CHR
DRAW_STR_OVER	POP		{R0-R8, PC}
				ENDP					
				
				ALIGN
				END






