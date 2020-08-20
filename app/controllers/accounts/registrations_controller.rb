# frozen_string_literal: true

module Accounts
  class RegistrationsController < AccountsController
    skip_before_action :authenticate_account!
    before_action :redirect_active_account
    before_action :redirect_pending_account, except: :complete
    before_action :region_options, only: %i[new create]

    def new; end

    def create
      if @account.update(account_params)
        @account.pending!
        NewAccountNotificationWorker.perform_async
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
        redirect_to root_path if current_account.active?
      end

      def redirect_pending_account
        redirect_to complete_account_registration_path if current_account.pending?
      end

      def current_account
        current_user.account
      end
  end
end
