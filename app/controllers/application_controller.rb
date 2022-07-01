class ApplicationController < ActionController::Base
   def require_signin
        unless session[:user_id]
            redirect_to "/session/sign_in", allow_other_host: true
        end
    end
end
