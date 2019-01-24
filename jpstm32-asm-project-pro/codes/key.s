;===============================================
;key.s  按键处理
;开发板上的五向按键（摇杆）
;===============================================
				INCLUDE map.s
				IMPORT	USR_DELAY
				AREA	KEY_PROC, CODE, READONLY
;按键初始化 PC4 PG6 PG7 PG9 上拉输入
KEY_INIT		PROC
				EXPORT 	KEY_INIT
				PUSH	{R0-R8, LR}
				;开启GPIOC、GPIOG时钟
				LDR		R0, =RCC_APB2ENR
				LDR		R1, [R0]
				ORR		R1, #Bit4
				ORR		R1, #Bit8
				STR		R1, [R0]
				;配置 PC4 PG6 PG7 PG9 PG11为上拉输入
				LDR		R0, =GPIOC_CRL
				LDR		R1, [R0]
				MOV		R2, #0X0F
				BIC		R1, R1, R2, LSL #16
				MOV		R2, #0X08
				ORR		R1, R1, R2, LSL #16
				STR		R1, [R0]
				;设置PG6 PG7
				LDR		R0, =GPIOG_CRL
				LDR		R1, [R0]
				MOV		R2, #0X0F
				BIC		R1, R1, R2, LSL #24
				BIC		R1, R1, R2, LSL #28
				MOV		R2, #0X08
				ORR		R1, R1, R2, LSL #24
				ORR		R1, R1, R2, LSL #28
				STR		R1, [R0]
				;设置 PG9 PG11为上拉输入
				LDR		R0, =GPIOG_CRH
				LDR		R1, [R0]
				MOV		R2, #0X0F
				BIC		R1, R1, R2, LSL #4
				MOV		R2, #0X08
				ORR		R1, R1, R2, LSL #4
				MOV		R2, #0X0F
				BIC		R1, R1, R2, LSL #12
				MOV		R2, #0X08
				ORR		R1, R1, R2, LSL #12
				STR		R1, [R0]
				;设置内部上拉使能
				LDR		R0, =GPIOC_ODR
				LDR		R1, [R0]
				MOV		R2, #0X01
				ORR		R1, R1, R2, LSL #4
				STR		R1, [R0]
				LDR		R0, =GPIOG_ODR
				LDR		R1, [R0]
				LDR		R2, =0X0AC0
				ORR		R1, R1, R2
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
;按键扫描,通过r0返回键值
KEY_SCAN		PROC
				EXPORT	KEY_SCAN
				PUSH	{R1-R8, LR}
				MOV		R2, #0X01
				;验证pc4是否有按键按下
				LDR		R0,	=GPIOC_IDR
				LDR		R1, [R0]
				ANDS	R3, R1, R2, LSL #4
				BEQ		KEY_WAIT
				;判断pg6、7、9是否有按键按下
				LDR		R0, =GPIOG_IDR
				LDR		R1, [R0]
				ANDS	R3, R1, R2, LSL #6
				BEQ		KEY_WAIT
				ANDS	R3, R1, R2, LSL #7
				BEQ		KEY_WAIT
				ANDS	R3, R1, R2, LSL #9
				BEQ		KEY_WAIT
				ANDS	R3, R1, R2, LSL #11
				BEQ		KEY_WAIT
				;没有按键按下时直接退出
				BNE		KEY_EXIT
				;软件消抖				
KEY_WAIT		LDR		R0, =0XFFFF
				BL		USR_DELAY
				LDR		R0, =GPIOC_IDR
				LDR		R1, [R0]
				ANDS	R3, R1, R2, LSL #4
				MOVEQ	R0, #KEY_RIGHT
				BEQ		KEY_READY
				LDR		R0, =GPIOG_IDR
				LDR		R1, [R0]
				ANDS	R3, R1, R2, LSL #6
				MOVEQ	R0, #KEY_CENTER
				BEQ		KEY_READY
				ANDS	R3, R1, R2, LSL #7
				MOVEQ	R0, #KEY_DOWN
				BEQ		KEY_READY
				ANDS	R3, R1, R2, LSL #9
				MOVEQ	R0, #KEY_LEFT
				BEQ		KEY_READY
				ANDS	R3, R1, R2, LSL #11
				MOVEQ	R0, #KEY_UP
				BEQ		KEY_READY
KEY_EXIT
KEY_READY		POP		{R1-R8, PC}
				ENDP
				ALIGN
			
				
				END
	
	
	
	
	