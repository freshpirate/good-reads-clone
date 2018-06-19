class StaticPagesController < ApplicationController
  def home
    if current_user && !current_user.email_confirmation
      current_user_session.destroy
      flash[:warning] = "Please confirm you email first"
      redirect_to sign_in_path
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
