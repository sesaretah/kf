require 'test_helper'

class SegmentationsControllerTest < ActionController::TestCase
  setup do
    @segmentation = segmentations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:segmentations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create segmentation" do
    assert_difference('Segmentation.count') do
      post :create, segmentation: { ext_code: @segmentation.ext_code, product_id: @segmentation.product_id, segment_id: @segmentation.segment_id }
    end

    assert_redirected_to segmentation_path(assigns(:segmentation))
  end

  test "should show segmentation" do
    get :show, id: @segmentation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @segmentation
    assert_response :success
  end

  test "should update segmentation" do
    patch :update, id: @segmentation, segmentation: { ext_code: @segmentation.ext_code, product_id: @segmentation.product_id, segment_id: @segmentation.segment_id }
    assert_redirected_to segmentation_path(assigns(:segmentation))
  end

  test "should destroy segmentation" do
    assert_difference('Segmentation.count', -1) do
      delete :destroy, id: @segmentation
    end

    assert_redirected_to segmentations_path
  end
end
