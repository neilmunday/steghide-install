# steghide-install

steghide-install provides patches and a build script to compile and install [StegHide](http://steghide.sourceforge.net>) on modern Linux installations.

The patch files used here are from from Arch Linux (see https://git.archlinux.org/svntogit/community.git/tree/trunk?h=packages/steghide). Credit to the maintainers for creating these patches.

Tested on CentOS 7 (x86_64).

Required Packages
-----------------

You will need to install (e.g. via yum):

* autoconf
* gcc
* gcc-c++
* libjpeg-turbo-devel
* libmcrypt-devel
* libtool
* make
* mhash-devel
* patch

Why create this script?
-----------------------

After trying (and failing) to build StegHide on CentOS I found many other users in the same situation as me. I therefore decided to share these files in the hope that others can use StegHide on CentOS (and similar distributions).
