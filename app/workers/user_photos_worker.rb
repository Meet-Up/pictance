class UserPhotosWorker
  include Sidekiq::Worker
  def perform(id)
  	user = User.find(id)
  	facebook_user = FbGraph::User.me(user.facebook_token).fetch

  	facebook_user.photos.each do |photo|
	  photo = Photo.new({user_id: user.id, photo_id: photo.identifier, photo_url: photo.raw_attributes["picture"]})

	  photo.save
	end
  end
end
