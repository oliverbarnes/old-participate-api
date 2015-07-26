FactoryGirl.define do
  factory :login do
    email        { Faker::Internet.email }
    facebook_uid { Faker::Number.number(7) }
    participant
  end
end
