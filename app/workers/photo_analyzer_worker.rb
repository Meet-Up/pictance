class PhotoAnalyzerWorker
  include Sidekiq::Worker

  def perform(photo)
    pux = PuxSDK::PostImageFace.new(Settings.pux.api_key)
    pux_data = pux.post_image_url(photo.photo_url)
  end
end
