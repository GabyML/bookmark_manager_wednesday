  module Bookmarks
    module Routes
      class User_Controller < Base

        get '/users/new' do
          @user = User.new
          erb :'users/new'
        end

        post '/users' do
          @user = User.create(email: params[:email], password: params[:password],
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

      end
    end
  end