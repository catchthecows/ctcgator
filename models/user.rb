require 'murmurhash3'
require 'securerandom'

class User
    include DataMapper::Resource
    property :id, Serial
    property :name, String
    property :password, String
    property :salt, String

    def self.authenticate(params) 
        u = User.first(:name=>params['user']['name'])
        if (u)
            pw = params['user']['password']
            rawhash = MurmurHash3::V128.str_hash(u.salt+pw)
            saltedhash = rawhash.join("")
            if (saltedhash != u.password)
                u = nil
            end
        end
        return u
    end

    def self.createuser(params)
        username = params['user']['name']
        pw = params['user']['password']
        salt = SecureRandom.base64
        rawhash = MurmurHash3::V128.str_hash(salt+pw)
        saltedhash = rawhash.join("")
        u = User.new
        u.name = username
        u.salt = salt
        u.password = saltedhash
        u.save
        return u
    end
end
