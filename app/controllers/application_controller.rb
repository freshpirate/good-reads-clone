class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  helper_method :current_user_session, :current_user, :current_user?

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def current_user?(user)
    user == current_user
  end

  def require_user
    unless current_user
      store_location
      notice_str = "You must be logged in to access this page"

      respond_to do |format|
        format.html do
          flash[:notice] = notice_str
          redirect_to root_url
        end

        format.json do
          json_obj = {}
          json_obj["error"] = true
          json_obj["status"] = {}
          json_obj["status"] = {
            "signed_in": true,
            "messages": [notice_str]
          }

          # json_obj["user"] = current_user

          render json: json_obj, error: notice_str
        end
      end
      return false
    end
  end

  def require_admin_privileges
    unless current_user && current_user.admin?
      store_location
      notice_str = "You must be an administrator to access this page"

      respond_to do |format|
        format.html do
          flash[:notice] = notice_str
          redirect_to root_url
        end

        format.json do
          json_obj = {}
          json_obj["error"] = true
          json_obj["status"] = {}
          json_obj["status"] = {
            "signed_in": true,
            "messages": [notice_str]
          }

          # json_obj["user"] = current_user

          render json: json_obj, error: notice_str
        end
      end
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      notice_str = "You must be logged out to access this page"

      respond_to do |format|
        format.html do
          flash[:notice] = notice_str
          redirect_to root_url
        end

        format.json do
          json_obj = {}
          json_obj["error"] = true
          json_obj["status"] = {}
          json_obj["status"] = {
            "signed_in": true,
            "messages": [notice_str]
          }

          # json_obj["user"] = current_user

          render json: json_obj.to_json, error: notice_str
        end
      end
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.url
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
