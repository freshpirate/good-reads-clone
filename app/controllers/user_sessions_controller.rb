class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params.to_h)
    saved = @user_session.save

    respond_to do |format|
      format.html do
        if saved
          redirect_to root_url, notice: "Welcome Back!"
        else
          render :new
        end
      end

      format.json do
        json_obj = {}

        if saved
          json_obj["error"] = false
          json_obj["status"] = {}
          json_obj["user"] = @user_session
          render json: json_obj
        else
          json_obj["error"] = true
          json_obj["status"] = {
            "messages": @user_session.errors.full_messages,
          }
          json_obj["user"] = @user_session
          render json: json_obj
        end
      end
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = "Logged Out Successfully!"
    redirect_to root_url
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end
