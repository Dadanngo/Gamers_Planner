require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "マイページ表示" do
    user = User.create(email: 'test@example.com', name: 'test_user', password: 'password123', password_confirmation: 'password123')
    post login_path, params: { email: user.email, password: 'password123' }
    get profile_url(user)
    assert_response :success
  end
end
