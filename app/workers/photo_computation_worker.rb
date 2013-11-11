class PhotoComputationWorker
  include Sidekiq::Worker

  def self.perform(user_id)
    user = User.find(user_id)
    user_datas = user.data
    user_datas.each do |own|
      friend_datas = PhotoData.where(photo_id: own.photo_id).where.not(user_id: user_id)
      friend_datas.each do |friend|
        current_score =  friend.smile / Math.sqrt((own.x - friend.x) ** 2 + (own.y - friend.y) ** 2)
        score = user.scores.where(friend_id: friend.user_id).first_or_initialize
        score.score += current_score
        score.save
      end
    end
  end

  def perform(user_id)
    PhotoComputationWorker.perform(user_id)
  end
end
