require 'minitest/autorun'
require 'minitest/pride'
require './lib/attendee'
require './lib/item'
require './lib/auction'

class ItemTest < Minitest::Test
  def setup
    @item1 = Item.new('Chalkware Piggy Bank')
  end

  def test_it_exists
    assert_instance_of Item, @item1
  end

  def test_it_has_name
    assert_equal 'Chalkware Piggy Bank', @item1.name
  end

  # def test_2
  #   assert_equal
  # end
end
