# frozen_string_literal: true

class CkeditorImageUploader < Shrine
  attr_accessor :file_scope

  plugin :url_options, store: { public: true }
  plugin :upload_endpoint

  # rubocop:disable Lint/UnusedMethodArgument
  def generate_location(io, record: nil, derivative: nil, **)
    file_name = SecureRandom.hex + File.extname(io)
    "ckeditor/images/#{file_scope}/#{file_name}"
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
