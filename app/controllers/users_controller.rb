class UsersController < ApplicationController
    before_action :require_signin, except: [:create, :new] 
    def index
        @users= User.all
    end
    def show
        @user = User.find(params[:id])
    end
    def create
        
        @user= User.new(name: params[:name], phone: params[:phone], email: params[:email], password: params[:password])
        if @user.save
            redirect_to "/users",allow_other_host: true, notice: "Successfuly created"
        else
            render :new
        end
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        @user = User.find(params[:id])
        if @user.update(name: params[:name], phone: params[:phone], email: params[:email], password: params[:password])
            redirect_to "/users/#{@user.id}", notice: "Successfuly updated"
        else
            render :edit
        end

    end
    def destroy
        User.find(params[:id]).destroy
        session[:user_id] = nil
        redirect_to "/users",allow_other_host: true, notice: "Successfuly deleted"
        
    end

    
    private
        def user_params
            params.require(:user).premit(:name, :email, :password, :phone)
        end
end
