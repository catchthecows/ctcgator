require 'sinatra'

class CTCGator < Sinatra::Application
    unless RACK_COOKIE_SECRET = ENV['RACK_COOKIE_SECRET']
        raise "No RACK_COOKIE_SECRET in ENV"
    end
    use Rack::Session::Cookie, :secret => RACK_COOKIE_SECRET
    enable :sessions

    configure :production do
        set :port, 80
    end

    configure :development do
    end
end

require_relative '../models/init'
require_relative 'routes/init'
