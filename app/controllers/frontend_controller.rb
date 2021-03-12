# frozen_string_literal: true

class FrontendController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_account!

  private

    # TODO: Make it resources specific
    def authenticate_account!
      case current_user.account.status
      when 'created'
        redirect_to new_account_registration_path
      when 'pending'
        redirect_to complete_account_registration_path
      end
    end
end
