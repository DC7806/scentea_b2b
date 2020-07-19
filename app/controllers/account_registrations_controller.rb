# frozen_string_literal: true

class AccountRegistrationsController < ApplicationController
  layout 'registrations'

  before_action :authenticate_user!
  before_action :account, only: %i[new create]
  before_action :redirect_pending_account, only: %i[new create]
  before_action :redirect_active_account
  before_action :region_options, only: %i[new create]

  def new; end

  def create
    if @account.update(registration_params.except(:term))
      @account.pending!
      redirect_to complete_account_registrations_path
    else
      render :new
    end
  end

  def complete; end

  private

    def account
      @account ||= current_user.account
    end

    def redirect_active_account
      return redirect_to root_path if account.active?
    end

    def redirect_pending_account
      return redirect_to complete_account_registrations_path if account.pending?
    end

    def region_options
      @region_options ||= Account.regions.keys.map do |k|
        [t("activerecord.attributes.account/region.#{k}"), k]
      end
    end

    def registration_params
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
end
