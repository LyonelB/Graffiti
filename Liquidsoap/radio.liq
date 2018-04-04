#!/usr/bin/liquidsoap
set("log.file.path", "/home/pi/stream/radio.log")
set("frame.audio.samplerate",48000)

stream = input.alsa(device="plughw:1,0", bufferize = true)
stream = compress(stream, attack = 5.0, gain = 8.0, knee = 10.0, ratio = 5.0, release = 100.0, threshold = -18.0, rms_window = 0.7)
stream = normalize(stream, target = -1.0, threshold = -65.0)
stream = limit(stream, threshold = -0.2, attack = 2.0, release = 25.0, rms_window = 0.02)

output.icecast(%fdkaac(channels=2, samplerate=48000, bitrate=128, afterburner=false, transmux="adts", sbr_mode=true, aot="mpeg4_he_aac_v2",),
host = "xxxxxxxx",
port = 8000,
password = "xxxxxx",
mount = "graffiti",
name="Graffiti Urban Radio",
description="Fournisseur de Bonnes Ondes",
url="http://www.urban-radio.com",
genre="alternative",
stream)

output.icecast(%shine(bitrate=128, samplerate=48000,),
host = "xxxxxxxxxx",
port = 8000,
password = "xxxxxx",
mount = "graffiti.mp3",
name="Graffiti Urban Radio",
description="Fournisseur de Bonnes Ondes",
url="http://www.urban-radio.com",
genre="alternative",
stream)
