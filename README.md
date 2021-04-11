Ada i2c BCM2835 interface for PCF8574 Remote 8-bit I/O I2C expander to drive a HD44780 2x16 5x7 LCD display

Bindings of the bcm2835 i2c interface for raspberry pi; The following functions are adopted:  
**bcm2835_i2c_setSlaveAddress**,
**bcm2835_i2c_set_baudrate**,
**bcm2835_i2c_write**,
**bcm2835_i2c_read**
See **i2c.adb** and **i2c.ads**  and https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2835/BCM2835-ARM-Peripherals.pdf for details


## Wiring:
I2c device 1 is used.

| PCFF8574 "Backpack" PIN  |  Raspberry Pi PIN |
| --- | --- |
|GND | GND |
|VCC | +5V |
|SDA | GPIO2 (SDA1) |
|SCL | GPIO3 (SCL1) |


## BCM2835 library installation:
BCM2835 need to be installed on the device. Follow the procedure bwelow for installation:

wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.68.tar.gz
tar zxvf bcm2835-1.68.tar.gz
cd bcm2835-1.68
./configure
make
sudo make check
sudo make install