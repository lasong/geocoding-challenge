require "rails_helper"

RSpec.describe "User Login", type: :feature do
  let!(:user) { create(:user, email: "test@example.com", password: "password123") }
  let!(:location) { create(:location, user: user) }

  it "allows a user to log in with valid credentials" do
    visit login_path

    expect(page).to have_content("Login")

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    click_button "Login"

    expect(page).to have_current_path(root_path)
    expect(page).to have_content(user.email)
    expect(page).to have_content(location.street)
    expect(page).to have_content(location.city)
    expect(page).to have_content(location.zip)
    expect(page).to have_content(location.latitude)
    expect(page).to have_content(location.longitude)
  end

  it "shows error message with invalid credentials" do
    visit login_path

    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "wrong_password"
    click_button "Login"

    expect(page).to have_content("Invalid email or password")
    expect(page).to have_current_path(/login/)
  end

  it "allows a user to log out" do
    visit login_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    click_button "Login"

    click_button "Logout"

    expect(page).to have_current_path(login_path)
  end

  it "redirects to dashboard if already logged in" do
    visit login_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password123"
    click_button "Login"

    visit login_path
    expect(page).to have_current_path(root_path)
  end
end
