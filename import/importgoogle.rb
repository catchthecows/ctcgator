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
    cats
end

def parse_object(user,node) 
    puts "parse object"
    n = node.first
    while (n) do 
        if n.name=='string' && n['name']=='title' then 
            title = n.content
            title.strip!
        end
        if n.name=='string' && n['name']=='id' then 
            url = n.content
            url.strip!
            url.gsub!(/^feed\//,"")
        end
        if n.name=='list' && n['name']=='categories' then
            cats = parse_categories n
        end
        if cats.nil? then
            cats = Array.new
            cats.push("global")
        end
        
        n = n.next
    end
    s = Source.first(:url=>url)
    if s.nil? then
        s = Source.create(:count => 0,
                          :title => title,
                          :url   => url,
                          :type  => 'rss')
        s.save
    end
    cats.each do | c | 
        tag = user.tags.first(:tag=>c)
        if tag.nil? then
            tag = user.tags.create(:tag=>c)
        end
        unless tag.feeds.first(:source=>s) 
            f = tag.feeds.create(:source=>s)
            if !f.valid? then
                puts f.errors.inspect
            end
        end
    end
end

def import_subscriptions(user,filename)
    source = XML::Parser.file(filename)
    document = source.parse
    content = document.find('//list') #.find
    
    content.each do | l |
        if (l['name'] == 'subscriptions') then
            n = l.first
            while (n) do
                if !n.text? then
                   if (n.name == 'object') then
                       parse_object user,n
                   end 
                end
                n = n.next
            end
        end
    end
end

#import_opml "#{ENV['DATA_DIR']}/subscriptions.xml"
#import_subscriptions "#{ENV['DATA_DIR']}/list.txt.full"

