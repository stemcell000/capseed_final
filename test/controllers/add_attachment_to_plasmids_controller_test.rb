require 'test_helper'

class AddAttachmentToPlasmidsControllerTest < ActionController::TestCase
  setup do
    @add_attachment_to_plasmid = add_attachment_to_plasmids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:add_attachment_to_plasmids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create add_attachment_to_plasmid" do
    assert_difference('AddAttachmentToPlasmid.count') do
      post :create, add_attachment_to_plasmid: { attachment: @add_attachment_to_plasmid.attachment, plamsid_batch_id: @add_attachment_to_plasmid.plamsid_batch_id }
    end

    assert_redirected_to add_attachment_to_plasmid_path(assigns(:add_attachment_to_plasmid))
  end

  test "should show add_attachment_to_plasmid" do
    get :show, id: @add_attachment_to_plasmid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @add_attachment_to_plasmid
    assert_response :success
  end

  test "should update add_attachment_to_plasmid" do
    patch :update, id: @add_attachment_to_plasmid, add_attachment_to_plasmid: { attachment: @add_attachment_to_plasmid.attachment, plamsid_batch_id: @add_attachment_to_plasmid.plamsid_batch_id }
    assert_redirected_to add_attachment_to_plasmid_path(assigns(:add_attachment_to_plasmid))
  end

  test "should destroy add_attachment_to_plasmid" do
    assert_difference('AddAttachmentToPlasmid.count', -1) do
      delete :destroy, id: @add_attachment_to_plasmid
    end

    assert_redirected_to add_attachment_to_plasmids_path
  end
end
