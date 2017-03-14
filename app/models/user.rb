class User < ApplicationRecord
  has_many :piggies, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  #attr_accessor :password

  #validates :username, presence: true, uniqueness: true
  #validates :password, presence: true, on: :create, confirmation: true

  #before_save :encrypt_password

  def piggy_by_restaurant(restaurant)
    piggies.each do |piggy|
      if piggy.restaurant == restaurant
        piggy
      end
    end
    nil
  end

  #def self.authenticate(username, password)
  #  user = find_by_username(username)
  #  if user
  #    expected_ep = BCrypt::Engine.hash_secret(password, user.salt)
  #    if user.encrypted_password == expected_ep
  #      return user
  #    end
  #  end
  #  return nil
  #end

  #def encrypt_password
  #  self.salt = BCrypt::Engine.generate_salt
  #  self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  #end
end
