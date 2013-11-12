# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  photo_id   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  photo_url  :string(255)
#

class Photo < ActiveRecord::Base
  has_many :data, class_name: 'PhotoData', foreign_key: 'photo_id'
end
