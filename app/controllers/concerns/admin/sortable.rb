# frozen_string_literal: true

module Admin
  module Sortable
    extend ActiveSupport::Concern

    included do
      helper_method :sort_path

      def sort
        sort_item = JSON.parse(params[:sort])
                        .transform_keys(&:to_sym)

        current_scope.find(sort_item[:id])
                     .insert_at(sort_item[:position].to_i)

        head :ok
      end

      def sort_path
        current_sort_path
      end
    end
  end
end
