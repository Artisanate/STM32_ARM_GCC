;============================================
;common.s 本文件中定义一些常用子程序
;主要包括NVIC配置 中断分组 利用SysTick实现的
;毫秒级延时
;============================================
				INCLUDE map.s
				AREA	COMMON_DATA, CODE, READWRITE
DELAY_NTIME		DCD		0X00000000
				EXPORT	DELAY_NTIME
				AREA	COMMON_PROC, CODE, READONLY
				
SYSTICK_INIT	PROC
				EXPORT	SYSTICK_INIT
				PUSH	{R0-R8, LR}
				;SYSTICK使用外部时钟源,开启中断
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
;利用SysTick实现毫秒级延时
;R0作为参数，表示延时时长
SYS_DELAY_MS	PROC
				EXPORT	SYS_DELAY_MS
				PUSH	{R0-R8, LR}
				;设置延时时长
				LDR		R1, =DELAY_NTIME
				STR		R0, [R1]
				;计数器清零
				LDR		R1, =SYSTICK_VAL
				MOV		R2, #0
				STR		R2, [R1]
				;启动systick
				LDR		R1, =SYSTICK_CTRL
				LDR		R2, [R1]
				ORR		R2, #Bit0
				STR		R2, [R1]
				LDR		R1, =DELAY_NTIME
SYS_DLY_NOTOK	LDR		R0, [R1]
				CMP		R0, #0
				BNE		SYS_DLY_NOTOK
				;计数器清零
				LDR		R1, =SYSTICK_VAL
				MOV		R2, #0
				STR		R2, [R1]
				;停止systick
				LDR		R1, =SYSTICK_CTRL
				LDR		R2, [R1]
				BIC		R2, R2, #Bit0
				STR		R2, [R1]
				POP		{R0-R8, PC}
				ENDP
			
;延时一定时长，通过r0传递延时时间
USR_DELAY		PROC
				EXPORT	USR_DELAY
				PUSH	{R0-R8, LR}
DELAY_NOTOK		SUBS	R0, R0, #1
				NOP
				BNE		DELAY_NOTOK
				POP		{R0-R8, PC}
				ENDP

;注意优先级不能超过设定的组的范围!否则会有未定义的错误
;组划分:
;组0:4位抢占优先级,0位子优先级
;该子程序仅需被执行一次
NVIC_SET_GROUP	PROC
				EXPORT	NVIC_SET_GROUP
				PUSH	{R0-R8, LR}
				LDR		R3, =SCB_AIRCR
				LDR		R1, [R3]
				;清空之前的分组
				LDR		R2, =0XFFFFF8FF
				AND		R1, R2
				MOV		R0, #0
				ADD		R0, #3
				LSL		R0, #8
				ORR		R0, R1
				STR		R0, [R3]
				LDR		R0, =SCB_VTOR
				;设置中断向量表的位置
				MOV		R1, #0X08000000
				STR		R1, [R0]
				POP		{R0-R8, PC}
				ENDP
;R0 表示中断号 
;R1 表示抢占优先级别(0~15)
NVIC_SET_PRIO	PROC
				EXPORT	NVIC_SET_PRIO
				PUSH	{R0-R8, LR}
				;保证优先级属于0x00~0x0F
				AND		R1, #0X0F
				LDR		R2, =NVIC_IPR_BASE
				LSL		R1, #4
				STRB	R1, [R2, R0]
				POP		{R0-R8, PC}
				ENDP
;开启中断，中断使能
;R0中保存的是要操作的中断号
NVIC_SET_ENABLE	PROC
				EXPORT	NVIC_SET_ENABLE
				PUSH	{R0-R8, LR}
				;保证中断号在合法范围内
				LDR		R1, =0X3F
				AND		R0, R1
				;判断当前中断号属于ISER的高32位还是低32位
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




			