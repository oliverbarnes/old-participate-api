FactoryGirl.define do
  factory :suggestion do
    body  { Faker::Lorem.paragraphs(1) }
    proposal
    association :author, factory: :participant
  end
end
