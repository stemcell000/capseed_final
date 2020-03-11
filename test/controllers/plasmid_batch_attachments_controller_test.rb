require 'test_helper'

class PlasmidBatchAttachmentsControllerTest < ActionController::TestCase
  setup do
    @plasmid_batch_attachment = plasmid_batch_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plasmid_batch_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plasmid_batch_attachment" do
    assert_difference('PlasmidBatchAttachment.count') do
      post :create, plasmid_batch_attachment: {  }
    end

    assert_redirected_to plasmid_batch_attachment_path(assigns(:plasmid_batch_attachment))
  end

  test "should show plasmid_batch_attachment" do
    get :show, id: @plasmid_batch_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plasmid_batch_attachment
    assert_response :success
  end

  test "should update plasmid_batch_attachment" do
    patch :update, id: @plasmid_batch_attachment, plasmid_batch_attachment: {  }
    assert_redirected_to plasmid_batch_attachment_path(assigns(:plasmid_batch_attachment))
  end

  test "should destroy plasmid_batch_attachment" do
    assert_difference('PlasmidBatchAttachment.count', -1) do
      delete :destroy, id: @plasmid_batch_attachment
    end

    assert_redirected_to plasmid_batch_attachments_path
  end
end
