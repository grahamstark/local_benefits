--
-- copyright(c) 2011 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)/ Howard Reed, Landman Economics (howard@landman-economics.co.uk)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
--
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
--
-- /////////////////////////////

pragma License( Modified_GPL );

with Ada.Strings.Unbounded;

--
-- This contains settings which are constant across all runs, including (this may be a cross-dependency mistake)
-- information on the web application. Some.
--
package Model.LA_Global_Settings is

   procedure Read_Settings( filename : String );

   function Log_Config_File_Name return String;
   function Physical_Root return String;
   function Web_Root return String;
   function Tmp_Dir return String;
   function Template_Components_Path return String;
   function Port return Positive;
   function Dir_Separator return String;
   function Working_Root return String;
   
   procedure Initialise_Logging( filename : String := "" );
   
end Model.LA_Global_Settings;
