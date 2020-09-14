# frozen_string_literal: true

require 'shrine'
require 'shrine/storage/memory'
require 'shrine/storage/s3'

s3_options = {
  access_key_id:     ENV['AWS_ACCESS_KEY_ID'] || 'dummy_access_key_id',
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || 'dummy_secret_access_key',
  region:            ENV['AWS_S3_REGION'] || 'dummy_region',
  bucket:            ENV['AWS_S3_BUCKET'] || 'dummy_bucket'
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'uploads/cache', **s3_options),
  store: Shrine::Storage::S3.new(prefix: 'uploads', **s3_options)
}

Shrine.storages = {
  cache: Shrine::Storage::Memory.new,
  store: Shrine::Storage::Memory.new
} if Rails.env.test?

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :determine_mime_type
Shrine.plugin :pretty_location
Shrine.plugin :restore_cached_data

Shrine.plugin :presign_endpoint, presign_options: -> (request) {
  filename = request.params['filename']
  type     = request.params['type']
  {
    content_disposition:    ContentDisposition.inline(filename),
    content_type:           type,
    content_length_range:   0..(10*1024*1024),
  }
}

# source: https://github.com/shrinerb/shrine/blob/master/lib/shrine/plugins/validation_helpers.rb
pretty_filesize = lambda do |bytes|
  return '0.0 B' if bytes == 0

  filesize_units = %w[B KB MB GB TB PB EB ZB YB]
  exp = Math.log(bytes, 1024).floor
  max_exp = filesize_units.length - 1
  exp = max_exp if exp > max_exp
  "%.1f %s" % [bytes.to_f / 1024 ** exp, filesize_units[exp]]
end

Shrine.plugin :validation_helpers, default_messages: {
  max_size:            -> (max)  { I18n.t('errors.file.max_size', max: pretty_filesize.call(max)) },
  min_size:            -> (min)  { I18n.t('errors.file.min_size', min: pretty_filesize.call(min)) },
  max_width:           -> (max)  { I18n.t('errors.file.max_width', max: max) },
  min_width:           -> (min)  { I18n.t('errors.file.min_width', min: min) },
  max_height:          -> (max)  { I18n.t('errors.file.max_height', max: max) },
  min_height:          -> (min)  { I18n.t('errors.file.min_height', min: min) },
  max_dimensions:      -> (dims) { I18n.t('errors.file.max_dimensions', dims: dims.join('x')) },
  min_dimensions:      -> (dims) { I18n.t('errors.file.min_dimensions', dims: dims.join('x')) },
  mime_type_inclusion: -> (list) { I18n.t('errors.file.mime_type_inclusion', list: list.join(', ')) },
  mime_type_exclusion: -> (list) { I18n.t('errors.file.mime_type_exclusion', list: list.join(', ')) },
  extension_inclusion: -> (list) { I18n.t('errors.file.extension_inclusion', list: list.join(', ')) },
  extension_exclusion: -> (list) { I18n.t('errors.file.extension_exclusion', list: list.join(', ')) },
}
