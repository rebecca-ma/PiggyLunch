require 'rails_helper'

RSpec.describe User, type: :model do
  context "when associated with other models" do
    it "should have many piggies" do
      piggy = User.reflect_on_association(:piggies)
      expect(piggy.macro).to eq :has_many
    end
  end
  context "when registering a new user" do   
    it "should save a valid user password combination" do
      user = User.new(username: 'User', password: 'password')
      expect(user.save).to be true
    end

    it "should only accept a non-empty username" do
      nil_user = User.new(username: nil, password: 'password')
      empty_user = User.new(username: '', password: 'password')
      blank_user = User.new(username: ' ', password: 'password')

      expect(nil_user.valid?).to be false
      expect(empty_user.valid?).to be false
      expect(blank_user.valid?).to be false
    end

    it "should only accept a non-empty password" do
      nil_user = User.new(username: 'User', password: nil)
      empty_user = User.new(username: 'User', password: '')
      blank_user = User.new(username: 'User', password: ' ')
      
      expect(nil_user.valid?).to be false
      expect(empty_user.valid?).to be false
      expect(blank_user.valid?).to be false
    end

    it "should only accept a unique username" do
      user = User.new(username: 'User', password: 'password')
      if user.save
        user_copy = User.new(username: 'User', password: 'password')
        expect(user_copy.save).to be false

        new_user = User.new(username: 'NotUser', password: 'password')
        expect(new_user.save).to be true
      else
        fail "first user didn't save"
      end
    end

    it "should encrypt the password before saving" do
      user = User.new(username: 'User', password: 'password')
      if user.save
        salt = user.salt
        encrypted_password = user.encrypted_password
        expected_ep = BCrypt::Engine.hash_secret('password', salt)
        expect(encrypted_password).to eq expected_ep
      else
        fail 'user did not save'
      end
    end

    it "should confirm the password" do
      wrong_user = User.new(username: 'User', password: 'password',
                            password_confirmation: 'wrong')
      empty_user = User.new(username: 'User', password: 'password',
                            password_confirmation: '')
      right_user = User.new(username: 'User', password: 'password',
                            password_confirmation: 'password')
      expect(wrong_user.valid?).to be false
      expect(empty_user.valid?).to be false
      expect(right_user.valid?).to be true
    end

    after(:each) do
      User.destroy_all
    end
  end

  context "when logging in an existing user" do
    before(:all) do
      user = User.new(username: 'User', password: 'password')
      if !user.save
        fail "User could not be saved"
      end
    end 

    it "should authenticate existing users" do
      user = User.authenticate('User', 'password')
      expect(user.nil?).to be false
    end

    it "should not authenticate a wrong username password combination" do
      wrong_password = User.authenticate('User', 'wrong')
      wrong_user = User.authenticate('Wrong', 'password')

      expect(wrong_password.nil?).to be true
      expect(wrong_user.nil?).to be true
    end

    after(:all) do
      User.destroy_all
    end
  end
end
