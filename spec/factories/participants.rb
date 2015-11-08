FactoryGirl.define do
  factory :participant do
    name { Faker::Name.name }

    factory :delegate do
      after(:create) do |delegate|
        delegate.delegations_received << create(:delegation)
      end
    end
  end
end
