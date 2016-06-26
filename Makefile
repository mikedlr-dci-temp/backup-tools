install:
	install -o root -g root inventory.sh /usr/local/bin/inventory

home_exclude: excludes-info/home-ignore-list
	sed -e '/^[ 	]*$$/d' -e '/^[  ]*#/d' -e '/[ 	][ 	]*#/d'  -e 's,^,*/,' excludes-info/home-ignore-list > home-exclude
