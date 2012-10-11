require 'test_helper'

class LaunchControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get launch" do
    get :launch
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get stop" do
    get :stop
    assert_response :success
  end

  test "should get pause" do
    get :pause
    assert_response :success
  end

  test "should get resume" do
    get :resume
    assert_response :success
  end

  test "should get restart" do
    get :restart
    assert_response :success
  end

  test "should get snapshot" do
    get :snapshot
    assert_response :success
  end

  test "should get clone" do
    get :clone
    assert_response :success
  end

end
