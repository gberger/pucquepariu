# encoding: utf-8

class ContentUploader < CarrierWave::Uploader::Base

  storage :fog

  include CarrierWave::MimeTypes
  process :set_content_type

  def store_dir
    "cw/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
