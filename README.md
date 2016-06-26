## Backup tools Synopsis

This is a project for tools to help with backup management.  Currently
there is only one tool - inventory

## Inventory

This is a simple tool to record an inventory of a directory.  That
inventory should then be stored with the backup and also as a record
of the backup elsewhere.

The backup can then be verified against the inventory.  For example

   inventory features/test-data/basic-testdir/ -o basic.inventory

will create an inventory file basic.inventory

   inventory -c features/test-data/basic-testdir/ -o basic.inventory

Compared to a simple use of sha256sum

  * inventory verifies the integrity of it's own file with an overall checksum
  * inventory records meta data such as the time of the backup and the directory name
  * inventory allows you to exclude files that you don't want backed up

### Options

    -h --help

output usage information

 -c --check

Reads an already existing inventory file and verifies the files
listed in it.  N.B. files not listed in the inventory will be ignored
and will not trigger a warning.

 -v --verbose - verbose output

Will output the checksums of the files being checked and other similar
verbose information.

 -o --output <file> - output to <file>

Gives the file to output the inventory to.  Will not work with -c to
protect against accidental overwriting.

 -i --input <file> - use <file> for input (as an inventory file), together with -c

Gives the file to read the inventory from whilst checking the inventory.

 -x --exclude <file>

Gives the name of a file to read exclude expressions from.  This
format will probably change in a future version of inventory.
Currently it is used directly by find and to exclude files named
'.cache' you would use an exclude pattern as follows:

    */.cache*

### Security

The backup file should be secure against accidental damage but not
against malicious modification.  If you want to verify that the
inventory file has not been tampered with then use GPG separately to
sign the inventory file.

If someone or something else has control of a directory that you are
checksumming then they could force you to checksum a file you weren't
expecting to checksum and prove that you have access to that file.
This doesn't seem serious but don't do that anyway.

## Installation (for local machine administrators)

run

    sudo make install

or just copy inventory.sh to a directory in your path as `inventory`


## Development

* please install shellcheck and python including python-behave
* use `behave-2` or `behave` to run your tests

## License

Unless mentioned otherwise software in this collection is licensed
under the GNU AFFERO GENERAL PUBLIC LICENSE Version 3.  Please see
https://www.gnu.org/licenses/agpl.html