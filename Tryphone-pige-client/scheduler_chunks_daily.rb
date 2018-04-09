#!/usr/bin/env ruby
require 'tryphon-pige-client'
Pige::Client.box_url = "http://pigebox.local"
include Pige::Client

Pige::Client::Chunk.destroy_all :older_than => 3.days.ago

ChunkScheduler.define do |schedule|
  # Schedule Chunks for yesterday
  schedule.day = Date.today.prev_day
  # Doesn't really Chunks, only log orders
  # schedule.dry_run = true
  # Daily Chunks
  schedule.default_attributes[:margin] = 5.minutes  
  schedule.default_attributes[:format] = "wav"

  # Only monday Chunks
  schedule.on(:monday) do
    create :title => "%Y-%m-%d-17-00", :begin => "17:00", :duration => 1.hour
    create :title => "%Y-%m-%d-18-00", :begin => "18:00", :duration => 0.6.hour
    create :title => "%Y-%m-%d-19-30", :begin => "19:30", :duration => 2.hour
    create :title => "%Y-%m-%d-21-30", :begin => "21:30", :duration => 1.5.hour
    create :title => "%Y-%m-%d-23-00", :begin => "23:00", :duration => 1.hour
  end

  # Only tuesday Chunks
  schedule.on(:tuesday) do
    create :title => "%Y-%m-%d-12-30", :begin => "12:15", :duration => 1.hour
    create :title => "%Y-%m-%d-17-00", :begin => "17:00", :duration => 1.hour
    create :title => "%Y-%m-%d-17-27", :begin => "17:00", :duration => 1.hour
#    create :title => "%Y-%m-%d-17-20", :begin => "17:00", :duration => 1.hour if day.cweek.odd?
    create :title => "%Y-%m-%d-19-00", :begin => "19:00", :duration => 1.hour
    create :title => "%Y-%m-%d-21-00", :begin => "21:00", :duration => 1.hour
    create :title => "%Y-%m-%d-22-00", :begin => "22:00", :duration => 1.hour
  end

  # Only wednesday Chunks  
  schedule.on(:wednesday) do
    create :title => "%Y-%m-%d-17-00", :begin => "17:00", :duration => 1.hour
    create :title => "%Y-%m-%d-18-00", :begin => "18:00", :duration => 1.hour
#    create :title => "%Y-%m-%d-20-00", :begin => "20:00", :duration => 1.hour if day.cweek.odd?
    create :title => "%Y-%m-%d-20-00", :begin => "20:00", :duration => 1.hour
    create :title => "%Y-%m-%d-21-00", :begin => "21:00", :duration => 1.hour
  end

  # Only thursday Chunks
  schedule.on(:thursday) do
    create :title => "%Y-%m-%d-17-00", :begin => "17:00", :duration => 1.hour
    create :title => "%Y-%m-%d-18-00", :begin => "18:00", :duration => 1.hour
    create :title => "%Y-%m-%d-21-00", :begin => "21:00", :duration => 1.hour
    create :title => "%Y-%m-%d-22-00", :begin => "22:00", :duration => 2.hours, :margin => 10.minutes
  end

  # Only friday Chunks
  schedule.on(:friday) do
    create :title => "%Y-%m-%d-17-00", :begin => "17:00", :duration => 1.hour
    create :title => "%Y-%m-%d-18-00", :begin => "18:00", :duration => 1.hour
    create :title => "%Y-%m-%d-19-00", :begin => "19:00", :duration => 1.hour
    create :title => "%Y-%m-%d-20-00", :begin => "20:00", :duration => 1.hour
    create :title => "%Y-%m-%d-21-00", :begin => "21:00", :duration => 1.hour
    create :title => "%Y-%m-%d-22-00", :begin => "22:00", :duration => 1.hour
    create :title => "%Y-%m-%d-23-00", :begin => "23:00", :duration => 1.5.hour
  end

  # Only saturday Chunks
  schedule.on(:saturday) do
#    create :title => "%Y-%m-%d-7-55", :begin => "7:55", :duration => 1.hour
  end

  # Only sunday Chunks
  schedule.on(:sunday) do
    create :title => "%Y-%m-%d-18-00", :begin => "18:00", :duration => 1.hour
  end

end.download("/home/graffiti/Bureau/podcast").each do |file|
  system "ecanormalize", file
  system "wput", "--basename=#{File.dirname(file)}",  "ftp://podcast:urbanradio@192.168.1.33/", file
end
