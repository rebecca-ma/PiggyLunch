require 'rails_helper'

RSpec.describe Piggy, type: :model do
  context "when associated with other models" do
    it "should belong to a User" do
      user = Piggy.reflect_on_association(:user)
      expect(user.macro).to eq :belongs_to
    end

    it "should belong to a restaurant" do
      rest = Piggy.reflect_on_association(:restaurant)
      expect(rest.macro).to eq :belongs_to
    end
  end

  context "when creating or editting a piggy" do
    before(:each) do
      @user = User.new(username: 'User', password: 'password')
      @restaurant = Restaurant.new(name: 'Restaurant')
    end

    it "should accept a valid piggy" do
      bad_piggy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: 1)
      good_piggy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: 8)
      
      expect(bad_piggy.valid?).to be true
      expect(good_piggy.valid?).to be true
    end

    it "should require a user" do
      piggy = Piggy.new(user: nil, restaurant: @restaurant, piggy_score: 1)
      expect(piggy.valid?).to be false
    end
    
    it "should require a restaurant" do
      piggy = Piggy.new(user: @user, restaurant: nil, piggy_score: 1)
      expect(piggy.valid?).to be false
    end

    it "should require a piggy score" do
      piggy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: nil)
      expect(piggy.valid?).to be false
    end

    it "should reject non-existent users" do
      piggy = Piggy.new(user_id: 2, restaurant: @restaurant, piggy_score: 1)
      expect(piggy.valid?).to be false
    end

    it "should reject non-existent restaurants" do
      piggy = Piggy.new(user: @user, restaurant_id: 2, piggy_score: 1)
      expect(piggy.valid?).to be false
    end

    it "should reject piggy scores outside the range of 0-8" do
      low_piggy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: -1)
      high_piggy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: 9)
      expect(low_piggy.valid?).to be false
      expect(high_piggy.valid?).to be false
    end

    it "should reject piggies with the same user and restaurant" do
      piggy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: 1)
      if piggy.save
        piggy_copy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: 1)
        expect(piggy_copy.save).to be false
      else
        fail "could not save initial piggy"
      end
    end

    it "should accept an optional comment" do
      piggy = Piggy.new(user: @user, restaurant: @restaurant, piggy_score: 1, comment: "It was horrible")
      expect(piggy.save).to be true
    end

    after(:each) do
      User.destroy_all
      Restaurant.destroy_all
      Piggy.destroy_all
    end
  end
end
