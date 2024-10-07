require "test_helper"

class Public::CampLayoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_camp_layouts_index_url
    assert_response :success
  end
end
