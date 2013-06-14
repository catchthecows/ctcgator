require 'test/unit'
require_relative '../models/init'
require_relative '../import/importgoogle'

class TestUser < Test::Unit::TestCase
    def test_import_list
        #u = User.createuser( {"user"=>{"name"=>"test4", "password"=>"test"}} )
        u = User.get(3)
        
        #import_subscriptions u, "#{ENV['DATA_DIR']}/list.txt"


        content='<object> <list name="subscriptions"> <object> <string name="id">feed/http://feeds.feedburner.com/funandfoo</string> <string name="title">fun & foo</string> <list name="categories"> <object> <string name="id">user/07520339150177640784/label/Random People</string> <string name="label">Random People</string> </object> </list> <string name="sortid">6ECB3400</string> <number name="firstitemmsec">1359841246593</number> <string name="htmlUrl">http://www.thisiscolossal.com</string> </object> </list> </object>'

        import_subscriptions_string u, content
    end
end


