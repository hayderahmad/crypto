class SessionController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to "/", notice: "Welcome back, #{user.name}!"
            
        else
            flash.now[:alert] = "Invalid email/password combination"
            render :sign_in
        end
    end
    def destroy
        session[:user_id] = nil
        redirect_to "/", notice: "successfully signd out"

    end
end
