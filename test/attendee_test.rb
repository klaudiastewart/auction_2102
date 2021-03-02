require 'minitest/autorun'
require 'minitest/pride'
require './lib/attendee'
require './lib/item'
require './lib/auction'

class AttendeTest < Minitest::Test
  def setup
    @attendee = Attendee.new(name: 'Megan', budget: '$50')
  end

  def test_it_exists
    assert_instance_of Attendee, @attendee
  end

  def test_it_has_attributes
    assert_equal "Megan", @attendee.name
    assert_equal 50, @attendee.budget
  end

  # def test_2
  #   assert_equal
  # end
end
