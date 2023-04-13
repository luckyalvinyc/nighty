require "test_helper"

class V1::Users::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lucky = users(:lucky)

    Activity.where(user: @lucky).delete_all

    3.times do |n|
      @lucky.sleep!

      travel_to Time.current + n.hours do
        @lucky.wake_up!
      end
    end
  end

  test "should list all activities" do
    get v1_user_activities_url(@lucky.id)

    activities = JSON.parse(body)

    assert_equal activities.size, 3
    assert_nil headers["Link"]
    assert_equal status, 200
  end

  test "should add the next page to the Link response header" do
    get v1_user_activities_url(@lucky.id), params: { per_page: 1 }

    activities = JSON.parse(body)

    assert_equal activities.size, 1
    assert_equal status, 200

    link_header_rel = headers["Link"].split(";").last.strip

    assert_equal link_header_rel, "rel=\"next\""
  end

  test "should add the previous page to the Link response header" do
    get v1_user_activities_url(@lucky.id), params: { page: 2, per_page: 1 }

    activities = JSON.parse(body)

    assert_equal activities.size, 1
    assert_equal status, 200

    link_header_rel = headers["Link"].split(";").last.strip

    assert_equal link_header_rel, "rel=\"prev\""
  end

  test "should respond with not found when user does not exist" do
    get v1_user_activities_url(2)

    data = JSON.parse(body)

    assert_equal data, {"message" => "User 2 does not exist."}
    assert_equal status, 404
  end
end
