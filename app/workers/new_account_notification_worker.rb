# frozen_string_literal: true

class NewAccountNotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(account_id)
    account = Account.find(account_id)

    AccountMailer.new_account(account).deliver
  end
end
