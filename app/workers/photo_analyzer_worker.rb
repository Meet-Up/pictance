class PhotoAnalyzerWorker
  def self.perform(id, tags)
    photo = Photo.find(id)
    tags = JSON.parse(tags)
    pux = PuxSDK::PostImageFace.new(Settings.pux.api_key)
    pux_data = pux.post_image_url(photo.photo_url)
    logger.debug { YAML::dump(pux_data) }
  end

  def perform(id, tags)
    PhotoAnalyzerWorker.perform(id, tags)
  end
end
