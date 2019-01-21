.text
.global _start
.code 16
.syntax unified
.type _start, function
_start:
/* ��������ڵ� */
movs r0, #0
movs r1, #0
movs r2, #0
movs r3, #0
movs r4, #0
movs r5, #0
ldr r0, =hello
bl puts
movs r0, #0x4
bl putc
deadloop:
b deadloop
hello:
.ascii "Hello\n"
.byte 0
.align
puts:
/* ���ӳ�����UART�����ַ��� */
/* ��������� r0 = �ַ�������ʼ��ַ */
/* �ַ���Ҫ�����β */
push {r0, r1, lr} /* ����Ĵ��� */
mov r1, r0 /* �ѵ�ַ������R1����Ϊ */
/* R0 ��Ҫ������putc�Ĳ��� */
putsloop:
ldrb.w r0, [r1], #1 /* ��ȡһ���ַ�����������ַ */
cbz r0, putsloopexit /* ����ַ�ΪNULL������ת������ */
bl putc
b putsloop
putsloopexit:
pop {r0, r1, pc} /* ���� */
.equ UART0_DATA, 0x4000C000
.equ UART0_FLAG, 0x4000C018
putc:
/* ���ӳ���ͨ��UART����һ���ַ� */
/* ��������� R0 = Ҫ���͵��ַ� */
push {r1, r2, r3, lr} /* ����Ĵ��� */
ldr r1, =UART0_FLAG
putcwaitloop:
ldr r2, [r1] /* ��ȡ״̬λ */
tst.w r2, #0x20 /* ��鷢�ͻ���������־ */
bne putcwaitloop /* ���������ѭ���ȴ� */
ldr r1, =UART0_DATA /* ������������ͻ������������� */
str r0, [r1]
pop {r1, r2, r3, pc} /* ���� */
.end