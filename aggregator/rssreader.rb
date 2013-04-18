require 'rss'
require 'open-uri'
require_relative 'reader.rb'

class RssReader < Reader

    def read(url) 
        open(url) do |rss|
            begin
                feed = RSS::Parser.parse(rss)
                #puts "Feed: #{feed.channel.title}"
                feed.items.each do |item|
                    puts item.title
                    puts item.pubDate
                end
            rescue => ex
                puts ex.message
            end
        end
    end

end
