require "rails_helper"

RSpec.describe UserRegistration do
  let(:email) { "test@example.com" }
  let(:password) { "password" }
  let(:street) { "Grenzstr" }
  let(:city) { "Oberhausen" }
  let(:zip) { "46045" }
  let(:latitude) { 51.4647398 }
  let(:longitude) { 6.8589566 }

  let(:params) do
    {
      email: email,
      password: password,
      street: street,
      city: city,
      zip: zip
    }
  end

  describe "#call" do
    before do
      geo_location = instance_double(GeoLocation)
      allow(GeoLocation).to receive(:new).and_return(geo_location)
      allow(geo_location).to receive(:coordinates).and_return(
        { latitude: latitude, longitude: longitude }
      )
    end

    it "creates a new user with the correct attributes" do
      user = UserRegistration.new(params).call

      expect(user).to be_a(User)
      expect(user).to be_new_record
      expect(user.email).to eq(email)
      expect(user.password).to eq(password)
    end

    it "assigns the correct location attributes" do
      user = UserRegistration.new(params).call
      location = user.location

      expect(location).to be_a(Location)
      expect(location.street).to eq(street)
      expect(location.city).to eq(city)
      expect(location.zip).to eq(zip)
      expect(location.latitude).to eq(latitude)
      expect(location.longitude).to eq(longitude)
    end

    context "when some location parameters are missing" do
      let(:params_without_zip) do
        {
          email: email,
          password: password,
          street: street,
          city: city
        }
      end

      before do
        geo_location = instance_double(GeoLocation)
        allow(GeoLocation).to receive(:new).and_return(geo_location)
        allow(geo_location).to receive(:coordinates).and_return(
          { latitude: latitude, longitude: longitude }
        )
      end

      it "still creates a user with available location information" do
        user = UserRegistration.new(params_without_zip).call

        expect(user).to be_a(User)
        expect(user.location.street).to eq(street)
        expect(user.location.city).to eq(city)
        expect(user.location.zip).to be_nil
        expect(user.location.latitude).to eq(latitude)
        expect(user.location.longitude).to eq(longitude)
      end
    end

    context "when geocoding returns nil coordinates" do
      before do
        geo_location = instance_double(GeoLocation)
        allow(GeoLocation).to receive(:new).and_return(geo_location)
        allow(geo_location).to receive(:coordinates).and_return(
          { latitude: nil, longitude: nil }
        )
      end

      it "creates a location with nil coordinates" do
        user = UserRegistration.new(params).call

        expect(user).to be_a(User)
        expect(user.location.latitude).to be_nil
        expect(user.location.longitude).to be_nil
      end
    end
  end
end
