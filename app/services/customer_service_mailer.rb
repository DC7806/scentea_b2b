# frozen_string_literal: true

require 'digest/sha2'

class CustomerServiceMailer
  DOEMSTIC_BRAND = 'SCENTEA'
  DOEMSTIC_DOMAIN = '@scentea.co'
  FOREIGN_BRAND = 'BUPPOZ'
  FOREIGN_DOMAIN = '@buppoz.com'

  def initialize(account)
    @account = account
  end

  def message_id
    digested_time + domain
  end

  def sender
    "#{brand.upcase} <noreply#{domain}>"
  end

  def recipient
    settings = SiteSetting.first
    return settings.service_email_zh_tw if @account.domestic?

    settings.service_email_en
  end

  private

    def brand
      return DOEMSTIC_BRAND if @account.domestic?

      FOREIGN_BRAND
    end

    def domain
      return DOEMSTIC_DOMAIN if @account.domestic?

      FOREIGN_DOMAIN
    end

    def digested_time
      Digest::SHA2.hexdigest(Time.now.to_i.to_s)
    end
end
