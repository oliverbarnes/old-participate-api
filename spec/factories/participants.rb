FactoryGirl.define do
  factory :participant do
    name { Faker::Name.name }
  end
end
