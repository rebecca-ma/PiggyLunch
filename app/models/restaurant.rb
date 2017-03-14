class Restaurant < ApplicationRecord
  attr_accessor :map_url_unparsed

  has_many :piggies, dependent: :destroy
  has_many :users, through: :piggies

  validates :name, presence: true, uniqueness: true

  before_save :parse_map_url

  def mean_score_by_user(subgroup)
    sum = 0.0
    divisor = 0
    subgroup.each do |subuser|
      piggy = subuser.piggy_by_restaurant(self)
      if piggy
        sum += piggy.score
        divisor += 1
      end
    end
    return sum / divisor
  end

  def mean_score_all
    sum = 0.0
    piggies.each do |piggy|
      sum += piggy.score
    end
    return sum / piggies.size
  end

  def parse_map_url
    unless map_url_unparsed.blank?
      split_url =  map_url_unparsed.split('"')
      if split_url[0] == '<iframe src='
        self.map_url = split_url[1]
      end
    end
  end
end
