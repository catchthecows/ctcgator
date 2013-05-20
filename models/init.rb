require 'data_mapper'

DataMapper.setup(:default, {
    :adapter => 'sqlite3',
    :database => ENV['DATABASE']
})

=begin
DataMapper.setup(:default, {
    :adapter => 'mysql',
    :database => ENV['DATABASE'],
    :username => 'username',
    :password => 'password',
    :host     => 'hostname'
})
=end

DataMapper::Property::String.length(255)

require_relative 'source'
require_relative 'entry'
require_relative 'user'
require_relative 'usersession'
require_relative 'tokenpair'

DataMapper.auto_upgrade!

