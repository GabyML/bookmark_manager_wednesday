module Bookmarks
	module Routes 
	  class Link_Controller < Base  # Give different names to these classes and the models to avoid confusion 

	  	get '/links' do
    		@links = Link.all
    		erb :'/links/index'
    	end 

    	get '/links/new' do
    		erb :'links/new'
    	end

    	post '/links' do
    		link = Link.new(url: params[:url], title: params[:title])
    		tag  = Tag.create(name: params[:tags]) 
    		link.tags << tag
    		link.save                        
    		redirect to('/links')
    	end

      end
  end
end
