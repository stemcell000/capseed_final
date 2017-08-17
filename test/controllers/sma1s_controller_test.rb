require 'test_helper'

class Sma1sControllerTest < ActionController::TestCase
  setup do
    @sma1 = sma1s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sma1s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sma1" do
    assert_difference('Sma1.count') do
      post :create, sma1: {  }
    end

    assert_redirected_to sma1_path(assigns(:sma1))
  end

  test "should show sma1" do
    get :show, id: @sma1
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sma1
    assert_response :success
  end

  test "should update sma1" do
    patch :update, id: @sma1, sma1: {  }
    assert_redirected_to sma1_path(assigns(:sma1))
  end

  test "should destroy sma1" do
    assert_difference('Sma1.count', -1) do
      delete :destroy, id: @sma1
    end

    assert_redirected_to sma1s_path
  end
end
