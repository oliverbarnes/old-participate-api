class Initiative
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :draft

  belongs_to :author, class_name: 'Member'
  belongs_to :area
  belongs_to :issue
  has_many :suggestions, class_name: 'SuggestionToInitiative'
  has_many :supports, class_name: 'SupportToInitiative'
end