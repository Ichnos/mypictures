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
    assert_select 'a[href=?]', edit_picture_path(@picture), text: "Edit this picture"
    assert_select 'a[href=?]', picture_path(@picture), text: "Delete this picture"
    assert_select 'a[href=?]', pictures_path, text: "Return to Pictures listing"
  end

  
  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    description_of_recipe = "add chicken, add vegetables, 
  
                       cook for 20 minutes, serve delicious meal"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, 
  
                                                     description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end
  
    
  test "reject invalid picture submissions" do
    get new_picture_path
    assert_template 'pictures/new'
    assert_no_difference 'Picture.count' do
      post pictures_path, params: { picture: { name: " ", description: " " } }
    end
    assert_template 'pictures/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end