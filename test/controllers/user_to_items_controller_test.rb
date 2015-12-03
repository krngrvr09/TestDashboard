require 'test_helper'

class UserToItemsControllerTest < ActionController::TestCase
  setup do
    @user_to_item = user_to_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_to_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_to_item" do
    assert_difference('UserToItem.count') do
      post :create, user_to_item: { item_id: @user_to_item.item_id, user_id: @user_to_item.user_id }
    end

    assert_redirected_to user_to_item_path(assigns(:user_to_item))
  end

  test "should show user_to_item" do
    get :show, id: @user_to_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_to_item
    assert_response :success
  end

  test "should update user_to_item" do
    patch :update, id: @user_to_item, user_to_item: { item_id: @user_to_item.item_id, user_id: @user_to_item.user_id }
    assert_redirected_to user_to_item_path(assigns(:user_to_item))
  end

  test "should destroy user_to_item" do
    assert_difference('UserToItem.count', -1) do
      delete :destroy, id: @user_to_item
    end

    assert_redirected_to user_to_items_path
  end
end
