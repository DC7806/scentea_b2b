# frozen_string_literal: true

module Accounts
  class RegistrationsController < AccountsController
    before_action :redirect_pending_account, only: %i[new create]
    before_action :redirect_active_account
    before_action :region_options, only: %i[new create]

    def new; end

    def create
      if @account.update(account_params)
        @account.pending!
        NewAccountNotificationWorker.perform_async(@account.id)
        redirect_to complete_account_registration_path
      else
        render :new
      end
    end

    def complete
      redirect_to new_account_registration_path if @account.created?
    end

    private

      def redirect_active_account
        redirect_to root_path if current_user.account.active?
      end
  end
end
