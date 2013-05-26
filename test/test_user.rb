require 'test/unit'
require_relative '../models/init'

class TestUser < Test::Unit::TestCase
    def test_basic
        u = User.new
        u.name = "test"
        assert_equal "test", u.name
    end

    def test_create
        u = User.createuser( {"user"=>{"name"=>"user", "password"=>"pw"}} )
        assert_equal "user", u.name

        lookup = User.authenticate( {"user"=>{"name"=>"user", "password"=>"pw"}} )
        assert_equal "user", u.name
    end

    def test_login
        u = User.createuser( {"user"=>{"name"=>"user2", "password"=>"pw"}} )
        assert_equal "user2", u.name

        lookup = User.authenticate( {"user"=>{"name"=>"user2", "password"=>"pw"}} )
        assert_equal "user2", u.name

        session = UserSession.createsession( u, "192.168.1.2" )
        assert_equal u.id, session.userid

        sessionuser = UserSession.authenticate( session.token, "192.168.1.2" )
        assert_equal u.id, sessionuser.id

        failuser = UserSession.authenticate( session.token, "192.168.1.3" )
        assert_nil failuser
    end
end
