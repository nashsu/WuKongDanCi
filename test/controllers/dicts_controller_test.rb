require 'test_helper'

class DictsControllerTest < ActionController::TestCase
  setup do
    @dict = dicts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dicts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dict" do
    assert_difference('Dict.count') do
      post :create, dict: { desc: @dict.desc, name: @dict.name }
    end

    assert_redirected_to dict_path(assigns(:dict))
  end

  test "should show dict" do
    get :show, id: @dict
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dict
    assert_response :success
  end

  test "should update dict" do
    patch :update, id: @dict, dict: { desc: @dict.desc, name: @dict.name }
    assert_redirected_to dict_path(assigns(:dict))
  end

  test "should destroy dict" do
    assert_difference('Dict.count', -1) do
      delete :destroy, id: @dict
    end

    assert_redirected_to dicts_path
  end
end
