require 'test_helper'

class SterilitytestsControllerTest < ActionController::TestCase
  setup do
    @sterilitytest = sterilitytests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sterilitytests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sterilitytest" do
    assert_difference('Sterilitytest.count') do
      post :create, sterilitytest: {  }
    end

    assert_redirected_to sterilitytest_path(assigns(:sterilitytest))
  end

  test "should show sterilitytest" do
    get :show, id: @sterilitytest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sterilitytest
    assert_response :success
  end

  test "should update sterilitytest" do
    patch :update, id: @sterilitytest, sterilitytest: {  }
    assert_redirected_to sterilitytest_path(assigns(:sterilitytest))
  end

  test "should destroy sterilitytest" do
    assert_difference('Sterilitytest.count', -1) do
      delete :destroy, id: @sterilitytest
    end

    assert_redirected_to sterilitytests_path
  end
end
