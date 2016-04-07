class UsersController < ApplicationController
  def index
    @q = User.search(params[:q])
    @users = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10 )
    respond_with @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with @user, location: users_admin_index_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    @user.update_attributes(user_params)
    respond_with @user, location: users_admin_index_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

