# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    layout 'registrations'

    private

      def after_sign_in_path_for(resource)
        return new_account_registration_path if resource.account.created?

        super
      end
  end
end
