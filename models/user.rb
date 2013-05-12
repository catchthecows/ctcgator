class User
    include DataMapper::Resource
    property :id, Serial
    property :name, String
    property :password, String
    property :salt, String
    property :token, String

    def self.authenticate(params) 
        u = User.first(:name=>params['user']['name'])
    end
end
