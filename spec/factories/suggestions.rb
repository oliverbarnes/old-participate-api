FactoryGirl.define do
  factory :suggestion do
    body  { Faker::Lorem.paragraphs(1) }
    proposal
    login
  end
end
