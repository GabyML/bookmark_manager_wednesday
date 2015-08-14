module Bookmarks
  module Routes
    class Base < Sinatra::Base
      # within here we can have configuration common to all our route subclasses
        enable :sessions
        register Sinatra::Flash
        use Rack::MethodOverride
        set :sessions_secret, 'super secret'
        set :views, proc { File.join(root, '..', 'views')}
        run! if app_file == $0

            helpers do # YOU NEED THIS HERE!!!!!!!!!!!!! BOTH IN BASE.RB AND APP.RB
              def current_user 
                current_user = User.get(session[:user_id])
              end
            end
          end
        end
      end