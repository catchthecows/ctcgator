class CTCGator < Sinatra::Application
    get '/feeds' do
        @feeds = Source.all
        erb :feeds
    end

    get '/f/:id' do
        @feed = Source.get(params[:id])
        @entries = Entry.all(:sourceid => params[:id])
        erb :feed
    end

    get '/f/:feedid/:entryid' do
        @entries = Entry.all(:sourceid => params[:feedid],:num => params[:entryid])
        @entry = @entries[0]
        erb :entry
    end
end
