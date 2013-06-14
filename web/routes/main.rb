class CTCGator < Sinatra::Application
    get '/', :auth => :user do
       redirect "/u" 
    end

    get '/login' do 
        erb :login
    end
end
