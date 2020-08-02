# frozen_string_literal: true

module Admin
  module ComponentsHelper
    def go_back_button
      paramaters = {}
      paramaters[:region_id] = params[:region_id]
      paramaters[:action] = :index

      link_to t('utilities.buttons.back'),
              url_for(paramaters),
              class: 'btn btn-block btn-outline-secondary'
    end
  end
end
