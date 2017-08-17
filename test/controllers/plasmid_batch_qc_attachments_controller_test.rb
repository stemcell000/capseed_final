require 'test_helper'

class PlasmidBatchQcAttachmentsControllerTest < ActionController::TestCase
  setup do
    @plasmid_batch_qc_attachment = plasmid_batch_qc_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plasmid_batch_qc_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plasmid_batch_qc_attachment" do
    assert_difference('PlasmidBatchQcAttachment.count') do
      post :create, plasmid_batch_qc_attachment: { attachment: @plasmid_batch_qc_attachment.attachment }
    end

    assert_redirected_to plasmid_batch_qc_attachment_path(assigns(:plasmid_batch_qc_attachment))
  end

  test "should show plasmid_batch_qc_attachment" do
    get :show, id: @plasmid_batch_qc_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plasmid_batch_qc_attachment
    assert_response :success
  end

  test "should update plasmid_batch_qc_attachment" do
    patch :update, id: @plasmid_batch_qc_attachment, plasmid_batch_qc_attachment: { attachment: @plasmid_batch_qc_attachment.attachment }
    assert_redirected_to plasmid_batch_qc_attachment_path(assigns(:plasmid_batch_qc_attachment))
  end

  test "should destroy plasmid_batch_qc_attachment" do
    assert_difference('PlasmidBatchQcAttachment.count', -1) do
      delete :destroy, id: @plasmid_batch_qc_attachment
    end

    assert_redirected_to plasmid_batch_qc_attachments_path
  end
end
