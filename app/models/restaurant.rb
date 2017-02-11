class Restaurant < ApplicationRecord
  attr_accessor :description

  has_many :piggies
  has_many :users, through: :piggies

  validates :name, presence: true, uniqueness: true

  def mean_score
    sum = 0.0
    piggies.each do |piggy|
      sum += piggy.piggy_score
    end
    return sum / piggies.size
  end
end
