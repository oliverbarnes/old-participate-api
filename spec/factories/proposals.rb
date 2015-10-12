FactoryGirl.define do
  factory :proposal do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraphs(3) }
    association :author, factory: :participant

    trait :supported do
      after(:build) do |proposal|
        create_list(:support, 1, proposal: proposal)
      end
    end
  end
end
