class Entry
    include DataMapper::Resource
    property :id, Serial
    property :sourceid, Integer
    property :date, String, :required => true, :key=>true
    property :title, String, :required => true
    property :url, String, :required => true
    property :content, Text, :required => true
end
