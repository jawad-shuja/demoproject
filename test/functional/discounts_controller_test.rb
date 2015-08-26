require 'test_helper'

class DiscountsControllerTest < ActionController::TestCase
  test "should get validate" do
    get :validate
    assert_response :success
  end

end
