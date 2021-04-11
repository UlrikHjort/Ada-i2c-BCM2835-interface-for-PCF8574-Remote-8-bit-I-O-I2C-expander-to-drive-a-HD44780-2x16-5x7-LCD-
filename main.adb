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
with HD44780;

procedure Main is
   
   R : Integer := 0;
   S : constant String := "Hello Ada Pi   BCM2835! :)";
   I : Integer := 0;
   
   
begin
   HD44780.Init;
   HD44780.Set_Cursor_Mode(HD44780.BLINK);  
   
   -- Print string and counter as example
   HD44780.Print_String(S);    
   loop
      exit when I = 10;
      delay 1.0;
      HD44780.Print_String_Position(Integer'Image(I),2,10);
      I := I + 1;
   end loop;

end Main;

