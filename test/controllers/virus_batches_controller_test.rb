require 'test_helper'

class VirusBatchesControllerTest < ActionController::TestCase
  setup do
    @virus_batch = virus_batches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:virus_batches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create virus_batch" do
    assert_difference('VirusBatch.count') do
      post :create, virus_batch: { box_id: @virus_batch.box_id, column_id: @virus_batch.column_id, name: @virus_batch.name, row_id: @virus_batch.row_id, virus_production_id: @virus_batch.virus_production_id }
    end

    assert_redirected_to virus_batch_path(assigns(:virus_batch))
  end

  test "should show virus_batch" do
    get :show, id: @virus_batch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @virus_batch
    assert_response :success
  end

  test "should update virus_batch" do
    patch :update, id: @virus_batch, virus_batch: { box_id: @virus_batch.box_id, column_id: @virus_batch.column_id, name: @virus_batch.name, row_id: @virus_batch.row_id, virus_production_id: @virus_batch.virus_production_id }
    assert_redirected_to virus_batch_path(assigns(:virus_batch))
  end

  test "should destroy virus_batch" do
    assert_difference('VirusBatch.count', -1) do
      delete :destroy, id: @virus_batch
    end

    assert_redirected_to virus_batches_path
  end
end
