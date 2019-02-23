# Installation de Liiquidsoap avec Opam 2     
    
    $ cd /tmp
    $ wget https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh
    $ chmod +x install.sh
    $  ./install.sh
    $ cd
    $ sudo apt-get install m4 libsamplerate0-dev libmp3lame-ocaml-dev libtaglib-ocaml-dev libalsa-ocaml-dev libpulse-ocaml-dev libmad-ocaml-dev libcry-ocaml-dev libvorbis-ocaml-dev libogg-ocaml-dev libopus-ocaml-dev
    $ opam init --compiler=4.07.0
    $ opam depext taglib mad lame vorbis cry samplerate liquidsoap
    $ opam install taglib mad lame vorbis cry samplerate liquidsoap
