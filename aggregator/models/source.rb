class Source
    include DataMapper::Resource
    property :id, Serial
    property :count, Integer 
    property :title, String, :required => true
    property :type, String, :required => true
    property :url, String, :required => true
end
