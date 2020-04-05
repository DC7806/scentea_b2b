# frozen_string_literal: true

module Admin
  class AdminUsersController < AdminController
    before_action :find_admin_user

    def edit; end

    def update
      if @admin_user.update(admin_user_params)
        sign_in(@admin_user, bypass: true)
        redirect_to admin_root_path,
                    notice: t('actions.update') + t('notices.success')
      else
        render :edit
      end
    end

    private

      def find_admin_user
        @admin_user = current_admin_user
      end

      def admin_user_params
        params.require(:admin_user)
              .permit(:email, :password, :password_confirmation)
      end
  end
end
