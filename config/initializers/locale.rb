# frozen_string_literal: true

I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml')]
I18n.default_locale = :'zh-TW'
I18n.available_locales = %i[en zh-TW]
