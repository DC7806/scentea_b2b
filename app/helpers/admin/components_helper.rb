# frozen_string_literal: true

module Admin
  module ComponentsHelper
    def go_back_button
      paramaters = {}
      paramaters[:region] = params[:region]
      paramaters[:action] = :index

      link_to t('utilities.buttons.back'),
              url_for(paramaters),
              class: 'btn btn-block btn-outline-secondary'
    end
  end
end
