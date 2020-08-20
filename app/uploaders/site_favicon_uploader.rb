# frozen_string_literal: true

class SiteFaviconUploader < ImageUploader
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    { small: magick.resize_to_limit!(32, 32) }
  end
end
