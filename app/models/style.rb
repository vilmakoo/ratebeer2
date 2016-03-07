class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating||0) }
    if sorted_by_rating_in_desc_order.size < n
      return sorted_by_rating_in_desc_order
    end
    sorted_by_rating_in_desc_order.take(n)
  end

  def to_s
    self.name
  end
end
