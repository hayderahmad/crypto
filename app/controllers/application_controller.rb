class ApplicationController < ActionController::Base
   def require_signin
        unless session[:user_id]
            redirect_to "/session/sign_in", allow_other_host: true
        end
    end
    def require_current_session
        unless Tiem.now - session[:login_time] > 3600
            redirect_to "/session/sign_in", allow_other_host: true
        end
    end
            
end
