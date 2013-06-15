require 'oauth2'

require_relative '../../import/importgoogle'

class CTCGator < Sinatra::Application
    # Scopes are space separated strings
    SCOPES = [
	'https://www.google.com/reader/api/'
    ].join(' ')

    unless G_API_CLIENT = ENV['G_API_CLIENT']
        raise "You must specify the G_API_CLIENT env variable"
    end

    unless G_API_SECRET = ENV['G_API_SECRET']
        raise "You must specify the G_API_SECRET env veriable"
    end

    def client
        client ||= OAuth2::Client.new(G_API_CLIENT, G_API_SECRET, {
            :site => 'https://accounts.google.com', 
            :authorize_url => "/o/oauth2/auth", 
            :token_url => "/o/oauth2/token"
        })
    end

    get '/oauth2callback' do
        # AccessToken object
        # http://rubydoc.info/github/intridea/oauth2/ebe4be038ec14b349682/OAuth2/AccessToken
        access_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
        session[:access_token] = access_token.token

        erb :startimport
    end

    get '/importdirectgoogle', :auth => :user do
  	access_token = OAuth2::AccessToken.new(client, session[:access_token])

	response = access_token.get('https://www.google.com/reader/api/0/subscription/list')

        import_subscriptions_string @user, response.body

        @tags = @user.tags
        erb :user
    end

    get '/authgoogle', :auth => :user do
        redirect client.auth_code.authorize_url(:redirect_uri => redirect_uri,:scope => SCOPES,:access_type => "offline")
    end

    def redirect_uri
        uri = URI.parse(request.url)
        uri.path = '/oauth2callback'
        uri.query = nil
        uri.to_s
    end
end
