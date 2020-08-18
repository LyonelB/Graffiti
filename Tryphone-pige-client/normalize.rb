#!/usr/bin/env ruby
require 'tryphon-pige-client'
Pige::Client.box_url = "http://pigebox.local"
include Pige::Client

system "rm -rf /home/debian/podcast/*"

end.download("/home/debian/podcast").each do |file|
  system "ecanormalize", file
  system "wput", "--basename=#{File.dirname(file)}",  "ftp://podcast:urbanradio@192.168.1.15/", file
end
