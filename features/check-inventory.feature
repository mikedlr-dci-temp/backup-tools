Feature:
In order to know if may backup is corrupt I would like to be able to
check my files against my inventory.

    Scenario: backup matches with inventory.  
    Given that I have access to basic-test-data-directory
    and that I have made an inventory file for that directory
    when I run inventory -c on the inventory file
    then the command should succeed
    and there should be no output

    Scenario: verbose check gives full output
    Given that I have access to basic-test-data-directory
    and that I have made an inventory file for that directory
    when I run inventory -c -v on the inventory file
    then the command should succeed
    and there should be output showing that files are okay

    Scenario: a file doesn't match inventory.  
    Given that I have access to basic-test-data-directory
    and that I have made an inventory file for that directory with one file corrupted
    when I run inventory -c on the inventory file
    then the command should fail
    and print out the corrupted filename

    Scenario: a file is missing
    Given that I have access to basic-test-data-directory
    and that I have made an inventory file for that directory with one additional file
    when I run inventory -c on the inventory file
    then the command should fail
    and print out the missing filename


