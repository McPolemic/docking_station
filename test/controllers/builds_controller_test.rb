require 'test_helper'

class BuildsControllerTest < ActionController::TestCase
  setup do
    @build = builds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:builds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create build" do
    assert_difference('Build.count') do
      post :create, build: { build_output: @build.build_output, build_status: @build.build_status, commit: @build.commit, deployment_output: @build.deployment_output, deployment_status: @build.deployment_status, name: @build.name, project_id: @build.project_id, test_output: @build.test_output, test_status: @build.test_status }
    end

    assert_redirected_to build_path(assigns(:build))
  end

  test "should show build" do
    get :show, id: @build
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @build
    assert_response :success
  end

  test "should update build" do
    patch :update, id: @build, build: { build_output: @build.build_output, build_status: @build.build_status, commit: @build.commit, deployment_output: @build.deployment_output, deployment_status: @build.deployment_status, name: @build.name, project_id: @build.project_id, test_output: @build.test_output, test_status: @build.test_status }
    assert_redirected_to build_path(assigns(:build))
  end

  test "should destroy build" do
    assert_difference('Build.count', -1) do
      delete :destroy, id: @build
    end

    assert_redirected_to builds_path
  end
end
