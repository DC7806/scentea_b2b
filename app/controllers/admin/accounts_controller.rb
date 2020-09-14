# frozen_string_literal: true

module Admin
  class AccountsController < AdminController
    before_action :find_account, except: :index

    def index
      @accounts = current_scope.where(region: current_region)
                               .order(id: :desc)
    end

    def edit; end

    def update
      @account.assign_attributes(account_params)

      if @account.valid?
        send_activation_email(@account)
        @account.save
        return redirect_to_index
      end

      flash_and_render(:edit)
    end

    private

      def current_scope
        @current_scope ||= Account
      end

      def find_account
        @account = current_scope.find(params[:id])
      end

      def account_params
        params.require(:account)
              .permit(:status)
      end

      def send_activation_email(account)
        return unless account.status_changed? && account.active?

        ActivateAccountNotificationWorker.perform_async(account.id)
      end
  end
end
