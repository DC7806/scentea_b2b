# frozen_string_literal: true

module AdminUsers
  class SessionsController < Devise::SessionsController
    layout 'admin_users'
  end
end
