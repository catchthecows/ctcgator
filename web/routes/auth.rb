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
        @user = UserSession.authenticate(session[:token])
    end

    post "/login" do
        u = User.authenticate(params)
        if (u)
            s = UserSession.createsession(u)
            session[:token] = s.token
        end
        redirect "/u"
    end

    get "/logout" do
        session[:token] = nil
    end
end
