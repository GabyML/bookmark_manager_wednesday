require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require './data_mapper_setup'
require './app/controllers/base' #require base first
require './app/controllers/link_controller'
require './app/controllers/session_controller'
require './app/controllers/tag_controller'
require './app/controllers/user_controller'


module Bookmarks

  class App < Sinatra::Base

    get '/' do
      erb :'/index'
    end

    use Routes::Link_Controller
    use Routes::Session_Controller
    use Routes::User_Controller
    use Routes::Tag_Controller

    register Sinatra::Partial
    register Sinatra::Flash

    helpers do
      def current_user 
        current_user = User.get(session[:user_id])
      end
    end
  end
end
