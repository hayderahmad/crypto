require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should show profile" do
    user = User.create(name: "Haider", email: "hayderahmad@yahoo.com", password: "123456")
    sign_in_as(user)
    get user_url(user)
    assert_response :success
  end
  # test "should fail showing profile" do
  #   sign_in_as('sam')
  #   get user_url
  #   assert_response :success
  # end
end
