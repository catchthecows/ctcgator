require 'rss'
require 'open-uri'
require_relative 'reader.rb'

class RssReader < Reader

    def read(url) 
        begin
        puts url
        open(url) do |rss|
                feed = RSS::Parser.parse(rss)
                #puts "Feed: #{feed.channel.title}"
                feed.items.each do |item|
                    item.instance_variable_set(:@valid,true)
                    yield item
                    #puts item.title
                    #puts item.pubDate
                end
        end
        rescue OpenURI::HTTPError => ex
            item = Object.new
            item.instance_variable_set(:@valid,false)
            yield item
            puts "HTTPERROR #{ex.message}"
        rescue => ex
            item = Object.new
            item.instance_variable_set(:@valid,false)
            yield item
            puts "EX #{ex.message}"
        end
    end

end
