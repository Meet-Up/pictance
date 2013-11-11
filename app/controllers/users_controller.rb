class UsersController < ApplicationController
	def index
	end

	def show
		@facebook_user = FbGraph::User.me(current_user.facebook_token).fetch
		UserPhotosWorker.perform_async(current_user.id)
	end

	def fetch_photo

	end
end
