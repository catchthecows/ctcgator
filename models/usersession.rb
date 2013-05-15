require 'securerandom'

class UserSession
    include DataMapper::Resource

    property :id, Serial
    property :token, String
    property :ip, String
    property :userid, Integer

    def self.createsession( user, ipaddr )
        s = UserSession.new
        s.token = SecureRandom.base64
        s.ip = ipaddr
        s.userid = user.id
        s.save
        return s
    end

    def self.authenticate( token, ipaddr )
        s = UserSession.first(:token => token)
        if (s)
            if (s.ip == ipaddr) 
                u = User.get(s.userid)
                return u
            end
        end
        return nil
    end
end
