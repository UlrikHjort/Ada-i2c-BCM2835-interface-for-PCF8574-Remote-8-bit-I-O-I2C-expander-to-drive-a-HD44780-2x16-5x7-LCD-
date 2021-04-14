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
with Interfaces;
with I2c;

package body HD44780 is
   
   -------------------------------------------------------------
   --
   -- Constants: 
   --
   -------------------------------------------------------------      
   LINE_1 : constant Byte := 16#80#;
   LINE_2 : constant Byte := 16#C0#;   
   
   LINE_LENGTH : constant Integer  := 16;
   
   ENABLE_DELAY : constant Duration := 0.0004;
   
   
   -------------------------------------------------------------
   --
   -- HD44780 Commands: 
   --
   -------------------------------------------------------------   
   CMD_ENTRY_MODE                     : constant Byte := 16#06#;
   CMD_INIT_4_BIT_MODE                : constant Byte := 16#32#;
   CMD_BITS_4_LINES_1_DOTS_5X7        : constant Byte := 16#20#;
   CMD_BITS_4_LINES_2_DOTS_5X7        : constant Byte := 16#28#;
   CMD_BITS_8_LINES_1_DOTS_5X7        : constant Byte := 16#30#;
   CMD_BITS_8_LINES_2_DOTS_5X7        : constant Byte := 16#38#;
   CMD_DISPLAY_ON_CURSOR_NO_BLINK     : constant Byte := 16#0E#;      
   CMD_DISPLAY_ON_CURSOR_BLINK        : constant Byte := 16#0F#;            
   CMD_DISPLAY_ON_CURSOR_OFF          : constant Byte := 16#0C#;
   CMD_DISPLAY_OFF_CURSOR_OFF         : constant Byte := 16#08#;   
   CMD_SHIFT_ENTIRE_DISPLAY_LEFT      : constant Byte := 16#18#;   
   CMD_SHIFT_ENTIRE_DISPLAY_RIGHT     : constant Byte := 16#1C#;      
   CMD_CURSOR_HOME                    : constant Byte := 16#02#;            
   CMD_CURSOR_LEFT_ONE_CHAR           : constant Byte := 16#10#;   
   CMD_CURSOR_RIGHT_ONE_CHAR          : constant Byte := 16#14#;         
   CMD_CLEAR_DISPLAY_AND_DRAM_CONTENT : constant Byte := 16#01#;      
   
   ---------------------------------------------------------
   -- Local methods:
   ---------------------------------------------------------         
      
   ---------------------------------------------------------
   --
   -- Write a command to the display
   --
   ---------------------------------------------------------      
   procedure Write_Cmd(Cmd : Byte) is
      
      Buffer : Byte_Buffer;
      Upper : constant Byte := Cmd and 16#F0#;
      Lower : constant Byte := Byte(Interfaces.Shift_Left(Interfaces.Unsigned_8(Cmd),4)) and 16#F0#; 
      
      R : Integer := 0;
      
   begin      
      -- E ~ Clock Enable, RS ~ Register Select 
      Buffer(0) := Upper or 16#0C#; -- E = 1, RS = 0 
      Buffer(1) := Upper or 16#08#; -- E = 0, RS = 0       
      Buffer(2) := Lower or 16#0C#; -- E = 1, RS = 0 
      Buffer(3) := Lower or 16#08#; -- E = 0, RS = 0                         
      R := I2c.Write(Buffer, 4);
   end Write_Cmd;
   
   
   ---------------------------------------------------------
   --
   -- Write data to the display
   --
   ---------------------------------------------------------      
   procedure Write_Data(Data : Byte) is      
      
      Buffer : Byte_Buffer;
      Upper : constant Byte := Data and 16#F0#;
      Lower : constant Byte := Byte(Interfaces.Shift_Left(Interfaces.Unsigned_8(Data),4)) and 16#F0#; 
      
      R : Integer := 0;
      
   begin      
      -- E ~ Clock Enable, RS ~ Register Select       
      Buffer(0) := Upper or 16#0D#; -- E = 1, RS = 1 
      Buffer(1) := Upper or 16#09#; -- E = 0, RS = 1 
      Buffer(2) := Lower or 16#0D#; -- E = 1, RS = 1 
      Buffer(3) := Lower or 16#09#; -- E = 0, RS = 1             
      R := I2c.Write(Buffer, 4); 
   end Write_Data;   
   

   ---------------------------------------------------------
   -- Global methods:
   ---------------------------------------------------------         
   
   ---------------------------------------------------------
   --
   -- Init display
   --
   ---------------------------------------------------------      
   procedure Init is
      R : Integer := 0;
   begin
      
      R := I2c.Init;
      R := I2c.Set_Slave(16#27#);
      --R := I2c.Set_Speed(100000);
      
      delay 0.1;            
      Write_Cmd(CMD_BITS_8_LINES_1_DOTS_5X7);      
      delay 0.01;
      Write_Cmd(CMD_BITS_8_LINES_1_DOTS_5X7);      
      delay 0.01;
      Write_Cmd(CMD_BITS_8_LINES_1_DOTS_5X7);            
      delay 0.01;      
      Write_Cmd(CMD_INIT_4_BIT_MODE);            	
      delay 0.01; 
      Write_Cmd(CMD_CLEAR_DISPLAY_AND_DRAM_CONTENT); 
      delay 0.01; 
      Write_Cmd(CMD_ENTRY_MODE); 
      delay 0.01;      
      Write_Cmd(CMD_DISPLAY_ON_CURSOR_OFF);  
      delay 0.01;            

   end Init;
   
   
   ---------------------------------------------------------
   --
   -- Print string S on the display
   --
   ---------------------------------------------------------      
   procedure Print_String(S : String) is 
      J : Integer := 0;      
      
   begin
      J := 1;
      Write_Cmd(Line_1);
	for I in S'First .. S'Last loop
	if J = LINE_LENGTH then
	   Write_Cmd(Line_2);
	end if;
	J := J +1;
	 Write_Data(Character'Pos(S(I)));
	end loop;      
   end Print_String;
   
   ---------------------------------------------------------
   --
   -- Print string S on the display at position S at line L 
   --
   ---------------------------------------------------------      
   procedure Print_String_Position(S : String; L : Line; Pos : Position) is 
      
   begin
      Set_Cursor_Position(L,Pos);
      for I in S'First .. S'Last loop
	 Write_Data(Character'Pos(S(I)));
      end loop;      
   end Print_String_Position;   
   
   
   ---------------------------------------------------------
   --
   -- Set cursor mode (BLINK, NO_BLINK, OFF) 
   --
   ---------------------------------------------------------      
   procedure Set_Cursor_Mode(Cursor : Cursor_Mode) is
      
   begin      
      case Cursor is
         when NO_BLINK => 
	    Write_Cmd(CMD_DISPLAY_ON_CURSOR_NO_BLINK);
         when BLINK => 
	    Write_Cmd(CMD_DISPLAY_ON_CURSOR_BLINK);	    
	 when OFF =>
	    Write_Cmd(CMD_DISPLAY_ON_CURSOR_OFF);
      end case;      
   end Set_Cursor_Mode;
   
   
   ---------------------------------------------------------
   --
   -- Set cursor positon Pos at line L 
   --
   ---------------------------------------------------------      
   procedure Set_Cursor_Position(L : Line; Pos : Position) is
      
   begin
      case L is 
	 when 1 =>
	    Write_Cmd(LINE_1 + Pos); 	 
	 when 2 =>  
	    Write_Cmd(LINE_2 + Pos); 	 	    
      end case;
   end Set_Cursor_Position;
   
   
   ---------------------------------------------------------
   --
   -- Shift cursor position left N places
   --
   ---------------------------------------------------------      
   procedure Shift_Cursor_Left(N : Natural) is
      
      I : Natural := 0;
   begin
      loop
	 exit when I = N;
	 I := I + 1;
	 Write_Cmd(CMD_CURSOR_LEFT_ONE_CHAR); 	 	    	 
      end loop;      
   end Shift_Cursor_Left;
   
   
   ---------------------------------------------------------
   --
   -- Shift cursor position right N places      
   --
   ---------------------------------------------------------      
   procedure Shift_Cursor_Right(N : Natural) is
      
      I : Natural := 0;            
   begin
      loop
	 exit when I = N;
	 I := I + 1;
	 Write_Cmd(CMD_CURSOR_RIGHT_ONE_CHAR); 	 	    	 
      end loop;      
   end Shift_Cursor_Right;      
   
   
   ---------------------------------------------------------
   --
   -- Set cursor position to "home"
   --
   ---------------------------------------------------------      
   procedure Home is
   begin
      Write_Cmd(CMD_CURSOR_HOME);
   end Home;   
   
   
   ---------------------------------------------------------
   --
   -- Clear display
   --
   ---------------------------------------------------------      
   procedure Clear is
   begin
      Write_Cmd(CMD_CLEAR_DISPLAY_AND_DRAM_CONTENT);      	 
   end Clear;
   
end HD44780;
