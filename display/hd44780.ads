---------------------------------------------------------------------------
--           Raspberry Pi HD44780 I2C BCM2835 interface
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

package HD44780 is
         
   type Cursor_Mode is (NO_BLINK,
			BLINK,
			OFF);
   
   type Line is range 1 .. 2;
   
   subtype Position is Byte range 0 .. 15;
   
   ---------------------------------------------------------
   --
   -- Init display
   --
   ---------------------------------------------------------      
   procedure Init;
   
   
   ---------------------------------------------------------
   --
   -- Print string S on the display   
   --
   ---------------------------------------------------------      
   procedure Print_String(S : String);   
   
   
   ---------------------------------------------------------
   --
   -- Print string S on the display at position S at line L 
   --
   ---------------------------------------------------------      
   procedure Print_String_Position(S : String; L : Line; Pos : Position);
      
      
   ---------------------------------------------------------
   --
   -- Set cursor mode (BLINK, NO_BLINK, OFF)    
   --
   ---------------------------------------------------------      
   procedure Set_Cursor_Mode(Cursor : Cursor_Mode);      
   
   
   ---------------------------------------------------------
   --
   -- Set cursor positon Pos at line L       
   --
   ---------------------------------------------------------      
   procedure Set_Cursor_Position(L : Line; Pos : Position);         
   
   
   ---------------------------------------------------------
   --
   -- Shift cursor position left N places      
   --
   ---------------------------------------------------------      
   procedure Shift_Cursor_Left(N : Natural);            
   
   
   ---------------------------------------------------------
   --
   -- Shift cursor position right N places            
   --
   ---------------------------------------------------------      
   procedure Shift_Cursor_Right(N : Natural);               
   
   
   ---------------------------------------------------------
   --
   -- Set cursor position to "home" (pos 0)
   --
   ---------------------------------------------------------      
   procedure Home;
   
   
   ---------------------------------------------------------
   --
   -- Clear display   
   --
   ---------------------------------------------------------      
   procedure Clear;         
   
end HD44780;
