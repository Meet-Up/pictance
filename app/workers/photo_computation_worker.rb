class PhotoComputationWorker
  include Sidekiq::Worker

  def perform(id)
  	user = .find(id)

  end
end