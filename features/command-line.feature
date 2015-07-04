Feature:
Command line argument handling

@wip
Scenario: with -o argument create file 
Given that I have access to basic-test-data-directory
and that I have a target-file that doesn't exist
when I run inventory on the test data with -o on the directory
then the inventory file should be created

@wip
Scenario: too many -o arguments 
Given nothing much
when I run inventory with two -o arguments
then it should abort with a failure

@wip
Scenario: with no arguments bomb out
Given nothing much
when I run inventory with no arguments
then it should abort with a failure


