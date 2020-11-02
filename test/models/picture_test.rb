require 'test_helper'
class PictureTest < ActiveSupport::TestCase
  
  def setup
    @picture = Picture.new(name: "Vecchio con barba", description: "Bel ritratto di un vecchio pastore")  
  end
  
  test "picture should be valid" do
    assert @picture.valid?
  end  
  
  test "name should be present" do
    @picture.name = " "
    assert_not @picture.valid?
  end
  
  test "description should be present" do
    @picture.description = " "
    assert_not @picture.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @picture.description = "a" * 3
    assert_not @picture.valid?
  end
  
  test "description shouldn't be more than 500 characters" do
    @picture.description = "a" * 501
    assert_not @picture.valid?
  end
  
end
