require 'test_helper'

class ProviderControllerTest < ActionController::TestCase
  test "should get select" do
    get :select
    assert_response :success
  end

end
