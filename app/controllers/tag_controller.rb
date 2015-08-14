module Bookmarks 
	module Routes
		class Tag_Controller < Base

			get '/tags/:name' do
				tag = Tag.first(name: params[:name])
				@links = tag ? tag.links : []
				erb :'links/index'
			end

		end
	end
end
