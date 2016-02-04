class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)

      if params[:session][:remember_me] == '1'
        puts "########################################################################"
        puts "########################################################################"
        puts "rememmm"
        puts "########################################################################"
        puts "########################################################################"
      else
        puts "########################################################################"
        puts "########################################################################"
        puts "no rememmmm"
        puts "########################################################################"
        puts "########################################################################"
      end

      redirect_to user
    else
      flash.now[:danger] = "Wrong email or pass"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
