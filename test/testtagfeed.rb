require 'test/unit'
require_relative '../models/init'

class TestUser < Test::Unit::TestCase
    def test_tag
        u = User.get(11) 

        c = u.tags.count
        puts "tags #{c}"

        u.tags.each do | t |
            puts "tag #{t.tag}"

            c = t.feeds.count
            puts "feeds #{c}"

            t.feeds.each do | f |
                puts "source #{f.source.id} #{f.source.title}"
            end

            puts "----"
        end
    end
end
