Ajout de supervisor pour le controle de Darkice sur le Raspberry Pi

Après avoir suvi le tuto https://github.com/LyonelB/Darkice-All-codecs-RPi
NE PAS FAIRE LA PARTIE "Auto Start" et suivre les indications suivantes

### Installation

    $ sudo apt-get install supervisor
    $ mkdir config && cd config
    $ mkdir supervisor && cd supervisor
    $ wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/darkice-supervisor/darkice.conf
    $ cd
    $ sudo ln -s /home/pi/config/supervisor/darkice.conf /etc/supervisor/conf.d/darkice.conf
    $ sudo nano /etc/supervisor/supervisord.conf    

Ajoutez les lignes suivantes

    [inet_http_server]
    port = 9300
    username = user ; Auth username
    password = pass ; Auth password
    
Reprenez la configuration

    $ sudo /etc/init.d/supervisor restart
    $ sudo supervisorctl reread
    $ sudo supervisorctl update
    $ sudo reboot

Une fois redemarré, vous pourrez accéder à l'interface de supervisor via http://ip.du.rasp.berry.pi:9300
