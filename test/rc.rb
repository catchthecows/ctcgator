class Feed
    @@readids = ""
    def markread id
        ranges = @@readids.split(",")
        if ranges.count>0 then
            i=0
            while i<ranges.count 
                puts ranges[i]
                i+=1
                puts ranges[i]
                i+=1
            end
        else
            @@readids="#{id},#{id}"
        end

        puts @@readids
    end
end

f = Feed.new
f.markread 1
f.markread 2
f.markread 5
f.markread 4
f.markread 3

