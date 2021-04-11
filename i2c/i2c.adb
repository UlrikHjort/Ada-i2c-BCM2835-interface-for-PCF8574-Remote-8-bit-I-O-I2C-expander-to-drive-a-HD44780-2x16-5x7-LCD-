---------------------------------------------------------------------------
--              Raspberry Pi I2C BCM2835 Interface
-- 
--           Copyright (C) 2021 By Ulrik Hørlyk Hjort
--
--  This Program is Free Software; You Can Redistribute It and/or
--  Modify It Under The Terms of The GNU General Public License
--  As Published By The Free Software Foundation; Either Version 2
--  of The License, or (at Your Option) Any Later Version.
--
--  This Program is Distributed in The Hope That It Will Be Useful,
--  But WITHOUT ANY WARRANTY; Without Even The Implied Warranty of
--  MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See The
--  GNU General Public License for More Details.
--
-- You Should Have Received A Copy of The GNU General Public License
-- Along with This Program; if not, See <Http://Www.Gnu.Org/Licenses/>.
---------------------------------------------------------------------------

package body i2c is
   
   --------------------------------------------------------------------
   --
   -- Init
   --
   --------------------------------------------------------------------          
   function Init return Integer is
	 
      function bcm2835_init return C.Int
	with
	Import        => True,
	Convention    => C,
        External_Name => "bcm2835_init";
      
   begin      
      return  Integer(bcm2835_init);      	 
   end Init;	    
   
   --------------------------------------------------------------------
   --
   -- Set Slave
   --
   --------------------------------------------------------------------             
   function Set_Slave(Addr : C.Int) return Integer is
      function bcm2835_i2c_setSlaveAddress(Addr : C.Int) return C.Int
	with
	Import        => True,
	Convention    => C,
        External_Name => "bcm2835_i2c_setSlaveAddress";
   begin
         return  Integer(Bcm2835_I2c_SetSlaveAddress(Addr));
   end Set_Slave;
   
   
   --------------------------------------------------------------------
   --
   -- Set i2c clock 
   --
   --------------------------------------------------------------------             
   function Set_Speed(Baud : C.Int) return Integer is
      function bcm2835_i2c_set_baudrate(Baud : C.Int) return C.Int
	with
	Import        => True,
	Convention    => C,
        External_Name => "bcm2835_i2c_set_baudrate";      
      
   begin      
      return  Integer(bcm2835_I2c_Set_Baudrate(Baud));	
   end Set_Speed;
   
   
   --------------------------------------------------------------------
   --
   -- Write
   --
   --------------------------------------------------------------------             
   function Write(Buffer : Byte_Buffer; Length : C.Int) return Integer is
      function bcm2835_i2c_write(Buffer : Byte_Buffer; Length : C.Int) return C.Int
	with
	Import        => True,
	Convention    => C,
        External_Name => "bcm2835_i2c_write";      
   begin
      return  Integer(bcm2835_i2c_write(Buffer, length));      
   end Write;
   
   
   --------------------------------------------------------------------
   --
   -- Read
   --
   --------------------------------------------------------------------             
   function Read(Buffer : Byte_Buffer; Length : C.Int)  return Integer is
      function bcm2835_i2c_read(Buffer : Byte_Buffer; Length : C.Int) return C.Int
	with
	Import        => True,
	Convention    => C,
        External_Name => "bcm2835_i2c_read";      
   begin
      return  Integer(bcm2835_i2c_read(Buffer, length));      	 
	 
   end Read;	 
   
end i2c;

