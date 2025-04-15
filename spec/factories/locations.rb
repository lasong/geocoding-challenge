FactoryBot.define do
  factory :location do
    user { nil }
    street { "123 Main St" }
    city { "Example City" }
    zip { "12345" }
    latitude { 40.7128 }
    longitude { -74.0060 }
  end
end
