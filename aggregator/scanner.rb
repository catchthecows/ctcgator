require 'fileutils'

require_relative 'models/init'
require_relative 'rssreader'

def scan
    r = RssReader.new
    #Source.all.each do | s |
    Source.all( :url.like => '%colo%' ).each do | s |
        feednum=s.count
        FileUtils.mkpath "feed/#{s.id}"
        
        r.read(s.url) { | item | 
            if (item.instance_variable_get(:@valid) == true) 
                if (item.date_published)
                    use_date = item.date_published
                else
                    use_date = item.last_updated
                end

                entries = Entry.all( :date => use_date, :title => item.title, :sourceid=>s.id )
                if entries.empty?
                    e = Entry.new
                    e.title = item.title
                    e.date = use_date
                    e.sourceid = s.id
                    e.num = feednum
                    e.url = item.urls.first

                    e.save
                    
                    puts "feed/#{s.id}/#{e.num}"
                    file = nil
                    begin
                        file = File.open("feed/#{s.id}/#{e.num}", 'w')
                        file.puts item.content
                    rescue => ex
                        puts "ERROR Writing feed"
                        puts ex
                    ensure
                        file.close unless file.nil?
                    end

                    feednum = feednum+1
                end
            else
                puts 'ERROR READING FEED'
            end
        }
    end
end

scan

