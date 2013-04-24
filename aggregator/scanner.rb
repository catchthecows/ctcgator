require_relative 'models/init'

require_relative 'rssreader'

def scan
    r = RssReader.new
    Source.all.each do | s |
    #Source.all( :url.like => '%GitHub%' ).each do | s |
        r.read(s.url) { | item | 
            if (item.instance_variable_get(:@valid) == true) 
                #puts '-----'
                #puts "[#{item.title}]"
                #puts item.description
                #puts item.content
                #puts "date    [#{item.date_published}]"
                #puts "updated [#{item.last_updated}]"
                #puts item.id
                #puts item.url
                
                # TODO
                # lookup up date_published + title
               
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
                    e.url = item.urls.first
                    e.content = item.content

                    # TODO validate

                    e.save

                    puts 'New Record'
                end
            else
                puts 'ERROR READING FEED'
            end
        }
    end
end

scan

