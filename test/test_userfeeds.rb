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

    def test_tag
        u = User.createuser( {"user"=>{"name"=>"taguser", "password"=>"pw"}} )

        t1 = u.tags.create(:tag=>"test tag 1")
        puts t1.errors.full_messages
        t2 = u.tags.create(:tag=>"test tag 2")
        puts t2.errors.full_messages
        t3 = u.tags.create(:tag=>"test tag 3")
        puts t3.errors.full_messages

        c = u.tags.count
        assert_equal( 3, c, "count should be 3")

        lookuptag = u.tags.first(:tag=>"test tag 2")
        assert_not_nil(lookuptag, "lookup test tag 2 failed")
        assert_equal( t2.id, lookuptag.id, "looked up tag id does not match")
    end

    def test_feedtrack
        u = User.createuser( {"user"=>{"name"=>"feeduser", "password"=>"pw"}} )
        t = u.tags.create(:tag=>"notag")
        assert_not_nil(t, "failed to create tag")
        ft1 = t.feeds.create(:feedid=>1)
        assert_not_nil(ft1, "failed to create feed track")
        ft2 = t.feeds.create(:feedid=>2)
        assert_not_nil(ft2, "failed to create feed track")

        c = t.feeds.count
        assert_equal(2,c,"feed count should be 2")

        lookuptag = u.tags.get(t.id)
        assert_not_nil(lookuptag, "tag lookup failed")

        lookupfeed = lookuptag.feeds.get(ft2.id)
        assert_not_nil(lookupfeed, "feed lookup failed")
        assert_equal(lookupfeed.feedid, 2, "looked up feed id does not match")
    end
end
