FactoryGirl.define do
  factory :issue do
    title "Public school in disrepair"
    description "My local school has missing lights, bathrooms that don't work"
  end

  factory :vote do
  end

  factory :member do
    #TODO: use faker at some point
    sequence(:name) { |n| "Alastair Reynolds #{n}" }
  end

  factory :delegation do
    issue
    truster { FactoryGirl.create :member }
    trustee { FactoryGirl.create :member }
  end

  factory :area do
    name "housing"
    description "All issues and initiatives related to housing"
  end

  factory :initiative do
    title "Repurpose abandoned warehouse to make public housing"
    draft "It's been sitting there for 8 years, and there's funding available to renovate it and let new tenants in"
    author { FactoryGirl.create :member  }
    area
    issue
  end

  factory :suggestion do
    initiative
    body "Let's give priority to previously displaced tenants"
  end
end