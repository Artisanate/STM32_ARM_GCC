.text
.global _start
.code 16
.syntax unified
.type _start, function
_start:
/* 主程序入口点 */
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
/* 该子程序向UART发送字符串 */
/* 入口条件： r0 = 字符串的起始地址 */
/* 字符串要以零结尾 */
push {r0, r1, lr} /* 保存寄存器 */
mov r1, r0 /* 把地址拷贝到R1，因为 */
/* R0 还要用于作putc的参数 */
putsloop:
ldrb.w r0, [r1], #1 /* 读取一个字符并且自增地址 */
cbz r0, putsloopexit /* 如果字符为NULL，则跳转到结束 */
bl putc
b putsloop
putsloopexit:
pop {r0, r1, pc} /* 返回 */
.equ UART0_DATA, 0x4000C000
.equ UART0_FLAG, 0x4000C018
putc:
/* 该子程序通过UART发送一个字符 */
/* 入口条件： R0 = 要发送的字符 */
push {r1, r2, r3, lr} /* 保存寄存器 */
ldr r1, =UART0_FLAG
putcwaitloop:
ldr r2, [r1] /* 获取状态位 */
tst.w r2, #0x20 /* 检查发送缓冲区满标志 */
bne putcwaitloop /* 如果已满则循环等待 */
ldr r1, =UART0_DATA /* 否则继续往发送缓冲区里送数据 */
str r0, [r1]
pop {r1, r2, r3, pc} /* 返回 */
.end