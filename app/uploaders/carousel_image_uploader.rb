# frozen_string_literal: true

class CarouselImageUploader < ImageUploader
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(1200, 1200),
      small: magick.resize_to_limit!(300, 300)
    }
  end
end
