require 'sinatra'

class CTCGator < Sinatra::Application
    enable :sessions

    configure :production do
        set :port, 80
    end

    configure :development do
    end
end

require_relative '../models/init'
require_relative 'routes/init'
