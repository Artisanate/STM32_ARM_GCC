.code 16
.syntax unified
.global kcs_led_deay
.type  kcs_led_deay,function
kcs_led_deay:		sub r0,#1
					mov r1,#520
delay_loop:
					sub r1,#1
					nop
					nop
					nop
					cmp r1,#0
					bne delay_loop
					cmp r0,#0
					bne kcs_led_deay
					mov pc,lr
					