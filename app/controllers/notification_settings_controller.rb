class NotificationSettingsController < ApplicationController
    before_action :require_signin
    def new
    end
    def create
        @user= User.find(session[:user_id])
        @user.notification_settings.create(setting_config_type: "like_count", setting_config_params: {"count": params[:like_count]}, by_phone: params[:like_count_by_phone] == "1", by_email: params[:like_count_by_email]  == "1"  )
        @user.notification_settings.create(setting_config_type: "dislike_count", setting_config_params: {"count": params[:dislike_count]}, by_phone: params[:dislike_count_by_phone] == "1", by_email: params[:dislike_count_by_email]  == "1"  )
        @user.notification_settings.create(setting_config_type: "comment_count", setting_config_params: {"count": params[:comment_count], "within": params[:comment_duration]}, by_phone: params[:comment_count_by_phone] == "1", by_email: params[:comment_count_by_email]  == "1"  )
        redirect_to "/users/#{@user.id}", notice: "Successfuly Created"
        
    end
    def edit
        
        @user= User.find(params[:user_id])
        @notifications= @user.notification_settings
    end
    def update
        @user= User.find(params[:user_id])
        @notification= @user.notification_settings.find_by(setting_config_type: "like_count")
        @notification.update( setting_config_params: {"count": params[:like_count]}, by_phone: params[:like_count_by_phone] == "1", by_email: params[:like_count_by_email]  == "1"  )
        @notification= @user.notification_settings.find_by(setting_config_type: "dislike_count")
        @notification.update( setting_config_params: {"count": params[:dislike_count]}, by_phone: params[:dislike_count_by_phone] == "1", by_email: params[:dislike_count_by_email]  == "1"  )
        @notification= @user.notification_settings.find_by(setting_config_type: "comment_count")
        @notification.update( setting_config_params: {"count": params[:dislike_count], "within":params[:comment_duration]}, by_phone: params[:comment_count_by_phone] == "1", by_email: params[:comment_count_by_email]  == "1"  )
        redirect_to "/users/#{@user.id}", notice: "Successfuly updated"
    end
end
