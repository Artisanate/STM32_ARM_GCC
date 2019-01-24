;===============================================
;Һ������ʼ������ز���
;LCD9486����оƬ
;480*320�ֱ���
;ʵ��lcd��ʼ��
;�����ӳ���
;��ӡ16*8����ASC���ӳ���
;��ӡˮƽ�����ַ����ӳ���
;===============================================
				INCLUDE		map.s

;lcd�����ַ�����ݵ�ַ
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
;Һ������ʼ������
LCD_INIT		PROC
				EXPORT	LCD_INIT
				PUSH	{R0-R8, LR}
				;���I/O�˿ڳ�ʼ��
LCD_IO_INIT		LDR		R0, =RCC_AHBENR
				;����FSMCʱ��
				LDR		R1, [R0]
				ORR		R1, #Bit8
				STR		R1, [R0]
				;ʹ��GPIO B D E G�˿�ʱ��
				LDR		R0, =RCC_APB2ENR
				LDR		R1, [R0]
				ORR		R1, #0X0168
				STR		R1, [R0]
				;PB0�������������lcd����
				LDR		R0, =GPIOB_CRL
				LDR		R1, [R0]
				BIC		R1, #0X0F
				ORR		R1, #0X03
				STR		R1, [R0]
				;GPIOD 0 1 4 5 8 9 10 14 15 ����Ϊ���ù���
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
				;E������,�����������Ϊ���ù���
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
				;G������
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
				;FSMC��������
LCD_FSMC_INIT	LDR		R0, =FSMC_BANK1_BTCR
				MOV		R2, #24
				MOV		R1, #0
				;bcr[4] �ĵ�4��12��14λ��1
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
				;����LCDʱ��
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				MOV		R2, #0X0000
				STRH	R2, [R7]
				MOV		R2, #0X0001
				STRH	R2, [R8]
				MOV		R0, #50
				BL		SYS_DELAY_MS
				;�����Ҫ��ȡоƬID��ִ�д�ָ��
				;B		LCD_CONFIG_PARM
				;��ȡ����оƬID
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
				;����ˮƽ������ʾ�߽� 480
				MOV		R0, #0X002A
				STRH	R0, [R7]
				MOV		R0, #0X0000
				STRH	R0, [R8]
				STRH	R0, [R8]
				MOV		R0, #0X0001
				STRH	R0, [R8]
				MOV		R0, #0X00DF
				STRH	R0, [R8]
				;���ô�ֱ������ʾ�߽� 320
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
				;���ûҶ������ѹ����٤��ֵ
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
				;���ûҶȸ����ѹ����٤��ֵ
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
				;�������ظ�ʽ 16λɫ
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
				;����lcd���� PB0 
				LDR		R0, =GPIOB_ODR
				LDR		R1, [R0]
				ORR		R1, #0X00000001
				STR		R1, [R0]
				
				;���ð�ɫ���������Ļ
				LDR		R0, =RED
				BL		LCD_CLEAR
LCD_INIT_OVER	POP		{R0-R8, PC}
				;�������ֳأ��൱�ڳ�����
				ALIGN
				LTORG
				ENDP
				
;�趨һ�����ε���ʾ����
;R0  ˮƽ���� ��߽�
;R1  ��ֱ���� �ϱ߽�
;R2  ˮƽ���� �ұ߽�
;R3  ��ֱ���� �±߽�
LCD_SET_WINDOW	PROC
				EXPORT	LCD_SET_WINDOW
				PUSH	{R0-R8, LR}
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				MOV		R4, #LCD_CMD_X
				STRH	R4, [R7]
				LSR		R5, R0, #8
				STRH	R5, [R8];��߽��8λ
				STRH	R0, [R8];��߽��8λ
				LSR		R5, R2, #8
				STRH	R5, [R8];�ұ߽��8λ
				STRH	R2, [R8];�ұ߽��8λ
				MOV		R4, #LCD_CMD_Y
				STRH	R4, [R7]
				LSR		R5, R1, #8
				STRH	R5, [R8];�ϱ߽��8λ
				STRH	R1, [R8];�ϱ߽��8λ
				LSR		R5, R3, #8
				STRH	R5, [R8];�±߽��8λ
				STRH	R3, [R8];�±߽��8λ
				;����д�Ĵ���
				MOV		R4, #LCD_CMD_WR
				STRH	R4, [R7]
				POP		{R0-R8, PC}
				;�������ֳأ��൱�ڳ�����
				ALIGN
				LTORG
				ENDP
;�õ�һ��ɫ���������Ļ
;R0 ��ɫֵ
LCD_CLEAR		PROC
				EXPORT	LCD_CLEAR
				PUSH	{R0-R8, LR}
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				PUSH	{R0}
				;ѡ��������Ļ����
				MOV		R0, #0
				MOV		R1, #0
				MOV		R2, #480
				MOV		R3, #320
				BL		LCD_SET_WINDOW
				MOV		R0, #480
				MOV		R1, #320
				MUL		R1, R0
				;����������д����Ļ
				POP		{R0}
LCD_WRITE_DATA	SUBS	R1, #1
				STRH	R0, [R8]
				BNE		LCD_WRITE_DATA
				POP			{R0-R8, PC}
				ENDP


;����Ļ�ϻ���
;r0	ˮƽ����
;r1	��ֱ����
;r2	��ɫ
LCD_DRAW_POINT	PROC
				EXPORT	LCD_DRAW_POINT
				PUSH	{R0-R8, LR}
				LDR		R7, =LCD_CMD_ADDR
				LDR		R8, =LCD_DATA_ADDR
				;�趨ˮƽ��������
				MOV		R3, #LCD_CMD_X
				STRH	R3, [R7]
				LSR		R4, R0, #8
				STRH	R4, [R8]
				STRH	R0, [R8]
				STRH	R4, [R8]
				STRH	R0, [R8]				
				;�趨��ֱ���������
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

;��ָ������λ�û���һ��Ӣ���ַ�
;r0	ˮƽ����
;r1 ��ֱ����
;r2 Ҫ��ӡ���ַ�
LCD_DRAW_CHAR	PROC
				IMPORT	F_ASCII_16
				EXPORT	LCD_DRAW_CHAR
				PUSH	{R0-R8, LR}
				;��ȡ��ǰ�ַ����ֿ��е�ƫ��λ��
				MOV		R3, #' '
				SUB		R2, R3
				LSL		R2, #4
				LDR		R3, =F_ASCII_16
				ADD		R2, R3
				;���洹ֱ�����ʼֵ
				MOV		R9, R1
				;��ʼ����
				MOV		R3, #0
DRAW_NEXT_BYTE	LDRB	R4, [R2, R3]
				MOV		R8, #0
				MOV		R7, #0X80
				PUSH	{R2}
				MOV		R2, #LCD_PEN_COLOR
DRAW_NEXT_BIT	ANDS	R6, R4, R7
				BLNE	LCD_DRAW_POINT
				;�����굱ǰ���꣬��ֱ��������
				ADD		R1, #1
				;bit������Լ�
				ADD		R8, #1
				LSL		R4, #1
				CMP		R8, #8
				BNE		DRAW_NEXT_BIT
				SUB		R10, R1, R9
				CMP		R10, #16
				;ɨ����һ�У������µ�һ��
				MOVEQ	R1, R9
				ADDEQ	R0, #1
				POP		{R2}
				ADD		R3, #1
				CMP		R3, #16
				BNE		DRAW_NEXT_BYTE
				POP		{R0-R8, PC}
				ENDP
;����Ļ����ˮƽ�����ӡһ����'\0'��β���ַ���
;r0	x����
;r1 y����
;r2 �ַ����׵�ַ
LCD_DRAW_STR	PROC
				EXPORT	LCD_DRAW_STR
				PUSH	{R0-R8, LR}
DRAW_NEXT_CHR	LDRB	R3, [R2]
				CMP		R3, #0
				BEQ		DRAW_STR_OVER
				;�����ӳ�����Ҫr2���ݲ��������ڴ���ջ����
				PUSH	{R2}
				MOV		R2, R3
				BL		LCD_DRAW_CHAR
				POP		{R2}
				;�ַ���ָ������ƶ�һ���ֽ�
				ADD		R2, #1
				;ˮƽ�����ƶ�8������
				ADD		R0, #8
				B		DRAW_NEXT_CHR
DRAW_STR_OVER	POP		{R0-R8, PC}
				ENDP					
				
				ALIGN
				END






