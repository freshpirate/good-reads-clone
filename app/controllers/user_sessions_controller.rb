class UserSessionsController < ApplicationController
    before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => :destroy
    
    def new
        @user_session = UserSession.new
    end

    def create
        @user_session = UserSession.new(user_session_params)
        if @user_session.save
            flash[:success] = 'Welcome Back!'
            redirect_to root_url
        else
            render :new
        end
    end

    def destroy
        current_user_session.destroy
        flash[:success] = "Logged Out Successfully!"
        redirect_to root_url
    end

    private

    def user_session_params
        params.require(:user_session).permit(:email, :password, :remember_me, :name)
    end
end