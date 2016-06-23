Feature: ignore some files when doing the inventory

Scenario:
	Given that I have an excludes file excluding a cache file
	When I run inventory using that excludes file
	Then the cache file should be ignored