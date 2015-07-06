Feature:
in order to avoid surprising bugs and security flaws, inventory-check
should be written in a reasonably sensible form of bash language and
try to avoid dangerous constructs.

Scenario: input file when building inventory
Given nothing much
when I run shellcheck on inventory.sh
then the command should succeed

