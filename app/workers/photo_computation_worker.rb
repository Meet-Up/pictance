class PhotoComputationWorker
  include Sidekiq::Worker

  def perform(user_id)
    user_datas = PhotoData.where(user_id: user_id)
    user_datas.each do |own|
      friend_datas = PhotoData.where(photo_id: own.photo_id).where.not(user_id: user_id)
      friend_datas.each do |friend|
        #ここで値の計算
        score = Math.sqrt((own.x - friend.x) ** 2 + (own.y - friend.y) ** 2) + friend.smile
        score = Score.new({user_id: user_id, friend_id: friend.user_id, score: score})
        score.save
      end
    end
  end
end
