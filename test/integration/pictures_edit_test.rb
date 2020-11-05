require 'test_helper'

class PicturesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(username: "Ichnos", email: "ichnos@example.com", password: "password", password_confirmation: "password")
    @picture = Picture.create(name: "vegetable saute", description: "great vegetable sautee, add vegetable and oil", user: @user)
  end
  test "reject invalid picture update" do
    get edit_picture_path(@picture)
    assert_template 'pictures/edit'
    patch picture_path(@picture), params: { picture: { name: " ", description: "some description" } } 
    assert_template 'pictures/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully edit a picture" do
    get edit_picture_path(@picture)
    assert_template 'pictures/edit'
    updated_name = "updated picture name"
    updated_description = "updated picture description"
    patch picture_path(@picture), params: { picture: { name: updated_name, description: updated_description } }
    assert_redirected_to @picture
    #follow_redirect!
    assert_not flash.empty?
    @picture.reload
    assert_match updated_name, @picture.name
    assert_match updated_description, @picture.description
  end


end
