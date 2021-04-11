---------------------------------------------------------------------------
--                Raspberry Pi sysfs gpio interface
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
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Streams.Stream_IO; 

package body Gpio_RaspberryPi is
   
   package IO renames Ada.Streams.Stream_IO;
   
   ----------------------------
   -- Generic Export/UnExport 
   ----------------------------   
   procedure Export_UnExport(Pin : Integer; File_Path : String; Action : String) is
      
      F : IO.File_Type;
      Output_Stream :IO.Stream_Access;
      Raw : constant String := Integer'Image(Pin);
      
   begin      
      IO.Open(F, IO.Out_File, File_Path);
      Output_Stream := IO.Stream(F);
      String'Write(Output_Stream, Raw(2 .. Raw'Last)); 
      IO.Close(F);
      
   exception
      when Device_Error =>
	 Put_Line("Warning: Pin" & Raw & " probably already " & Action);      
   end Export_UnExport;
   
   ----------------------------
   -- Integer to String 
   ----------------------------      
   Function Integer_To_String (Value : Integer) return String is
      Raw : constant String := Integer'Image(Value);
   begin
      return Raw(2 .. Raw'Last);
   end Integer_To_String;
   
   
   -------------------------
   -- Export
   -------------------------   
   procedure Export(Pin : Integer) is
      
      File_Path : constant String := "/sys/class/gpio/export";
      
   begin
      Export_UnExport(Pin, File_Path, "exported");
   end Export;
   
   
   -------------------------
   -- UnExport
   -------------------------   
   procedure UnExport(Pin : Integer) is
      
      File_Path : constant String := "/sys/class/gpio/unexport";      
      
   begin
      Export_UnExport(Pin, File_Path, "unexported");
   end UnExport;   
   
   
   -------------------------
   -- Pin_Mode
   -------------------------   
   procedure Set_Pin_Mode(Pin : Integer; Direction : Pin_Modes) is   
      
      F : IO.File_Type;
      Output_Stream :IO.Stream_Access;      
      File_Path : constant String := "/sys/class/gpio/gpio"& Integer_To_String(Pin) &"/direction";
      
   begin      
      IO.Open(F, IO.Out_File, File_Path);
      Output_Stream := IO.Stream(F);
      if Direction = Mode_In then 
	 String'Write(Output_Stream, "in");
      elsif Direction = Mode_Out then 
	 String'Write(Output_Stream, "out");	 
      end if;
      
      IO.Close(F);
   end Set_Pin_Mode;
   
   
   -------------------------
   -- Digital_Read
   -------------------------   
   Function Digital_Read(Pin : Integer) return Integer
      is
      
      F : IO.File_Type;
      Input_Stream :IO.Stream_Access;            
      File_Path : constant String := "/sys/class/gpio/gpio"& Integer_To_String(Pin) & "/value";
      Res : String := " ";
      
   begin
      IO.Open(F, IO.In_File, File_Path);
      Input_Stream := IO.Stream(F);
      String'Read(Input_Stream, Res); 
      IO.Close(F); 
      
      return Integer'Value(Res);
   end Digital_Read; 
   
   
   -------------------------
   -- Write
   -------------------------      
   procedure Digital_Write(Pin : Integer; Value: Low_High) is
           
      F : IO.File_Type;
      Output_Stream :IO.Stream_Access;            

      File_Path : constant String := "/sys/class/gpio/gpio"& Integer_To_String(Pin) & "/value";            
      
   begin
      IO.Open(F, IO.Out_File, File_Path);
      Output_Stream := IO.Stream(F);
      String'Write(Output_Stream, Integer_To_String(Value)); 
      IO.Close(F);      
   end Digital_Write;   
   
   
   -------------------------
   -- Active Low
   -------------------------      
   procedure Set_Active_Low(Pin : Integer; State: Low_High) is
      F : IO.File_Type;
      Output_Stream :IO.Stream_Access;            

      File_Path : constant String := "/sys/class/gpio/gpio"& Integer_To_String(Pin) & "/active_low";                  
      
   begin
      IO.Open(F, IO.Out_File, File_Path);
      Output_Stream := IO.Stream(F);
      String'Write(Output_Stream, Integer_To_String(State)); 
      IO.Close(F);            
   end Set_Active_Low;
   
   
   -------------------------
   -- Edge
   -------------------------      
   procedure Set_Edge(Pin : Integer; State : Edge_States) is
      F : IO.File_Type;
      Output_Stream :IO.Stream_Access;            

      File_Path : constant String := "/sys/class/gpio/gpio"& Integer_To_String(Pin) & "/edge";                        
   begin
      IO.Open(F, IO.Out_File, File_Path);
      Output_Stream := IO.Stream(F);
      
      if State = None then 
	 String'Write(Output_Stream, "none");
      elsif State = Rising then 
	 String'Write(Output_Stream, "rising");	 
      elsif State = Falling then 
	 String'Write(Output_Stream, "falling");
      elsif State = Both then 
	 String'Write(Output_Stream, "both");	 	 
      end if;
      
      IO.Close(F);      
   end Set_Edge;
   
end Gpio_RaspberryPi;
