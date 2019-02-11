require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get receipts_index_url
    assert_response :success
  end

end
