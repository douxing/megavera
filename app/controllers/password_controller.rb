class PasswordController < ApplicationController
  layout "admin"

  def new
  end

  def create
  end

  def edit
  end

  def update
    if current_user.update_attributes(params.permit(:current_password, :password, :password_confirmation))
      session[:admin] = nil
      redirect_to admin_path
    else
      render "edit"
    end
  end
end
