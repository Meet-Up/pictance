class UserPhotosWorker
  include Sidekiq::Worker
  def perform(user)
  end
end
