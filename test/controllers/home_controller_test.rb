require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get principal" do
    get :principal
    assert_response :success
  end

end
