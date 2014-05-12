FactoryGirl.define do
  factory :initiative do
    title "Repurpose abandoned warehouse to make public housing"
    draft "It's been sitting there for 8 years, and there's funding available to renovate it and let new tenants in"
    author { FactoryGirl.create :member  }
    area
    issue
  end
end