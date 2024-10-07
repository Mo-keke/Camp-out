require "test_helper"

class Public::CampMealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_camp_meals_index_url
    assert_response :success
  end
end
