require 'data_mapper'

DataMapper.setup(:default, {
    :adapter => 'sqlite3',
    :database => ENV['DATABASE']
})

DataMapper::Property::String.length(255)

require_relative 'source'
require_relative 'entry'
require_relative 'user'

DataMapper.auto_upgrade!

