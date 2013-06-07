require 'test/unit'
require_relative '../models/init'
require_relative '../import/importgoogle'

class TestUser < Test::Unit::TestCase
    def test_import_list
        #u = User.createuser( {"user"=>{"name"=>"test4", "password"=>"test"}} )
        u = User.get(3)
        
        import_subscriptions u, "#{ENV['DATA_DIR']}/list.txt"
    end
end


