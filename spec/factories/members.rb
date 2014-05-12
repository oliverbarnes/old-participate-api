FactoryGirl.define do
  factory :member do
    #TODO: use faker at some point
    sequence(:name) { |n| "Alastair Reynolds #{n}" }
  end
end