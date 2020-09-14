# frozen_string_literal: true

require 'image_processing/mini_magick'

class CkeditorImageProcessor
  def initialize(scope:, file:, dimensions: nil, quality: 100)
    @file = file
    @dimensions = dimensions
    @quality = quality
    @uploader = uploader(scope)
    @attacher = CkeditorImageUploader::Attacher.new
  end

  def upload
    @uploader.upload(optimized_image)
  end

  def file_valid?
    @attacher.attach(@file)
    return true if @attacher.file.size < 500 * 1024

    false
  end

  private

    def uploader(scope)
      uploader = CkeditorImageUploader.new(:store)
      uploader.file_scope = scope
      uploader
    end

    def optimized_image
      magick = ImageProcessing::MiniMagick.source(@file)
      magick.saver(quality: @quality)
      return magick.call unless @dimensions

      magick.resize_to_limit(*@dimensions)
            .call
    end
end
