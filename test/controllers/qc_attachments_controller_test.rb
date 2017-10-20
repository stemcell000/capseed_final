require 'test_helper'

class QcAttachmentsControllerTest < ActionController::TestCase
  setup do
    @qc_attachment = qc_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qc_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qc_attachment" do
    assert_difference('QcAttachment.count') do
      post :create, qc_attachment: { attachment: @qc_attachment.attachment }
    end

    assert_redirected_to qc_attachment_path(assigns(:qc_attachment))
  end

  test "should show qc_attachment" do
    get :show, id: @qc_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qc_attachment
    assert_response :success
  end

  test "should update qc_attachment" do
    patch :update, id: @qc_attachment, qc_attachment: { attachment: @qc_attachment.attachment }
    assert_redirected_to qc_attachment_path(assigns(:qc_attachment))
  end

  test "should destroy qc_attachment" do
    assert_difference('CloneBatchQcAttachment.count', -1) do
      delete :destroy, id: @qc_attachment
    end

    assert_redirected_to qc_attachments_path
  end
end
