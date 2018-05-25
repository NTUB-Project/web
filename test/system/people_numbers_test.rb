require "application_system_test_case"

class PeopleNumbersTest < ApplicationSystemTestCase
  setup do
    @people_number = people_numbers(:one)
  end

  test "visiting the index" do
    visit people_numbers_url
    assert_selector "h1", text: "People Numbers"
  end

  test "creating a People number" do
    visit people_numbers_url
    click_on "New People Number"

    fill_in "Title", with: @people_number.title
    click_on "Create People number"

    assert_text "People number was successfully created"
    click_on "Back"
  end

  test "updating a People number" do
    visit people_numbers_url
    click_on "Edit", match: :first

    fill_in "Title", with: @people_number.title
    click_on "Update People number"

    assert_text "People number was successfully updated"
    click_on "Back"
  end

  test "destroying a People number" do
    visit people_numbers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "People number was successfully destroyed"
  end
end
