Modelling Local Authorities Using the Family Resources Survey
=============================================================
July 2013

This is a little piece of code put together as part of an unsuccessful project
bid (such is life..) Hopefully, someone will find it useful (perhaps even the
people who won the bid..).

It takes an FRS dataset and produces sample weights that makes the dataset (or a
subset of it) match 2011 Census data for each local authority in England and
Wales. So in principle you can treat the whole FRS sample as if it came from
that Local Authority. The weight generator uses a technique described in [Survey
Reweighting for Tax Microsimulation
Modelling](http://ideas.repec.org/p/nzt/nztwps/03-17.html]) by John Creedy.

It currently matches Census totals for:
 * Gender;
 * Age Group;
 * Race
 * Tenure Type;
 * Number of Rooms;
 * Employment Status;
 * Occupation
 * receipts various benefits

To make sure the routine finds a solution, the categories had to be aggregated
somewhat (quite broad age groups and so on). The code can produce weights for
the whole FRS, or for samples of it, for instance the LA's enclosing Government
Region (reweighting all Londoners to look like Lewisham or Westminster.)

It works quite well still needs a lot of work. I want to add benefit counts and
a few other things to the target variables. And I'd still need to scale income
and housing cost variables up - Westminster has higher average wages than
Doncaster both because of because it has more bankers, and because Westminster
bankers are paid more than Doncaster ones. Likewise for housing costs. But that
looks doable. And the code is not at all well organised: I can see a much
cleaner way of doing by dumping everything we want into a database and running
queries to produce subsets. But this is a start.

The directories contain:

data/ - contains downloaded aggregate census data for Local Authorities, and
these dumped as CSV files.

scripts/ - some code in [Ruby](http://ruby.org) that parses the CSV files into
enumerated types and data declarations for use in the Ada code.

src/ Ada Source files (see below)

tests/ test driver code - at present, the only way to drive it is through the
test code.

You need [Tax Benefit Model Components](http://virtual-worlds.biz/downloads/),
and the dependencies described in that for the Ada code. You'd need to follow
the instructions there on creating raw FRS files - no chance, probably...

The file src/la_reweighter.ads contains 'public' definitions of local
authorities, target variables and regions, as well as the public signature of
the reweighting procedure.

src/la_reweighter.adb contains the actual code. Reweighting works in two passes,
one to generate 'flat' files of FRS data matching the Local Authority targets,
and one to actually generate the weights. The code can be called to generate
data and weights for the whole sample, England and Wales, England Only, and by
Government Region.

tests/ contains a AUnit V3 Test Suite, basically just a driver for the generator
at the moment.

It's a bit of a mess, relying on multiple passes through the FRS dataset where
only 1 would do and requireing a different run each time the target definitions
change. Also, not many comments.

Better scheme would be:

 * make a database from FRS with everything that we have counts for for the LAs
 * construct a dataset on the fly using the same mappings for the LA and the FRS dataset
 * have a simple driver routines
 * create_frs_subset [SQL Query] [outfile]
 * create_weights [dataset] [targets] [settings_file]
 
outputs/ needs a directory structure like:

   output/
    ├── [Name of your Dataset]
    │   ├── created_datasets
    │   └── weights
    │   ├── england
    │   ├── england_and_wales
    │   ├── government_region
    │   └── whole_sample

This archive doesn't contain the actual generated weights. 
