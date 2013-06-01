require 'securerandom'

class UserSession
    include DataMapper::Resource

    property :id, Serial
    property :token, String
    property :userid, Integer

    def self.createsession( user )
        s = UserSession.first(:userid=>user.id)
        if s.nil? then
            s = UserSession.new
            s.token = SecureRandom.base64
            s.userid = user.id
            s.save
        end
        return s
    end

    def self.authenticate( token )
        s = UserSession.first(:token => token)
        if (s)
            u = User.get(s.userid)
            return u
        end
        return nil
    end
end
