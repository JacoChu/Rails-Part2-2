class Admin::UsersController < ApplicationController
  before_action :find_user, only: %i[edit update]
  before_action :require_admin!
  def index
    @users = User.includes(:groups).all
  end

  def edit
  end

  def update

    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :role, :group_ids => [])
  end
  
  def find_user
    @user = User.find(params[:id])
  end



end
