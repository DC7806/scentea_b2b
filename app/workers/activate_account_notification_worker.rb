# frozen_string_literal: true

class ActivateAccountNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform
    AccountMailer.activate_account.deliver
  end
end
