class ApplicationMailer < ActionMailer::Base
  # default from: "support@#{Rails.application.credentials.config[:mailgun][:mydomain]}"
  # layout "mailer"
end
