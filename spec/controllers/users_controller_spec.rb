require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET new" do
    def do_get
      get :new
    end

    it "should redirect a logged in user" do
      TODO
      do_get
      expect(response).to redirect_to show_user_url
    end
  end

  describe "GET create" do
    it "should check that the current user is not logged in"
    end

    context "when given a valid user" do
      it "should save the user" do
      end

      it "should redirect to login" do
      end
    end

    context "when given an invalid user" do
      it "should render 'new'" do
      end
    end
  end

  describe "GET edit" do
    it "should check that the current user is logged in" do
    end
  end
end
