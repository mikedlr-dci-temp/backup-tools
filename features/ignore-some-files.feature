Feature: ignore some files when doing the inventory

Scenario: exclude unwanted directories
	Given that I have an excludes file excluding a .cache directory
	When I run inventory using that excludes file
	Then the .cache directory should not be included in the inventory
	and the keep-dir and keep-file should be included in the inventory

Scenario: warn about missing excludes file
	Given that I have an excludes file name that doesn't exist
	When I run inventory using that file name
	Then the program should return an error