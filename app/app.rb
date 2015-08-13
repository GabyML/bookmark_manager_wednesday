require 'sinatra/base'
require 'sinatra/flash'
require_relative '../data_mapper_setup'
require_relative './models/link'

class App < Sinatra::Base

  use Rack::MethodOverride

  enable :sessions
  set :sessions_secret, 'super secret'
  register Sinatra::Flash

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
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation])
    # the user.id will be nil if the user wasn't saved
    # because of password mismatch
    if @user.save #save returns true/false depending on wheter the model is successfully saved to a database
      session[:user_id] = @user.id
      redirect to('/')
      # if it's not valid
      # we'll render the sing up form again
    # elsif params[:email] == '' 
    #   flash.now[:errors] = 'Email address required to sign in'
    #   erb :'users/new'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  helpers do
    def current_user 
      current_user = User.get(session[:user_id])
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
