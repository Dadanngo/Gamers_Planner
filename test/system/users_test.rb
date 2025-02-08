require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    visit users_url
    click_on "New user"

    fill_in "メールアドレス", with: @user.email
    fill_in "名前", with: @user.name
    fill_in "パスワード", with: 'password123' # password追加
    fill_in "パスワード（確認）", with: 'password123' # password_confirmation追加
    click_on "保存"

    assert_text "ユーザー登録に成功しました。"
  end

  test "should update User" do
    visit user_url(@user)
    click_on "Edit this user", match: :first

    fill_in "メールアドレス", with: @user.email
    fill_in "名前", with: @user.name
  end

  test "should destroy User" do
    visit user_url(@user)
    click_on "Destroy this user", match: :first

    assert_text "User was successfully destroyed"
  end
end
