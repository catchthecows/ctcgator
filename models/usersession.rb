class TokenPair
      include DataMapper::Resource

      property :token, String
      property :ip, String
      property :id, Integer
end
