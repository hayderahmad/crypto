require 'mail'
# require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE


mail = Mail.new do
    from    'test@sandbox116f2c3e468c4234a4fab1ea8c157cc2.mailgun.org'
    to      'hayderahmad@yahoo.com'
    subject 'This is a test email'
    body    'File read'
end
puts mail.to_s #=> "From: mitelkel@test.lindsaar.net\r\nTo: you@...

# mail.delivery_method :sendmail
mail.delivery_method :smtp, address: "localhost", port: 1025
mail.deliver!