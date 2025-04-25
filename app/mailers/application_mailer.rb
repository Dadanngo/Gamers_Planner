class ApplicationMailer < ActionMailer::Base
  default from: -> {
    if Rails.env.test?
      'no-reply@example.com'
    else
      ENV["MAIL_USER_NAME"] || 'fallback@example.com'
    end
  }

  layout "mailer"
end
