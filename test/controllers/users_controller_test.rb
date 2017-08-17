require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get inform" do
    get :inform
    assert_response :success
  end

end
