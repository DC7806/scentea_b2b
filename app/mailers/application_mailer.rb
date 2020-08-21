# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  private

    def service_email(account)
      @service_email ||= CustomerServiceMailer.new(account)
    end
end
