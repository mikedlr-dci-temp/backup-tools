Feature:
In order to check if my backups have worked I would like a clear
inventory file which lists all of the files in my directory.

Scenario: record checksums for files
Given that I have access to basic-test-data-directory
when I run inventory on that directory
then for each file the <filename> should be listed with the <checksum>
     | filename   | checksum                                                                                         |
     | ./empty      | 38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b |
     | ./hi         | 4284b5694ca6c0d2cf4789a0b95ac8025c818de52304364be7cd2981b2d2edc685b322277ec25819962413d8c9b2c1f5 |
     | ./randomfile | 3004c786f0513006058dfd6c593536365c103af3047d0346b87a8898565e0e75caf0c06d3d760b6915a375ed66a6591c |
and "emptydirectory" should not be present

Scenario: provide header and footer
Given that I have access to basic-test-data-directory
when I run inventory on that directory
then at the beginning of the file should be a header with the filetype
and in the header should be date information and the titled directory name
and there should be a footer with a checksum
