require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "ログイン" do
    password = "password123"
    user = User.new(email: 'test@example.com', password: password)
    user.save

    visit new_login_url
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: password
    click_on "ログイン"

    assert_text "ログインしました"
  end

  test "新規登録" do
    visit new_user_url
    fill_in "名前", with: "Test User"
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: 'password123'
    fill_in "パスワード（確認）", with: 'password123'
    click_on "保存"

    assert_text "新規登録に成功しました"
  end
end
