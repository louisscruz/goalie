require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    2.times do
      FactoryGirl.create(:user)
    end
  end

  describe "GET #new" do
    it "renders the new session form" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when given correct credentials" do
      it "redirects to the root url" do
        post :create, user: { name: User.first.name, password: "testtest" }
        expect(response).to redirect_to(root_url)
      end
    end

    context "when given the incorrect credentials" do
      it "renders the new template" do
        post :create, user: { name: User.first.name, password: "test" }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do
    it "sets the session_token to nil" do
      post :create, user: { name: User.first.name, password: "testtest" }
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
end
