require 'test_helper'

class ProminentsControllerTest < ActionController::TestCase
  setup do
    @prominent = prominents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prominents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prominent" do
    assert_difference('Prominent.count') do
      post :create, prominent: { level: @prominent.level, product_id: @prominent.product_id, user_id: @prominent.user_id }
    end

    assert_redirected_to prominent_path(assigns(:prominent))
  end

  test "should show prominent" do
    get :show, id: @prominent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prominent
    assert_response :success
  end

  test "should update prominent" do
    patch :update, id: @prominent, prominent: { level: @prominent.level, product_id: @prominent.product_id, user_id: @prominent.user_id }
    assert_redirected_to prominent_path(assigns(:prominent))
  end

  test "should destroy prominent" do
    assert_difference('Prominent.count', -1) do
      delete :destroy, id: @prominent
    end

    assert_redirected_to prominents_path
  end
end
