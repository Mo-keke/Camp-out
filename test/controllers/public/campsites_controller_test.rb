require "test_helper"

class Public::CampsitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_campsites_index_url
    assert_response :success
  end
end
