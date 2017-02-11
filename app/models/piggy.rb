class Piggy < ApplicationRecord
  attr_accessor :comment

  belongs_to :user
  belongs_to :restaurant

  validates :piggy_score, presence: true, inclusion: { in: (0..8) }
  validates :restaurant, uniqueness: { scope: :user }
end
