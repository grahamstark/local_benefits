--
-- $Revision $
-- $Author $
-- $Date $
--
with Ada.Text_IO;
with Ada.Strings.Unbounded;

with AWS.Config.Set; 
with AWS.Config; 
with AWS.Dispatchers.Callback;
with AWS.Mime;
with AWS.Server.Log;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with AWS.Services.Page_Server;
with AWS.Services;
with AWS.Default;
with Ada.Command_Line;

with Callbacks;
with Connection_Pool;
with GNATColl.Traces;

with Text_Utils;
with Web_Utils;
with Signal_Handler;
with Environment;
with Model.LA_Global_Settings;

procedure LA_Server is
   
   use AWS.Services;
   use AWS.Config;
   use AWS.Config.Set;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "WSC_SERVER" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
 
   my_dispatcher : AWS.Services.Dispatchers.URI.Handler;
   my_config     : AWS.Config.Object := AWS.Config.Get_Current;
   
   package awsc renames AWS.Config; 
   
   use Text_Utils;
   use Ada.Strings.Unbounded;
   use Ada.Text_IO;
   
   SEP : constant String := Model.LA_Global_Settings.Dir_Separator;
    
   default_handler : AWS.Dispatchers.Callback.Handler;

   STATIC_FILE_REGEP : constant String :=  
                                   ".*\.css|" & 
                                   ".*\.js|" &
                                   ".*\.png|" & 
                                   ".*\.html|" & 
                                   ".*\.gif|" &
                                   ".*\.pdf|" &
                                   ".*\.zip";
begin
   if( Ada.Command_Line.Argument_Count = 1 ) then  
      Model.LA_Global_Settings.Read_Settings( Ada.Command_Line.Argument( 1 ));
   else
      Model.LA_Global_Settings.Read_Settings( "etc/global_settings.txt" );
   end if;
   Model.LA_Global_Settings.Initialise_Logging;
   
   default_handler := AWS.Dispatchers.Callback.Create( Callbacks.Index_Page_Callback'Access );
   
   -- add a mime type for SVG
   -- AWS.Mime.Add_Extension( "svg", globals.MIME_TYPE_IMAGE_SVG );
   
   awsc.Set.Server_Name( my_config, "LA Server" );
   awsc.Set.Server_Port( my_config, Model.LA_Global_Settings.port );
   awsc.Set.WWW_Root( my_config, Model.LA_Global_Settings.Physical_Root & "web" );
   awsc.Set.Session( my_config, true );
   awsc.Set.Session_Lifetime( Duration( 48*60*60 ) ); -- 48 hours
   awsc.Set.Max_Connection( my_config,  100 );
   awsc.Set.Accept_Queue_Size( my_config, 60 );
   awsc.Set.Free_Slots_Keep_Alive_Limit( my_config, 80 );
   awsc.Set.Line_Stack_Size( my_config, AWS.Default.Line_Stack_Size*10 );
   declare
      Web_Root : constant String := Model.LA_Global_Settings.Web_Root;
   begin
      Log
         ("Call me on port" &
         Positive'Image( Model.LA_Global_Settings.port ) & "; serving web root |" & Web_Root &
          "| press ctl-break to stop me ...");
      Dispatchers.URI.Register_Default_Callback( my_dispatcher, default_handler );
      Dispatchers.URI.Register_Regexp( my_dispatcher, Web_Root & "/*csv.*",  
         Callbacks.CSV_File_Callback'Access );
      Dispatchers.URI.Register_Regexp( my_dispatcher, STATIC_FILE_REGEP,
                                      Callbacks.Serve_Static_Resource'Access );
   end;
   
   Connection_Pool.Initialise(
      Environment.Get_Server_Name,
      Environment.Get_Database_Name,
      Environment.Get_Username,
      Environment.Get_Password,
      2 );
      
   AWS.Server.Log.Start( 
      Web_Server => Signal_Handler.aws_web_server,
      Filename_Prefix => "logs/request_log",
      Auto_Flush => False  );
   
   Log( "started the logger" );
   AWS.Server.Start( 
      Signal_Handler.aws_web_server,
      Dispatcher => my_dispatcher,
      Config     => my_config );
   Log( "started the server" );
   
   AWS.Server.Wait( AWS.Server.forever );
   Log( "server shutting down" );
end LA_Server;
