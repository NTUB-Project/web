require "application_system_test_case"

class ActivityKindsTest < ApplicationSystemTestCase
  setup do
    @activity_kind = activity_kinds(:one)
  end

  test "visiting the index" do
    visit activity_kinds_url
    assert_selector "h1", text: "Activity Kinds"
  end

  test "creating a Activity kind" do
    visit activity_kinds_url
    click_on "New Activity Kind"

    fill_in "Title", with: @activity_kind.title
    click_on "Create Activity kind"

    assert_text "Activity kind was successfully created"
    click_on "Back"
  end

  test "updating a Activity kind" do
    visit activity_kinds_url
    click_on "Edit", match: :first

    fill_in "Title", with: @activity_kind.title
    click_on "Update Activity kind"

    assert_text "Activity kind was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity kind" do
    visit activity_kinds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity kind was successfully destroyed"
  end
end
