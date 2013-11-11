# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  user_id    :string(255)
#  friend_id  :string(255)
#  score      :integer
#  created_at :datetime
#  updated_at :datetime
#

class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
end
