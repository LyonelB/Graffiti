# Installation

Sur Debian Stretch Mate

    $ su
    $ apt-get install git-core curl zlib1g-dev build-essential libssl1.0-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev wput ecatools
    $ exit
    $ cd
    $ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    $ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    $ exec $SHELL
    $ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    $ echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    $ exec $SHELL
    $ git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
    $ rbenv install 2.1.10
    $ rbenv global 2.1.10
    $ ruby -v #pour vérifier la version de ruby
    $ gem install tryphon-pige-client
    $ wget https://raw.githubusercontent.com/LyonelB/Graffiti/master/Tryphone-pige-client/scheduler_chunks_daily.rb
    $ mkdir /home/graffiti/Bureau/podcast
    
# Crontab

    $  crontab -e
    
Ajouter la ligne suivante :

    0 6 * * * /home/graffiti/.rbenv/versions/2.1.10/bin/ruby  /home/graffiti/scheduler_chunks_daily.rb 2>&1 | logger -t scheduler -i
