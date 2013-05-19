require 'xml'
require 'murmurhash3'

require_relative '../models/init'

def show(msg)
end

def import_opml(filename)
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

def parse_categories(node)
    cats = Array.new
    n = node.first
    while (n) do 
        if n.name=='object' then
            n1 = n.first
            while (n1) do
                if n1.name=='string' && n1['name']=='label' then 
                    category = n1.content
                    category.strip!
                    cats.push category
                end
                n1 = n1.next
            end
        end
        n = n.next
    end
    puts "category #{cats.join(',')}"
end

def parse_object(node) 
    puts "parse object"
    n = node.first
    while (n) do 
        if n.name=='string' && n['name']=='title' then 
            title = n.content
            title.strip!
            puts "title #{title}"
        end
        if n.name=='string' && n['name']=='id' then 
            url = n.content
            url.strip!
            puts "url #{url}"
        end
        if n.name=='list' && n['name']=='categories' then
            parse_categories n
        end
        n = n.next
    end
end

def import_subscriptions(filename)
    source = XML::Parser.file(filename)
    document = source.parse
    content = document.find('//list') #.find
    
    content.each do | l |
        if (l['name'] == 'subscriptions') then
            n = l.first
            while (n) do
                if !n.text? then
                   if (n.name == 'object') then
                       parse_object n
                   end 
                end
                n = n.next
            end
        end
    end
end

#import_opml "#{ENV['DATA_DIR']}/subscriptions.xml"
import_subscriptions "#{ENV['DATA_DIR']}/list.txt.full"

