require "test_helper"

class V1::Me::AnalyticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    lucky = users(:lucky)
    alvin = users(:alvin)
    john = users(:john)
    doe = users(:doe)

    lucky.follow!(alvin)
    lucky.follow!(john)
    lucky.follow!(doe)

    travel_to 1.day.ago do
      alvin.sleep!
      john.sleep!
      doe.sleep!
    end

    travel_to 1.day.ago + 5.minutes do
      alvin.wake_up!
    end

    travel_to 1.day.ago + 5.hours do
      john.wake_up!
    end

    travel_to 2.weeks.ago + 8.hours do
      doe.wake_up!
    end
  end

  test "should list all friends sleep duration for the past 1 week" do
    get v1_me_analytics_url

    analytics = JSON.parse(body)

    assert_equal analytics.size, 2
    assert_nil headers["Link"]
    assert_equal status, 200
  end

  test "should add the next page to the Link response header" do
    get v1_me_analytics_url, params: {per_page: 1}

    analytics = JSON.parse(body)

    assert_equal analytics.size, 1
    assert_equal status, 200

    link_header_rel = headers["Link"].split(";").last.strip

    assert_equal link_header_rel, "rel=\"next\""
  end

  test "should add the previous page to the Link response header" do
    get v1_me_analytics_url, params: {page: 2, per_page: 1}

    analytics = JSON.parse(body)

    assert_equal analytics.size, 1
    assert_equal status, 200

    link_header_rel = headers["Link"].split(";").last.strip

    assert_equal link_header_rel, "rel=\"prev\""
  end
end
