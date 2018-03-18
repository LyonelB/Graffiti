$ sudo apt-get install autoreconf libtool libtool-bin
$ git clone https://github.com/mstorsjo/fdk-aac.git
$ cd fdk-aac
$ ./autogen.sh --host=arm-unknown-linux-gnueabi --enable-static --enable-shared
$ ./configure --enable-shared --enable-static
$ make -j4
$ sudo make install
$ sudo ldconfig
$ cd

$ opam install fdkaac
