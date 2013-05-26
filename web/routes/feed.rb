require 'zip/zip'
require 'fileutils'

class CTCGator < Sinatra::Application
    get '/feeds', :auth => :user do
        @feeds = Source.all
        erb :feeds
    end

    get '/f/:id', :auth => :user do
        @feed = Source.get(params[:id])
        @entries = Entry.all(:sourceid => params[:id], :order=>[:date.desc])
        erb :feed
    end

    get '/f/:feedid/:entryid', :auth => :user do 
        fid = params[:feedid]
        eid = params[:entryid]

        @entries = Entry.all(:sourceid => fid,:num => eid)
        @entry = @entries[0]

        file = "#{ENV['FEED_DIR']}/#{fid}/#{eid}.zip"

        Zip::ZipInputStream::open(file) { |io|
            while (entry = io.get_next_entry)
                # puts "Contents of #{entry.name}: '#{io.read}'"
                @content = "#{io.read}"
            end
        }
        erb :entry
    end
end
