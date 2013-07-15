#!/usr/bin/ruby
require 'utils'
require 'csv'
#
# This program parses nomis_dwp_hmrc data from nomis (http://www.nomisweb.co.uk/articles/696.aspx)
# and the DWP for HB at CTB (http://statistics.dwp.gov.uk/asd/asd1/hb_ctb/index.php?page=hbctb_arc) 
# into a single dataset with a row for each LA.
# each dataset is a single csv file dumped via openoffice from the original .xls files.
# DWP files have a different layout & are extracted from single sheets of the main HB data dump.
# The DWP file has edited names for Anglesey ('Isle of' removed) and King's Lynne (apostrophe)
# the HMCR file has LA codes and is merged on those.
# Some of the files have edited headers so the names fit 
# Only the LAs in the DWP dataset
# are merged in; the Nomis dataset also includes some aggregate things like Leicestershire
# needed outputs:
# the dataset, one for each individual LAs
# list of county(?) aggregates
# list of government region aggregates
# TODO: there are later population forecasts than the 2011 nomis_dwp_hmrc
#       wages and housing costs somehow 
# family credit from:
# http://www.hmrc.gov.uk/statistics/prov-geog-stats.htm

EDITION  = 1
DATA_PATH = '/home/graham_s/VirtualWorlds/projects/local_benefits/data/nomis_dwp_hmrc/csv/'
GENERATED_CODE_PATH = '/home/graham_s/VirtualWorlds/projects/local_benefits/output/generated_code/'
$enumeratedTypes = []
$regionToLas = []
$las = {}
$namesInOrder = []
$unmatched = {}
$keyToName = {}

class LARec
        
        attr_reader :name, :data, :key, :fullMatched, :frs_region, :region
        attr_writer :name, :data, :key, :fullMatched, :frs_region, :region
        
        def initialize( name )
                puts "initialsed #{name}"
                @name = name
                @data = []
                @key = ''
                @fullMatched = true
        end 
end



##
# mill definitions, just the bits for the enum type
#
def writeMillXML( filename )
	f = File.open( GENERATED_CODE_PATH+filename, 'w' );
	f.write( '<?xml version="1.0"  encoding="ISO-8859-1"  standalone="no" ?>'+"\n" )
	f.write( '<!DOCTYPE database PUBLIC "http://virtual-worlds.biz/Mill"  "http://www.virtual-worlds.biz/dtds/mill.dtd">'+"\n" )
	f.write( '<database name="la_data">'+"\n" )
	f.write( "        <table name='target_candidates' description='One row for each Council/FRS household' >\n" );
        f.write( "                <column name='id' type='INTEGER' primaryKey='true' />\n" )
        f.write( "                <column name='code' type='CHAR' size='10' primaryKey='true' />\n" )
        f.write( "                <column name='edition' type='INTEGER' primaryKey='true' />\n" )
        f.write( "                <column name='frs_region' type='INTEGER' required='true' />\n" )

	$enumeratedTypes.each{
                |et|
                f.write( "                <column name='#{et}' type='REAL' />\n" )
        }
        f.write( "        </table>\n\n")
        f.write( "</database>\n\n")        
        f.close()
end

def writeEnum( filename, enumname )
        f = File.open( GENERATED_CODE_PATH+filename, 'w' );
        f.write(   "type #{enumname} is (\n" )
        n = $enumeratedTypes.length;
        n.times{
                |i|
                f.write( "      #{$enumeratedTypes[i]}" )
                if( i < (n - 1))then
                        f.write( ",\n" )
                else
                        f.write( " );\n\n" )
                end
        }
        f.close()
end

def writeCSVFile( filename, edition )
        f = File.open( GENERATED_CODE_PATH+filename, 'w' );
        $namesInOrder.each(){
                |laname|
                la = $las[ laname ]
                if( not $unmatched.has_key?( laname ))then
                        f.write( "1\t#{la.key}\t#{edition}\t#{la.frs_region}\t" )
                        f.write( la.data.join( "\t" )+"\n" )    
                end; 
        }
        f.close()            
end;

def addCodes( filename )
	file = File.open( DATA_PATH+filename+".csv", 'rb' );
	puts "opened #{filename}" ;
	CSV::Reader.parse( file, ',' ){
	        |line|
	        laname = line[0].data
	        if( laname =~ /ualad09:(.*)/ )then # we only want district ones, so we match the DWP data
	                laname = $1.gsub(/[`’']/, "");
	                key = line[1].data
	                region = line[2].data
	                frs_region = line[3].data.to_i
	                if( $las.has_key?( laname ))then
                                $las[laname].key = key
                                $las[laname].frs_region = frs_region
                                $las[laname].region = region                                
                                $keyToName[key] = laname
                        else
                                puts "addCodes UNMATCHED |#{laname}|"
                        end
                end
	}
       file.close()
end
# 
# the data is a manually cleaned up version of 2 sheets from
# http://statistics.dwp.gov.uk/asd/asd1/hb_ctb/index.php?page=hbctb_arc
# with all but the disaggregated data removed, and scotland removed
# and the 2 sheets merged, and apostrophes deleted and 'Isle of' removed from Anglesey
#
def parseHBFile( filename )
	rowNum = 0;
	file = File.open( DATA_PATH+filename+".csv", 'rb' );
	puts "opened #{filename}" ;
	CSV::Reader.parse( file, ';' ){
		|row|
		rowNum+=1;
		puts "rowNum #{rowNum}"
		numCols = row.length-1;
               if( rowNum == 1 )then ## parse top line into an array of variable names
                        (1 .. numCols ).each{
		               |colNum|
		               puts "col #{colNum}"
		               varname = row[colNum].data; 
		               enumName = stringToEnum( varname ).downcase()
                              puts "enumName #{enumName}"
                              $enumeratedTypes << enumName;
                       }
               else
                      laname = row[0].gsub(/[`’']/, "");
                      $namesInOrder << laname
                      $las[laname] = LARec.new( laname )
                      (1 .. numCols).each{
                              |colNum| 
				count = cleanupRealNumberToAda( row[colNum].data )
				$las[laname].data << count
		      }
		end
	}
end

def addHmrcTaxCredits( filename )
   	file = File.open( DATA_PATH+filename+".csv", 'rb' );
	puts "opened #{filename}" ;
	rowNum = 0
	CSV::Reader.parse( file, ',' ){
		|row|
		rowNum += 1
		numCols = row.length - 1;
		if( rowNum == 1)then
		        (2 .. numCols).each{
                                |colNum|
                                varname = row[colNum].data;
                                en = "#{varname}"
                                enumName = stringToEnum( en ).downcase()
                                $enumeratedTypes << enumName;
                        }
	        else
                        code = row[0].data
                        
                        if( $keyToName.has_key?(code))then
                                laname = $keyToName[ code ]
                                puts "addHmrcTaxCredits: matched LA #{laname}"
                                $keyToName.delete(code)
                                (2 .. numCols).each{
                                        |colNum|
                                        count = cleanupRealNumberToAda( row[colNum].data )
                                        $las[laname].data << count.gsub( /_/, '' );
                                }
                        end
                end
	}
end

#
# 
#
def parseOneFile( filename )
	rowNum = 0;
	file = File.open( DATA_PATH+filename+".csv", 'rb' );
	puts "opened #{filename}" ;
	CSV::Reader.parse( file, ',' ){
		|row|
		rowNum+=1;
		numCols = row.length - 1;
		if( rowNum == 8 )then ## parse top line into an array of variable names
                        (1 .. numCols).each{
                                |colNum|
                                varname = row[colNum].data;
                                en = "#{filename}_#{varname}"
                                enumName = stringToEnum( en ).downcase()
                                $enumeratedTypes << enumName;
                        }
		elsif( rowNum > 8 )then
                        laname = row[0].data;
                        if( laname =~ /ualad09:(.*)/ )then # we only want district ones, so we match the DWP data
                                laname = $1.gsub(/[`’']/, "");
                                if( $las.has_key?( laname ))then
                                        (1 .. numCols).each{
                                                |colNum|
                                                count = cleanupRealNumberToAda( row[colNum].data )
                                                $las[laname].data << count.gsub( /_/, '' );
                                        }
                                else
                                        $unmatched[ laname ] = laname
                                        puts "Unmatched #{laname}"
                                end
                        end
                end
	}
end

parseHBFile( "hb_by_passport_status_and_la_edited" )

nomis_target_files = [ 
        "genders",
        "age_ranges",
        "accom",
        "ec_act",
        "ethgrp",
        "hcomp",
        "number_of_rooms",
        "residence",
        "tenure",
        "occupation",
        "income_support",
        "jsa",
        "pension_credits"
]
#
#        "wages" needs parsed
#
nomis_target_files.each{
        |target|
        parseOneFile( target )
}


#writeEnum( deffile, "Local_Authorities", $las )
#writeEnum( deffile, "Weight_Targets", $enumeratedTypes )
#writDataLines( deffile )
#deffile.close()

p $las
addCodes( "code_to_la_mapping" )

p $keyToName


addHmrcTaxCredits( "hmrc_tax_credits_geographical_breakdowns_may_2013" )

writeMillXML( "database-schema.xml")
writeEnum( "enumfile", "Target_Variables")
writeCSVFile( "merged_la_data.tab", EDITION );

puts "unmatched from HMRC code"; p $keyToName
