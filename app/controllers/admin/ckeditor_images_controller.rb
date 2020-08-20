# frozen_string_literal: true

module Admin
  class CkeditorImagesController < AdminController
    def upload
      return render_error unless current_scope && tmp_file

      processor = CkeditorImageProcessor.new(
        scope: current_scope,
        file: tmp_file,
        dimensions: [1200, 1200],
        quality: 90
      )

      return render_error(msg: 'max_size', max: '500kb') unless processor.file_valid?

      uploaded_file = processor.upload
      return render json: { url: uploaded_file.url }.to_json if uploaded_file.url

      render_error
    end

    private

      def optimized_image
        ImageProcessor.new(
          file: tmp_file,
          dimensions: [1200, 1200],
          quality: 90
        ).perform
      end

      def tmp_file
        params['upload']
      end

      def current_scope
        @current_scope ||= params[:scope]
      end

      def render_error(msg: nil, max: nil)
        message = max.present? ? t("errors.file.#{msg}", max: max) : t('errors.upload.fail')
        render json: { error: { message: message } }.to_json
      end
  end
end
