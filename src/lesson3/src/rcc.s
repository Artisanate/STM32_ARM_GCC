.include "./inc/reg.s"
.code 16
.syntax unified
.global Rcc_Init
.type  Rcc_Init,function
/*系统时钟初始化*/
Rcc_Init:		push	{r0-r8, lr}
				/*外部高速时钟时能 rcc->cr |= bit16*/
				ldr		r0, =RCC_CR
				ldr		r1, [r0]
				orr		r1, #Bit16
				str		r1, [r0]
				/*检验外部时钟是否就绪*/
rcc_clk_notok:	ldr		r1, [r0]
				ands	r1, #Bit17
				beq		rcc_clk_notok
				ldr		r1, [r0]
				orr		r1, #Bit17
				str		r1, [r0]
				/*flash缓冲区及访问速度配置*/
				ldr		r0, =FLASH_ACR
				mov		r1, #0x00000032
				str		r1, [r0]
				/*设置系统时钟倍频*/
				ldr		r0, =RCC_CFGR
				ldr		r1, [r0]
				/*hclk 2分频*/
				orr		r1, #Bit10
				/*9倍频[21:18]-->0111*/
				orr		r1, #Bit18
				orr		r1, #Bit19
				orr		r1, #Bit20
				/*设置adc的预分频为pclk2的4分频*/
				orr		r1, #Bit14
				/*设置hse为pll输入时钟源*/
				orr		r1, #Bit16
				str		r1, [r0]
				/*开启倍频*/
				ldr		r0, =RCC_CR
				ldr		r1, [r0]
				orr		r1, #Bit24
				str		r1, [r0]
				/*等待倍频生效*/
rcc_pll_notok:	ldr		r1, [r0]
				ands	r1, #Bit25
				beq		rcc_pll_notok
				/*设置pll为当前系统时钟*/
				ldr		r0, =RCC_CFGR
				ldr		r1, [r0]
				orr		r1, #Bit1
				str		r1, [r0]
				/*验证系统时钟状态是否切换为pll*/
				mov		r2, #0x02
rcc_pll_notrdy:	ldr		r1, [r0]
				lsr		r1, r1, #2
				and		r1, #0x03
				cmp		r1, r2
				bne		rcc_pll_notrdy
				pop		{r0-r8, pc}

	
	
		
	
	
	
