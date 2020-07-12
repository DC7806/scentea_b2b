# frozen_string_literal: true

module Admin
  class AccountsController < AdminController
    before_action :find_account, except: :index

    def index
      @accounts = current_scope.order(id: :desc)
    end

    def edit; end

    def update
      return redirect_to_index if @account.update(account_params)

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
  end
end
