FactoryGirl.define do
  factory :delegation do
    issue
    truster { FactoryGirl.create :member }
    trustee { FactoryGirl.create :member }
  end
end