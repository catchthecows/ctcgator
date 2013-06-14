require 'zip/zip'
require 'fileutils'

class CTCGator < Sinatra::Application
    get '/t/:id', :auth => :user do
        @tag = @user.tags.get(params[:id])
        @feeds = @tag.feeds
        erb :userfeeds, :layout => false
    end

    get '/u', :auth => :user do
        @tags = @user.tags
        erb :user
    end
end

