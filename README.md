Modelling Local Authorities Using the Family Resources Survey
=============================================================
July 2013

This little piece of code takes an [FRS](https://www.gov.uk/government/organisations/department-for-work-pensions/series/family-resources-survey--2)
dataset and produces sample weights that 
makes the dataset (or a subset of it) match 2011 Census data for each local authority 
in England and Wales. So in principle you can treat the whole FRS sample as if it came from
that Local Authority. The weight generator uses a technique described in [Survey
Reweighting for Tax Microsimulation
Modelling](http://ideas.repec.org/p/nzt/nztwps/03-17.html) by John Creedy.

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

It works quite well still needs a lot of work. I still need to scale income
and housing cost variables up - Westminster has higher average wages than
Doncaster both because of because it has more bankers, and because Westminster
bankers are paid more than Doncaster ones. Likewise for housing costs. But that
looks doable. And the code is not at all well organised: I can see a much
cleaner way of doing by dumping everything we want into a database and running
queries to produce subsets. But this is a start.

The directories contain:

data/ - contains downloaded aggregate census data for Local Authorities, and
these dumped as CSV files.

scripts/ - some code in [Ruby](http://ruby-lang.org) that parses the CSV files into
enumerated types and data declarations for use in the Ada code.

src/ Ada Source files (see below)

tests/ test driver code - at present, the only way to drive it is through the
test code.

You need [Tax Benefit Model Components](https://github.com/tax_benefit_model_components/),
and the dependencies described in that for the Ada code. You'd need to follow
the instructions there on creating raw FRS files - no chance, probably...

tests/ contains a AUnit V3 Test Suite, basically just a driver for the generator
at the moment.
