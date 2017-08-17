require 'test_helper'

class CloneBatchAsPlasmidAttachmentsControllerTest < ActionController::TestCase
  setup do
    @clone_batch_as_plasmid_attachment = clone_batch_as_plasmid_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clone_batch_as_plasmid_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clone_batch_as_plasmid_attachment" do
    assert_difference('CloneBatchAsPlasmidAttachment.count') do
      post :create, clone_batch_as_plasmid_attachment: {  }
    end

    assert_redirected_to clone_batch_as_plasmid_attachment_path(assigns(:clone_batch_as_plasmid_attachment))
  end

  test "should show clone_batch_as_plasmid_attachment" do
    get :show, id: @clone_batch_as_plasmid_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clone_batch_as_plasmid_attachment
    assert_response :success
  end

  test "should update clone_batch_as_plasmid_attachment" do
    patch :update, id: @clone_batch_as_plasmid_attachment, clone_batch_as_plasmid_attachment: {  }
    assert_redirected_to clone_batch_as_plasmid_attachment_path(assigns(:clone_batch_as_plasmid_attachment))
  end

  test "should destroy clone_batch_as_plasmid_attachment" do
    assert_difference('CloneBatchAsPlasmidAttachment.count', -1) do
      delete :destroy, id: @clone_batch_as_plasmid_attachment
    end

    assert_redirected_to clone_batch_as_plasmid_attachments_path
  end
end
