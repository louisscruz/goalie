require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  describe "GET #index" do
    it "renders all the goals" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before(:each) do
      FactoryGirl.create(:goal)
    end
    it "renders the correct goal" do
      get :show, id: Goal.first.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the new form" do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
