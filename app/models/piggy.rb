class Piggy < ApplicationRecord
  attr_accessor :comment

  belongs_to :user
  belongs_to :restaurant

  validates :score, presence: true, inclusion: { in: (0..8) }
  validates :restaurant, uniqueness: { scope: :user }

  def matching_user?(to_check)
    user == to_check
  end

  def matching_restaurant?(to_check)
    restaurant == to_check
  end
end
