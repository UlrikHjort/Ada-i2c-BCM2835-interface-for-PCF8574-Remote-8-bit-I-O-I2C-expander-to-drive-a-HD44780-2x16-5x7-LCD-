EXE = main
ADA_VERSION = -gnat12
I2C_DIR = i2c
I2C = $(I2C_DIR)/i2c.adb 
DISPLAY_DIR = display
DISPLAY = $(DISPLAY_DIR)/hd44780.adb
TYPES_DIR = ./types
LIBS= -lbcm2835 
SRC = main.adb  $(I2C) $(DISPLAY)
INCLUDE =  -I$(I2C_DIR) -I$(DISPLAY_DIR) -I$(TYPES_DIR)
FLAGS = -gnato -gnatwa -fstack-check -g

all:
	gnatmake  $(ADA_VERSION) $(FLAGS) $(INCLUDE) $(SRC) -largs $(LIBS) --LINK=gcc  


clean:
	rm *.ali *~ *.o b~* $(EXE) $(I2C_DIR)/*~ $(DISPLAY_DIR)/*~  $(TYPES_DIR)/*~ 
