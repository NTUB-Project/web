require 'test_helper'

class ActivityKindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_kind = activity_kinds(:one)
  end

  test "should get index" do
    get activity_kinds_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_kind_url
    assert_response :success
  end

  test "should create activity_kind" do
    assert_difference('ActivityKind.count') do
      post activity_kinds_url, params: { activity_kind: { title: @activity_kind.title } }
    end

    assert_redirected_to activity_kind_url(ActivityKind.last)
  end

  test "should show activity_kind" do
    get activity_kind_url(@activity_kind)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_kind_url(@activity_kind)
    assert_response :success
  end

  test "should update activity_kind" do
    patch activity_kind_url(@activity_kind), params: { activity_kind: { title: @activity_kind.title } }
    assert_redirected_to activity_kind_url(@activity_kind)
  end

  test "should destroy activity_kind" do
    assert_difference('ActivityKind.count', -1) do
      delete activity_kind_url(@activity_kind)
    end

    assert_redirected_to activity_kinds_url
  end
end
