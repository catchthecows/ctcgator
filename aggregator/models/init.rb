require 'data_mapper'

DataMapper.setup(:default, 'sqlite3:test.db')

require_relative 'source'
require_relative 'entry'

DataMapper.auto_upgrade!

