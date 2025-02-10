require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "マイページ表示" do
    password = "password123"
    user = User.new(email: 'test@example.com', password: password)
    user.save

    visit new_login_url
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: password
    click_on "保存"
    assert_text "さん"
  end
end
