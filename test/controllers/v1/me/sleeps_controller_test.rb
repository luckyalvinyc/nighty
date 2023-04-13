require "test_helper"

class V1::Me::SleepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:lucky)
    Activity.where(user: user).delete_all
  end

  test "should create an activity" do
    post v1_me_sleep_url

    activities = JSON.parse(body)

    assert_equal activities.size, 1
    assert_equal activities.first.keys, %w[id slept_at woke_up_at]
    assert_nil activities.first['woke_up_at']
    assert_equal status, 201
  end

  test "should respond with bad request" do
    post v1_me_sleep_url
    post v1_me_sleep_url

    data = JSON.parse(body)

    assert_equal data, {"message" => "You need to wake up first before sleeping again."}
    assert_equal status, 400
  end
end
