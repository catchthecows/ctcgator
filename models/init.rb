require 'data_mapper'

=begin
DataMapper.setup(:default, {
    :adapter => 'sqlite3',
    :database => ENV['DATABASE']
})
=end

DataMapper.setup(:default, {
    :adapter => 'mysql',
    :database => 'ctcgator',
    :username => ENV['MYSQL_USER'],
    :password => ENV['MYSQL_PASSWORD']'
    :host     => 'localhost'
})

DataMapper::Property::String.length(255)

require_relative 'source'
require_relative 'entry'
require_relative 'user'
require_relative 'usersession'
require_relative 'tokenpair'

DataMapper.auto_upgrade!

