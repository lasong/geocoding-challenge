require "rails_helper"

RSpec.describe GeoLocation do
  let(:latitude) { 51.4647398 }
  let(:longitude) { 6.8589566 }

  describe "#coordinates" do
    context "when the location is found" do
      before do
        Geocoder::Lookup::Test.add_stub(
          "Grenzstr, 46045 Oberhausen", [ { "latitude" => latitude, "longitude" => longitude } ]
        )
      end

      it "returns the coordinates of the location" do
        location = GeoLocation.new(street: "Grenzstr", city: "Oberhausen", zip: "46045")
        expect(location.coordinates).to eq({ latitude: latitude, longitude: longitude })
      end
    end

    context "when the location is not found" do
      before do
        Geocoder::Lookup::Test.add_stub(
          "Foo, 12345 Bar", [ { "latitude" => nil, "longitude" => nil } ]
        )
      end

      it "returns nil values for latitude and longitude" do
        location = GeoLocation.new(street: "Foo", city: "Bar", zip: "12345")
        expect(location.coordinates).to eq({ latitude: nil, longitude: nil })
      end
    end
  end
end
