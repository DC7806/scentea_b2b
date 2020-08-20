# frozen_string_literal: true

class AccountMailer < ApplicationMailer
  def new_account
    mail to: ENV['SERVICE_EMAIL'],
         subject: 'Bowen TODO: 通知管理者新帳戶註冊待審',
         template_path: 'mailers/accounts'
  end

  def activate_account(account)
    @account = account

    mail to: account.contact_email,
         subject: 'Bowen TODO: 通知客戶帳戶啟用完成',
         template_path: 'mailers/accounts'
  end
end
