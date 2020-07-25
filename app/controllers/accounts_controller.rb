# frozen_string_literal: true

class AccountsController < ApplicationController
  layout 'registrations'

  before_action :authenticate_user!
  before_action :redirect_pending_account
  before_action :find_account
  before_action :region_options, only: %i[edit update]

  def edit; end

  def update
    if @account.update(account_params)
      redirect_to edit_account_path
      flash_success
    else
      render :edit
    end
  end

  protected

    def find_account
      @account = current_user.account
    end

    def redirect_pending_account
      return redirect_to complete_account_registration_path if current_user.account.pending?
    end

    def region_options
      @region_options ||= current_scope.regions.keys.map do |k|
        [t("activerecord.attributes.account/region.#{k}"), k]
      end
    end

    def account_params
      params.require(:account)
            .permit(
              :address,
              :brand_name,
              :company_name,
              :contact_email,
              :contact_number,
              :region,
              :tax_id_number
            )
    end

  private

    def current_scope
      @current_scope ||= Account
    end
end
