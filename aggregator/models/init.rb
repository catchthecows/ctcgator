require 'data_mapper'

DataMapper.setup(:default, 'sqlite3:test.db')
DataMapper::Property::String.length(255)

require_relative 'source'
require_relative 'entry'

DataMapper.auto_upgrade!

