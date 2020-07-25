# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'registrations'

    def create
      user = User.new(user_params)
      assign_account(user)

      if user.valid?
        user.save!
        sign_in user
        redirect_to new_account_registration_path
      else
        @user = user
        render :new
      end
    end

    protected

      def after_update_path_for(_resource)
        edit_user_registration_path
      end

    private

      def user_params
        params.require(:user)
              .permit(
                :email,
                :first_name,
                :last_name,
                :password,
                :password_confirmation
              )
      end

      def assign_account(user)
        user.account = Account.new(contact_email: user.email)
      end
  end
end
