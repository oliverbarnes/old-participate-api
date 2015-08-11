FactoryGirl.define do
  factory :proposal do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraphs(3) }
    association :author, factory: :participant
  end
end
