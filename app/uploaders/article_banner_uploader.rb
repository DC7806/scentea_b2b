# frozen_string_literal: true

class ArticleBannerUploader < ImageUploader
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(800, 800),
      medium: magick.resize_to_limit!(600, 600),
      small: magick.resize_to_limit!(300, 300)
    }
  end
end
