# frozen_string_literal: true

module Admin
  module SidebarHelper
    def sidebar_active_on(*resources)
      paths = request.path.split('/')
      res_index = paths.index(ENV['ADMIN_PATH']) + 1
      return unless resources.select { |res| paths[res_index]&.include?(res) }.any?

      'active'
    end
  end
end
