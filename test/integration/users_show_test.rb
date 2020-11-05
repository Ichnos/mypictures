require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "Ichnos", email: "ichnos@example.com", password: "password", password_confirmation: "password")
    @picture = Picture.create(name: "vegetable saute", description: "great vegetable sautee, add vegetable and oil", user: @user)
    @picture2 = @user.pictures.build(name: "chicken saute", description: "great chicken dish")
    @picture2.save
  end
  
  test "should get users show" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", picture_path(@picture), text: @picture.name
    assert_select "a[href=?]", picture_path(@picture2), text: @picture2.name
    assert_match @picture.description, response.body
    assert_match @picture2.description, response.body
    assert_match @user.username, response.body
  end

end
