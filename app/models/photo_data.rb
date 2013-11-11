# == Schema Information
#
# Table name: photo_data
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  photo_id   :integer
#  x          :float
#  y          :float
#  smile      :float
#  created_at :datetime
#  updated_at :datetime
#

class PhotoData < ActiveRecord::Base
	belongs_to :user
	belongs_to :photo
end
