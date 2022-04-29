require "application_system_test_case"

class VisualMediaTest < ApplicationSystemTestCase
  setup do
    @visual_medium = visual_media(:one)
  end

  test "visiting the index" do
    visit visual_media_url
    assert_selector "h1", text: "Visual media"
  end

  test "should create visual medium" do
    visit visual_media_url
    click_on "New visual medium"

    fill_in "Author", with: @visual_medium.author
    fill_in "Date", with: @visual_medium.date
    fill_in "Description", with: @visual_medium.description
    fill_in "Location", with: @visual_medium.location
    fill_in "Media", with: @visual_medium.media
    fill_in "Priority index", with: @visual_medium.priority_index
    fill_in "Project", with: @visual_medium.project_id
    fill_in "Title", with: @visual_medium.title
    fill_in "Url", with: @visual_medium.url
    click_on "Create Visual medium"

    assert_text "Visual medium was successfully created"
    click_on "Back"
  end

  test "should update Visual medium" do
    visit visual_medium_url(@visual_medium)
    click_on "Edit this visual medium", match: :first

    fill_in "Author", with: @visual_medium.author
    fill_in "Date", with: @visual_medium.date
    fill_in "Description", with: @visual_medium.description
    fill_in "Location", with: @visual_medium.location
    fill_in "Media", with: @visual_medium.media
    fill_in "Priority index", with: @visual_medium.priority_index
    fill_in "Project", with: @visual_medium.project_id
    fill_in "Title", with: @visual_medium.title
    fill_in "Url", with: @visual_medium.url
    click_on "Update Visual medium"

    assert_text "Visual medium was successfully updated"
    click_on "Back"
  end

  test "should destroy Visual medium" do
    visit visual_medium_url(@visual_medium)
    click_on "Destroy this visual medium", match: :first

    assert_text "Visual medium was successfully destroyed"
  end
end
