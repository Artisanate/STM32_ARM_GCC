PRJ_NAME   = Led_Rcc
PREFIX ?= arm-none-eabi-

AS=$(PREFIX)as
LD=$(PREFIX)ld
OBJCOPY=$(PREFIX)objcopy
OBJDUMP=$(PREFIX)objdump

SRC_DIR=src
BUILD_DIR=build

ASFILES=$(wildcard $(SRC_DIR)/*.s)
OBJ=$(ASFILES:$(SRC_DIR)/%.s=$(BUILD_DIR)/%.o)


ASFlAGE = -mcpu=cortex-m3 -mthumb 
LDFLAGE = -Ttext
LDFLAGE += 0x0


.PHONY: all clean bin download
all: $(PRJ_NAME).out

$(PRJ_NAME).out: $(OBJ) 
	$(LD) $(LDFLAGE) -o $(BUILD_DIR)/$(PRJ_NAME).out $(OBJ)
#	$(OBJCOPY) -Obinary $(BUILD_DIR)/$(PRJ_NAME).out $(BUILD_DIR)/$(PRJ_NAME).bin
	$(OBJDUMP) -S $(BUILD_DIR)/$(PRJ_NAME).out > $(BUILD_DIR)/$(PRJ_NAME).list
	
$(BUILD_DIR)/%.o:$(SRC_DIR)/%.s
	mkdir -p $(@D)
	$(AS) $(ASFLAGS) -c $< -o $@
	
clean:
	rm $(BUILD_DIR)/*.o $(BUILD_DIR)/*.out $(BUILD_DIR)/*.list $(BUILD_DIR)/*.bin

bin: $(BUILD_DIR)/$(PRJ_NAME).out
	$(OBJCOPY) -Obinary $(BUILD_DIR)/$(PRJ_NAME).out $(BUILD_DIR)/$(PRJ_NAME).bin
download:
	st-flash write $(BUILD_DIR)/$(PRJ_NAME).bin 0x8000000
	