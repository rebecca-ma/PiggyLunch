require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET index" do
    context "when user is not logged in" do
      it "should redirect to login" do
        get :index
        expect(response).to redirect_to login_url
      end
    end
    context "when user is logged in" do
      it "should render the 'index' template" do
        user = User.new(username: 'User', password: 'password')
        login(user)
        get :index
        expect(response).to render_template 'index'
      end
    end
  end

  describe "GET show" do
    context "when user is not logged in" do
      it "should redirect to login" do
        get :show
        expect(response).to redirect_to login_url
      end
    end
    context "when user is logged in" do
      it "should render the 'show' template" do
        user = User.new(username: 'User', password: 'password')
        login_user(user)
        get :show
        expect(response).to render_template 'show'
      end
    end
  end

  describe "GET new" do
    context "when user is not logged in" do
      it "should render the 'new' template" do
        get :new
        expect(response).to render_template 'new'
      end
    end
    context "when user is logged in" do
      it "should redirect to user home" do
        user = User.new(username: 'User', password: 'password')
        login_user(user)
        get :new
        expect(response).to redirect_to show_user_url
      end
    end
  end

  describe "POST create" do
    context "when user is logged in" do
      it "should redirect to user home" do
        user = User.new(username: 'User', password: 'password')
        login_user(user)
        post :create, user: { username: 'User1', password: 'password'}
        expect(response).to redirect_to show_user_url
      end
    end
    context "when given valid user params" do
      it "should save the user" do
        post :create, user: { username: 'User', password: 'password' }
        expect(response).to change(User, :count).by(1)
      end
      it "should redirect to user home" do
        post :create, user: { username: 'User', password: 'password' }
        expect(response).to redirect_to show_user_url
      end
    end
    context "when given invalid user params" do
      it "should render the 'new' template" do
        post :create, user: { username: nil, password: nil }
        expect(response).to render_template 'new'
      end
    end
  end

  describe "GET edit" do
    context "when the user is not logged in" do
      it "should redirect to login" do
        get :edit
        expect(response).to redirect_to login_url
      end
    end
    context "when the user is logged in" do
      it "should render the 'edit' template"
    end
  end

  describe "POST update" do
    context "when the user is not logged in" do
      it "should redirect to login" do
        post :update, user: { username: 'User', password: 'password' }
        expect(response).to redirect_to login_url
      end
    end
    context "when given valid user params" do
      it "should save the changes"
      it "should redirect to user home"
    end
    context "when given invalid user params" do
      it "should render the 'edit' template"
    end
  end
end
