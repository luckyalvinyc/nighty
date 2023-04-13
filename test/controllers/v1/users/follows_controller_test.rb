require "test_helper"

class V1::Users::FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should follow user" do
    alvin = users(:alvin)

    post v1_user_follows_url(alvin.id)

    data = JSON.parse(body)

    assert_equal data, {"ok" => true}
    assert_equal status, 201

    lucky = users(:lucky)

    assert_equal lucky.following.size, 1
    assert_equal lucky.following.first.followed, alvin
  end

  test "should respond with bad request when user is already followed" do
    alvin = users(:alvin)

    post v1_user_follows_url(alvin.id)
    post v1_user_follows_url(alvin.id)

    data = JSON.parse(body)

    assert_equal data, {"message" => "Already followed the user."}
    assert_equal status, 400
  end

  test "should respond with bad request when following self" do
    post v1_user_follows_url(1)

    data = JSON.parse(body)

    assert_equal data, {"message" => "Cannot follow self."}
    assert_equal status, 400
  end

  test "should respond with not found when following a user that does not exist" do
    post v1_user_follows_url(2)

    data = JSON.parse(body)

    assert_equal data, {"message" => "User 2 does not exist."}
    assert_equal status, 404
  end

  test "should unfollow user" do
    lucky = users(:lucky)
    alvin = users(:alvin)

    lucky.follow!(alvin)
    assert_equal lucky.following.size, 1

    delete v1_user_follows_url(alvin.id)

    data = JSON.parse(body)

    assert_equal lucky.following.size, 0
    assert_equal data, {"ok" => true}
    assert_equal status, 200
  end

  test "should respond with bad request when user is already unfollowed" do
    lucky = users(:lucky)
    alvin = users(:alvin)

    lucky.follow!(alvin)

    delete v1_user_follows_url(alvin.id)
    delete v1_user_follows_url(alvin.id)

    data = JSON.parse(body)

    assert_equal data, {"message" => "Already unfollowed the user."}
    assert_equal status, 400
  end

  test "should respond with not found when unfollowing a user that does not exist" do
    delete v1_user_follows_url(2)

    data = JSON.parse(body)

    assert_equal data, {"message" => "User 2 does not exist."}
    assert_equal status, 404
  end
end
