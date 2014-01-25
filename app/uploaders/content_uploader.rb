# encoding: utf-8

class ContentUploader < CarrierWave::Uploader::Base

  storage :fog

  include CarrierWave::MimeTypes
  process :set_content_type

  def store_dir
    "files/#{model.id}"
  end

end
