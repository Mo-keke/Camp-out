require "test_helper"

class Public::InquiresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_inquires_new_url
    assert_response :success
  end
end
