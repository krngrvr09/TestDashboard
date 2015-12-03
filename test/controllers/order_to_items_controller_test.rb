require 'test_helper'

class OrderToItemsControllerTest < ActionController::TestCase
  setup do
    @order_to_item = order_to_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_to_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_to_item" do
    assert_difference('OrderToItem.count') do
      post :create, order_to_item: { item_id: @order_to_item.item_id, order_id: @order_to_item.order_id }
    end

    assert_redirected_to order_to_item_path(assigns(:order_to_item))
  end

  test "should show order_to_item" do
    get :show, id: @order_to_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_to_item
    assert_response :success
  end

  test "should update order_to_item" do
    patch :update, id: @order_to_item, order_to_item: { item_id: @order_to_item.item_id, order_id: @order_to_item.order_id }
    assert_redirected_to order_to_item_path(assigns(:order_to_item))
  end

  test "should destroy order_to_item" do
    assert_difference('OrderToItem.count', -1) do
      delete :destroy, id: @order_to_item
    end

    assert_redirected_to order_to_items_path
  end
end
