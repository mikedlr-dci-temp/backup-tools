Feature:
Command line argument handling

Scenario: with -o argument create file 
Given that I have access to basic-test-data-directory
and that I have a target-file that doesn't exist
when I run inventory on the test data with -o on the directory
then the inventory file should be created

Scenario: too many -o arguments 
When I run inventory with two -o arguments
then it should abort with a failure

Scenario: input file when building inventory
When I run inventory without -c or --check and with an input file
then it should abort with a failure

Scenario: output file when checking inventory
When I run inventory with -c and with an output file
then it should abort with a failure

Scenario: give help text for --help option
When I run inventory with --help 
then it should output a help text

Scenario: with no arguments bomb out
When I run inventory with no arguments
then it should abort with a failure


