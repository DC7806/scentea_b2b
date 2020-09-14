# frozen_string_literal: true

class SiteLogoUploader < ImageUploader
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    { small: magick.resize_to_limit!(200, 200) }
  end
end
