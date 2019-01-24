.include "./inc/reg.s"
.code 16
.syntax unified
.global Rcc_Init
.type  Rcc_Init,function
/*ϵͳʱ�ӳ�ʼ��*/
Rcc_Init:		push	{r0-r8, lr}
				/*�ⲿ����ʱ��ʱ�� rcc->cr |= bit16*/
				ldr		r0, =RCC_CR
				ldr		r1, [r0]
				orr		r1, #Bit16
				str		r1, [r0]
				/*�����ⲿʱ���Ƿ����*/
rcc_clk_notok:	ldr		r1, [r0]
				ands	r1, #Bit17
				beq		rcc_clk_notok
				ldr		r1, [r0]
				orr		r1, #Bit17
				str		r1, [r0]
				/*flash�������������ٶ�����*/
				ldr		r0, =FLASH_ACR
				mov		r1, #0x00000032
				str		r1, [r0]
				/*����ϵͳʱ�ӱ�Ƶ*/
				ldr		r0, =RCC_CFGR
				ldr		r1, [r0]
				/*hclk 2��Ƶ*/
				orr		r1, #Bit10
				/*9��Ƶ[21:18]-->0111*/
				orr		r1, #Bit18
				orr		r1, #Bit19
				orr		r1, #Bit20
				/*����adc��Ԥ��ƵΪpclk2��4��Ƶ*/
				orr		r1, #Bit14
				/*����hseΪpll����ʱ��Դ*/
				orr		r1, #Bit16
				str		r1, [r0]
				/*������Ƶ*/
				ldr		r0, =RCC_CR
				ldr		r1, [r0]
				orr		r1, #Bit24
				str		r1, [r0]
				/*�ȴ���Ƶ��Ч*/
rcc_pll_notok:	ldr		r1, [r0]
				ands	r1, #Bit25
				beq		rcc_pll_notok
				/*����pllΪ��ǰϵͳʱ��*/
				ldr		r0, =RCC_CFGR
				ldr		r1, [r0]
				orr		r1, #Bit1
				str		r1, [r0]
				/*��֤ϵͳʱ��״̬�Ƿ��л�Ϊpll*/
				mov		r2, #0x02
rcc_pll_notrdy:	ldr		r1, [r0]
				lsr		r1, r1, #2
				and		r1, #0x03
				cmp		r1, r2
				bne		rcc_pll_notrdy
				pop		{r0-r8, pc}

	
	
		
	
	
	
