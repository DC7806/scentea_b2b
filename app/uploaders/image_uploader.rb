# frozen_string_literal: true

require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :derivatives
  plugin :backgrounding
  plugin :default_url

  Attacher.validate do
    validate_max_size  500 * 1024
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]
    validate_extension %w[jpg jpeg png webp tiff tif]
  end

  Attacher.promote_block do
    PromoteWorker.perform_async(
      self.class.name, record.class.name, record.id, name, file_data
    )
  end

  Attacher.default_url do |derivative: nil, **|
    file&.url if derivative
  end
end
