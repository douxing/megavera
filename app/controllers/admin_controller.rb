class AdminController < ApplicationController
  layout "admin", except: [:new_session, :create_session]

  def show
  end

  def new_session
    render layout: nil
  end

  def create_session
  end

  def destroy_session
    redirect_to '/login'
  end
end
