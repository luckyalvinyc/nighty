require "test_helper"

class V1::Me::ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    lucky = users(:lucky)

    Activity.where(user: lucky).delete_all

    3.times do |n|
      lucky.sleep!

      travel_to Time.current + n.hours do
        lucky.wake_up!
      end
    end
  end

  test "should list all activities" do
    get v1_me_activities_url

    activities = JSON.parse(body)

    assert_equal activities.size, 3
    assert_nil headers["Link"]
    assert_equal status, 200
  end

  test "should add the next page to the Link response header" do
    get v1_me_activities_url, params: {per_page: 1}

    activities = JSON.parse(body)

    assert_equal activities.size, 1
    assert_equal status, 200

    link_header_rel = headers["Link"].split(";").last.strip

    assert_equal link_header_rel, "rel=\"next\""
  end

  test "should add the previous page to the Link response header" do
    get v1_me_activities_url, params: {page: 2, per_page: 1}

    activities = JSON.parse(body)

    assert_equal activities.size, 1
    assert_equal status, 200

    link_header_rel = headers["Link"].split(";").last.strip

    assert_equal link_header_rel, "rel=\"prev\""
  end
end
