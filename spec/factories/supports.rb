FactoryGirl.define do
  factory :support do
    association :author, factory: :participant
    proposal

    trait :with_double_weight do
      association :author, factory: :delegate

      # FIXME: this is not updating the support
      # weight
      # after(:create) do |support|
      #   delegation = support.author.delegations_received.first
      #   delegation.proposal = support.proposal
      #   delegation.save!
      # end
    end
  end
end
