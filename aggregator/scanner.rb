require_relative 'models/init'

require_relative 'rssreader'

def scan
    r = RssReader.new
    Source.all.each do | s |
    #Source.all( :url.like => '%col%' ).each do | s |
        r.read(s.url) { | item | 
            if (item.instance_variable_get(:@valid) == true) 
                puts item.title
            else
                puts 'ERROR READING FEED'
            end
        }
    end
end

scan

