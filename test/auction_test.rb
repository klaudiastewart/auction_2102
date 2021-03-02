require 'minitest/autorun'
require 'minitest/pride'
require './lib/attendee'
require './lib/item'
require './lib/auction'

class AuctionTest < Minitest::Test
  def setup
    @auction = Auction.new
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    @attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    @attendee3 = Attendee.new(name: 'Mike', budget: '$100')
  end

  def test_it_exists
    assert_instance_of Auction, @auction
  end

  def test_it_can_have_items
    assert_equal [], @auction.items
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    assert_equal [@item1, @item2], @auction.items
  end

  def test_items_can_have_names
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    assert_equal ["Chalkware Piggy Bank", "Bamboo Picture Frame"], @auction.item_names
  end

  def test_auction_bids
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    assert_equal Hash.new, @item1.bids
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    expected = {
      @attendee2 => 20,
      @attendee1 => 22
    }
    assert_equal expected, @item1.bids
  end

  def test_for_current_high_bid
    @auction.add_item(@item1)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    assert_equal 22, @item1.current_high_bid
  end

  def test_unpopular_items_and_potential_revenue
    @auction.add_item(@item1)
    @auction.add_item(@item2)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @auction.add_item(@item5)
    @item1.add_bid(@attendee2, 20)
    @item1.add_bid(@attendee1, 22)
    @item4.add_bid(@attendee3, 50)
    assert_equal [@item2, @item3, @item5], @auction.unpopular_items
    @item3.add_bid(@attendee2, 15)
    assert_equal [@item2, @item5], @auction.unpopular_items
    assert_equal 87, @auction.potential_revenue
  end

  def test_for_bidders_names
    @auction.add_item(@item1)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @item1.add_bid(@attendee1, 22)
    @item1.add_bid(@attendee2, 20)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    assert_equal ["Megan", "Bob", "Mike"], @auction.bidders
  end

  def test_for_bidder_info_hash
    @auction.add_item(@item1)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @item1.add_bid(@attendee1, 22)
    @item1.add_bid(@attendee2, 20)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    expected = {
      @attendee1 =>
        {
          :budget => 50,
          :items => [@item1]
        },
      @attendee2 =>
        {
        :budget => 75,
        :items => [@item1, @item3]
        },
      @attendee3 =>
        {
        :budget => 100,
        :items => [@item4]
        }
                }
    assert_equal expected, @auction.bidder_info
  end

  def test_bidding_cant_add_more_bidders
    @auction.add_item(@item1)
    @auction.add_item(@item3)
    @auction.add_item(@item4)
    @item1.add_bid(@attendee1, 22)
    @item1.add_bid(@attendee2, 20)
    @item4.add_bid(@attendee3, 50)
    @item3.add_bid(@attendee2, 15)
    expected = {@attendee1 => 22, @attendee2 => 20}
    assert_equal expected, @item1.bids
    @item1.close_bidding
    @item1.add_bid(@attendee3, 70)
    assert_equal expected, @item1.bids
  end
end
