class PhotoAnalyzerWorker
  @@pux = PuxSDK::PostImageFace.new(Settings.pux.api_key)

  def self.perform(id, json_tags)
    photo = Photo.find(id)
    tags = JSON.parse(json_tags)
    pux_data = PhotoAnalyzerWorker.get_pux_data(photo)
    return if pux_data.nil?
    users = PhotoAnalyzerWorker.get_or_create_users(tags, pux_data)
    users.each do |user|
      closest_face = PhotoAnalyzerWorker.compute_closest_face(user, pux_data)
      smile_level = closest_face['smileJudge']['smileLevel'].to_f
      user[:info].data.create(photo_id: id, x: user[:x], y: user[:y], smile: smile_level)
      user[:info].update(gender: closest_face['genderJudge']['genderResult'].to_i)
    end
    users
  end

  def self.get_pux_data(photo)
    pux_data = @@pux.post_image_url(photo.photo_url)
    recognition_results = pux_data['results']['faceRecognition']
    return nil if recognition_results['detectionFaceInfo'].nil?
    pux_data = {
      width: recognition_results['width'].to_f,
      height: recognition_results['height'].to_f,
      faces: recognition_results['detectionFaceInfo']
    }
    return nil unless PhotoAnalyzerWorker.compute_face_center(pux_data[:faces])
    pux_data
  end

  def self.get_or_create_users(tags, pux_data)
    users = []
    tags.each do |tag|
      users << {
        info: User.where(uid: tag['tag_uid']).first_or_create!(name: tag['tag_text'], email: "#{tag['tag_uid']}@facebook.com"),
        x: tag['x'],
        y: tag['y']
      }
    end
    users
  end

  def self.compute_face_center(faces)
    faces.each do |face|
      coordinates = face['faceCoordinates'] rescue nil
      return false if coordinates.nil?
      face[:x] = (coordinates['faceFrameLeftX'].to_f + coordinates['faceFrameLeftX'].to_f) / 2
      face[:y] = (coordinates['faceFrameTopY'].to_f + coordinates['faceFrameBottomY'].to_f) / 2
    end
    true
  end

  def self.compute_closest_face(user, pux_data)
    user_x = user[:x] * pux_data[:width] / 100
    user_y = user[:y] * pux_data[:height] / 100
    faces = pux_data[:faces]
    faces.min_by { |f| self.distance(user_x, user_y, f[:x], f[:y]) }
  end

  def self.distance(x1, y1, x2, y2)
    dx = x1 - x2
    dy = y1 - y2
    Math.sqrt(dx * dx + dy * dy)
  end

  def perform(id, tags)
    PhotoAnalyzerWorker.perform(id, tags)
  end
end
