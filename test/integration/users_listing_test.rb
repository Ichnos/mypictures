require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest
    
  def setup
    @user = User.create!(username: "ichnos", email: "ichnos@example.com", password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "john", email: "john@example.com", password: "password", password_confirmation: "password")                                                                                                                                                                                                                                                                                      password: "password", password_confirmation: "password") 
  end
  
  test "should get users listing" do
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user), text: @user.username.capitalize
    assert_select "a[href=?]", user_path(@user2), text: @user2.username.capitalize
  end
  
  test "should delete user" do
    get users_path
    assert_template 'users/index'
    assert_difference 'user.count', -1 do
      delete user_path(@user2)
    end
    assert_redirected_to users_path
    assert_not flash.empty?
  end

end
