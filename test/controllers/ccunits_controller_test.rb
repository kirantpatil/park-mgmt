require 'test_helper'

class CcunitsControllerTest < ActionController::TestCase
  setup do
    @ccunit = ccunits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ccunits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ccunit" do
    assert_difference('Ccunit.count') do
      post :create, ccunit: { floor_id: @ccunit.floor_id, ip: @ccunit.ip, port: @ccunit.port }
    end

    assert_redirected_to ccunit_path(assigns(:ccunit))
  end

  test "should show ccunit" do
    get :show, id: @ccunit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ccunit
    assert_response :success
  end

  test "should update ccunit" do
    patch :update, id: @ccunit, ccunit: { floor_id: @ccunit.floor_id, ip: @ccunit.ip, port: @ccunit.port }
    assert_redirected_to ccunit_path(assigns(:ccunit))
  end

  test "should destroy ccunit" do
    assert_difference('Ccunit.count', -1) do
      delete :destroy, id: @ccunit
    end

    assert_redirected_to ccunits_path
  end
end
