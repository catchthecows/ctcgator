require 'zip/zip'
require 'fileutils'

class CTCGator < Sinatra::Application
    get '/t/:id', :auth => :user do
        @tag = @user.tags.get(params[:id])
        @feeds = @tag.feeds
        erb :feeds
    end

    get '/u', :auth => :user do
        @tags = @user.tags
        erb :tags
    end
end

