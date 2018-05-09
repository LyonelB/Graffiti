## Compilation de Liquidsoap et prise en charge MP3 et AAC+ (HE AAC V2)   
Installation sur un pc avec Debian Stretch sans interface graphique. Utilisateur : debian

    $ su
    $ apt-get update
    $ apt-get upgrade
    $ apt-get install sudo
    $ visudo -f /etc/sudoers
    <Ajoutez la ligne suivante après “root All=(ALL:ALL) ALL”>
    <debian ALL=(ALL:ALL) ALL>
    $ exit
    $ sudo apt-get install dh-autoreconf libtool libtool-bin git
    $ mkdir src && cd src
    $ git clone https://github.com/Opendigitalradio/fdk-aac.git
    $ cd fdk-aac
    $ ./bootstrap
    $ ./configure
    $ make
    $ sudo make install
    $ sudo ldconfig
    $ cd
    $ sudo apt-get install opam m4
    $ sudo adduser liquidsoap
    $ sudo adduser liquidsoap audio
    $ su liquidsoap
    $ cd
    $ opam init
    <y>
    $ exit
    $ su liquidsoap
    $ opam update
    $ opam install depext
    $ opam depext taglib mad lame vorbis cry pulseaudio liquidsoap fdkaac ladspa shine
    <n>
    $ exit
    $ sudo apt-get install libmp3lame-ocaml-dev libtaglib-ocaml-dev libalsa-ocaml-dev libpulse-ocaml-dev libmad-ocaml-dev libcry-ocaml-dev libvorbis-ocaml-dev libogg-ocaml-dev libopus-ocaml-dev ladspa-sdk libshine-dev
    $ su liquidsoap
    $ opam install lame pulseaudio mad alsa taglib cry opus liquidsoap fdkaac ladspa shine
    <y>
    $ exit
    $ sudo ln -s /home/liquidsoap/.opam/system/bin/liquidsoap /usr/bin/liquidsoap
    $ sudo mkdir /etc/liquidsoap
    $ cd /etc/liquidsoap
    $ sudo wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/Debian/radio.liq
    $ cd
    $ sudo nano /etc/liquidsoap/radio.liq
    <modifier les lignes començant par "host" et "password"; enregistrez et quittez>
    $ sudo chmod +x /etc/liquidsoap/radio.liq
    $ mkdir stream
    $ touch stream/radio.log
    $ sudo chown -R debian /home/debian/stream/radio.log
    
### Supervisor

    $ sudo apt-get install supervisor
    $ mkdir config && cd config
    $ mkdir supervisor && cd supervisor
    $ wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/Debian/liquidsoap.conf
    $ cd
    $ sudo ln -s /home/debian/config/supervisor/liquidsoap.conf /etc/supervisor/conf.d/liquidsoap.conf
    $ sudo nano /etc/supervisor/supervisord.conf    

Ajoutez les lignes suivantes

    [inet_http_server]
    port = 9300
    username = user ; Auth username
    password = pass ; Auth password

    [eventlistener:supermail]
    command=python /usr/local/bin/supermail.py -a -m mail@domain.com -o "[Liquidsoap]"
    events=PROCESS_STATE
    
Pensez à modifier "mail@domain.com"    

### Supermail

    $ sudo apt-get install sendmail
    $ cd /usr/local/bin
    $ sudo wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/darkice-supervisor/supermail.py
    $ cd
    $ sudo /etc/init.d/supervisor restart
    $ sudo supervisorctl reread
    $ sudo supervisorctl update
    $ sudo reboot
