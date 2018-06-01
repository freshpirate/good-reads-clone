class MyBooksController < ApplicationController

  before_filter :require_user, :only => [:index]
  def index
    @statuses = current_user.statuses.paginate(page: params[:page])
  end
end
