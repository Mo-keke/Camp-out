require "test_helper"

class Public::BookMarksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_book_marks_index_url
    assert_response :success
  end
end
