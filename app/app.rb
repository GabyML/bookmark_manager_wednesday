require 'sinatra/base'
require_relative '../data_mapper_setup'
require_relative './models/link'

class App < Sinatra::Base

  enable :sessions
  set :sessions_secret, 'super secret'

  get '/' do
    erb :'/index'
  end

  get '/links' do
  	@links = Link.all
  	erb :'/links/index'
  end 

  get '/links/new' do
  	erb :'links/new'
  end

  post '/links' do
  	link = Link.new(url: params[:url], 
                title: params[:title])
  	tag  = Tag.create(name: params[:tags]) 
  	link.tags << tag
    link.save                        
  	redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
              password: params[:password])
    session[:user_id] = user.id
    redirect to('/')
  end

  helpers do
    def current_user 
      current_user = User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
