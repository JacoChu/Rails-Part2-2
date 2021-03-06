class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def edit
  end
  
  def show
  end

  def update

    if @user.update(user_params)
      redirect_to edit_user_path, notice: "修改成功"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:time_zone, profile_attributes:
                                [:id, :legal_name, :birthday, 
                                :location, :education, :occupation,
                                :bio, :specialty] )
  end
  
  def find_user
    @user = current_user
    @user.create_profile unless @user.profile
  end

end
