require "test_helper"

class Admin::InquiresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_inquires_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_inquires_show_url
    assert_response :success
  end
end
