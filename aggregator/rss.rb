require 'rss'
require 'open-uri'

#url = 'http://www.ruby-lang.org/en/feeds/news.rss'
url = 'http://feeds.feedburner.com/colossal'
open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      puts "Title: #{feed.channel.title}"
      feed.items.each do |item|
        puts item.title
        puts item.pubDate
        #puts item
      end
end
