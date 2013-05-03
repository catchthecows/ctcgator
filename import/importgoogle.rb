require 'xml'
require 'murmurhash3'

require_relative '../models/init'

def show(msg)
end

def import(filename)
    source = XML::Parser.file(filename)
    document = source.parse
    content = document.find('//outline').find

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
            rescue => ex
                puts ex.message
            end
            false
        else
            puts i['title']
        end
    end
end

import "#{ENV['DATA_DIR']}/subscriptions.xml"

