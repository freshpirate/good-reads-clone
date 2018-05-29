class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(users_params)
        if @user.save
            flash[:success] = "Registered Successfully!"
            redirect_to root_url
        else
            render :new
        end

    end

    private

    def users_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end
end