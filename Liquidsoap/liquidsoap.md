    $ sudo apt-get update
    $ sudo apt-get upgrade
    $ sudo apt-get install dh-autoreconf libtool libtool-bin    
    $ mkdir src && cd src
    $ wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master 
    $ tar xzvf fdk-aac.tar.gz 
    $ cd mstorsjo-fdk-aac* 
    $ autoreconf -fiv 
    $ ./configure --enable-shared 
    $ make -j2 
    $ sudo make install
    $ sudo ldconfig
    $ cd
    $ sudo apt-get install opam m4
    $ sudo adduser liquidsoap
    $ sudo adduser liquidsoap audio
    $ su liquidsoap
    $ cd
    $ opam init #répondre "y"
    $ exit
    $ su liquidsoap
    $ opam update
    $ opam install depext    
   
Attention à ne pas installer les paquets à cette étape → répondre "non"   
   
    $ opam depext taglib mad lame vorbis cry pulseaudio liquidsoap fdkaac ladspa
    $ exit
    $ sudo apt-get install libmp3lame-ocaml-dev libtaglib-ocaml-dev libalsa-ocaml-dev libpulse-ocaml-dev libmad-ocaml-dev libcry-ocaml-dev libvorbis-ocaml-dev libogg-ocaml-dev libopus-ocaml-dev ladspa-sdk
    $ su liquidsoap
    $ opam install lame pulseaudio mad alsa taglib cry opus liquidsoap fdkaac ladspa
    $ exit
    $ sudo ln -s /home/liquidsoap/.opam/system/bin/liquidsoap /usr/bin/liquidsoap
    $ sudo mkdir /etc/liquidsoap
    $ sudo nano /etc/liquidsoap/radio.liq

    #!/usr/bin/liquidsoap
    set("log.file.path", "/tmp/basic-radio.log")  
    set("alsa.alsa_buffer", 3)
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

    $ sudo chmod +x /etc/liquidsoap/radio.liq
    $ sudo touch /tmp/basic-radio.log
    $ sudo chown -R pi /tmp/basic-radio.log

### Supervisor

    $ sudo apt-get install supervisor
    $ mkdir config && cd config
    $ mkdir supervisor && cd supervisor
    $ wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/Liquidsoap/liquidsoap.conf
    $ cd
    $ sudo ln -s /home/pi/config/supervisor/liquidsoap.conf /etc/supervisor/conf.d/liquidsoap.conf
    $ sudo nano /etc/supervisor/supervisord.conf    

Ajoutez les lignes suivantes

    [inet_http_server]
    port = 9300
    username = user ; Auth username
    password = pass ; Auth password

    [eventlistener:supermail]
    command=python /usr/local/bin/supermail.py -a -m mail@domain.com -o "[Liquidsoap]"
    events=PROCESS_STATE

### Supermail

    $ sudo apt-get install sendmail
    $ cd /usr/local/bin
    $ sudo wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/darkice-supervisor/supermail.py
    $ cd
    $ sudo /etc/init.d/supervisor restart
    $ sudo supervisorctl reread
    $ sudo supervisorctl update
    $ sudo chown -R pi /var/log/supervisor/liquidsoap.log    
    $ sudo reboot
