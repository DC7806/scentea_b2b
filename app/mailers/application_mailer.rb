# frozen_string_literal: true

require 'digest/sha2'

class ApplicationMailer < ActionMailer::Base
  digested_time = Digest::SHA2.hexdigest(Time.now.to_i.to_s)

  default 'Message-ID': "#{digested_time}@scentea.co"
  default from: 'service@scentea.co'

  layout 'mailer'
end
