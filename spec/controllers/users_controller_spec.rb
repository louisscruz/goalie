require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    2.times do
      FactoryGirl.create(:user)
    end
  end

  describe "GET #show" do
    it "renders the user profile" do
      get :show, id: User.last.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the new user form" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when given invalid credentials" do
      before(:each) do
        post :create, user: { name: "randomname", password: "test"}
      end

      it "renders the new user form" do
        expect(response).to render_template(:new)
      end
    end

    context "when given valid credentials" do
      before(:each) do
        post :create, user: { name: "randomname", password: "testtest" }
      end

      it "renders the user url" do
        expect(response).to redirect_to(user_url(User.last))
      end

      it "logs the user in" do
        expect(session[:session_token]).to eq(User.last.session_token)
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      get :edit, id: User.last.id
    end

    context "when not logged in" do
      it "redirects to the login page" do
        expect(response).to redirect_to(new_session_url)
      end
    end

    context "when logged in" do
      before(:each) do
        login(User.last)
      end

      context "when the correct user" do
        it "renders the edit user form" do
          get :edit, id: User.last.id
          expect(response).to render_template(:edit)
        end
      end

      context "when the incorrect user" do
        it "renders the root url" do
          get :edit, id: User.first.id
        end
      end
    end
  end

  describe "POST #update" do

    context "when not logged in" do
      it "redirects to the login page" do
        patch :update, id: User.last.id, user: { name: "newname" }
        expect(response).to redirect_to(new_session_url)
      end
    end

    context "when logged in" do
      before(:each) do
        login(User.last)
      end

      context "when the correct user" do
        context "when given valid input" do
          it "redirects to the users profile" do
            patch :update, id: User.last.id, user: { name: "newname" }
            expect(response).to redirect_to(user_url(User.last))
          end
        end

        context "when given invalid input" do
          it "renders the edit user form" do
            patch :update, id: User.last.id, user: { password: "test" }
            expect(response).to render_template(:edit)
          end
        end
      end

      context "when the incorrect user" do
        it "renders the root url" do
          patch :update, id: User.first.id, user: { name: "newname" }
          expect(response).to redirect_to(root_url)
        end
      end
    end
  end
end
