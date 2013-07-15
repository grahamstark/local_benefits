with Ada.Text_IO;
with Text_Utils;
with GNATColl.Traces;

package body Model.LA_Global_Settings is

   use Ada.Strings.Unbounded;
   use Text_Utils;
   
   this_log_config_file_name     : Unbounded_String := To_Unbounded_String("");
   this_web_root                 : Unbounded_String := To_Unbounded_String("");
   this_physical_root            : Unbounded_String := To_Unbounded_String("");
   this_template_components_path : Unbounded_String := To_Unbounded_String("");
   this_port                     : Positive := 80;
   this_dir_separator            : Unbounded_String := To_Unbounded_String("");
   this_working_root             : Unbounded_String := To_Unbounded_String("");
   this_tmp_dir                  : Unbounded_String := To_Unbounded_String("");
   

   procedure Read_Settings( filename : String ) is
      use UK_Key_Value_IO;
      use Ada.Text_IO;
      file : Ada.Text_IO.File_Type;  
   begin
      Ada.Text_IO.Put_Line( "Reading global settings from " & filename );
      Open( file, In_File, filename );
      this_physical_root := read( file, "physical_root" );
      this_web_root := read( file, "web_root" );
      this_log_config_file_name := read( file, "log_config_file_name" );
      this_tmp_dir := read( file, "tmp_dir" );
      this_template_components_path := read( file, "template_components_path" );
      this_port := read( file, "port" );
      this_dir_separator := read( file, "dir_separator" );      
      this_working_root := Read( file, "working_root" );
      Ada.Text_IO.Put_Line( "Read global settings OK " );
      
      Close( file );
   end Read_Settings;
   
   function Dir_Separator return String is
   begin
      return To_String( this_dir_separator );
   end Dir_Separator;
   
   function Log_Config_File_Name return String is
   begin
      return To_String( this_physical_root &  "etc" & this_dir_separator & this_log_config_file_name );
   end Log_Config_File_Name;
   
   
   function Working_Root return String is
   begin
      return To_String( this_physical_root & this_dir_separator & this_working_root );
   end Working_Root;
   
   function Web_Root return String is 
   begin 
      return To_String( this_web_root ); 
   end Web_Root;

   function Physical_Root return String is 
   begin 
      return To_String( this_physical_root ); 
   end Physical_Root;

   function Tmp_Dir return String is 
   begin 
      return To_String( this_physical_root & this_dir_separator & this_tmp_dir ); 
   end Tmp_Dir;
   
   function Template_Components_Path return String is 
   begin 
      return To_String( this_physical_root & this_dir_separator & this_template_components_path ); 
   end Template_Components_Path;

   function Port return Positive is 
   begin 
      return this_port;
   end Port;
    
   procedure Initialise_Logging( filename : String := "" ) is
      use Ada.Text_IO;
      fname : constant String := ( if filename = "" then Log_Config_File_Name else filename );
   begin
      Put_Line( "Initialise_Logging reading from: |" & fname );
      GNATColl.Traces.Parse_Config_File( fname );
      Put_Line( "Log file read OK" );
   end Initialise_Logging;
   
end Model.LA_Global_Settings;
