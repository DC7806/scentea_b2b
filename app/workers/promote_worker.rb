# frozen_string_literal: true

class PromoteWorker
  include Sidekiq::Worker

  def perform(attacher_class, record_class, record_id, name, file_data)
    attacher_class = Object.const_get(attacher_class)
    record         = Object.const_get(record_class).find(record_id)

    attacher = attacher_class.retrieve(model: record, name: name, file: file_data)
    attacher.create_derivatives
    attacher.atomic_promote

    # rubocop:disable Lint/SuppressedException
  rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound
    # rubocop:enable Lint/SuppressedException
    # attachment has changed or the record has been deleted, nothing to do
  end
end
