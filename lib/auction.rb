class Auction
  attr_reader :items

  def initialize()
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids.empty?
    end
  end

  def potential_revenue
    revenue = @items.map do |item|
      item.current_high_bid
    end
    revenue.compact.sum
  end

  def bidders
    bid_by = @items.map do |item|
      item.bids
    end
    hash_keys = bid_by.map do |bidder|
      bidder.keys
    end
    hash_keys.map do |key|
      key[0].name
    end
  end

  def bidder_info
    bidders = @items.map do |item|
      item.bids
    end
    keys = bidders.map do |bid|
      bid.keys
    end.flatten
    {
      keys[0] =>
        {budget: keys[0].budget,
         items: []},
      keys[1] =>
        {budget: keys[1].budget,
         items: []},
      keys[2] =>
        {budget: keys[2].budget,
         items: []}
    }
    ### I COULDN'T FIGURE OUT HOW TO ADD IN THE ITEMS :(, also, does this count
    ### as hardcoding when I put an index of the keys variable? Was I supposed
    ### to use group_by? I tried a few times and just couldn't get it...
  end
end
