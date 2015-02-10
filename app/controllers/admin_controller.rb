class AdminController < ApplicationController
  before_filter :check_admin, except: [:new_session, :create_session]
  layout "admin", except: [:new_session, :create_session]

  def show
  end

  def new_session
    render layout: nil
  end

  def create_session
    ps = params.permit(:name, :password)
    user = User.authenticate(ps[:name], ps[:password])
    if user
      session[:user_id] = user.id
      redirect_to admin_path
    else
      render "new_session", layout: nil
    end
  end

  def destroy_session
    session[:user_id] = nil
    redirect_to login_path
  end
end
