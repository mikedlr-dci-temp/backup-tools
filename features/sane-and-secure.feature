Feature:
inventory-check should be written in a reasonably sensible form of bash language

Scenario: input file when building inventory
Given nothing much
when I run shellcheck on inventory.sh
then the command should succeed

