class CTCGator < Sinatra::Application
    get '/' do
        #erb :index
       redirect "/login" 
    end

    get '/login' do 
        erb :login
    end
end
