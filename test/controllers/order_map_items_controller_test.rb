require 'test_helper'

class OrderMapItemsControllerTest < ActionController::TestCase
  setup do
    @order_map_item = order_map_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_map_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_map_item" do
    assert_difference('OrderMapItem.count') do
      post :create, order_map_item: { item_id: @order_map_item.item_id, order_id: @order_map_item.order_id }
    end

    assert_redirected_to order_map_item_path(assigns(:order_map_item))
  end

  test "should show order_map_item" do
    get :show, id: @order_map_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_map_item
    assert_response :success
  end

  test "should update order_map_item" do
    patch :update, id: @order_map_item, order_map_item: { item_id: @order_map_item.item_id, order_id: @order_map_item.order_id }
    assert_redirected_to order_map_item_path(assigns(:order_map_item))
  end

  test "should destroy order_map_item" do
    assert_difference('OrderMapItem.count', -1) do
      delete :destroy, id: @order_map_item
    end

    assert_redirected_to order_map_items_path
  end
end
