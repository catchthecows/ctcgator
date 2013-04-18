require 'xml'

require_relative 'rssreader.rb'

source = XML::Parser.file('./temp/subscriptions.xml')

document = source.parse

content = document.find('//outline').find

r = RssReader.new
content.each do | i |
    if (i['type'] == 'rss')
        puts i['xmlUrl']
        begin
            r.read(i['xmlUrl'])
        rescue => ex
            puts ex.message
        end
        puts '-- done'
    end
end
