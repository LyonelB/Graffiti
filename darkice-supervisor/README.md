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
    
    [eventlistener:supermail]
    command=python /usr/local/bin/supermail.py -a -m mail@domain.com -o "[DARKICE]"
    events=PROCESS_STATE
    
Reprenez la configuration

    $ sudo /etc/init.d/supervisor restart
    $ sudo supervisorctl reread
    $ sudo supervisorctl update
    $ sudo reboot

Une fois redemarré, vous pourrez accéder à l'interface de supervisor via http://localhost:9300

## Monitoring

    $ sudo nano /etc/supervisor/supervisord.conf

Ajoutez les lignes suivantes

    [eventlistener:supermail]
    command=python /usr/local/bin/supermail.py -a -m mail@domain.com -o "[DARKICE]"
    events=PROCESS_STATE

Reprenez l'installation
   
    $ sudo apt-get install sendmail
    $ cd /usr/local/bin
    $ sudo wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/darkice-supervisor/supermail.py
    $ cd
    $ sudo /etc/init.d/supervisor restart
    $ sudo supervisorctl reread
    $ sudo supervisorctl update

## A SUPPRIMER
### Superlance

    $ sudo apt-get install python-pip
    $ sudo pip install superlance
    $ sudo nano /etc/supervisor/conf.d/fatalmailbatch.conf
    
Ajoutez le texte suivant    
    
    # /etc/supervisor/conf.d/fatalmailbatch.conf 

    [eventlistener:fatalmailbatch]
    command=fatalmailbatch 
      --toEmail="admin@team.com" 
      --fromEmail="supervisor@app.com" 
      --smtpHost="smtp.mailgun.org" 
      --userName="username" 
      --password="password"
    events=PROCESS_STATE,TICK_60
    autostart=true
    autorestart=true

Reprenez la configuration 

    $ sudo supervisorctl reread
    $ sudo supervisorctl add fatalmailbatch
    $ sudo supervisorctl start fatalmailbatch
