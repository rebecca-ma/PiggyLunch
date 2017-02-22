class Restaurant < ApplicationRecord
  attr_accessor :description
  attr_accessor :map_url
  attr_accessor :tags

  has_many :piggies
  has_many :users, through: :piggies

  validates :name, presence: true, uniqueness: true

  def mean_score_by_user(subgroup)
    sum = 0.0
    divisor = 0
    subgroup.each do |subuser|
      piggy = subuser.piggy_by_restaurant(self)
      if piggy
        sum += piggy.piggy_score
        divisor += 1
      end
    end
    return sum / divisor
  end

  def mean_score_all
    sum = 0.0
    piggies.each do |piggy|
      sum += piggy.piggy_score
    end
    return sum / piggies.size
  end
end
