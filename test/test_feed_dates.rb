require 'test/unit'
require_relative '../models/init'

class TestFeedDates < Test::Unit::TestCase
    def test_dates
        e = Entry.new
        e.title = "title test"
        e.date = nil
        e.sourceid = 9999
        e.num = 1
        e.url = "http://testUrl.com"

        e.save

        puts e.errors.inspect

        entries = Entry.all( :date => nil, :title => "title test", :sourceid=>9999 )
        assert_not_nil entries



    end
end
