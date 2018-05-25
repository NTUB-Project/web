require 'test_helper'

class PeopleNumbersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @people_number = people_numbers(:one)
  end

  test "should get index" do
    get people_numbers_url
    assert_response :success
  end

  test "should get new" do
    get new_people_number_url
    assert_response :success
  end

  test "should create people_number" do
    assert_difference('PeopleNumber.count') do
      post people_numbers_url, params: { people_number: { title: @people_number.title } }
    end

    assert_redirected_to people_number_url(PeopleNumber.last)
  end

  test "should show people_number" do
    get people_number_url(@people_number)
    assert_response :success
  end

  test "should get edit" do
    get edit_people_number_url(@people_number)
    assert_response :success
  end

  test "should update people_number" do
    patch people_number_url(@people_number), params: { people_number: { title: @people_number.title } }
    assert_redirected_to people_number_url(@people_number)
  end

  test "should destroy people_number" do
    assert_difference('PeopleNumber.count', -1) do
      delete people_number_url(@people_number)
    end

    assert_redirected_to people_numbers_url
  end
end
