class UserPhotosWorker
  include Sidekiq::Worker
  def perform(id)
  	user = User.find(id)
  	facebook_user = FbGraph::User.me(user.facebook_token)

  	facebook_user.photos.each do |fb_photo|
      next if Photo.where(photo_id: fb_photo.identifier).exists?
      photo = Photo.new(user_id: user.id, photo_id: fb_photo.identifier, photo_url: fb_photo.source)
      if photo.save
        PhotoAnalyzerWorker.perform(photo.id, fb_photo.tags.to_json)
      end
    end
  end
end
