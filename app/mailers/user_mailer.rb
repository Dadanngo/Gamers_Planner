class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = activate_users_url(id: user.activation_token)
    mail(to: user.email, subject: "【GamersPlanner】アカウントを有効化してください")
  end

  def activation_success_email(user)
    @user = user
    mail(to: @user.email, subject: "【GamersPlanner】会員登録完了のお知らせ")
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: @user.email, subject: "【GamersPlanner】パスワード再設定のご案内")
  end
end
