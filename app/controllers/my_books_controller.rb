class MyBooksController < ApplicationController
  before_filter :require_user, :only => [:index]

  def index
    @user_book_statuses = current_user.user_book_statuses.paginate(page: params[:page]).preload(:book)
  end
end
