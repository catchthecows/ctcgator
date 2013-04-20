class Entry
    include DataMapper::Resource
    property :id, Serial
    property :title, String, :required => true
    property :url, String, :required => true
    property :text, String, :required => true
end
