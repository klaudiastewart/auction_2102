class Item
  attr_reader :name,
              :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, bid)
    if @bids.nil?
      @bids[attendee]
    elsif
      @bids[attendee] = bid
    # end
    else @bids.close_bidding
      @bids[] != bid
    end
  end

  def current_high_bid
    @bids.values.max
  end

  def close_bidding
    @bids.map do |hash|
      hash = nil
    end
    #Not too sure how to add this into the add_bid method?
  end
end
