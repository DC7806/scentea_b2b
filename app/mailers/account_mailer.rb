# frozen_string_literal: true

class AccountMailer < ApplicationMailer
  def new_account(account)
    service_email = service_email(account)

    mail from: service_email.sender,
         to: service_email.recipient,
         subject: 'Bowen TODO: 通知管理者新帳戶註冊待審',
         'Message-ID': service_email.message_id,
         template_path: 'mailers/accounts'
  end

  def activate_account(account)
    @account = account
    service_email = service_email(account)

    mail from: service_email.sender,
         to: @account.contact_email,
         subject: 'Bowen TODO: 通知客戶帳戶啟用完成',
         'Message-ID': service_email.message_id,
         template_path: 'mailers/accounts'
  end
end
