require 'test_helper'

class PlasmidBatchQcsControllerTest < ActionController::TestCase
  setup do
    @plasmid_batch_qc = plasmid_batch_qcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plasmid_batch_qcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plasmid_batch_qc" do
    assert_difference('PlasmidBatchQc.count') do
      post :create, plasmid_batch_qc: { comments: @plasmid_batch_qc.comments, dig_other: @plasmid_batch_qc.dig_other, dig_smal: @plasmid_batch_qc.dig_smal, itr: @plasmid_batch_qc.itr }
    end

    assert_redirected_to plasmid_batch_qc_path(assigns(:plasmid_batch_qc))
  end

  test "should show plasmid_batch_qc" do
    get :show, id: @plasmid_batch_qc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plasmid_batch_qc
    assert_response :success
  end

  test "should update plasmid_batch_qc" do
    patch :update, id: @plasmid_batch_qc, plasmid_batch_qc: { comments: @plasmid_batch_qc.comments, dig_other: @plasmid_batch_qc.dig_other, dig_smal: @plasmid_batch_qc.dig_smal, itr: @plasmid_batch_qc.itr }
    assert_redirected_to plasmid_batch_qc_path(assigns(:plasmid_batch_qc))
  end

  test "should destroy plasmid_batch_qc" do
    assert_difference('PlasmidBatchQc.count', -1) do
      delete :destroy, id: @plasmid_batch_qc
    end

    assert_redirected_to plasmid_batch_qcs_path
  end
end
