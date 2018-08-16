### OpenOB - Raspbian Stretch
#### Installation
     $ sudo apt-get install python-gst-1.0 gstreamer1.0-plugins-ugly gstreamer1.0-tools python-gobject python-redis redis-server
     $ sudo sed -i.bak 's/bind 127.*/bind 0.0.0.0/' /etc/redis/redis.conf && sudo service redis-server restart
     $ sudo pip install git+https://github.com/jonty-comp/openob.git@gst1.0
