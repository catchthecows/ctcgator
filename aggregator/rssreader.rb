require 'rss'
require 'open-uri'
require 'reader.rb'

class RssReader < Reader

    def read(url) 
        #url = 'http://www.ruby-lang.org/en/feeds/news.rss'
        #url = 'http://feeds.feedburner.com/colossal'
        open(url) do |rss|
            feed = RSS::Parser.parse(rss)
            puts "Feed: #{feed.channel.title}"
            feed.items.each do |item|
                puts item.title
                puts item.pubDate
                #puts item
            end
        end
    end

end
