# frozen_string_literal: true

class NewAccountNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform
    AccountMailer.new_account.deliver
  end
end
