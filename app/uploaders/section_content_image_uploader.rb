# frozen_string_literal: true

class SectionContentImageUploader < ImageUploader
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(1200, 1200),
      medium: magick.resize_to_limit!(600, 600),
      small: magick.resize_to_limit!(300, 300)
    }
  end

  Attacher.promote_block do
    PromoteWorker.new.perform(
      self.class.name, record.class.name, record.id, name, file_data
    )
  end
end
