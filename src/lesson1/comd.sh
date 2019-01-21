#!/bin/sh
rm ./*.o
echo "删除旧的*.o文件"
rm ./boot.out
echo "删除旧的led_flash.out文件"
rm ./boot.bin
echo "删除旧的led_flash.bin文件"
arm-none-eabi-as -mcpu=cortex-m3 -mthumb delay.s -o delay.o
echo "正在编译生成新的delay.o文件"
arm-none-eabi-as -mcpu=cortex-m3 -mthumb boot.s -o boot.o
echo "正在编译生成新的boot.o文件"
arm-none-eabi-ld -Ttext 0x0 -o boot.out boot.o delay.o 
echo "正在连接生成新的led_flash.out文件"
arm-none-eabi-objcopy -Obinary boot.out boot.bin
echo "正在生成新的led_flash.bin文件"
arm-none-eabi-objdump -S boot.out > example1.list
echo "开始下载工程的bin文件到Flash中"
st-flash write boot.bin 0x8000000
