FactoryGirl.define do
  factory :delegation do
    association :author, factory: :participant
    association :delegate, factory: :participant
    proposal
  end
end
