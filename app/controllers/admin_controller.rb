class AdminController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  layout "admin"


  private

  def require_admin!
    if not current_user.is_editor?
      flash[:alert] = "您的權限不足"
      redirect_to root_path
    end
  end

  def require_editor!
    if not current_user.is_admin?
      flash[:alert] = "您的權限不足"
      redirect_to root_path
    end
  end
end
