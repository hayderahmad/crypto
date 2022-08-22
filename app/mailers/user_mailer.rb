class UserMailer < ApplicationMailer
  
    default from: 'notifications@example.com'
  
    def emailnotifications
      @article = params[:article]
      @alert_type = params[:alert_type]
      @target = params[:target]
      @user = params[:user]
      @url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
end
