class SessionsController < ApplicationController

  def new
  end

  def create
    profile = Profile.find_by(email: params[:session][:email].downcase)
    if profile && profile.authenticate(params[:session][:password])
      #
      log_in profile
      params[:session][:remember_me] == '1' ? remember(profile) : forget(profile)
      remember profile
      redirect_to profile
    else
      #
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
