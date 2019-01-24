;==============================================
;led.s led��ز���
;PC0~PC2�ֱ�����RGBLED�� ��ɫ ��ɫ ��ɫ����
;==============================================
				INCLUDE map.s
				AREA	LED_PROC, CODE, READONLY
;led��ʼ��		
LED_INIT		PROC
				EXPORT	LED_INIT
				PUSH	{R0-R8, LR}
				;����PC��ʱ��
				LDR		R0, =RCC_APB2ENR
				LDR		R1, [R0]
				ORR		R1, #Bit4
				STR		R1, [R0]
				;����PC�ڹ���,PC0~PC2����Ϊͨ���������
				LDR		R0, =GPIOC_CRL
				LDR		R1, [R0]
				LDR		R2, =0XFFFFF000
				AND		R1, R2
				MOV		R2, #0X03
				ORR		R1, R2
				ORR		R1, R1, R2, LSL #4
				ORR		R1, R1, R2, LSL #8
				STR		R1, [R0]
				;��ʼ��led�Ƶ�״̬��Ĭ�Ϲر�			
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				ORR		R1, #0X07
				STR		R1, [R0];
				POP		{R0-R8, PC}
				ENDP
;������, �޲���
LEDB_ON			PROC
				EXPORT	LEDB_ON
				PUSH	{R0-R8, LR}
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				BIC		R1, R1, #0X01
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
;������, �޲���
LEDB_OFF		PROC
				EXPORT	LEDB_OFF
				PUSH	{R0-R8, LR}
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				ORR		R1, R1, #0X01
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
;�����				
LEDR_ON			PROC
				EXPORT	LEDR_ON
				PUSH	{R0-R8, LR}
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				BIC		R1, R1, #0X04
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
LEDR_OFF		PROC
				EXPORT	LEDR_OFF
				PUSH	{R0-R8, LR}
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				ORR		R1, R1, #0X04
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
;�̵���				
LEDG_ON			PROC
				EXPORT	LEDG_ON
				PUSH	{R0-R8, LR}
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				BIC		R1, R1, #0X02
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
LEDG_OFF		PROC
				EXPORT	LEDG_OFF
				PUSH	{R0-R8, LR}
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				ORR		R1, R1, #0X02
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP

				END
			
			
			