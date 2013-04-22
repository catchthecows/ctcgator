require_relative 'models/init'

require_relative 'rssreader'

def scan
    r = RssReader.new
    Source.all.each do | s |
    #Source.all( :url.like => '%recover%' ).each do | s |
        r.read(s.url) { | item | 
            if (item.instance_variable_get(:@valid) == true) 
                #puts '-----'
                puts "[#{item.title}]"
                #puts item.description
                #puts item.content
                #puts item.date_published
                #puts item.id
                #puts item.url
            else
                puts 'ERROR READING FEED'
            end
        }
    end
end

scan

