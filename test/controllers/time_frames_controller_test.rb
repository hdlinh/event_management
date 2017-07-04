require 'test_helper'

class TimeFramesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_frame = time_frames(:one)
  end

  test "should get index" do
    get time_frames_url
    assert_response :success
  end

  test "should get new" do
    get new_time_frame_url
    assert_response :success
  end

  test "should create time_frame" do
    assert_difference('TimeFrame.count') do
      post time_frames_url, params: { time_frame: { ev_id: @time_frame.ev_id, ro_id: @time_frame.ro_id, sp_id: @time_frame.sp_id, tf_end: @time_frame.tf_end, tf_start: @time_frame.tf_start, tf_title: @time_frame.tf_title } }
    end

    assert_redirected_to time_frame_url(TimeFrame.last)
  end

  test "should show time_frame" do
    get time_frame_url(@time_frame)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_frame_url(@time_frame)
    assert_response :success
  end

  test "should update time_frame" do
    patch time_frame_url(@time_frame), params: { time_frame: { ev_id: @time_frame.ev_id, ro_id: @time_frame.ro_id, sp_id: @time_frame.sp_id, tf_end: @time_frame.tf_end, tf_start: @time_frame.tf_start, tf_title: @time_frame.tf_title } }
    assert_redirected_to time_frame_url(@time_frame)
  end

  test "should destroy time_frame" do
    assert_difference('TimeFrame.count', -1) do
      delete time_frame_url(@time_frame)
    end

    assert_redirected_to time_frames_url
  end
end
