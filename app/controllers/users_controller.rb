class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:profile, :edit_profile, :update_profile, :account]

  def profile
    # プロフィール表示のロジック
    # @user には set_user メソッドで現在のユーザーがセットされています
  end

  def edit_profile
    # プロフィール編集ページの表示ロジック
    # @user には set_user メソッドで現在のユーザーがセットされています
  end

  def update_profile
    # プロフィール更新ロジック
    if @user.update(user_params)
      # 更新に成功した場合の処理
      redirect_to users_profile_path, notice: 'プロフィールが更新されました。'
    else
      # 更新に失敗した場合の処理
      render :edit_profile
    end
  end

  def account
  end


  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :icon, :introduction, :profile_image)
  end
end
