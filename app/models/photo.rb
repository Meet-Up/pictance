# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  photo_id   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Photo < ActiveRecord::Base
end
