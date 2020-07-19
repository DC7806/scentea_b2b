# frozen_string_literal: true

module Admin
  module ComponentsHelper
    def go_back_button
      link_to t('utilities.buttons.back'),
              url_for(action: :index),
              class: 'btn btn-block btn-outline-secondary'
    end
  end
end
