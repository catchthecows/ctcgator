require 'xml'
require 'murmurhash3'

require_relative 'rssreader'

require_relative 'models/init'

def show(msg)
end

def import(filename)
    source = XML::Parser.file(filename)
    document = source.parse
    content = document.find('//outline').find

    r = RssReader.new
    content.each do | i |
        if (i['type'] == 'rss')
            puts "    #{i['title']}"
            puts "    #{i['xmlUrl']}"

            begin
                s = Source.new
                s.count = 0
                s.title = i['title']
                s.url = i['xmlUrl']
                s.type = 'rss'
                s.save

#                puts "  - saved"

            #m1 = MurmurHash3::V128.str_hash(i['xmlUrl'])
            #puts m1.join('')
                # r.read(i['xmlUrl'])
            rescue => ex
                puts ex.message
            end
            #puts '-- done'
            false
        else
            puts i['title']
        end
    end
end

import './temp/subscriptions.xml'

