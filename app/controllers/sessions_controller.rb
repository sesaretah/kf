class SessionsController < Devise::SessionsController

  def new
    if !params[:user].blank?
      params[:user][:username] = params[:user][:username].split('_')[1]
    end
    super
  end

  def create
    # this is to ensure that each user only is uniqe in every subdomain.
    # thus a user with same mobile phone number can authenticate in various subdmain
    params[:user][:username] = request.subdomain+'_'+params[:user][:username]
    request.params[:user].merge!(params[:user])
    warden.clear_strategies_cache!(:scope => :user)
    super
  end

end
