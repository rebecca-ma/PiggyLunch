class Piggy < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :score, inclusion: { in: (1..5) }, presence: true
  validates :restaurant, uniqueness: { scope: :user }

  def matching_user?(to_check)
    user == to_check
  end

  def matching_restaurant?(to_check)
    restaurant == to_check
  end
end
