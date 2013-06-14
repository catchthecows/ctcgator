class CTCGator < Sinatra::Application
    get '/' do, :auth => :user
       redirect "/u" 
    end

    get '/login' do 
        erb :login
    end
end
