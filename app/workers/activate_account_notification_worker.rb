# frozen_string_literal: true

class ActivateAccountNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(account_id)
    account = Account.find(account_id)

    AccountMailer.activate_account(account).deliver
  end
end
