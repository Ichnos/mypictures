require 'test_helper'

class PicturesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "Ichnos", email: "ichnos@example.com", password: "password", password_confirmation: "password")
    @picture = Picture.create(name: "vegetable saute", description: "great vegetable sautee, add vegetable and oil", user: @user)
  end
  test "successfully delete a picture" do
    get picture_path(@picture)
    assert_template 'pictures/show'
    assert_select 'a[href=?]', picture_path(@picture), text: "Delete this picture"
    assert_difference 'Picture.count', -1 do
      delete picture_path(@picture)
    end
    assert_redirected_to pictures_path
    assert_not flash.empty?
  end  
end