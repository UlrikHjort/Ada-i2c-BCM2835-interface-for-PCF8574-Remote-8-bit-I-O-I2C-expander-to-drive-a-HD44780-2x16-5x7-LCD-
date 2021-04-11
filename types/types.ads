---------------------------------------------------------------------------
--          Raspberry Pi HD44780 BCM2835 I2C interface
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

with Interfaces.C;

package Types is
   
   package C renames Interfaces.C;
   
   type Byte is mod 256; pragma Convention (C, Byte);
   type Byte_Buffer is array (Interfaces.C.Int range 0 .. 3) of Byte;  pragma Convention (C, Byte_Buffer);
   
end Types;
