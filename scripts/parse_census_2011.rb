#!/usr/bin/ruby
require 'utils'
require 'csv'
# require 'amatch' # fuzzy searching from http://flori.github.io/amatch/doc/index.html

$enumeratedTypes = []
$las = []
DATA_PATH='/home/graham_s/VirtualWorlds/projects/local_benefits/data/nomis_dwp_hmrc/csv/'
$numFiles= 0
$properNames = {}

def writDataLines( outfile )
        nlas = $las.length
        nlas.times(){
                |i|
                la = $las[i]
                # outfile.write( "      #{la} => ( " );
                outfile.write( "      ( " );
                data = $dataset[la]
                nd = data.length
                nd.times(){
                        |j|
                        outfile.write( "#{data[j]}" )
                        if( j < nd-1)then
                                outfile.write(", ")
                        end
                }

                outfile.write( " )" );
                if( i < nlas-1 )then
                        outfile.write( ",\n" )
                else
                        outfile.write( ")\n\n" )
                end
        }
end

def writeEnum( outfile, name, values )
        n = values.length;
        outfile.write(   "type #{name} is (\n" )
        n.times{
                |i|
                outfile.write( "      #{values[i]}" )
                if( i < (n-1))then
                        outfile.write( ",\n" )
                else
                        outfile.write( " );\n\n" )
                end
        }
end

def matchToLANames( laname )
      puts "matchToLANames: LANAME #{laname}"
      enumla = "UNMATCHED |#{laname}|"
      if( laname =~ /(.*) *UA/)then
           laname = $1.strip()
      elsif( laname =~ /(.*) *\/.*/)
           laname = $1.strip()
      end
      if( not $properNames[laname].nil? )then
              enumla = $properNames[laname]
              puts "MATCHED TO #{enumla}"
              $properNames.delete( laname )
      end
      return enumla
end

# 
# these are the hb and ct sheets from
# http://statistics.dwp.gov.uk/asd/asd1/hb_ctb/index.php?page=hbctb_arc
# and are in a 
def parseHBFile( filename, prefix )
	row = 0;
	$numFiles += 1
	file = File.open( DATA_PATH+filename+".csv", 'rb' );
	puts "opened #{filename}" ;
	CSV::Reader.parse( file, ',' ){
		|elements|
		row+=1;
		# print "on line #{row}"
		if( row == 7 )then ## parse top line into an array of variable names
		       col = 0
		       elements.each{
		               |cell|
				col+=1;
				p cell
				if( col > 4 ) and ( not cell.nil? ) then
                                      varname = cell.data; 
                                      en = "#{prefix}_#{varname}"
                                      enumName = stringToEnum( en ).downcase()
                                      puts "enumName #{enumName}"
                                      $enumeratedTypes << enumName;
                              end
                       }
               elsif row > 7 then
                       if(( elements[1].nil?) and ( not elements[2].nil?))then
                               laname = matchToLANames( elements[2].data.strip())
                       elsif(( not elements[1].nil? ) and ( not elements[4].nil? ))then 
                               laname = matchToLANames( elements[1].data.strip())
                       end 
                       puts "laname #{laname}"
		end
	}
	        
end

#
# 
#
def parseOneFile( filename )
	row = 0;
	$numFiles += 1
	file = File.open( DATA_PATH+filename+".csv", 'rb' );
	puts "opened #{filename}" ;
	CSV::Reader.parse( file, ',' ){
		|elements|
		row+=1;
		# print "on line #{row}"
		if( row == 8 )then ## parse top line into an array of variable names
		        col = 0;
			elements.each{
				|element|
				col+=1;
				p element
				varname = element.data;
				if( col > 1 )then
				        en = "#{filename}_#{varname}"
				        enumName = stringToEnum( en ).downcase()
				        # puts "enumName #{enumName}"
				        $enumeratedTypes << enumName;
			        end
			}
		elsif( row > 8 )then
		        col = 0;
                        laenum = ''
			elements.each{
				|element|
				col+=1
				varname = element.data;
                                if( col == 1 )then
                                        laenum = stringToEnum( varname ).downcase()
                                        puts "laenum #{laenum}"
                                        if( $numFiles == 1 )then
                                                $las << laenum
                                                $dataset[laenum] = []
                                                puts "varname |#{varname}|"
                                                if( varname =~ /uacounty09:(.*)/) or ( varname =~ /ualad09:(.*)/ )then
                                                        propername = $1;
                                                        puts "new propername |#{propername}| laenum |#{laenum}|"
                                                        $properNames[ propername ] = laenum
                                                end
                                                # reverse lookup proper name
                                                
                                        end
                                elsif( col > 1 )then
				        count = cleanupRealNumberToAda( element.data )
				        # puts "col #{col} count #{count} laenum #{laenum}"
				        $dataset[laenum] << count
			        end
			}
		end
		
	}
end


targets = [ 
        "genders",
        "age_ranges",
        "accomodation_type",
        "economic_activity",
        "ethnic_group",
        "household_composition",
        "number_of_rooms",
        "residence_type",
        "tenure_type",
        "occupation",
        "income_support",
        "pension_credits"
]

targets.each{
        |target|
        parseOneFile( target )
}

p $enumeratedTypes
p $las;

deffile = File.new( "weights.adb", 'w' );
writeEnum( deffile, "Local_Authorities", $las )
writeEnum( deffile, "Weight_Targets", $enumeratedTypes )
writDataLines( deffile )
deffile.close()

p $dataset

p $properNames

parseHBFile( "hb_by_passport_status_and_la", "hb" )

puts "unmatched main "
p $properNames
