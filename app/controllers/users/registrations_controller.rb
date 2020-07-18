# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    layout 'registrations'

    def new
      super
    end

    def create
      user = User.new(user_params)
      assign_account(user)

      if user.valid?
        user.save!
        redirect_to root_path
      else
        @user = user
        render :new
      end
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
        account = Account.new(
          contact_email: user.email,
          company_name: '',
          tax_id_number: '',
          region: 'domestic'
        )

        user.account = account
      end
  end
end
