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

    !/usr/bin/liquidsoap
    set("log.file.path", "/var/log/supervisor/liquidsoap.log")

    stream = input.alsa(device="plughw:1,0")

    output.icecast(%fdkaac(channels=2, samplerate=48000, bitrate=64,afterburner=false, transmux="adts", sbr_mode=false,),
    host = "xxxxxxxxx",
    port = 8000,
    password = "xxxx",
    mount = "graffiti",
    name="Graffiti Urban Radio",
    description="Fournisseur de Bonnes Ondes",
    url="http://www.urban-radio.com",
    genre="alternative",
    stream)


