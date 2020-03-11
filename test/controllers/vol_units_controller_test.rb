require 'test_helper'

class VolUnitsControllerTest < ActionController::TestCase
  setup do
    @vol_unit = vol_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vol_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vol_unit" do
    assert_difference('VolUnit.count') do
      post :create, vol_unit: {  }
    end

    assert_redirected_to vol_unit_path(assigns(:vol_unit))
  end

  test "should show vol_unit" do
    get :show, id: @vol_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vol_unit
    assert_response :success
  end

  test "should update vol_unit" do
    patch :update, id: @vol_unit, vol_unit: {  }
    assert_redirected_to vol_unit_path(assigns(:vol_unit))
  end

  test "should destroy vol_unit" do
    assert_difference('VolUnit.count', -1) do
      delete :destroy, id: @vol_unit
    end

    assert_redirected_to vol_units_path
  end
end
