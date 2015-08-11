FactoryGirl.define do
  factory :support do
    association :author, factory: :participant
    proposal
  end
end
