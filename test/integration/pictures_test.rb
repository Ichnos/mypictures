require 'test_helper'

class PicturesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(username: "ichnos", email: "ichnos@example.com")
    @picture = Picture.create(name: "vegetable saute", 
                                                        description: "great vegetable sautee, 
                                                       add vegetable and oil", user: @user)
    @picture2 = @user.pictures.build(name: "chicken saute", 
                                                       description: "great chicken dish")
    @picture2.save
  end
  
  test "should get pictures index" do
    get pictures_path
    assert_response :success
  end
  
  test "should get pictures listing" do
    get pictures_path
    assert_template 'pictures/index'
    assert_select "a[href=?]", picture_path(@picture), text: @recipe.name
    assert_select "a[href=?]", picture_path(@picture2), text: @picture2.name
  end
  
  test "should get pictures show" do
    get picture_path(@picture)
    assert_template 'pictures/show'
    assert_match @picture.name, response.body
    assert_match @picture.description, response.body
    assert_match @user.username, response.body
  end


end