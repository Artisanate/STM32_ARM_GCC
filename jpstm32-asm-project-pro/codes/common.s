;============================================
;common.s ���ļ��ж���һЩ�����ӳ���
;��Ҫ����NVIC���� �жϷ��� ����SysTickʵ�ֵ�
;���뼶��ʱ
;============================================
				INCLUDE map.s
				AREA	COMMON_DATA, CODE, READWRITE
DELAY_NTIME		DCD		0X00000000
				EXPORT	DELAY_NTIME
				AREA	COMMON_PROC, CODE, READONLY
				
SYSTICK_INIT	PROC
				EXPORT	SYSTICK_INIT
				PUSH	{R0-R8, LR}
				;SYSTICKʹ���ⲿʱ��Դ,�����ж�
				LDR		R0, =SYSTICK_CTRL
				LDR		R1, [R0]
				BIC		R1, R1,	#Bit2
				ORR		R1, R1, #Bit1
				STR		R1, [R0]
				LDR		R0, =SYSTICK_LOAD
				LDR		R1, =9000
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
;����SysTickʵ�ֺ��뼶��ʱ
;R0��Ϊ��������ʾ��ʱʱ��
SYS_DELAY_MS	PROC
				EXPORT	SYS_DELAY_MS
				PUSH	{R0-R8, LR}
				;������ʱʱ��
				LDR		R1, =DELAY_NTIME
				STR		R0, [R1]
				;����������
				LDR		R1, =SYSTICK_VAL
				MOV		R2, #0
				STR		R2, [R1]
				;����systick
				LDR		R1, =SYSTICK_CTRL
				LDR		R2, [R1]
				ORR		R2, #Bit0
				STR		R2, [R1]
				LDR		R1, =DELAY_NTIME
SYS_DLY_NOTOK	LDR		R0, [R1]
				CMP		R0, #0
				BNE		SYS_DLY_NOTOK
				;����������
				LDR		R1, =SYSTICK_VAL
				MOV		R2, #0
				STR		R2, [R1]
				;ֹͣsystick
				LDR		R1, =SYSTICK_CTRL
				LDR		R2, [R1]
				BIC		R2, R2, #Bit0
				STR		R2, [R1]
				POP		{R0-R8, PC}
				ENDP
			
;��ʱһ��ʱ����ͨ��r0������ʱʱ��
USR_DELAY		PROC
				EXPORT	USR_DELAY
				PUSH	{R0-R8, LR}
DELAY_NOTOK		SUBS	R0, R0, #1
				NOP
				BNE		DELAY_NOTOK
				POP		{R0-R8, PC}
				ENDP

;ע�����ȼ����ܳ����趨����ķ�Χ!�������δ����Ĵ���
;�黮��:
;��0:4λ��ռ���ȼ�,0λ�����ȼ�
;���ӳ�����豻ִ��һ��
NVIC_SET_GROUP	PROC
				EXPORT	NVIC_SET_GROUP
				PUSH	{R0-R8, LR}
				LDR		R3, =SCB_AIRCR
				LDR		R1, [R3]
				;���֮ǰ�ķ���
				LDR		R2, =0XFFFFF8FF
				AND		R1, R2
				MOV		R0, #0
				ADD		R0, #3
				LSL		R0, #8
				ORR		R0, R1
				STR		R0, [R3]
				LDR		R0, =SCB_VTOR
				;�����ж��������λ��
				MOV		R1, #0X08000000
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
;R0 ��ʾ�жϺ� 
;R1 ��ʾ��ռ���ȼ���(0~15)
NVIC_SET_PRIO	PROC
				EXPORT	NVIC_SET_PRIO
				PUSH	{R0-R8, LR}
				;��֤���ȼ�����0x00~0x0F
				AND		R1, #0X0F
				LDR		R2, =NVIC_IPR_BASE
				LSL		R1, #4
				STRB	R1, [R2, R0]
				POP		{R0-R8, PC}
				ENDP
;�����жϣ��ж�ʹ��
;R0�б������Ҫ�������жϺ�
NVIC_SET_ENABLE	PROC
				EXPORT	NVIC_SET_ENABLE
				PUSH	{R0-R8, LR}
				;��֤�жϺ��ںϷ���Χ��
				LDR		R1, =0X3F
				AND		R0, R1
				;�жϵ�ǰ�жϺ�����ISER�ĸ�32λ���ǵ�32λ
				CMP		R0, #31
				LDRHI	R1, =NVIC_ISER2
				SUBHI	R0, #32
				LDRLS	R1, =NVIC_ISER1
				MOV		R2, #1
				LDR		R3, [R1]
				LSL		R2, R0
				ORR		R3, R2
				STR		R3, [R1]
				POP		{R0-R8, PC}
				ENDP

				ALIGN
				END




			