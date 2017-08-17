require 'test_helper'

class InsertsControllerTest < ActionController::TestCase
  setup do
    @insert = inserts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inserts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insert" do
    assert_difference('Insert.count') do
      post :create, insert: {  }
    end

    assert_redirected_to insert_path(assigns(:insert))
  end

  test "should show insert" do
    get :show, id: @insert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insert
    assert_response :success
  end

  test "should update insert" do
    patch :update, id: @insert, insert: {  }
    assert_redirected_to insert_path(assigns(:insert))
  end

  test "should destroy insert" do
    assert_difference('Insert.count', -1) do
      delete :destroy, id: @insert
    end

    assert_redirected_to inserts_path
  end
end
