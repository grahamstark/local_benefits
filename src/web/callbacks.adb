------------------------------------------------------------------------------
--                                                                          --
--  Handlers for each of OSCR's callbacks, plus some support functions      --
--                                                                          --
-- This is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
--                                                                          --

with AWS.Config;
with AWS.Messages;
with AWS.Mime;
with AWS.Resources;
with AWS.Response.Set;
with AWS.Response;
with AWS.Server;
with AWS.URL;

with Ada.Containers;
with Ada.Directories;
with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Strings.Unbounded;
with Ada.Strings;
with Ada.Text_IO;
with Ada.Characters.Handling;

with GNAT.Regexp;
with Base_Model_Types;

with GNATColl.Traces;
with Text_Utils;
with Utils;
with Web_Utils;
with HTML_Utils;

with La_Data_Data;
with Las_Type_IO;

with Model.FRS_Reweighter;
with Model.FRS_Reweighter.HTML;

package body Callbacks is

   use Ada.Text_IO;
   use Text_Utils;
   use Ada.Strings.Unbounded;
   package chars renames Ada.Characters.Handling;
   package euws  renames Model.LA_Global_Settings;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "CALLBACKS" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   function Serve_Static_Resource( Request : in AWS.Status.Data ) return AWS.Response.Data is
      use Ada.Strings;
      WWW_Root : constant String := AWS.Config.WWW_Root( AWS.Server.Config( AWS.Server.Get_Current.all ));
      URI      : constant String := AWS.Status.URI( Request );
      root     : constant String := euws.Web_Root;      
      filename : constant String := WWW_Root & root & URI ( root'Last .. URI'Last );
   begin
      Log(  "serving |" & filename & "| URI was |" & URI & "| root |" & root & "| WWW_Root |" & WWW_Root & "|" );
      if AWS.Resources.Is_Regular_File( filename ) then
         return AWS.Response.File( 
            Content_Type => AWS.MIME.Content_Type( filename ),
            Filename     => filename );
      else          
         return AWS.Response.Acknowledge
              (AWS.Messages.S404,
               "<p>The page '"
               --  Replace HTML control characters to the HTML inactive symbols
               --  to avoid correct HTML pages initiated from the client side.
               --  See http://www.securityfocus.com/bid/7596
               & Fixed.Translate (URI, Maps.To_Mapping ("<>&", "{}@"))
               & "' was not found.");
      end if;         
   end Serve_Static_Resource;
   
   function Get_Std_Translations( request : in AWS.Status.Data ) return Templates_Parser.Translate_Set is
   use Templates_Parser;
      URI    : constant String := AWS.Status.URI( Request );
      translations : Translate_Set;
   begin
      Insert( translations, Assoc( "TEMPLATE_ROOT",  euws.template_components_path ));
      Insert( translations, Assoc( "SEP", euws.Dir_Separator ));
      Insert( translations, Assoc( "ROOT", euws.Web_Root ));
      Insert( translations, Assoc( "RANDOM_STRING", Utils.Random_String ));
      Insert( translations, Assoc( "URI", URI ));
      return translations;
   end Get_Std_Translations;
   
   function Index_Page_Callback( request : in AWS.Status.Data ) return AWS.Response.Data is
   use Templates_Parser;  
      session_id   : constant AWS.Session.Id := AWS.Status.Session( request );
      URI          : constant String := AWS.Status.URI( request );
      url          : constant AWS.URL.Object := AWS.Status.URI( request ); 
      params       : constant AWS.Parameters.List := AWS.Status.Parameters( request );
      translations : Translate_Set;
      path         : Unbounded_String_List := Split( URI, '/' );
      laname       : Unbounded_String;
      la           : La_Data_Data.LAs_Type;
      la_string    : constant String := AWS.URL.Parameter( url, "code" );
      la_code      : Unbounded_String;
   begin
       -- Handle_Language( path, logresult.user, session_id );
      translations := Get_Std_Translations( request );
      
      Log( "got la_string as |" & la_string & "| " ); 
      if( la_string /= "" )then
         la_code := TuS( la_string );
      else
         la_code := TuS( "E06000005" ); -- darlington; 1st in the menu
      end if;
      la := Las_Type_IO.Retrieve_By_PK( la_code );
      
      Log( "got LA as " & La_Data_Data.To_String( la ));
      Insert( translations, Assoc( "LA-NAME", la.name ));

      Insert( translations, Assoc( "INPUT-SECTION", 
         Model.FRS_Reweighter.HTML.Handle_Input_Page( request, la )));
      return Web_Utils.Build_Input_Page(
         euws.template_components_path & "index",
         translations );
   end Index_Page_Callback;

 function CSV_File_Callback( request : in AWS.Status.Data ) return AWS.Response.Data is
      URI          : constant String := AWS.Status.URI( request );
      params       : constant AWS.Parameters.List := AWS.Status.Parameters( Request );
      file_base    : constant String := params.Get( "filename" );
      filename     : constant String := euws.Tmp_Dir & euws.Dir_Separator & file_base & ".csv";
   begin
      Log( "CSV Callback Entered" );
      return AWS.Response.File(
            Content_Type  => "text/csv",
            Filename      => filename,
            Disposition   => AWS.Response.Attachment,
            User_Filename => "weights.csv" );         
   end CSV_File_Callback;

end Callbacks;
