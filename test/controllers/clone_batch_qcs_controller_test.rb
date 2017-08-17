require 'test_helper'

class CloneBatchQcsControllerTest < ActionController::TestCase
  setup do
    @clone_batch_qc = clone_batch_qcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clone_batch_qcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clone_batch_qc" do
    assert_difference('CloneBatchQc.count') do
      post :create, clone_batch_qc: { date_rec: @clone_batch_qc.date_rec, date_send: @clone_batch_qc.date_send, op: @clone_batch_qc.op, primer_name: @clone_batch_qc.primer_name, primer_nb: @clone_batch_qc.primer_nb, rec_name: @clone_batch_qc.rec_name, result: @clone_batch_qc.result }
    end

    assert_redirected_to clone_batch_qc_path(assigns(:clone_batch_qc))
  end

  test "should show clone_batch_qc" do
    get :show, id: @clone_batch_qc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clone_batch_qc
    assert_response :success
  end

  test "should update clone_batch_qc" do
    patch :update, id: @clone_batch_qc, clone_batch_qc: { date_rec: @clone_batch_qc.date_rec, date_send: @clone_batch_qc.date_send, op: @clone_batch_qc.op, primer_name: @clone_batch_qc.primer_name, primer_nb: @clone_batch_qc.primer_nb, rec_name: @clone_batch_qc.rec_name, result: @clone_batch_qc.result }
    assert_redirected_to clone_batch_qc_path(assigns(:clone_batch_qc))
  end

  test "should destroy clone_batch_qc" do
    assert_difference('CloneBatchQc.count', -1) do
      delete :destroy, id: @clone_batch_qc
    end

    assert_redirected_to clone_batch_qcs_path
  end
end
