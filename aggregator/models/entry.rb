class Entry
    include DataMapper::Resource
    property :id, Serial
    property :sourceid, Integer
    property :num, Integer, :key=>true
    property :date, String, :required => true, :key=>true
    property :title, String, :required => true
    property :url, String, :required => true
end
