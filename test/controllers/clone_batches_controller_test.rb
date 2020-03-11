require 'test_helper'

class CloneBatchesControllerTest < ActionController::TestCase
  setup do
    @clone_batch = clone_batches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clone_batches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clone_batch" do
    assert_difference('CloneBatch.count') do
      post :create, clone_batch: { comment: @clone_batch.comment, name: @clone_batch.name, promoted: @clone_batch.promoted }
    end

    assert_redirected_to clone_batch_path(assigns(:clone_batch))
  end

  test "should show clone_batch" do
    get :show, id: @clone_batch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clone_batch
    assert_response :success
  end

  test "should update clone_batch" do
    patch :update, id: @clone_batch, clone_batch: { comment: @clone_batch.comment, name: @clone_batch.name, promoted: @clone_batch.promoted }
    assert_redirected_to clone_batch_path(assigns(:clone_batch))
  end

  test "should destroy clone_batch" do
    assert_difference('CloneBatch.count', -1) do
      delete :destroy, id: @clone_batch
    end

    assert_redirected_to clone_batches_path
  end
end
