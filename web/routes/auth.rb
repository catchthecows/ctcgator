class CTCGator < Sinatra::Application
    register do
        def auth (type)
            condition do
                redirect "/login" unless send("is_#{type}?")
            end
        end
    end

    helpers do
        def is_user?
            @user != nil
        end
    end

    before do
        @user = User.get(session[:user_id])
    end

    post "/login" do
        u = User.authenticate(params)
        if (u)
            session[:user_id] = u.id
        end
        redirect "/feeds"
    end

    get "/logout" do
        session[:user_id] = nil
    end
end
