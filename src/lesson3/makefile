#这个脚本无法处理有data段的数据
PRJ_NAME   = Led_Rcc
PREFIX ?= arm-none-eabi-

AS=$(PREFIX)as
LD=$(PREFIX)ld
OBJCOPY=$(PREFIX)objcopy
OBJDUMP=$(PREFIX)objdump
SIZE=$(PREFIX)size

SRC_DIR=src
BUILD_DIR=build

ASFILES=$(wildcard $(SRC_DIR)/*.s)
OBJ=$(ASFILES:$(SRC_DIR)/%.s=$(BUILD_DIR)/%.o)


ASFlAGE = -mcpu=cortex-m3 -mthumb 
LDFLAGE = -Ttext
LDFLAGE += 0x0
# LDFLAGE += -Tdata
# LDFLAGE += 0x20000000

.PHONY: all clean hex bin download
all: $(PRJ_NAME).elf

$(PRJ_NAME).elf: $(OBJ) 
	$(LD) $(LDFLAGE) -o $(BUILD_DIR)/$(PRJ_NAME).elf $(OBJ)
	$(OBJDUMP) -S $(BUILD_DIR)/$(PRJ_NAME).elf > $(BUILD_DIR)/$(PRJ_NAME).list
	$(SIZE) $(BUILD_DIR)/$(PRJ_NAME).elf
	
$(BUILD_DIR)/%.o:$(SRC_DIR)/%.s
	mkdir -p $(@D)
	$(AS) $(ASFLAGS) -c $< -o $@
	
clean:
	rm $(BUILD_DIR)/*.o $(BUILD_DIR)/*.list $(BUILD_DIR)/*.bin  $(BUILD_DIR)/*.elf

hex: $(PRJ_NAME).elf
	$(OBJCOPY) -O ihex $(BUILD_DIR)/$(PRJ_NAME).elf $(BUILD_DIR)/$(PRJ_NAME).hex

bin: $(PRJ_NAME).elf
	$(OBJCOPY) -O binary $(BUILD_DIR)/$(PRJ_NAME).elf $(BUILD_DIR)/$(PRJ_NAME).bin
download:
	st-flash write $(BUILD_DIR)/$(PRJ_NAME).bin 0x8000000
	