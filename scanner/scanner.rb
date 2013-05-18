require 'fileutils'
require 'zip/zip'

require_relative '../models/init'
require_relative 'rssreader'

def scan
    r = RssReader.new
    Source.all.each do | s |
    #Source.all( :url.like => '%colo%' ).each do | s |
    #Source.all( :url.like => '%GitHub%' ).each do | s |
        FileUtils.mkpath "#{ENV['FEED_DIR']}/#{s.id}"
        
        r.read(s.url) do | item | 
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
                    e.num = s.count
                    e.url = item.urls.first

                    e.save
                    
                    puts "feed/#{s.id}/#{e.num}"
                    begin
                        Zip::ZipOutputStream.open("#{ENV['FEED_DIR']}/#{s.id}/#{e.num}.zip") do |z|
                            z.put_next_entry("content.txt")
                            z.puts item.content
                        end
                    rescue => ex
                        puts "ERROR Writing feed"
                        puts ex
                    end

                    s.count = s.count+1
                    s.save
                end
            else
                puts 'ERROR READING FEED'
            end
        end 
    end
end

scan

