require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before(:each) do
    visit new_user_url
  end

  scenario "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      fill_in "name", with: "newusername"
      fill_in "password", with: "newuserpassword"
      click_on "Sign Up"
      expect(page).to have_content("newusername")
    end

  end

end

feature "logging in" do
  before(:each) do
    FactoryGirl.create(:user)
    visit new_session_url
  end

  scenario "shows username on the homepage after login" do
    fill_in "name", with: User.last.name
    fill_in "password", with: "testtest"
    click_on "Sign In"
    expect(page).to have_content(User.last.name)
  end

end

feature "logging out" do
  before(:each) do
    FactoryGirl.create(:user)
  end

  scenario "begins with a logged out state" do
    visit root_url
    expect(page).not_to have_content("Sign Out")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in "name", with: User.last.name
    fill_in "password", with: "testtest"
    click_on "Sign In"
    expect(page).to have_content("Sign Out")
    click_on "Sign Out"
    expect(page).not_to have_content("Sign Out")
  end

end
