require "test_helper"

class VisualMediaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visual_medium = visual_media(:one)
  end

  test "should get index" do
    get visual_media_url
    assert_response :success
  end

  test "should get new" do
    get new_visual_medium_url
    assert_response :success
  end

  test "should create visual_medium" do
    assert_difference("VisualMedium.count") do
      post visual_media_url, params: { visual_medium: { author: @visual_medium.author, date: @visual_medium.date, description: @visual_medium.description, location: @visual_medium.location, media: @visual_medium.media, priority_index: @visual_medium.priority_index, project_id: @visual_medium.project_id, title: @visual_medium.title, url: @visual_medium.url } }
    end

    assert_redirected_to visual_medium_url(VisualMedium.last)
  end

  test "should show visual_medium" do
    get visual_medium_url(@visual_medium)
    assert_response :success
  end

  test "should get edit" do
    get edit_visual_medium_url(@visual_medium)
    assert_response :success
  end

  test "should update visual_medium" do
    patch visual_medium_url(@visual_medium), params: { visual_medium: { author: @visual_medium.author, date: @visual_medium.date, description: @visual_medium.description, location: @visual_medium.location, media: @visual_medium.media, priority_index: @visual_medium.priority_index, project_id: @visual_medium.project_id, title: @visual_medium.title, url: @visual_medium.url } }
    assert_redirected_to visual_medium_url(@visual_medium)
  end

  test "should destroy visual_medium" do
    assert_difference("VisualMedium.count", -1) do
      delete visual_medium_url(@visual_medium)
    end

    assert_redirected_to visual_media_url
  end
end
