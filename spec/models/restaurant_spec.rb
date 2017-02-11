require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context "when associated with other models" do
    it "should have many piggies" do
      rest = Restaurant.reflect_on_association(:piggies)
      expect(rest.macro).to eq :has_many
    end

    it "should have many users through piggies" do
      rest = Restaurant.reflect_on_association(:users)
      expect(rest.macro).to eq :has_many
    end
  end 

  context "when listing a new restaurant" do
    it "should save a valid restaurant" do
      rest = Restaurant.new(name: 'Restaurant')
      rest_desc = Restaurant.new(name: 'Rest Desc', description: 'Hi')

      expect(rest.save).to be true
      expect(rest_desc.save).to be true
    end

    it "should require a non-blank name" do
      nil_rest = Restaurant.new(name: nil)
      empty_rest = Restaurant.new(name: '')
      blank_rest = Restaurant.new(name: ' ')
      valid_rest = Restaurant.new(name: 'Restaurant')
      
      expect(nil_rest.valid?).to be false
      expect(empty_rest.valid?).to be false
      expect(blank_rest.valid?).to be false
      expect(valid_rest.valid?).to be true
    end
    
    it "should require a unique name" do
      first = Restaurant.new(name: 'Restaurant')
      if first.save
        copy = Restaurant.new(name: 'Restaurant')
        expect(copy.save).to be false
      else
        fail "could not save initial restaurant"
      end
    end

    after(:each) do
      Restaurant.destroy_all
    end
  end
  
  describe "method mean_score" do
    before(:each) do
      @rest = Restaurant.new(name: 'Restaurant')
      @user1 = User.new(username: 'User 1', password: 'password')
      @user2 = User.new(username: 'User 2', password: 'password')
      @user3 = User.new(username: 'User 3', password: 'password')

      if !@rest.save
        fail "could not save initial restaurant"
      end
      if !@user1.save || !@user2.save || !@user3.save
        fail "could not save initial users"
      end

      piggy1 = Piggy.new(user: @user1, restaurant: @rest, piggy_score: 1)
      piggy2 = Piggy.new(user: @user2, restaurant: @rest, piggy_score: 3)
      piggy3 = Piggy.new(user: @user3, restaurant: @rest, piggy_score: 8)

      if !piggy1.save || !piggy2.save || !piggy3.save
        fail "could not save initial piggies"
      end
    end
    
    it "should return the mean of all its piggy scores" do
      expect(@rest.mean_score).to eq 4
    end
    
    after(:each) do
      Restaurant.destroy_all
      User.destroy_all
      Piggy.destroy_all
    end
  end
end
