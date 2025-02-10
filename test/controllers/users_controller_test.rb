require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "ユーザー作成" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: 'test@example.com', name: 'test_user', password: 'password123', password_confirmation: 'password123' } }
    end
    assert_redirected_to profile_url(User.last)
  end
end
