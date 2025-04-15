require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  let(:latitude) { 40.7128 }
  let(:longitude) { -74.0060 }

  before do
    Geocoder::Lookup::Test.add_stub(
      "123 Main St, 12345 Example City", [ { "latitude" => latitude, "longitude" => longitude } ]
    )
  end

  it "allows a visitor to register" do
    visit register_path

    expect(page).to have_content("Register")

    fill_in "Email", with: "new@example.com"
    fill_in "Password", with: "password123"
    fill_in "Street", with: "123 Main St"
    fill_in "City", with: "Example City"
    fill_in "Zip", with: "12345"

    click_button "Register"

    expect(page).to have_current_path(root_path)
    expect(page).to have_content("new@example.com")
    expect(page).to have_content(latitude)
    expect(page).to have_content(longitude)
  end

  it "shows validation errors when registration fails" do
    visit register_path
    fill_in "Street", with: "123 Main St"
    fill_in "City", with: "Example City"
    fill_in "Zip", with: "12345"
    click_button "Register"

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_current_path(/users/)
  end

  it "redirects to dashboard if already logged in" do
    user = create(:user)
    create(:location, user: user)

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"
    click_button "Login"

    visit register_path
    expect(page).to have_current_path(root_path)
  end
end
