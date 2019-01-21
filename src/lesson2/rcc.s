.include "reg.s"
ldr r0,=RCC_APB1RSTR
ldr r1,=0x00000000
str r1,[r0]

ldr r0,=RCC_APB2RSTR
ldr r1,=0x00000000
str r1,[r0]

ldr r0,=RCC_AHBENR
ldr r1,=0x00000000
str r1,[r0]

ldr r0,=RCC_APB2ENR
ldr r1,=0x00000000
str r1,[r0]

ldr r0,=RCC_APB1ENR
ldr r1,=0x00000000
str r1,[r0]

ldr r0,=RCC_CR
ldr r1,[r0]
mov r2,=#0x00000001
orr r3,r1,r2
str r3,[r0]

ldr r0,=RCC_CFGR
ldr r1,[r0]
mov r2,=#0xF8FF0000
and r3,r1,r2
str r3,[r0]

ldr r0,=RCC_CR
ldr r1,[r0]
mov r2,=#0xFEF6FFFF
and r3,r1,r2
str r3,[r0]

ldr r0,=RCC_CR
ldr r1,[r0]
mov r2,=#0xFFFBFFFF
and r3,r1,r2
str r3,[r0]

ldr r0,=RCC_CFGR
ldr r1,[r0]
mov r2,=#0xFF80FFFF
and r3,r1,r2
str r3,[r0]

ldr r0,=RCC_CIR
ldr r1,=0x00000000
str r1,[r0]

ldr r0,=RCC_CR
ldr r1,[r0]
mov r2,=#0x00010000
orr r3,r1,r2
str r3,[r0]

ldr r0,=RCC_CR
LOOP:
	ldr r1,[r0]
	tst r1,#0x20000
	beq LOOP
	ldr r0,=RCC_CFGR
	ldr r1,=0X00000400
	str r1,[r0]
/*	sub r0,r1,#2 */
	
	ldr r0,=RCC_CFGR
	ldr r1,[r0]
	mov r2,=#0x1D0000
	orr r3,r1,r2
	str r3,[r0]	
	
	ldr r0,=FLASH_ACR
	ldr r1,[r0]
	mov r2,=#0x32
	orr r3,r1,r2
	str r3,[r0]	
    
	ldr r0,=RCC_CR
	ldr r1,[r0]
	mov r2,=#0x01000000
	orr r3,r1,r2
	str r3,[r0]
	
	ldr r0,=RCC_CR
LOOP1:
	ldr r1,[r0]
	tst r1,#0x2000000
	beq LOOP1
	ldr r0,=RCC_CFGR
	ldr r1,[r0]
	mov r2,=#0x00000002
	orr r3,r1,r2
	str r3,[r0]
	
ll:
	mov r0,#0x02
	ldr r1,=RCC_CFGR
	ldr r2,[r1]
	mov r1, r2, LSL #2
	and r1,r1,#0X03
	cmp r1,r0
	bnq ll
	bx lr
	
	
		
	
	
	
