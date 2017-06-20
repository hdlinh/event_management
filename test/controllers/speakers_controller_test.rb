require 'test_helper'

class SpeakersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @speaker = speakers(:one)
  end

  test "should get index" do
    get speakers_url
    assert_response :success
  end

  test "should get new" do
    get new_speaker_url
    assert_response :success
  end

  test "should create speaker" do
    assert_difference('Speaker.count') do
      post speakers_url, params: { speaker: { sp_avatar: @speaker.sp_avatar, sp_description: @speaker.sp_description, sp_email: @speaker.sp_email, sp_firstname: @speaker.sp_firstname, sp_lastname: @speaker.sp_lastname, sp_major: @speaker.sp_major, sp_phone: @speaker.sp_phone } }
    end

    assert_redirected_to speaker_url(Speaker.last)
  end

  test "should show speaker" do
    get speaker_url(@speaker)
    assert_response :success
  end

  test "should get edit" do
    get edit_speaker_url(@speaker)
    assert_response :success
  end

  test "should update speaker" do
    patch speaker_url(@speaker), params: { speaker: { sp_avatar: @speaker.sp_avatar, sp_description: @speaker.sp_description, sp_email: @speaker.sp_email, sp_firstname: @speaker.sp_firstname, sp_lastname: @speaker.sp_lastname, sp_major: @speaker.sp_major, sp_phone: @speaker.sp_phone } }
    assert_redirected_to speaker_url(@speaker)
  end

  test "should destroy speaker" do
    assert_difference('Speaker.count', -1) do
      delete speaker_url(@speaker)
    end

    assert_redirected_to speakers_url
  end
end
