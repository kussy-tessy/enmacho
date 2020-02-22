require 'test_helper'

class KigurumiControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get kigurumi_new_url
    assert_response :success
  end

  test "should get create" do
    get kigurumi_create_url
    assert_response :success
  end

  test "should get edit" do
    get kigurumi_edit_url
    assert_response :success
  end

  test "should get update" do
    get kigurumi_update_url
    assert_response :success
  end

end
