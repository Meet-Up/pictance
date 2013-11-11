class PhotoComputationWorker
  include Sidekiq::Worker

  def perform(user_id)
    user_datas = PhotoData.where(user_id: user_id)
    user_datas.each do |user_data|
      my_x = user_data.x
      my_y = user_data.y
      my_smile = user_data.smile

      friend_datas = PhotoData.where(photo_id: user_data.photo_id)
      friend_datas.each do |friend_data|
        next if user_id == friend_data.user_id

        #ここで値の計算
        friend_x = friend_data.x
        friend_y = friend_data.y
        friend_smile = friend_data.smile
        score = Math.sqrt((my_x - friend_x) ** 2 + (my_y - friend_y) ** 2) + friend_smile
        score = Score.new({user_id: user_id, friend_id: friend_data.user_id, score: score})
        score.save
      end
    end
  end
end
