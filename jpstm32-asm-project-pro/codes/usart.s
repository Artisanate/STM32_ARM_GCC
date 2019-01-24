;===============================================
;usart.s	usart���ڲ���
;��������
;���ֽڷ���(��ѯ��ʽ)
;���ֽڽ���(�жϷ�ʽ������ѭ��������Ϊ������)
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
;����1��ʼ��				
USART1_INIT		PROC
				EXPORT	USART1_INIT
				IMPORT	NVIC_SET_ENABLE
				IMPORT	NVIC_SET_PRIO
				
				PUSH	{R0-R8, LR}
				;PORTA ʱ��ʱ��, USART1 ʱ��ʱ��
				LDR		R0, =RCC_APB2ENR
				LDR		R1, [R0];
				ORR		R1, #Bit2
				ORR		R1, #Bit14
				STR		R1, [R0]
				;��ʼ��RX��TX I/O����
				LDR		R0, =GPIOA_CRH
				LDR		R1, [R0]
				LDR		R2, =0XFFFFF00F
				AND		R1, R2
				LDR		R2, =0X000008B0
				ORR		R1, R2
				STR		R1, [R0]
				;��λUSART1,����λ ������
				LDR		R0, =RCC_APB2RSTR
				LDR		R1, [R0]
				ORR		R1, #Bit14
				STR		R1, [R0]
				LDR		R1, [R0]
				BIC		R1, #Bit14
				STR		R1, [R0]
				;���ò�����
				LDR		R0, =USART1_BRR
				;72MHz��Ƶ115200������ʱ
				;�������BRR��ֵΪ0x0271
				LDR		R1, =0X0271
				STR		R1, [R0]
				;USART1ʹ�� ����ʹ�� ����ʹ��
				;8λ����λ ��У��
				LDR		R0, =USART1_CR1
				LDR		R1, =0X200C
				STR		R1, [R0]
				; ���ݽ�������,�������ݻ���������
				LDR		R0, =USART1_RX_SIZE
				MOV		R1, #0
				STR		R1, [R0]
				LDR		R0, =USART1_RX_SEEK
				STR		R1, [R0]
				LDR		R0, =USART1_RX_STAT
				MOV		R1, #0
				ORR		R1, #USART1_RX_BUF_EMPTY
				STR		R1, [R0]
				; ���ݽ�����ؼĴ�������
				LDR		R0, =USART1_CR1
				LDR		R1, [R0]
				;���ݽ���ʹ�ܣ���żУ���жϿ���
				ORR		R1, #0X0120
				STR		R1, [R0]
				;����1�ж�����
				LDR		R0, =USART1_IRQChannel
				MOV		R1, #10	;������ռ���ȼ�Ϊ10
				BL		NVIC_SET_PRIO
				;ʹ��USART1����ж�
				LDR		R0, =USART1_IRQChannel
				BL		NVIC_SET_ENABLE
				POP		{R0-R8, PC}
				ENDP
				
				
;����һ���ֽڵ����ݣ� r0Ϊ����
USART1_PUTC		PROC
				EXPORT USART1_PUTC
				PUSH	{R0-R8, LR}
				;�ȴ����ݷ������
USART1_TX_BUSY	LDR		R1, =USART1_SR
				LDR		R2, [R1]
				ANDS	R2, #Bit7
				;�����ݷ������ݷ��ͼĴ���
				BEQ		USART1_TX_BUSY
				LDR		R1, =USART1_DR
				STR		R0, [R1]
				POP		{R0-R8, PC}
				ENDP
				
;�Ӵ��ڶ�ȡһ���ֽڵ�����
;��R0�з���
USART1_GETC		PROC
				EXPORT	USART1_GETC
				PUSH	{R1-R8, LR}
				;�жϻ������Ƿ�Ϊ��
				LDR		R1, =USART1_RX_STAT
				LDR		R2, [R1]
				ANDS	R2, #USART1_RX_BUF_EMPTY
				BNE		USART1_RX_ERR
				;��ȡ��ǰ����
				LDR		R1, =USART1_RX_BUF
				LDR		R2, =USART1_RX_SEEK
				LDR		R3, [R2]
				LDRB	R0, [R1, R3]
				;ƫ��������һ����λ
				ADD		R3, #1
				AND		R3, #USART1_RX_BUF_MASK
				STR		R3, [R2];��ƫ������д
				;�жϻ������Ƿ񱻶���
				LDR		R1, =USART1_RX_SIZE
				LDR		R4, [R1]
				LDR		R1, =USART1_RX_STAT
				LDR		R5, [R1]
				CMP		R3, R4
				;��������������꣬�����û������ձ��
				ORREQ	R5, #USART1_RX_BUF_EMPTY
				;������ζ���������������
				BIC		R5, R5, #USART1_RX_BUF_FULL
				STR		R5, [R1];������״̬��д
				B		USART1_RX_OK
USART1_RX_ERR	MOV		R0, #0
USART1_RX_OK	POP		{R1-R8, PC}
				ENDP
				

USART1_IRQHandler	PROC
					EXPORT	USART1_IRQHandler
					PUSH	{R0-R8, LR}
					;�رյ�ǰ�жϼ��ȵ�ǰ���ȼ��͵��ж�
					LDR		R0, =USART1_IRQChannel
					MSR		BASEPRI, R0
					;�жϵ�ǰ�������Ƿ�Ϊ��
					LDR		R0, =USART1_RX_STAT
					LDR		R1, [R0]
					ANDS	R1, #USART1_RX_BUF_FULL
					;�����ǰ�������������������ǰ����
					BNE		USART1_PUT_BUF_ERR
					;��ȡ���ݼĴ��е�����
					LDR		R0, =USART1_DR
					LDR		R1, [R0]
					;�����ݷ��뻺����
					LDR		R0, =USART1_RX_BUF
					LDR		R2, =USART1_RX_SIZE
					LDR		R3, [R2]
					STRB	R1, [R0, R3]
					;�޸Ļ�����ƫ����������д
					ADD		R3, #1
					AND		R3, #USART1_RX_BUF_MASK
					STR		R3, [R2]
					;�жϻ������Ƿ�д�������ñ��λ
					LDR		R0, =USART1_RX_SEEK
					LDR		R1, [R0]
					LDR		R0, =USART1_RX_STAT
					LDR		R2, [R0]
					CMP		R1, R3
					;��������������������������Ч
					ORREQ	R2, #USART1_RX_BUF_FULL
					;�����������������ձ��
					BIC		R2, #USART1_RX_BUF_EMPTY
					STR		R2, [R0]
					;������ǰ�жϼ��ȵ�ǰ���ȼ��͵��ж�
USART1_PUT_BUF_ERR	MOV		R0, #0
					MSR		BASEPRI, R0
					POP		{R0-R8, PC}
					ENDP



				
				
				ALIGN
				END








