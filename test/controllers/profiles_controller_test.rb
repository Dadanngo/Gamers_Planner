require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "マイページ表示" do
    password = "password123"
    user = User.new(email: 'test@example.com', password: password)
    user.save

    get profile_url(user)
    assert_response :success
  end
end
