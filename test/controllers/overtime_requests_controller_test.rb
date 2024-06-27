require "test_helper"

class OvertimeRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get overtime_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get overtime_requests_create_url
    assert_response :success
  end

  test "should get index" do
    get overtime_requests_index_url
    assert_response :success
  end

  test "should get export" do
    get overtime_requests_export_url
    assert_response :success
  end
end
