class UsersController < ApplicationController
  #この文を先頭に書くとこのコントローラー内のアクションはログイン状態時のみ実行できる
  before_action :authenticate_user!

  #以下アクション部分
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "update is done successfully"
      redirect_to user_path(@user.id)
    else
      flash[:notice] = "error to Update"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
