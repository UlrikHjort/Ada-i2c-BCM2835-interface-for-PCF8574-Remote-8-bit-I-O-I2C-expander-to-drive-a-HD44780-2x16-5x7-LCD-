---------------------------------------------------------------------------
--                  Raspberry Pi sysfs gpio interface
-- 
--  Copyright (C) 2020 By Ulrik Hørlyk Hjort  -  ulrik (at) adabots.se 
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
package Gpio_RaspberryPi is
   
   subtype Low_High is Natural range 0 .. 1;
   
   type Pin_Modes is (Mode_In, Mode_Out);
   type Edge_States is (None, Rising, Falling, Both);
   
   Low :  Low_High := 0;
   High : Low_High := 1;
   
   
   --------------------------------------------------------------
   -- Export pin
   --------------------------------------------------------------
   procedure Export(Pin : Integer);
   
   
   --------------------------------------------------------------
   -- Unexport pin
   --------------------------------------------------------------   
   procedure UnExport(Pin : Integer);
   
   
   --------------------------------------------------------------
   -- Set pin mode (Mode_In, Mode_Out)
   --------------------------------------------------------------
   procedure Set_Pin_Mode(Pin : Integer; Direction : Pin_Modes);
   
   
   --------------------------------------------------------------
   -- Read pin state
   --------------------------------------------------------------
   Function Digital_Read(Pin : Integer) return Integer;
   
      
   --------------------------------------------------------------
   -- Write pin state
   --------------------------------------------------------------   
   procedure Digital_Write(Pin : Integer; Value: Low_High);
   
   
   --------------------------------------------------------------
   -- Set active low (0,1)
   --------------------------------------------------------------   
   procedure Set_Active_Low(Pin : Integer; State: Low_High);
   
     
   --------------------------------------------------------------
   -- Set edge (None, Rising, Falling, Both);
   --------------------------------------------------------------   
   procedure Set_Edge(Pin : Integer; State : Edge_States);   
   
end Gpio_RaspberryPi;
