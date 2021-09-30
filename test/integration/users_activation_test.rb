require 'test_helper'

class UsersActivationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

def setup
  @activated = users(:michael)
  @non_activated = users(:red)
end

test "non-activated_user don't exist in index page" do
  log_in_as(@activated)
  get users_path
  assert_template 'users/index'
  assert_select 'div.pagination'
  assert_select 'a[href=?]', user_path(@activated), text: @activated.name
  assert_select 'a[href=?]', user_path(@non_activated), text: @non_activated.name, count: 0
end

test "non-activated_user don't exist in show page" do
  get user_url(@activated)
  assert_template 'users/show'
  get user_url(@non_activated)
  assert_redirected_to root_url
  follow_redirect!
  assert_template '/'
end

end
