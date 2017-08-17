require 'test_helper'

class CloneAttachmentsControllerTest < ActionController::TestCase
  setup do
    @clone_attachment = clone_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clone_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clone_attachment" do
    assert_difference('CloneAttachment.count') do
      post :create, clone_attachment: { clone_id: @clone_attachment.clone_id, filename: @clone_attachment.filename }
    end

    assert_redirected_to clone_attachment_path(assigns(:clone_attachment))
  end

  test "should show clone_attachment" do
    get :show, id: @clone_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clone_attachment
    assert_response :success
  end

  test "should update clone_attachment" do
    patch :update, id: @clone_attachment, clone_attachment: { clone_id: @clone_attachment.clone_id, filename: @clone_attachment.filename }
    assert_redirected_to clone_attachment_path(assigns(:clone_attachment))
  end

  test "should destroy clone_attachment" do
    assert_difference('CloneAttachment.count', -1) do
      delete :destroy, id: @clone_attachment
    end

    assert_redirected_to clone_attachments_path
  end
end
