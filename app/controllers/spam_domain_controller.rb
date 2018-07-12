class SpamDomainController < ApplicationController
  def index
    @domain_list = SpamFilter.all
    # byebug
  end

  def create
    SpamFilter[params[:domain]] = 1

    flash[:success] = "Added new Spam"
    redirect_to spam_domain_index_path
  end

  def destroy
    p "^" * 100
    p params
    SpamFilter.delete(params[:domain_name])

    flash[:success] = "Spam deleted"
    redirect_to spam_domain_index_path
  end
end
