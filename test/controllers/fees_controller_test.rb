require 'test_helper'

class FeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fees_index_url
    assert_response :success
  end

end
