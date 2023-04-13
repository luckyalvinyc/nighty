require "test_helper"

class V1::Me::WakeUpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:lucky)
    user.sleep!
  end

  test "should update the value of `woke_up_at`" do
    post v1_me_wake_up_url

    activity = JSON.parse(body)

    assert_equal activity.keys, %w[id slept_at woke_up_at]
    assert_not_nil activity["woke_up_at"]
    assert_equal status, 200
  end

  test "should respond with bad request" do
    post v1_me_wake_up_url
    post v1_me_wake_up_url

    data = JSON.parse(body)

    assert_equal data, {"message" => "You've already woken up."}
    assert_equal status, 400
  end
end
