require 'test_helper'

class PlasmidsControllerTest < ActionController::TestCase
  setup do
    @plasmid = plasmids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plasmids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plasmid" do
    assert_difference('Plasmid.count') do
      post :create, plasmid: { brand: @plasmid.brand, comment: @plasmid.comment, date: @plasmid.date, gene: @plasmid.gene, glyc_stock: @plasmid.glyc_stock, glyc_stock_box: @plasmid.glyc_stock_box, name: @plasmid.name, nb: @plasmid.nb, origin: @plasmid.origin, promoter: @plasmid.promoter, type: @plasmid.type }
    end

    assert_redirected_to plasmid_path(assigns(:plasmid))
  end

  test "should show plasmid" do
    get :show, id: @plasmid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plasmid
    assert_response :success
  end

  test "should update plasmid" do
    patch :update, id: @plasmid, plasmid: { brand: @plasmid.brand, comment: @plasmid.comment, date: @plasmid.date, gene: @plasmid.gene, glyc_stock: @plasmid.glyc_stock, glyc_stock_box: @plasmid.glyc_stock_box, name: @plasmid.name, nb: @plasmid.nb, origin: @plasmid.origin, promoter: @plasmid.promoter, type: @plasmid.type }
    assert_redirected_to plasmid_path(assigns(:plasmid))
  end

  test "should destroy plasmid" do
    assert_difference('Plasmid.count', -1) do
      delete :destroy, id: @plasmid
    end

    assert_redirected_to plasmids_path
  end
end
