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
with Types; use Types;

package I2c is
   
   --------------------------------------------------------------------
   --
   -- Init
   --
   --------------------------------------------------------------------             
   function Init return Integer;
   
   --------------------------------------------------------------------
   --
   -- Set Slave
   --
   --------------------------------------------------------------------                
   function Set_Slave(Addr : C.Int) return Integer;
   
   --------------------------------------------------------------------
   --
   -- Set i2c clock 
   --
   --------------------------------------------------------------------                
   function Set_Speed(Baud : C.Int) return Integer;
   
   --------------------------------------------------------------------
   --
   -- Write
   --
   --------------------------------------------------------------------                
   function Write(Buffer : Byte_Buffer; Length : C.Int) return Integer;   
   
   --------------------------------------------------------------------
   --
   -- Read
   --
   --------------------------------------------------------------------                
   function Read(Buffer : Byte_Buffer; Length : C.Int) return Integer;

end I2c;
